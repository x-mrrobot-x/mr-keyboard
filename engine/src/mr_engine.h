// Mr Keyboard - native engine, stage 1.
//
// C++ port of the two heaviest parts of the app, which used to run only in Java:
//   - Fuzzy:    the correction search (MrFuzzy.java: weighted edit distance over the .dict trie,
//               passes, splitting of run-together words);
//   - TriStore: the trigram lookup (MrTrigram.java: trigrams.bin file, MRT1 format).
// The files are the same as before (main.dict, trigrams.bin); no new format.
//
// Rules for this code (read before changing anything):
//   1. The source of truth for costs, rules and letter tables is the app's Java. Java hands over
//      everything at start-up (nInit/nSetRules); there is no hidden tuning constant here.
//   2. Never trust the files. Every read is checked against the size; a corrupt file gives fewer
//      results or an error, never a keyboard crash.
//   3. No exception crosses the JNI boundary.
//   4. Fixed-size types only. The result must not depend on char being signed or not (x86 vs ARM).
//   5. The result must be identical to the Java one, bit by bit (words, score, cost, order). The proof
//      is the parity test (test/ and docs/tools/e2e/NativeParity.java in the app).
#pragma once

#include <cstddef>
#include <cstdint>
#include <memory>
#include <string>
#include <vector>

namespace mr {

// Java <-> native contract version. Goes up when the signature of any native function, the order of
// the costs or the meaning of any table changes. The app checks it at load time and, if it differs, uses Java.
constexpr int kEngineVersion = 1;

constexpr int kMaxTyped = 20;         // MrFuzzy.MAX_TYPED
constexpr int kMaxExtraDepth = 3;     // MrFuzzy.MAX_EXTRA_DEPTH
constexpr int kMaxResults = 5;        // MrFuzzy.MAX_RESULTS
constexpr int kMaxWord = 48;          // MrFuzzy.MAX_WORD
constexpr int kInf = 1 << 20;         // MrFuzzy.INF
constexpr int kNear = 16;             // neighbours kept per touch
constexpr int kResultChars = kMaxWord * 2 + 2;  // size of each result buffer (word + space + word)
constexpr int kPowTable = 256;        // costs 0..255 have 2^(-c/25) coming from Java

// Costs (x100) and limits. The order is that of MrNative.COSTS in Java; change both together.
struct Costs {
    int prox1, prox2, proxFar, delFirst, phon, vowel, sub;
    int ins, insDouble, insH, insNear, del, delDouble;
    int trans, multi, split, nodeBudget;
    static constexpr int kCount = 17;
};

// Tables that do not depend on the language. They come from Java (Character/MrText) so they match it on
// any Android version.
struct Tables {
    Costs costs{};
    std::vector<char16_t> lower;    // 65536: Character.toLowerCase
    std::vector<uint8_t> upper;     // 65536: Character.isUpperCase (0/1)
    char16_t base256[256] = {0};    // MrText.base for 0..255
    double pow2[kPowTable] = {0};   // Math.pow(2.0, -c / 25.0), computed by Java

    char16_t baseOf(int c) const { return c < 256 ? base256[c] : lower[c & 0xFFFF]; }
    char16_t lowerOf(int c) const { return lower[c & 0xFFFF]; }
    bool isUpper(int c) const { return upper[c & 0xFFFF] != 0; }
};

// Language rules (the tables of MrRules.java).
struct Rules {
    std::vector<uint8_t> pairs = std::vector<uint8_t>(65536, 0);  // [(a << 8) | b]: 1 phonetic, 2 vowel
    std::vector<char16_t> t2a, t2b, t2d;   // groups: typed (2 letters) -> dictionary (1)
    std::vector<char16_t> d2p, d2c, d2t;   // groups: dictionary (2 letters) -> typed (1)
    std::vector<char16_t> silPrev, silChar;
    std::vector<int16_t> silCost;
    int16_t silentStart[256] = {0};
    int16_t silentAny[256] = {0};
    bool extra[256] = {false};
    bool oneLetter[256] = {false};

    int pair(int a, int b) const {
        if (a >= 256 || b >= 256) return 0;
        return pairs[(a << 8) | b];
    }
};

// Approximate search on the .dict trie (same format as dictionary.cpp). One instance at a time: Java already
// serializes the queries (synchronized) and the JNI takes a mutex.
class Fuzzy {
public:
    // dict: bytes of the .dict (read-only, alive during the call). size: size in bytes.
    void attach(const uint8_t* dict, int size);

    // tb: typed letters without accent/case (n between 1 and kMaxTyped); near: n x kNear neighbour letters of each
    // touch; nearCount: how many there are for each. Does not throw.
    void search(const Tables& t, const Rules& r, const char16_t* tb, int n, const char16_t* near, const int* nearCount);

    int count() const { return resCount_; }
    int wordLen(int i) const { return resLen_[i]; }
    const char16_t* word(int i) const { return resWord_[i]; }
    int64_t score(int i) const { return resScore_[i]; }
    int cost(int i) const { return resCost_[i]; }
    int visits() const { return visits_; }

private:
    void walk(int pos, int depth, int pcb, int parentRaw);
    void walkRoot();
    bool isPrefix() const;
    bool prefixRec(int pos, int j) const;
    int skipBigrams(int pos) const;
    void firstLetters();
    int sub(int j, int cb);
    int subCost(int cb, int j) const;
    int insCost(int j) const;
    int delCost(int cb, int pcb, int depth) const;
    int nearRank(int j, int cb) const;
    bool isNear(int j, int cb) const;
    int64_t scoreFor(int freq, int cost) const;
    void offer(const char16_t* word, int len, int freq, int cost);
    void insert(const char16_t* word, int len, int64_t score, int cost);
    void removeAt(int i);
    void setMaxCost(int max);
    void split();
    int lookup(int from, int to);
    void lookupRec(int pos, int j, int to, int depth);

    int dat(int pos) const { return dict_[pos]; }
    /** Address that starts at the flags byte (6 bits) followed by 2 bytes (format v1) or 3 bytes (v2). */
    int addrAt(int pos) const {
        int a = ((dat(pos) & 0x3F) << 8) | dat(pos + 1);
        a = (a << 8) | dat(pos + 2);
        return ab_ == 3 ? a : ((a << 8) | dat(pos + 3));
    }

    const uint8_t* dict_ = nullptr;
    int size_ = 0;
    bool latest_ = false;
    int ab_ = 3;          // bytes of an address: 3 in the dictionary format v1, 4 in v2 (header byte 1 = 2)
    int root_ = 0;
    const Tables* t_ = nullptr;
    const Rules* r_ = nullptr;

    int n_ = 0;
    char16_t tb_[kMaxTyped] = {0};
    char16_t near_[kMaxTyped][kNear] = {{0}};
    int nearCount_[kMaxTyped] = {0};
    int16_t sub_[kMaxTyped][256];
    int ins_[kMaxTyped] = {0};
    bool first_[256] = {false};
    char16_t twoD1_[kMaxTyped + 1] = {0};
    char16_t twoD2_[kMaxTyped + 1] = {0};
    int rows_[kMaxTyped + kMaxExtraDepth + 2][kMaxTyped + 1] = {{0}};
    int rowsLen_ = kMaxTyped + kMaxExtraDepth + 2;
    char16_t path_[kMaxWord + 2] = {0};
    int maxCost_ = 0;
    int band_ = 0;
    int visits_ = 0;
    int onlyTyped_ = 0;   // at the root: 1 = only the typed initial, 2 = only the other accepted ones, 3 = only the missing one, 0 = all

    int resCount_ = 0;
    char16_t resWord_[kMaxResults][kResultChars] = {{0}};
    int resLen_[kMaxResults] = {0};
    int64_t resScore_[kMaxResults] = {0};
    int resCost_[kMaxResults] = {0};

    char16_t splitBuf_[kResultChars] = {0};
    char16_t leftBuf_[kMaxWord + 1] = {0};
    char16_t lookBuf_[kMaxWord + 1] = {0};
    char16_t lookPath_[kMaxWord + 1] = {0};
    int lookFreq_ = 0;
    int lookLen_ = 0;
    // Node limit for the recursive searches that do not go through walk (isPrefix and the split lookup). In a real dictionary
    // they visit a few hundred nodes at most (measured: 41 and 379 over 43 thousand queries); in a corrupt file, with
    // cyclic pointers and repeated letters, they would grow exponentially and freeze the keyboard.
    mutable int guard_ = 0;
};

// trigrams.bin (MRT1 format, big-endian; docs/tools/make_trigrams.py in the app). The whole file is read into
// memory (3 MB) and only the indexes (4 bytes per word and per context) are kept apart. It deliberately does not use mmap:
// if a new pack replaced the file in place, reading a mapped page would bring the app down (SIGBUS).
class TriStore {
public:
    // false if the file does not exist, is not MRT1, is truncated, out of order or has invalid ids.
    bool open(const char* path);
    // Same as open() for bytes already in memory (tests). Copies.
    bool openBytes(const uint8_t* data, size_t size);
    bool isOpen() const { return !data_.empty(); }

    struct Hit {
        uint32_t id;
        int score;
    };
    // Continuations of (w1, w2). a1/a2 are the spellings of w1 (as typed and in lowercase), b1/b2 those of w2, in UTF-8
    // (null or repeated ones are accepted). Tries (a1,b1) (a1,b2) (a2,b1) (a2,b2) and returns the first context found
    // (like MrTrigram.find). Returns how many (up to max).
    int find(const std::string* a1, const std::string* a2, const std::string* b1, const std::string* b2,
             int max, Hit* out) const;
    // UTF-8 bytes of word id (without terminator). false if id is invalid.
    bool wordBytes(uint32_t id, const uint8_t** p, int* len) const;

    size_t contexts() const { return ctx_.size(); }
    size_t vocabulary() const { return word_.size(); }
    size_t indexBytes() const { return (ctx_.size() + word_.size()) * sizeof(uint32_t); }

private:
    bool parse();
    int wordId(const std::string& w) const;
    uint32_t be24(size_t p) const { return (uint32_t(data_[p]) << 16) | (uint32_t(data_[p + 1]) << 8) | data_[p + 2]; }

    std::vector<uint8_t> data_;
    std::vector<uint32_t> word_;   // position of the length byte of each word
    std::vector<uint32_t> ctx_;    // position of each context
};

// UTF-16 <-> UTF-8 conversions (the JNI uses modified UTF-8, which does not work for emoji).
std::string toUtf8(const char16_t* s, int len);
int fromUtf8(const uint8_t* s, int len, char16_t* out, int maxOut);

}  // namespace mr
