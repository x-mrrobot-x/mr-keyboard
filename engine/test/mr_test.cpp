// Native engine tests on the PC (no Java, no Android). Usage: mr_test dicts_dir [corruption_rounds]
//   dicts_dir: the project dicts/ folder (pt-BR/, en-US/, es/ with main.dict, trigrams.bin)
//
// What this program proves:
//   1. the search over the real dictionary finds obvious corrections (checks "contains", not the exact result);
//   2. a query does not depend on what came before (old dynamic-programming state does not leak);
//   3. corrupt dictionary and trigrams.bin (truncated, swapped bytes, garbage): nothing may crash, read out of the file or hang;
//   4. 2-byte character (0xFF + 2) in the dictionary, UTF-8, limits, invalid trigram files;
//   5. trigrams.bin in both formats (MRT1 and MRT2): the same data written in each (by the simple writer of test_util.h, which shares no
//      code with TriStore) answers the same on every context, on misses and on every spelling combination, and as an independent oracle says;
//      a pack replaced while the old file is open (as MrPacks.install does) leaves the open file readable.
// What it does NOT prove: the result with the app's real tables and rules. That is up to docs/tools/e2e/StrategyTest.java (live, through the JNI).
// With -DMR_SANITIZE=ON, out-of-bounds accesses and undefined behaviour become errors.
#include <algorithm>
#include <chrono>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <map>
#include <string>
#include <unordered_map>
#include <vector>

#include <sys/stat.h>
#include <unistd.h>

#include "mr_engine.h"
#include "test_util.h"

using namespace mr;
using namespace mrtest;

namespace {

int gFails = 0;
int gChecks = 0;

#define CHECK(cond, ...)                                      \
    do {                                                      \
        gChecks++;                                            \
        if (!(cond)) {                                        \
            gFails++;                                         \
            std::printf("FAIL %s:%d: ", __FILE__, __LINE__); \
            std::printf(__VA_ARGS__);                         \
            std::printf("\n");                                \
        }                                                     \
    } while (0)

struct Lang {
    const char* id;
    // typed -> word that must appear among the (up to 5) results
    std::vector<std::pair<std::string, std::string>> cases;
    std::vector<std::string> extra;   // queries only for the corruption and order-independence tests
    std::vector<std::pair<std::string, std::string>> pairs;   // common trigram pairs (at least one has a continuation)
};

std::vector<Lang> languages() {
    return {
        {"pt-BR",
         {{"obrigdo", "obrigado"}, {"sepre", "sempre"}, {"durate", "durante"}, {"vda", "vida"}, {"porisso", "por isso"}},
         {"agoa", "prte", "trabakho", "pesquiza", "hospitl", "conciencia", "qeu", "naoseiseeuvou", "ç", "Fernanda", "ÁGUA",
          "aaaaaaaaaaaaaaaaaaaa", "xyzxyzxyzxyz", "omem", "jente", "excessao", "cançado", "obrigaod", "dis", "alomde"},
         {{"de", "acordo"}, {"por", "causa"}, {"no", "entanto"}, {"em", "relação"}, {"o", "que"}, {"não", "é"}}},
        {"en-US",
         {{"recieve", "receive"}, {"wich", "which"}, {"definately", "definitely"}, {"seperate", "separate"}, {"becuase", "because"}},
         {"teh", "adn", "tommorow", "occured", "untill", "thier", "freind", "writting", "Monday", "I", "xyzxyzxyzxyz",
          "aaaaaaaaaaaaaaaaaaaa", "alot", "cantbe", "wouldnt", "goverment", "arguement", "comming"},
         {{"of", "the"}, {"in", "the"}, {"it", "is"}, {"to", "be"}, {"going", "to"}, {"i", "am"}}},
        {"es",
         {{"ecuela", "escuela"}, {"tambien", "también"}, {"porfavor", "por favor"}, {"hablr", "hablar"}, {"trabjo", "trabajo"}},
         {"ahcer", "mañna", "nesesito", "kiero", "aver", "ablar", "grasias", "Madrid", "ñandú", "xyzxyzxyzxyz",
          "aaaaaaaaaaaaaaaaaaaa", "pais", "estoy", "undia", "deacuerdo", "ademas"},
         {{"de", "la"}, {"en", "el"}, {"que", "se"}, {"es", "un"}, {"a", "la"}, {"por", "favor"}}},
    };
}

bool contains(const Fuzzy& f, const std::string& want) {
    for (int i = 0; i < f.count(); i++) {
        if (toUtf8(f.word(i), f.wordLen(i)) == want) return true;
    }
    return false;
}

void realDictionary(const std::string& dicts, const Lang& lang, const Tables& tables, const Rules& rules) {
    std::string dir = dicts + "/" + lang.id;
    auto dict = readFile(dir + "/main.dict");
    CHECK(!dict.empty(), "no %s/main.dict", dir.c_str());
    if (dict.empty()) return;
    auto rows = keyRows(lang.id);
    Fuzzy f;
    f.attach(dict.data(), static_cast<int>(dict.size()));

    // 1) obvious corrections
    int found = 0;
    for (const auto& c : lang.cases) {
        Query q;
        CHECK(makeQuery(tables, c.first, rows, &q), "query");
        f.search(tables, rules, q.tb, q.n, q.near, q.cnt);
        bool ok = contains(f, c.second);
        found += ok ? 1 : 0;
        if (!ok) std::printf("  (warning) %s: %s did not bring %s: %s\n", lang.id, c.first.c_str(), c.second.c_str(), render(f).c_str());
        // well-formed list: at most 5, scores in descending order, no repeats
        CHECK(f.count() <= kMaxResults, "more than %d results", kMaxResults);
        for (int i = 1; i < f.count(); i++) CHECK(f.score(i - 1) >= f.score(i), "score out of order in %s", c.first.c_str());
        for (int i = 0; i < f.count(); i++)
            for (int j = i + 1; j < f.count(); j++)
                CHECK(!(f.wordLen(i) == f.wordLen(j) && std::memcmp(f.word(i), f.word(j), sizeof(char16_t) * f.wordLen(i)) == 0),
                      "repeated result in %s", c.first.c_str());
    }
    // the tables and rules here are approximate: tolerate 1 case fewer, but the search must work
    CHECK(found >= static_cast<int>(lang.cases.size()) - 1, "%s: only %d of %zu obvious corrections", lang.id, found, lang.cases.size());

    // 2) order independence: a query gives the same result on a clean instance and on one that has run others
    std::vector<std::string> words;
    for (const auto& c : lang.cases) words.push_back(c.first);
    for (const auto& w : lang.extra) words.push_back(w);
    std::vector<std::string> alone;
    for (const auto& w : words) {
        Fuzzy fresh;
        fresh.attach(dict.data(), static_cast<int>(dict.size()));
        Query q;
        if (!makeQuery(tables, w, rows, &q)) { alone.push_back(""); continue; }
        fresh.search(tables, rules, q.tb, q.n, q.near, q.cnt);
        alone.push_back(render(fresh));
    }
    Fuzzy busy;
    busy.attach(dict.data(), static_cast<int>(dict.size()));
    int bad = 0;
    for (int pass = 0; pass < 2; pass++) {
        for (size_t k = 0; k < words.size(); k++) {
            size_t i = pass == 0 ? k : words.size() - 1 - k;   // 2nd round in reverse order
            Query q;
            if (!makeQuery(tables, words[i], rows, &q)) continue;
            busy.search(tables, rules, q.tb, q.n, q.near, q.cnt);
            if (render(busy) != alone[i]) {
                bad++;
                if (bad <= 3) std::printf("  ORDER DIFFERENCE %s \"%s\"\n    clean: %s\n    used: %s\n", lang.id, words[i].c_str(), alone[i].c_str(), render(busy).c_str());
            }
        }
    }
    CHECK(bad == 0, "%s: %d queries gave a different result on a used instance", lang.id, bad);
    std::printf("%-6s real dictionary: %zu obvious corrections (%d found), %zu queries without order dependence\n", lang.id,
                lang.cases.size(), found, words.size());
}

void realTrigrams(const std::string& dicts, const Lang& lang) {
    TriStore st;
    std::string path = dicts + "/" + lang.id + "/trigrams.bin";
    CHECK(st.open(path.c_str()), "open %s", path.c_str());
    CHECK(st.contexts() > 1000 && st.vocabulary() > 1000, "%s: too few contexts (%zu) or words (%zu)", lang.id, st.contexts(), st.vocabulary());
    int withNext = 0;
    for (const auto& p : lang.pairs) {
        std::string a = p.first, b = p.second;
        TriStore::Hit hits[8];
        int n = st.find(&a, &a, &b, &b, 8, hits);
        CHECK(n >= 0 && n <= 8, "count out of range");
        for (int i = 0; i < n; i++) {
            const uint8_t* w;
            int len;
            CHECK(st.wordBytes(hits[i].id, &w, &len) && len > 0, "invalid continuation id");
            CHECK(hits[i].score >= 0 && hits[i].score <= 255, "score outside 0..255");
        }
        if (n > 0) withNext++;
    }
    CHECK(withNext >= 1, "%s: none of the common pairs has a continuation (did the format change?)", lang.id);
    std::printf("%-6s real trigrams: %zu words, %zu contexts, %zu bytes of index, %d of %zu common pairs with a continuation\n", lang.id,
                st.vocabulary(), st.contexts(), st.indexBytes(), withNext, lang.pairs.size());
}

// ------------------------------------------------------------------------------------ corrupted data

struct Lcg {
    uint64_t s;
    explicit Lcg(uint64_t seed) : s(seed) {}
    uint32_t next() { s = s * 6364136223846793005ULL + 1442695040888963407ULL; return static_cast<uint32_t>(s >> 33); }
};

void corruptDict(const std::string& dicts, const Lang& lang, const Tables& tables, const Rules& rules, int rounds) {
    auto dict = readFile(dicts + "/" + lang.id + "/main.dict");
    if (dict.empty()) return;
    auto rows = keyRows(lang.id);
    std::vector<Query> qs;
    std::vector<std::string> words;
    for (const auto& c : lang.cases) words.push_back(c.first);
    for (const auto& w : lang.extra) words.push_back(w);
    for (const auto& w : words) {
        Query q;
        if (makeQuery(tables, w, rows, &q)) qs.push_back(q);
    }
    Lcg rnd(0xC0FFEE + std::strlen(lang.id));
    Fuzzy f;
    long searches = 0;
    auto t0 = std::chrono::steady_clock::now();
    for (int r = 0; r < rounds; r++) {
        std::vector<uint8_t> d = dict;
        int mode = static_cast<int>(rnd.next() % 4);
        if (mode == 0) {                       // cut at any point
            d.resize(rnd.next() % (d.size() + 1));
        } else if (mode == 1) {                // some bytes swapped
            int k = 1 + static_cast<int>(rnd.next() % 20);
            for (int i = 0; i < k; i++) d[rnd.next() % d.size()] = static_cast<uint8_t>(rnd.next());
        } else if (mode == 2) {                // many bytes swapped at the start (root and first groups)
            for (int i = 0; i < 200; i++) d[rnd.next() % std::min<size_t>(d.size(), 4096)] = static_cast<uint8_t>(rnd.next());
        } else {                               // pure garbage
            for (auto& b : d) b = static_cast<uint8_t>(rnd.next());
        }
        if (d.size() <= 2) d.resize(3, 0);
        f.attach(d.data(), static_cast<int>(d.size()));
        for (const Query& q : qs) {
            f.search(tables, rules, q.tb, q.n, q.near, q.cnt);
            searches++;
            CHECK(f.count() >= 0 && f.count() <= kMaxResults, "count out of range: %d", f.count());
            // the limit is checked at every node, but each pass that restarts counts one more before noticing (same as Java)
            CHECK(f.visits() <= tables.costs.nodeBudget + 8, "visited nodes above the limit: %d", f.visits());
            for (int i = 0; i < f.count(); i++) {
                CHECK(f.wordLen(i) >= 1 && f.wordLen(i) <= kResultChars, "invalid word length: %d", f.wordLen(i));
            }
        }
    }
    double ms = std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now() - t0).count();
    std::printf("%-6s corrupt dictionary: %d files, %ld searches, no crash; %.2f ms per search on average\n", lang.id, rounds, searches,
                ms / static_cast<double>(std::max<long>(1, searches)));
}

// Mutates a trigram file (any format) and queries the result: nothing may crash or read outside the file (ASan/UBSan), and every hit
// must have a valid id. For MRT2 the records are not checked at open, so a mutated file is expected to open often and then to be
// answered safely (fewer hits); that is what this loop proves.
void corruptTriFile(const char* lang, const char* label, const std::vector<uint8_t>& tri, const TriData& t, int rounds) {
    if (tri.empty() || t.ctx.empty()) return;
    Lcg rnd(0xBEEF + std::strlen(lang) + std::strlen(label));
    int opened = 0, verified = 0;
    long queries = 0;
    for (int r = 0; r < rounds; r++) {
        std::vector<uint8_t> d = tri;
        int mode = static_cast<int>(rnd.next() % 5);
        if (mode == 0) d.resize(rnd.next() % (d.size() + 1));
        else if (mode == 1) { int k = 1 + static_cast<int>(rnd.next() % 8); for (int i = 0; i < k; i++) d[rnd.next() % d.size()] = static_cast<uint8_t>(rnd.next()); }
        else if (mode == 2) { for (int i = 0; i < 12; i++) d[rnd.next() % std::min<size_t>(d.size(), 64)] = static_cast<uint8_t>(rnd.next()); }
        else if (mode == 3) { for (auto& x : d) x = static_cast<uint8_t>(rnd.next()); }
        else {
            // a block of garbage in the middle (records or tables)
            size_t at = rnd.next() % d.size();
            size_t len = std::min<size_t>(d.size() - at, 1 + rnd.next() % 4096);
            for (size_t i = 0; i < len; i++) d[at + i] = static_cast<uint8_t>(rnd.next());
        }
        TriStore st;
        if (!st.openBytes(d.data(), d.size())) continue;
        opened++;
        if (st.verifyAll()) verified++;
        for (int q = 0; q < 40; q++) {
            const auto& c = t.ctx[rnd.next() % t.ctx.size()];
            std::string a = t.words[c.a], b = t.words[c.b], miss = "zzzz";
            TriStore::Hit hits[8];
            int n = st.find(&a, q % 3 == 0 ? &miss : &a, &b, q % 5 == 0 ? &miss : &b, 8, hits);
            queries++;
            CHECK(n >= 0 && n <= 8, "trigram count outside the limit");
            for (int i = 0; i < n; i++) {
                const uint8_t* p;
                int len;
                CHECK(st.wordBytes(hits[i].id, &p, &len), "invalid continuation id (%s)", label);
                CHECK(hits[i].score >= 0 && hits[i].score <= 255, "score outside 0..255");
            }
        }
        // ids of any value must be refused without reading outside
        const uint8_t* p;
        int len;
        st.wordBytes(rnd.next(), &p, &len);
        st.wordBytes(0xFFFFFFFFu, &p, &len);
    }
    std::printf("%-6s corrupt trigrams.bin (%s): %d files (%d opened, %d of them with all the records valid), %ld queries, no crash\n", lang, label,
                rounds, opened, verified, queries);
}

void corruptTri(const std::string& dicts, const Lang& lang, int rounds) {
    auto tri = readFile(dicts + "/" + lang.id + "/trigrams.bin");
    TriData t;
    if (!parseTri(tri, &t)) return;
    corruptTriFile(lang.id, "as it comes", tri, t, rounds);
    // the other format too, so that both are fuzzed whatever the pack has
    bool fits2 = t.words.size() <= TriStore::kMaxWords2;
    for (const auto& c : t.ctx) if (c.c.size() > 3) fits2 = false;
    if (tri.size() >= 4 && std::memcmp(tri.data(), "MRT2", 4) == 0) corruptTriFile(lang.id, "MRT1", writeTri1(t), t, rounds);
    else if (fits2) corruptTriFile(lang.id, "MRT2", writeTri2(t), t, rounds);
}

// ------------------------------------------------------------------------------- the two formats, side by side

// What find() must return, written from scratch from the data (no TriStore).
struct Oracle {
    const TriData& t;
    std::unordered_map<std::string, int> id;
    std::map<std::pair<uint32_t, uint32_t>, const TriData::Ctx*> byKey;
    explicit Oracle(const TriData& d) : t(d) {
        for (size_t i = 0; i < d.words.size(); i++) id[d.words[i]] = static_cast<int>(i);
        for (const auto& c : d.ctx) byKey[{c.a, c.b}] = &c;
    }
    std::vector<std::pair<uint32_t, int>> find(const std::string* a1, const std::string* a2, const std::string* b1, const std::string* b2, int max) const {
        const std::string* as[2] = {a1, a2};
        const std::string* bs[2] = {b1, b2};
        for (const std::string* a : as) {
            if (!a || !id.count(*a)) continue;
            for (const std::string* b : bs) {
                if (!b || !id.count(*b)) continue;
                auto it = byKey.find({static_cast<uint32_t>(id.at(*a)), static_cast<uint32_t>(id.at(*b))});
                if (it == byKey.end()) continue;
                std::vector<std::pair<uint32_t, int>> out = it->second->c;
                if (static_cast<int>(out.size()) > max) out.resize(static_cast<size_t>(max));
                return out;
            }
        }
        return {};
    }
};

bool sameAsOracle(const TriStore& st, const Oracle& o, const std::string* a1, const std::string* a2, const std::string* b1, const std::string* b2, int max) {
    TriStore::Hit h[8];
    int n = st.find(a1, a2, b1, b2, max, h);
    auto want = o.find(a1, a2, b1, b2, max);
    if (n != static_cast<int>(want.size())) return false;
    for (int i = 0; i < n; i++) {
        if (h[i].id != want[static_cast<size_t>(i)].first || h[i].score != want[static_cast<size_t>(i)].second) return false;
    }
    return true;
}

std::string gTmp;   // temporary folder of this run

void triFormats(const std::string& dicts, const Lang& lang) {
    auto orig = readFile(dicts + "/" + lang.id + "/trigrams.bin");
    TriData t;
    CHECK(parseTri(orig, &t), "%s: the simple reader does not understand the file", lang.id);
    if (t.ctx.empty()) return;
    bool fits2 = t.words.size() <= TriStore::kMaxWords2;
    for (const auto& c : t.ctx) if (c.c.size() > 3) fits2 = false;
    CHECK(fits2, "%s: the data does not fit MRT2", lang.id);
    std::vector<uint8_t> f1 = writeTri1(t), f2 = writeTri2(t);
    // the writer of this test must reproduce the real file byte by byte (it is the one made by the Python tools)
    const bool origIs2 = orig.size() >= 4 && std::memcmp(orig.data(), "MRT2", 4) == 0;
    CHECK(origIs2 ? f2 == orig : f1 == orig, "%s: the simple writer does not reproduce the pack's file byte by byte", lang.id);
    std::string p1 = gTmp + "/" + lang.id + ".1.bin", p2 = gTmp + "/" + lang.id + ".2.bin";
    CHECK(writeFile(p1, f1) && writeFile(p2, f2), "write temporary files");

    TriStore s1, s2, h2;
    auto t0 = std::chrono::steady_clock::now();
    CHECK(s1.open(p1.c_str()), "%s: open MRT1", lang.id);
    double ms1 = std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now() - t0).count();
    t0 = std::chrono::steady_clock::now();
    CHECK(s2.open(p2.c_str()), "%s: open MRT2", lang.id);
    double ms2 = std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now() - t0).count();
    CHECK(h2.openBytes(f2.data(), f2.size()), "%s: openBytes MRT2", lang.id);
    CHECK(s1.format() == 1 && s2.format() == 2 && h2.format() == 2, "formats");
    CHECK(s1.mapped() && s2.mapped() && !h2.mapped(), "files opened by path are mapped, bytes are not");
    CHECK(s1.contexts() == t.ctx.size() && s2.contexts() == t.ctx.size(), "contexts()");
    CHECK(s1.vocabulary() == t.words.size() && s2.vocabulary() == t.words.size(), "vocabulary()");
    CHECK(s2.verifyAll() && h2.verifyAll() && s1.verifyAll(), "verifyAll on a valid file");
    CHECK(s2.indexBytes() == 0, "MRT2 must not build indexes");

    Oracle o(t);
    Lcg rnd(0x1234 + std::strlen(lang.id));
    long checks = 0, bad = 0;
    const std::string miss = "\xE2\x80\x8Bnotaword";
    auto both = [&](const std::string* a1, const std::string* a2, const std::string* b1, const std::string* b2, int max) {
        checks++;
        if (!sameAsOracle(s1, o, a1, a2, b1, b2, max) || !sameAsOracle(s2, o, a1, a2, b1, b2, max) || !sameAsOracle(h2, o, a1, a2, b1, b2, max)) {
            if (bad++ < 5) std::printf("DIFFERENT: %s | %s | %s | %s max %d\n", a1 ? a1->c_str() : "-", a2 ? a2->c_str() : "-", b1 ? b1->c_str() : "-", b2 ? b2->c_str() : "-", max);
        }
    };
    for (const auto& c : t.ctx) {
        const std::string& a = t.words[c.a];
        const std::string& b = t.words[c.b];
        both(&a, &a, &b, &b, 8);                          // as the app asks
        const int mode = static_cast<int>(rnd.next() % 6);
        if (mode == 0) both(&miss, &a, &b, &b, 3);        // second spelling of w1 is the good one
        else if (mode == 1) both(&a, &a, &miss, &b, 2);   // second spelling of w2 is the good one
        else if (mode == 2) both(&a, nullptr, &b, nullptr, 1);
        else if (mode == 3) both(&miss, &miss, &b, &b, 8);  // w1 unknown: nothing
        else if (mode == 4) both(nullptr, &a, nullptr, &b, 3);
    }
    // pairs that probably are not contexts
    const size_t V = t.words.size();
    for (int i = 0; i < 40000; i++) {
        const std::string& a = t.words[rnd.next() % V];
        const std::string& b = t.words[rnd.next() % V];
        const std::string& a2 = t.words[rnd.next() % V];
        both(&a, &a2, &b, &b, 3);
    }
    // all the words, as w1 with a w2 that has a context: the whole vocabulary is searched
    for (size_t i = 0; i < V; i += 7) both(&t.words[i], &t.words[i], &t.words[t.ctx[i % t.ctx.size()].b], &t.words[t.ctx[i % t.ctx.size()].b], 3);
    CHECK(bad == 0, "%s: %ld of %ld queries differ between the formats or from the oracle", lang.id, bad, checks);
    // wordBytes: the same words in both
    for (size_t i = 0; i < V; i += 13) {
        const uint8_t *x, *y;
        int lx, ly;
        CHECK(s1.wordBytes(static_cast<uint32_t>(i), &x, &lx) && s2.wordBytes(static_cast<uint32_t>(i), &y, &ly) && lx == ly && std::memcmp(x, y, static_cast<size_t>(lx)) == 0 &&
                  std::string(reinterpret_cast<const char*>(x), static_cast<size_t>(lx)) == t.words[i], "wordBytes %zu", i);
    }
    const uint8_t* x;
    int lx;
    CHECK(!s2.wordBytes(static_cast<uint32_t>(V), &x, &lx) && !s1.wordBytes(static_cast<uint32_t>(V), &x, &lx), "id outside the vocabulary");

    // closed store: nothing works, nothing crashes
    s2.close();
    TriStore::Hit hh[3];
    CHECK(!s2.isOpen() && s2.find(&t.words[0], &t.words[0], &t.words[0], &t.words[0], 3, hh) == 0 && s2.heapBytes() == 0, "closed store");

    // speed of the lookup (informative)
    TriStore m1, m2;
    m1.open(p1.c_str());
    m2.open(p2.c_str());
    auto timeFind = [&](const TriStore& st) {
        Lcg r2(7);
        long hit = 0;
        const int N = 100000;
        auto q0 = std::chrono::steady_clock::now();
        for (int i = 0; i < N; i++) {
            const auto& c = t.ctx[r2.next() % t.ctx.size()];
            TriStore::Hit h[3];
            hit += st.find(&t.words[c.a], &t.words[c.a], &t.words[c.b], &t.words[c.b], 3, h);
        }
        return std::chrono::duration<double, std::micro>(std::chrono::steady_clock::now() - q0).count() / N;
    };
    std::printf("%-6s MRT1 %zu bytes, open %.2f ms, heap %zu bytes, find %.2f us | MRT2 %zu bytes (%+.1f%%), open %.2f ms, heap %zu bytes, find %.2f us | %ld queries identical\n",
                lang.id, f1.size(), ms1, s1.heapBytes(), timeFind(m1), f2.size(), 100.0 * (static_cast<double>(f2.size()) - static_cast<double>(f1.size())) / static_cast<double>(f1.size()),
                ms2, s2.heapBytes(), timeFind(m2), checks);
    ::remove(p1.c_str());
    ::remove(p2.c_str());
}

// A pack is replaced while the old file is open, the way MrPacks.install does it: the new one is written in another folder, the old
// folder is deleted (unlink) and the new one takes its place (rename). The open file must go on answering as before.
void triSwap(const std::string& dicts, const Lang& lang) {
    auto orig = readFile(dicts + "/" + lang.id + "/trigrams.bin");
    TriData t;
    if (!parseTri(orig, &t) || t.ctx.size() < 10) return;
    TriData t2 = t;                       // the "new version": other data, same words
    t2.ctx.erase(t2.ctx.begin(), t2.ctx.begin() + static_cast<long>(t2.ctx.size() / 2));
    for (auto& c : t2.ctx) if (!c.c.empty()) c.c.pop_back();
    bool fits = t.words.size() <= TriStore::kMaxWords2;
    for (int fmt = 1; fmt <= 2; fmt++) {
        if (fmt == 2 && !fits) continue;
        auto bytes = [&](const TriData& d) { return fmt == 1 ? writeTri1(d) : writeTri2(d); };
        std::string root = gTmp + "/swap" + std::to_string(fmt) + lang.id;
        ::mkdir(root.c_str(), 0700);
        std::string cur = root + "/7", nw = root + "/8.tmp";
        ::mkdir(cur.c_str(), 0700);
        ::mkdir(nw.c_str(), 0700);
        CHECK(writeFile(cur + "/trigrams.bin", bytes(t)) && writeFile(nw + "/trigrams.bin", bytes(t2)), "write swap files");
        TriStore st;
        CHECK(st.open((cur + "/trigrams.bin").c_str()) && st.mapped(), "%s: open before the swap", lang.id);
        Oracle o(t), o2(t2);
        // touches a few pages before the swap, none of the others
        const auto& c0 = t.ctx[0];
        CHECK(sameAsOracle(st, o, &t.words[c0.a], &t.words[c0.a], &t.words[c0.b], &t.words[c0.b], 3), "before the swap");
        // the swap
        CHECK(::remove((cur + "/trigrams.bin").c_str()) == 0 && ::rmdir(cur.c_str()) == 0, "delete the old folder");
        CHECK(::rename(nw.c_str(), cur.c_str()) == 0, "rename the new folder");
        // the open store still reads the OLD data, all of it (every page is touched now, after the file is gone)
        long bad = 0;
        for (const auto& c : t.ctx) if (!sameAsOracle(st, o, &t.words[c.a], &t.words[c.a], &t.words[c.b], &t.words[c.b], 3)) bad++;
        CHECK(bad == 0, "%s MRT%d: %ld contexts changed under the open file after the swap", lang.id, fmt, bad);
        // reopening gives the NEW data
        TriStore st2;
        CHECK(st2.open((cur + "/trigrams.bin").c_str()), "open after the swap");
        for (const auto& c : t.ctx) if (!sameAsOracle(st2, o2, &t.words[c.a], &t.words[c.a], &t.words[c.b], &t.words[c.b], 3)) bad++;
        CHECK(bad == 0, "%s MRT%d: the reopened file does not have the new data", lang.id, fmt);
        // a file replaced by rename over the same path (atomic replace) does not touch the open one either
        CHECK(writeFile(cur + "/new.part", bytes(t)) && ::rename((cur + "/new.part").c_str(), (cur + "/trigrams.bin").c_str()) == 0, "replace by rename");
        for (const auto& c : t2.ctx) if (!sameAsOracle(st2, o2, &t.words[c.a], &t.words[c.a], &t.words[c.b], &t.words[c.b], 3)) bad++;
        CHECK(bad == 0, "%s MRT%d: replace by rename changed the open file", lang.id, fmt);
        // the store that was open is closed: the old inode is released with it (nothing to check besides not crashing)
        st.close();
        st2.close();
        ::remove((cur + "/trigrams.bin").c_str());
        ::remove((cur + "/new.part").c_str());
        ::rmdir(cur.c_str());
        ::rmdir(root.c_str());
    }
    std::printf("%-6s pack swap with the file open: old data kept by the open store, new data on reopen (MRT1 and MRT2)\n", lang.id);
}

// Small hand-made MRT2 files, valid and not.
void tinyMrt2() {
    TriStore st;
    TriData t;
    t.words = {"a", "b", "c"};
    t.ctx = {{0, 1, {{2, 100}, {0, 50}}}, {0, 2, {{1, 7}}}, {2, 0, {}}};
    auto ok = writeTri2(t);
    CHECK(st.openBytes(ok.data(), ok.size()) && st.format() == 2 && st.contexts() == 3 && st.vocabulary() == 3 && st.verifyAll(), "tiny MRT2");
    std::string a = "a", b = "b", c = "c";
    TriStore::Hit h[3];
    CHECK(st.find(&a, &a, &b, &b, 3, h) == 2 && h[0].id == 2 && h[0].score == 100 && h[1].id == 0 && h[1].score == 50, "tiny MRT2 hits");
    CHECK(st.find(&a, &a, &b, &b, 1, h) == 1 && h[0].id == 2, "max honoured");
    CHECK(st.find(&c, &c, &a, &a, 3, h) == 0, "a context without continuations gives 0 (and stops the search, like MRT1)");
    CHECK(st.find(&b, &b, &a, &a, 3, h) == 0, "no context");
    // the empty file: n = 0, m = 0
    std::vector<uint8_t> empty = {'M', 'R', 'T', '2', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    CHECK(st.openBytes(empty.data(), empty.size()) && st.contexts() == 0 && st.vocabulary() == 0 && st.verifyAll(), "empty MRT2");
    CHECK(st.find(&a, &a, &b, &b, 3, h) == 0, "empty MRT2 has no hits");
    // refused at open (each one changes one thing of a valid file)
    auto bad = [&](const char* what, std::vector<uint8_t> d) { CHECK(!st.openBytes(d.data(), d.size()), "MRT2 must be refused: %s", what); };
    { auto d = ok; d.pop_back(); bad("one byte short (the last word is cut)", d); }
    { auto d = ok; d.push_back(0); bad("one byte too many (the word section does not end at the end)", d); }
    { auto d = ok; d.resize(15); bad("cut inside the tables", d); }
    { auto d = ok; d[7] = 4; bad("n says 4 words", d); }
    { auto d = ok; d[11] = 9; bad("m says 9 records", d); }
    { auto d = ok; d[4] = 0xFF; bad("n huge", d); }
    { auto d = ok; d[12 + 3] = 1; bad("first word offset is not 0", d); }
    { auto d = ok; d[12 + 4 + 3] = 7; bad("word offsets do not add up", d); }
    { auto d = ok; size_t blob = 12 + 8 * 4 + 3 * 11; d[blob + 3] = 'a'; bad("words out of order or repeated", d); }
    { auto d = ok; size_t csr = 12 + 4 * 4; d[csr + 3] = 1; bad("row table does not start at 0", d); }
    { auto d = ok; size_t csr = 12 + 4 * 4; d[csr + 4 + 3] = 3; d[csr + 8 + 3] = 1; bad("row table goes back", d); }
    { auto d = ok; size_t csr = 12 + 4 * 4; d[csr + 4 * 3 + 3] = 2; bad("row table does not end at m", d); }
    // accepted at open, answered safely: corrupt records
    { auto d = ok; size_t rec = 12 + 8 * 4; d[rec + 2] = 0x12; d[rec + 3] = 0x34;   // id 0x1234 >= n in the first slot
      CHECK(st.openBytes(d.data(), d.size()) && !st.verifyAll() && st.find(&a, &a, &b, &b, 3, h) == 0, "record with an id outside the vocabulary: no hit, not valid"); }
    { auto d = ok; size_t rec = 12 + 8 * 4; d[rec + 2] = 0xFF; d[rec + 3] = 0xFF;   // empty first slot, filled second
      CHECK(st.openBytes(d.data(), d.size()) && !st.verifyAll() && st.find(&a, &a, &b, &b, 3, h) == 0, "empty slot before a filled one: nothing is returned"); }
    CHECK(!st.openBytes(reinterpret_cast<const uint8_t*>("MRT2"), 4), "4 bytes");
    CHECK(!st.openBytes(nullptr, 0), "null");
    std::printf("tiny MRT2 files ok\n");
}

// --------------------------------------------------------------------------------------------- edge cases

void edgeCases(const Tables& tables) {
    // Hand-made dictionary in the "latest" format: header 200,1; root at 2.
    //   2: [1] 'a' (children at 7)          root group
    //   7: [2] 'b' term f=100 no bigrams | 0xFF 0x01 0x51 (ő, U+0151) term f=90 no bigrams
    const uint8_t d[] = {200, 1,
                         1, 'a', 0x40, 0x00, 0x07,
                         2, 'b', 0x80, 100, 0x00, 0xFF, 0x01, 0x51, 0x80, 90, 0x00};
    Rules rules;
    Fuzzy f;
    f.attach(d, static_cast<int>(sizeof(d)));
    auto rows = keyRows("en-US");
    Query q;
    CHECK(makeQuery(tables, "ab", rows, &q), "query");
    f.search(tables, rules, q.tb, q.n, q.near, q.cnt);
    CHECK(f.count() == 1 && toUtf8(f.word(0), f.wordLen(0)) == "ab", "ab: expected ab, got %s", render(f).c_str());
    CHECK(makeQuery(tables, "a\xC5\x91", rows, &q), "query");
    f.search(tables, rules, q.tb, q.n, q.near, q.cnt);
    CHECK(f.count() == 1 && toUtf8(f.word(0), f.wordLen(0)) == "a\xC5\x91", "aő: expected aő (2-byte character), got %s", render(f).c_str());

    // The same dictionary in the format v2 (1.86): header 200,2 and one more byte in the address of the child group.
    //   2: [1] 'a' (children at 8)          root group
    //   8: [2] 'b' term f=100 no bigrams | 0xFF 0x01 0x51 (ő) term f=90 no bigrams
    const uint8_t d2[] = {200, 2,
                          1, 'a', 0x40, 0x00, 0x00, 0x08,
                          2, 'b', 0x80, 100, 0x00, 0xFF, 0x01, 0x51, 0x80, 90, 0x00};
    Fuzzy f2;
    f2.attach(d2, static_cast<int>(sizeof(d2)));
    CHECK(makeQuery(tables, "ab", rows, &q), "query");
    f2.search(tables, rules, q.tb, q.n, q.near, q.cnt);
    CHECK(f2.count() == 1 && toUtf8(f2.word(0), f2.wordLen(0)) == "ab", "v2 ab: expected ab, got %s", render(f2).c_str());
    CHECK(makeQuery(tables, "a\xC5\x91", rows, &q), "query");
    f2.search(tables, rules, q.tb, q.n, q.near, q.cnt);
    CHECK(f2.count() == 1 && toUtf8(f2.word(0), f2.wordLen(0)) == "a\xC5\x91", "v2 aő: got %s", render(f2).c_str());

    // The address of v2 has 6 + 24 bits: a child group placed at 0x500000 (5 MB, past the 22 bits of v1) and another at 0xC00000 (bit 23).
    for (uint32_t at : {0x500000u, 0xC00000u, 0xFFFFF0u}) {
        std::vector<uint8_t> big(at + 8, 0);
        big[0] = 200; big[1] = 2;
        big[2] = 1; big[3] = 'a'; big[4] = 0x40 | static_cast<uint8_t>(at >> 24); big[5] = (at >> 16) & 0xFF; big[6] = (at >> 8) & 0xFF; big[7] = at & 0xFF;
        big[at] = 1; big[at + 1] = 'b'; big[at + 2] = 0x80; big[at + 3] = 100; big[at + 4] = 0x00;
        Fuzzy fb;
        fb.attach(big.data(), static_cast<int>(big.size()));
        CHECK(makeQuery(tables, "ab", rows, &q), "query");
        fb.search(tables, rules, q.tb, q.n, q.near, q.cnt);
        CHECK(fb.count() == 1 && toUtf8(fb.word(0), fb.wordLen(0)) == "ab", "v2 child group at 0x%X: got %s", at, render(fb).c_str());
        // the same bytes with the header of v1 would read the address in 22 bits and not find it: the header decides
        big[1] = 1;
        Fuzzy fo;
        fo.attach(big.data(), static_cast<int>(big.size()));
        fo.search(tables, rules, q.tb, q.n, q.near, q.cnt);
        CHECK(fo.count() == 0 || toUtf8(fo.word(0), fo.wordLen(0)) != "ab", "v1 header must not read a v2 address as v2 (at 0x%X)", at);
    }

    // minimum and null sizes must not crash
    Fuzzy g;
    g.search(tables, rules, q.tb, q.n, q.near, q.cnt);   // without attach
    CHECK(g.count() == 0, "no dictionary must give 0 results");
    const uint8_t tiny[] = {200, 1};
    g.attach(tiny, 2);
    g.search(tables, rules, q.tb, q.n, q.near, q.cnt);
    CHECK(g.count() == 0, "2-byte dictionary must give 0 results");

    // UTF-8: round trip, surrogate pair, invalid sequences
    const char16_t emoji[] = {0xD83D, 0xDE00, u'a', 0x00E7, 0x20AC};
    std::string u8 = toUtf8(emoji, 5);
    CHECK(u8 == "\xF0\x9F\x98\x80" "a" "\xC3\xA7" "\xE2\x82\xAC", "toUtf8 with surrogate pair");
    char16_t back[16];
    int n = fromUtf8(reinterpret_cast<const uint8_t*>(u8.data()), static_cast<int>(u8.size()), back, 16);
    CHECK(n == 5 && std::memcmp(back, emoji, sizeof(emoji)) == 0, "fromUtf8 round trip");
    const uint8_t bad1[] = {0xE2, 0x82};            // cut off
    CHECK(fromUtf8(bad1, 2, back, 16) >= 1, "truncated UTF-8 gives something, without reading out of bounds");
    const uint8_t bad2[] = {0xC0, 0x80, 0xFF, 0xED, 0xA0, 0x80};   // overlong, invalid, surrogate
    n = fromUtf8(bad2, 6, back, 16);
    bool allRepl = true;
    for (int i = 0; i < n; i++) if (back[i] != 0xFFFD) allRepl = false;
    CHECK(n >= 1 && allRepl, "invalid UTF-8 becomes U+FFFD");
    char16_t tiny16[2];
    CHECK(fromUtf8(reinterpret_cast<const uint8_t*>(u8.data()), static_cast<int>(u8.size()), tiny16, 2) <= 2, "small output does not overflow");

    // trigrams: files that are not MRT1 or MRT2 (a MRT2 header with absurd sizes is refused too)
    TriStore st;
    CHECK(!st.open("/nao/existe.bin"), "nonexistent file");
    CHECK(!st.openBytes(reinterpret_cast<const uint8_t*>("MRT2aaaaaaaa"), 12), "wrong magic");
    const uint8_t zero[12] = {'M', 'R', 'T', '1', 0, 0, 0, 0, 0, 0, 0, 0};
    CHECK(st.openBytes(zero, 12) && st.contexts() == 0 && st.vocabulary() == 0, "valid empty file");
    const uint8_t outOfOrder[] = {'M', 'R', 'T', '1', 0, 0, 0, 2, 1, 'b', 1, 'a', 0, 0, 0, 0};
    CHECK(!st.openBytes(outOfOrder, sizeof(outOfOrder)), "words out of order");
    std::printf("edge cases ok\n");
}

}  // namespace

int main(int argc, char** argv) {
    if (argc < 2) {
        std::printf("usage: mr_test dicts_dir [corruption_rounds]\n");
        return 2;
    }
    std::string dicts = argv[1];
    int rounds = argc > 2 ? std::atoi(argv[2]) : 100;
    Tables tables;
    approxTables(tables);
    Rules rules;
    approxRules(rules);
    std::printf("engine contract: version %d, %d costs, node limit %d (approximate tables and rules: the real ones are StrategyTest's job)\n",
                kEngineVersion, Costs::kCount, tables.costs.nodeBudget);
    char tmpl[] = "/tmp/mr_test_XXXXXX";
    const char* tmp = ::mkdtemp(tmpl);
    gTmp = tmp != nullptr ? tmp : "/tmp";
    edgeCases(tables);
    tinyMrt2();
    std::vector<Lang> langs = languages();
    for (const Lang& l : langs) realDictionary(dicts, l, tables, rules);
    for (const Lang& l : langs) realTrigrams(dicts, l);
    for (const Lang& l : langs) triFormats(dicts, l);
    for (const Lang& l : langs) triSwap(dicts, l);
    for (const Lang& l : langs) corruptDict(dicts, l, tables, rules, rounds);
    for (const Lang& l : langs) corruptTri(dicts, l, rounds * 4);
    if (tmp != nullptr) ::rmdir(tmp);
    if (gFails == 0) std::printf("ALL OK (%d checks)\n", gChecks); else std::printf("%d FAILURE(S) out of %d checks\n", gFails, gChecks);
    return gFails == 0 ? 0 : 1;
}
