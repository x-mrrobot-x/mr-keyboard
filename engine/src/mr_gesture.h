// Mr Keyboard - native engine: gesture typing (engine contract 2; contract 3 adds Gesture::more).
//
// Finds the word of a gesture: the finger goes down on the first letter, slides over the others and lifts on the last one.
// It is done in two halves, tied together by Gesture (the only class the JNI uses):
//   - GestureNet    (mr_gesture_nn.cpp): a small neural network. It takes the trace (64 points) and the centres of the keys and
//                   gives, for each of 32 steps, the log-probability of each key and of "no key here" (the CTC blank). The
//                   keyboard only enters as the list of key centres, so the same network serves any layout.
//   - GestureSearch (mr_gesture_decode.cpp): looks in main.dict (the same bytes Fuzzy walks, no second copy) for the words that
//                   best explain that table, and ranks them with the frequency of the word and the bigram of the previous word.
//
// The network is the encoder of "FUTO Swipe" (honorable_sturgeon), by FUTO Holdings, Inc. The WEIGHTS are theirs and stay under
// the FUTO Model Weights License 1.0 (gesture/LICENSE-FUTO-Model-Weights.md in the app project; the product must tell the user it
// is powered by "FUTO Swipe"). The CODE that runs it here was written for this project from the published graph: no ExecuTorch,
// no XNNPACK, nothing of FUTO's GPL library, no dependency. The score of a word has the form of equation 3 of FUTO's technical
// report (arXiv 2606.25247) plus a bigram term; the search itself (a beam over key sequences) is this project's.
//
// How the rules of mr_engine.h apply to this part:
//   1. Java is the source of truth: the scoring values and the limits (GestureParams), the keys with their letters and centres and
//      the characters that take no key (GestureLayout) come from Java; the letter tables are the Tables of nInit. No tuning
//      constant hides here.
//   2. Never trust the files: the weights file is checked against its size, its tensor names and sizes, and refused if any value
//      is not a finite number; every dictionary read is checked against the size and the work per gesture has a ceiling
//      (nodeBudget, beam), so a corrupt file gives no word or a wrong word, never a crash or a frozen keyboard.
//   3. No exception crosses the JNI: this code only throws std::bad_alloc, which the JNI catches.
//   4. Fixed-size types only.
//   5. Does NOT apply: there is no Java implementation to be identical to, and float arithmetic is not identical between processors
//      (fused multiply-add, the libm of each system). The proof is by tolerance: test/mr_gesture_test.cpp compares the network
//      with the outputs of the official runtime (test/data/gesture_vectors.bin) and counts the right words on real gestures.
//      Given the same table the search is deterministic (every sort has a tie-break that does not depend on the C++ library).
#pragma once

#include <cstddef>
#include <cstdint>
#include <vector>

#include "mr_engine.h"

namespace mr {

constexpr int kGesturePoints = 64;        // points the network takes (the trace is resampled to this)
constexpr int kGestureFrames = 32;        // steps it gives
constexpr int kGestureKeys = 64;          // most keys in a layout (a limit of the model)
constexpr int kGestureCoeff = 64;         // 8 x 8 cosine coefficients per step
constexpr int kGestureMaxTouches = 4096;  // most touch points accepted in one gesture
constexpr int kGestureResults = 16;       // words returned (MrGesture.MAX_RESULTS)
constexpr int kGestureChars = kMaxWord;   // characters of each result in the output buffer (MrGesture.RESULT_CHARS)
constexpr int kGestureFree = 8;           // most characters that take no key
constexpr int kGestureSpellings = 4;      // spellings of the previous word tried
constexpr int kGestureContext = 256;      // most bigrams of the previous word read (the dictionaries have up to 60)
constexpr int kGestureMaxBeam = 2000;
constexpr int kGestureMaxBudget = 500000;
constexpr int kGestureInfo = 2 + 4 * kGestureResults;   // ints the JNI gives back (MrGesture.INFO_SIZE)
// Work memory of the search kept between gestures. An ordinary gesture stays far below; one that goes past it (a corrupt
// dictionary read up to the ceiling) has its memory given back as soon as it is answered.
constexpr size_t kGestureKeepBytes = 2u << 20;
constexpr size_t kGestureKeepWords = 256;
constexpr float kGestureMinLog = -100.f;  // floor of every log-probability the network gives

// Scoring values and limits. The order is that of MrGesture.params() and MrGesture.limits() in Java; change both together.
//   score = logp / keys^gamma + lambdaF * freq + beta * keys + ctx * bigram
//     logp: CTC log-probability of the word; keys: keys the gesture went through; freq: frequency in the dictionary (0..255);
//     bigram: frequency of the pair with the previous word (1..127; 0 = none).
//   pruning, at each step: logp / keys^gammaPrune + betaPrune * keys, the `beam` best key sequences stay.
struct GestureParams {
    float gamma = 0.f, lambdaF = 0.f, beta = 0.f, ctx = 0.f, gammaPrune = 0.f, betaPrune = 0.f;
    int beam = 0;         // key sequences kept at each step
    int minKeys = 0;      // a gesture goes through at least this many keys
    int nodeBudget = 0;   // ceiling of dictionary entries read per gesture
    static constexpr int kFloats = 6;
    static constexpr int kInts = 3;
    // f: kFloats values, i: kInts values, in the order above. false = some value is not a number or is out of range
    // (nothing is changed then).
    bool set(const float* f, const int* i);
};

// The keys a gesture can go through. Coordinates in the frame of the letter block: x = 0 at the left edge of the keyboard and 1 at
// the right edge; y = 0 at the top of the first row of letters and 1 at the bottom of the last one. The touch points use the same
// frame (they may leave it: a finger over the number row has y < 0).
struct GestureLayout {
    int n = 0;
    char16_t key[kGestureKeys] = {0};     // the letter of each key, in lowercase, in the order of the columns of the table
    char16_t free[kGestureFree] = {0};    // characters that are part of a word but not of its gesture (' and -)
    int nFree = 0;
    std::vector<float> basis;             // [n][kGestureCoeff]: the cosine basis at the centre of each key
    int16_t low[256];                     // key of each letter below 256 (-1 = none)

    // keys: nKeys letters (2..kGestureKeys, none repeated, none 0); xy: nKeys x (x, y), each between -1 and 2;
    // freeChars: nFree characters (0..kGestureFree). false = refused (the layout is left empty).
    bool set(const char16_t* keys, const float* xy, int nKeys, const char16_t* freeChars, int nFreeChars);
    void clear();
    int find(int c) const;                // key whose letter is c, or -1
    bool isFree(int c) const;
};

// Resamples the touch points the way the model was trained: 60 points per second by time, then kGesturePoints points equally
// spaced by index. x, y: n points in the frame of GestureLayout; tMs: the time of each in milliseconds (a time that goes back
// counts as no time passed). out: [2][kGesturePoints], the x then the y. false if n < 1.
bool gestureResample(const float* x, const float* y, const int32_t* tMs, int n, float* out);

class GestureNet {
public:
    // false if the file does not exist, is not a weights file of this network (magic, tensor names and sizes), is truncated or
    // has a value that is not a finite number. The file is read once and closed: nothing stays mapped.
    bool open(const char* path);
    // Same as open() for bytes already in memory (tests). Copies.
    bool openBytes(const uint8_t* data, size_t size);
    bool isOpen() const { return open_; }
    void close();

    // feats: [2][kGesturePoints] (gestureResample). out: [kGestureFrames][layout.n + 1]; the last column is the blank. Every value
    // is a number between kGestureMinLog and 0, whatever the input. Needs isOpen() and layout.n >= 1.
    void forward(const float* feats, const GestureLayout& layout, float* out);

    size_t values() const { return w_.size(); }
    // Heap taken: the weights plus the work memory of forward().
    size_t heapBytes() const { return (w_.capacity() + buf_.capacity()) * sizeof(float); }

    static constexpr size_t kMaxFile = 16u << 20;   // the real file has 2.5 MB

private:
    struct Block {
        const float *dwW, *dwB, *pw1W, *pw1B, *grnG, *grnB, *pw2W, *pw2B, *se1W, *se1B, *se2W, *se2B;
    };
    bool open_ = false;
    std::vector<float> w_;                 // every tensor, one after the other
    std::vector<float> buf_;               // work memory, allocated once at open
    const float* sg_[5] = {nullptr, nullptr, nullptr, nullptr, nullptr};   // 7-point filters: d1_x d1_y d2_x d2_y d1_curv
    const float *stemW_ = nullptr, *stemB_ = nullptr;
    Block blk_[5] = {};
    const float *adW_ = nullptr, *adB_ = nullptr, *lamW_ = nullptr, *lamB_ = nullptr, *coW_ = nullptr, *coB_ = nullptr;
};

// Reader of main.dict for the gesture search (the format is the one Fuzzy reads; docs/tools/build_dict.py writes it). Read-only;
// every position is checked against the size.
class GestureDict {
public:
    struct Entry {
        int at = 0;          // position of the entry (the address the bigrams of other words point to)
        int kids = 0;        // position of the group of children; 0 = none
        int bigramAt = 0;    // position of the bigram list; 0 = the format has none or the entry is not a word
        char16_t ch = 0;
        uint8_t freq = 0;    // only if terminal
        bool terminal = false;
    };
    // false = no dictionary (null or too small). The bytes must stay alive while this object is used.
    bool attach(const uint8_t* data, int size);
    int root() const { return root_; }
    // Appends to out the entries of the group at pos. false = the group is cut by the end of the file (what was read before the
    // cut is in out and is valid).
    bool readGroup(int pos, std::vector<Entry>* out) const;
    // The word exactly as written. false = not in the dictionary.
    bool find(const char16_t* w, int len, Entry* e) const;
    // Bigrams of a word: address of the entry of the next word and frequency (1..127). Returns how many (up to max).
    int bigrams(const Entry& e, int* addr, int* freq, int max) const;

private:
    const uint8_t* d_ = nullptr;
    int size_ = 0;
    int ab_ = 3;             // bytes of an address: 3 in the dictionary format v1, 4 in v2
    int root_ = 0;
    bool latest_ = false;    // the format with bigram lists
};

struct GestureWord {
    char16_t word[kGestureChars] = {0};
    int len = 0;
    float score = 0.f;       // the score of GestureParams (the results come ordered by it)
    float logp = 0.f;        // CTC log-probability of the word
    int keys = 0;            // keys the gesture went through for this word
    int freq = 0;            // frequency in the dictionary (0..255)
    int bigram = 0;          // frequency of the pair with the previous word (0 = none)
    int at = 0;              // address in the dictionary
    int source = 0;          // which dictionary: 0 = the one of Gesture::decode(), 1 = the one of Gesture::more()
};

// Beam search over key sequences, one step of the table at a time, adding up the probability of every alignment of each
// sequence (CTC). Each item of the beam is a key sequence and holds the set of dictionary prefixes it writes: "esta" and
// "está", "the" and "The", "of" and "off" (a doubled letter is passed over once) go together and take a single place.
class GestureSearch {
public:
    // logEm: [kGestureFrames][layout.n + 1] from GestureNet::forward. ctxAddr/ctxFreq: the bigrams of the previous word (nCtx
    // may be 0; only the first kGestureContext are read). The words alive at the end are left in all(), best first; with
    // the same score, the shorter word first.
    void decode(const Tables& t, const GestureDict& dict, const GestureLayout& layout, const float* logEm, const GestureParams& p,
                const int* ctxAddr, const int* ctxFreq, int nCtx);
    const std::vector<GestureWord>& all() const { return out_; }
    void clear() {                                 // forgets the last gesture (the work memory stays reserved)
        out_.clear();
        nodes_ = 0;
        sequences_ = 0;
    }
    int nodes() const { return nodes_; }           // dictionary entries read in the last gesture
    int sequences() const { return sequences_; }   // key sequences created in the last gesture
    int trims() const { return trims_; }           // times trim() gave memory back
    // Heap reserved by the search: it grows with the largest gesture seen and stays, so that an ordinary gesture allocates
    // nothing. trim() gives the work memory back if it went past maxBytes (the results stay, cut to the best keepWords);
    // release() gives everything back.
    size_t heapBytes() const;
    void trim(size_t maxBytes, size_t keepWords);
    void release();

private:
    struct DNode {               // a dictionary entry: one written prefix
        int parent, at, kidsPos;
        char16_t ch;
        uint8_t freq, raw;       // raw: characters written so far
        bool terminal;
    };
    struct VNode {               // a key sequence and the prefixes it writes
        int parent, memBegin, memCount, kidBegin, kidCount, slot, stamp;
        int16_t key;             // last key; -1 at the root
        uint8_t len;             // keys so far
        bool expanded;
    };
    struct Item {
        int node;
        float pb, pnb, score;    // log-probability ending in blank / not in blank; pruning score
    };
    struct Hit {
        int at, dnode, len;
        float logp;
    };
    int keyFor(int c) const;
    void expand(int v);
    int slotFor(int v, std::vector<Item>* items);

    const Tables* t_ = nullptr;
    const GestureDict* dict_ = nullptr;
    const GestureLayout* layout_ = nullptr;
    int budget_ = 0;
    int stamp_ = 0;
    int nodes_ = 0, sequences_ = 0, trims_ = 0;
    int16_t keyOf_[256];
    std::vector<DNode> dn_;
    std::vector<VNode> vn_;
    std::vector<int> pool_, tmpMem_;
    struct Kid {
        int key, dnode;
    };
    std::vector<Kid> tmpKids_;
    std::vector<Item> cur_, nxt_;
    std::vector<GestureDict::Entry> group_;
    std::vector<Hit> hits_;
    std::vector<GestureWord> out_;
};

// The whole recognition, for the JNI: weights, layout and one gesture at a time (the JNI takes a mutex).
// The weights and the layout do not depend on each other: either can be set first, and the layout survives close().
class Gesture {
public:
    bool open(const char* path);                    // a failed open leaves it closed
    bool openBytes(const uint8_t* data, size_t size);
    void close();                                   // frees the weights and the work memory
    bool isOpen() const { return net_.isOpen(); }
    // A refused layout leaves none.
    bool setLayout(const char16_t* keys, const float* xy, int nKeys, const char16_t* freeChars, int nFreeChars);
    bool hasLayout() const { return layout_.n > 0; }

    // x, y, tMs: n touch points (1..kGestureMaxTouches) in the frame of GestureLayout. prev/prevLen: nPrev spellings of the
    // previous word, tried in order until one is in the dictionary (0 = no previous word). Returns how many results
    // (0..kGestureResults), or -1 if it cannot answer: not open, no layout, n out of range, a coordinate that is not a number.
    int decode(const Tables& t, const uint8_t* dict, int dictSize, const float* x, const float* y, const int32_t* tMs, int n,
               const char16_t* const* prev, const int* prevLen, int nPrev, const GestureParams& p);

    // The gesture of the last decode() searched in another dictionary (contract 3): the words main.dict does not have, the
    // user's own, in a second dictionary of the same format. The network does not run again: the table the last decode() left
    // is used. prev is looked up in THIS dictionary. What is found is merged into the results there already are: afterwards
    // count() and result() give the best kGestureResults of the two dictionaries, by score (the same score everywhere: only
    // the dictionary differs). A word of this dictionary that is already there, in any spelling (the comparison is in lower
    // case), does not come a second time: it is left out when its score is not larger than the one there, and takes the place
    // of every spelling there when it is. A dictionary that gives nothing better leaves the results exactly as they were.
    // It may be called again, with another dictionary.
    // Returns count(), or -1, with the results untouched, if there is no table (no decode() answered since open(), close() or
    // setLayout()) or the values are out of range.
    int more(const Tables& t, const uint8_t* dict, int dictSize, const char16_t* const* prev, const int* prevLen, int nPrev,
             const GestureParams& p);
    bool hasTable() const { return table_; }        // is there a table for more()?

    int count() const { return count_; }
    const GestureWord& result(int i) const { return all()[static_cast<size_t>(i)]; }
    // Every word alive at the end of decode(), best first; after more(), the merged list (at most kGestureResults).
    const std::vector<GestureWord>& all() const { return merged_ ? both_ : search_.all(); }
    const float* emissions() const { return em_.data(); }   // the table of the last gesture (tests)
    int columns() const { return layout_.n + 1; }
    int nodes() const { return nodesBefore_ + search_.nodes(); }   // dictionary entries read for this gesture, more() included
    int sequences() const { return search_.sequences(); }
    int contextSize() const { return nCtx_; }       // bigrams of the previous word used in the last search (0 = no context)
    int trims() const { return search_.trims(); }   // gestures whose work memory was given back (kGestureKeepBytes)
    size_t heapBytes() const;
    size_t searchHeapBytes() const { return search_.heapBytes(); }

private:
    // The search of decode() and more(): the table in em_ against this dictionary.
    int search(const Tables& t, const uint8_t* dict, int dictSize, const char16_t* const* prev, const int* prevLen, int nPrev,
               const GestureParams& p);

    GestureNet net_;
    GestureLayout layout_;
    GestureSearch search_;
    std::vector<float> em_, px_, py_;
    int nCtx_ = 0;
    int count_ = 0;
    bool table_ = false;     // em_ holds the table of a gesture, made with the weights and the layout in use
    bool merged_ = false;    // more() ran: the results are in both_
    int nodesBefore_ = 0;    // entries read by the searches before the last one
    std::vector<GestureWord> both_;
    void forget() {          // no gesture: no results and no table
        count_ = 0;
        nCtx_ = 0;
        table_ = false;
        merged_ = false;
        nodesBefore_ = 0;
        both_.clear();
        search_.clear();
    }
};

}  // namespace mr
