// Mr Keyboard - native engine, stage 1.
//
// C++ port of the two heaviest parts of the app, which used to run only in Java:
//   - Fuzzy:    the correction search (MrFuzzy.java: weighted edit distance over the .dict trie,
//               passes, splitting of run-together words);
//   - TriStore: the trigram lookup (MrTrigram.java: trigrams.bin file, MRT1 and, since 1.90, MRT2 formats).
// main.dict is the same as before; trigrams.bin has a second, denser format (see TriStore).
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

// trigrams.bin, two formats, both big-endian, told apart by the first four bytes (layouts in docs/tools/make_trigrams.py
// and docs/tools/convert_trigrams.py in the app):
//   MRT1 (until 1.89): variable-size contexts. At open the lib checks the file and builds two index vectors (4 bytes per word
//        and per context, about 1.2 MB), so the file is searched through positions kept on the heap.
//   MRT2 (1.90): fixed-size records, 11 bytes each, plus two offset tables stored IN the file. Nothing is built at open, so
//        nothing is kept on the heap: the lookup walks the file itself.
// Both are mapped into memory (mmap, read-only, MADV_RANDOM) instead of being copied to the heap. This is safe because a pack is
// never changed in place: MrPacks writes the new version in another folder and renames it; the old folder is deleted with unlink,
// which keeps the mapped inode alive until the lib closes it. Nobody truncates or rewrites a file that is open. If mmap fails the
// file is read into the heap and everything works the same way (only the memory accounting changes).
// Identical results: the word ids are the same in both formats, so find() gives the same hits, in the same order, for the same data
// (docs/tools/e2e/ and engine/test/ compare the two).
class TriStore {
public:
    TriStore() = default;
    ~TriStore() { release(); }
    TriStore(const TriStore&) = delete;
    TriStore& operator=(const TriStore&) = delete;

    // false if the file does not exist, is neither MRT1 nor MRT2, is truncated, out of order or (MRT1) has invalid ids.
    // MRT2 checks at open everything that is O(words): size, offsets, word order, row table. The records (the big part) are
    // checked at each access instead, so a corrupt record gives fewer or no hits, never a read outside the file; verifyAll()
    // checks them all (tests and tools).
    bool open(const char* path);
    // Same as open() for bytes already in memory (tests). Copies.
    bool openBytes(const uint8_t* data, size_t size);
    bool isOpen() const { return base_ != nullptr; }
    void close() { release(); }

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

    // MRT2 only (MRT1 is always checked at open): checks every record once. false = some record is out of order or has an
    // invalid id.
    bool verifyAll() const;

    int format() const { return fmt_; }                 // 1, 2 or 0 (closed)
    bool mapped() const { return map_ != nullptr; }
    size_t fileBytes() const { return size_; }
    size_t contexts() const { return fmt_ == 2 ? m_ : ctx_.size(); }
    size_t vocabulary() const { return fmt_ == 2 ? n_ : word_.size(); }
    // Heap taken by the indexes built at open (MRT1) - 0 in MRT2.
    size_t indexBytes() const { return (ctx_.size() + word_.size()) * sizeof(uint32_t); }
    // Heap taken in total: indexes + the file itself when it could not be mapped.
    size_t heapBytes() const { return indexBytes() + heap_.size(); }

    // MRT2 limits (the ids take 16 bits, 0xFFFF marks an empty slot).
    static constexpr uint32_t kMaxWords2 = 65535;
    static constexpr int kSlots2 = 3;
    static constexpr size_t kRecord2 = 2 + kSlots2 * 3;   // b u16 + 3 x (id u16, score u8)

private:
    void release();
    bool load();
    bool parse1();
    bool parse2();
    bool wordAt(uint32_t id, size_t* at, int* len) const;
    int wordId(const std::string& w) const;
    int find1(int ia, int ib, int max, Hit* out, bool* found) const;
    int find2(int ia, int ib, int max, Hit* out, bool* found) const;
    uint32_t be16(size_t p) const { return (uint32_t(base_[p]) << 8) | base_[p + 1]; }
    uint32_t be24(size_t p) const { return (uint32_t(base_[p]) << 16) | (uint32_t(base_[p + 1]) << 8) | base_[p + 2]; }
    uint32_t be32(size_t p) const {
        return (uint32_t(base_[p]) << 24) | (uint32_t(base_[p + 1]) << 16) | (uint32_t(base_[p + 2]) << 8) | base_[p + 3];
    }

    const uint8_t* base_ = nullptr;   // the file: mapped (map_) or copied (heap_)
    size_t size_ = 0;
    std::vector<uint8_t> heap_;       // only when the file could not be mapped (or openBytes)
    void* map_ = nullptr;
    size_t mapLen_ = 0;
    int fmt_ = 0;
    // MRT1
    std::vector<uint32_t> word_;   // position of the length byte of each word
    std::vector<uint32_t> ctx_;    // position of each context
    // MRT2: sections of the file (positions, all checked at open)
    uint32_t n_ = 0, m_ = 0;       // words, records
    size_t offAt_ = 0;             // (n+1) x u32: start of each word in the word section (+ end)
    size_t csrAt_ = 0;             // (n+1) x u32: first record of each first word (+ m)
    size_t recAt_ = 0;             // m x 11 bytes
    size_t blobAt_ = 0;            // word section: n x (u8 length + UTF-8)
};

// UTF-16 <-> UTF-8 conversions (the JNI uses modified UTF-8, which does not work for emoji).
std::string toUtf8(const char16_t* s, int len);
int fromUtf8(const uint8_t* s, int len, char16_t* out, int maxOut);

}  // namespace mr
