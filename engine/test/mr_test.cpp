// Native engine tests on the PC (no Java, no Android). Usage: mr_test dicts_dir [corruption_rounds]
//   dicts_dir: the project dicts/ folder (pt-BR/, en-US/, es/ with main.dict, trigrams.bin)
//
// What this program proves:
//   1. the search over the real dictionary finds obvious corrections (checks "contains", not the exact result);
//   2. a query does not depend on what came before (old dynamic-programming state does not leak);
//   3. corrupt dictionary and trigrams.bin (truncated, swapped bytes, garbage): nothing may crash, read out of the file or hang;
//   4. 2-byte character (0xFF + 2) in the dictionary, UTF-8, limits, invalid trigram files.
// What it does NOT prove: a result identical to Java. That is up to docs/tools/e2e/NativeParity.java (live, with the Java tables).
// With -DMR_SANITIZE=ON, out-of-bounds accesses and undefined behaviour become errors.
#include <algorithm>
#include <chrono>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

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

void corruptTri(const std::string& dicts, const Lang& lang, int rounds) {
    auto tri = readFile(dicts + "/" + lang.id + "/trigrams.bin");
    if (tri.empty()) return;
    Lcg rnd(0xBEEF + std::strlen(lang.id));
    int opened = 0;
    std::string a = "de", b = "casa", c = "Casa";
    for (int r = 0; r < rounds; r++) {
        std::vector<uint8_t> d = tri;
        int mode = static_cast<int>(rnd.next() % 4);
        if (mode == 0) d.resize(rnd.next() % (d.size() + 1));
        else if (mode == 1) { int k = 1 + static_cast<int>(rnd.next() % 8); for (int i = 0; i < k; i++) d[rnd.next() % d.size()] = static_cast<uint8_t>(rnd.next()); }
        else if (mode == 2) { for (int i = 0; i < 12; i++) d[rnd.next() % std::min<size_t>(d.size(), 64)] = static_cast<uint8_t>(rnd.next()); }
        else { for (auto& x : d) x = static_cast<uint8_t>(rnd.next()); }
        TriStore st;
        if (st.openBytes(d.data(), d.size())) {
            opened++;
            // open = everything checked: any query must work
            TriStore::Hit hits[8];
            int n = st.find(&a, &b, &b, &c, 8, hits);
            CHECK(n >= 0 && n <= 8, "trigram count outside the limit");
            for (int i = 0; i < n; i++) {
                const uint8_t* p;
                int len;
                CHECK(st.wordBytes(hits[i].id, &p, &len), "invalid continuation id after open");
            }
        }
    }
    std::printf("%-6s corrupt trigrams.bin: %d files (%d still valid), no crash\n", lang.id, rounds, opened);
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

    // trigrams: files that are not MRT1
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
    std::printf("engine contract: version %d, %d costs, node limit %d (approximate tables and rules: parity with Java is NativeParity's job)\n",
                kEngineVersion, Costs::kCount, tables.costs.nodeBudget);
    edgeCases(tables);
    std::vector<Lang> langs = languages();
    for (const Lang& l : langs) realDictionary(dicts, l, tables, rules);
    for (const Lang& l : langs) realTrigrams(dicts, l);
    for (const Lang& l : langs) corruptDict(dicts, l, tables, rules, rounds);
    for (const Lang& l : langs) corruptTri(dicts, l, rounds * 4);
    if (gFails == 0) std::printf("ALL OK (%d checks)\n", gChecks); else std::printf("%d FAILURE(S) out of %d checks\n", gFails, gChecks);
    return gFails == 0 ? 0 : 1;
}
