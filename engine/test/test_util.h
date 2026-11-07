// Functions shared by the test and measurement programs (mr_test, mr_bench).
//
// These C++ tests use APPROXIMATE letter tables and rules (ASCII + Latin-1): they do not reproduce the app's real ones, which come
// from the Java at start-up. The real tables and rules are exercised by docs/tools/e2e/StrategyTest.java through the JNI, with the
// dicts/ dictionaries, in the app CI. Here they serve to exercise the search, corrupt files, trigram reading and edge cases,
// with ASan/UBSan.
#pragma once

#include <algorithm>
#include <cmath>
#include <cstdint>
#include <cstring>
#include <fstream>
#include <stdexcept>
#include <iterator>
#include <string>
#include <utility>
#include <vector>

#include "mr_engine.h"

namespace mrtest {

using namespace mr;

inline std::vector<uint8_t> readFile(const std::string& path) {
    std::ifstream f(path, std::ios::binary);
    if (!f) return {};
    return std::vector<uint8_t>((std::istreambuf_iterator<char>(f)), std::istreambuf_iterator<char>());
}

inline std::u16string utf16(const std::string& s) {
    std::vector<char16_t> buf(s.size() + 2);
    int n = fromUtf8(reinterpret_cast<const uint8_t*>(s.data()), static_cast<int>(s.size()), buf.data(), static_cast<int>(buf.size()));
    return std::u16string(buf.data(), static_cast<size_t>(n));
}

// Costs from MrFuzzy.java (1.77). The app's own arrive through the JNI; here they are only for the test.
inline void approxCosts(Costs& k) {
    k.prox1 = 25; k.prox2 = 30; k.proxFar = 35; k.delFirst = 30; k.phon = 25; k.vowel = 45; k.sub = 75;
    k.ins = 60; k.insDouble = 30; k.insH = 40; k.insNear = 45; k.del = 40; k.delDouble = 30;
    k.trans = 40; k.multi = 35; k.split = 35; k.nodeBudget = 12000;
}

// Approximate letter tables: ASCII and Latin-1 uppercase (the dictionary has no letters above U+00FF).
inline void approxTables(Tables& t) {
    approxCosts(t.costs);
    t.lower.assign(65536, 0);
    t.upper.assign(65536, 0);
    for (int c = 0; c < 65536; c++) t.lower[c] = static_cast<char16_t>(c);
    for (int c = 'A'; c <= 'Z'; c++) { t.lower[c] = static_cast<char16_t>(c + 32); t.upper[c] = 1; }
    for (int c = 0xC0; c <= 0xDE; c++) {
        if (c == 0xD7) continue;
        t.lower[c] = static_cast<char16_t>(c + 32);
        t.upper[c] = 1;
    }
    for (int c = 0; c < 256; c++) {
        int b = t.lower[c];
        if ((b >= 0xE0 && b <= 0xE5)) b = 'a';
        else if (b == 0xE7) b = 'c';
        else if (b >= 0xE8 && b <= 0xEB) b = 'e';
        else if (b >= 0xEC && b <= 0xEF) b = 'i';
        else if (b == 0xF1) b = 'n';
        else if ((b >= 0xF2 && b <= 0xF6)) b = 'o';
        else if (b >= 0xF9 && b <= 0xFC) b = 'u';
        else if (b == 0xFD || b == 0xFF) b = 'y';
        t.base256[c] = static_cast<char16_t>(b);
    }
    for (int i = 0; i < kPowTable; i++) t.pow2[i] = std::pow(2.0, -i / 25.0);
}

// Fake language rules, but covering every kind (phonetic pair, vowel, groups both ways, silent letter at the
// start, after another one and after any one, extra letter, one-letter word), so the search goes through every
// branches.
inline void approxRules(Rules& r) {
    auto pair = [&](char a, char b, uint8_t kind) { r.pairs[(a << 8) | b] = kind; r.pairs[(b << 8) | a] = kind; };
    pair('s', 'z', 1); pair('c', 's', 1); pair('x', 'z', 1); pair('g', 'j', 1); pair('k', 'c', 1); pair('q', 'k', 1);
    pair('e', 'i', 2); pair('o', 'u', 2); pair('a', 'e', 2);
    r.t2a = {u'c', u's'};  r.t2b = {u'h', u's'};  r.t2d = {u'x', u'c'};   // typed "ch" = x in the dictionary; "ss" = c
    r.d2p = {u's', u'x'};  r.d2c = {u's', u'c'};  r.d2t = {u'c', u'x'};   // "ss" in the dictionary = typed c; "xc" = x
    r.silPrev = {u'n', u'r'};  r.silChar = {u'h', u'h'};  r.silCost = {35, 35};
    r.silentStart[static_cast<int>('h')] = 30;
    r.silentAny[static_cast<int>('u')] = 45;
    r.extra[static_cast<int>('h')] = true;
    r.oneLetter[static_cast<int>('a')] = true;
    r.oneLetter[static_cast<int>('e')] = true;
    r.oneLetter[static_cast<int>('o')] = true;
}

// Search input as MrFuzzy.search prepares it: tb = letters without accent; near = neighbour keys of each touch.
struct Query {
    int n = 0;
    char16_t tb[kMaxTyped] = {0};
    char16_t near[kMaxTyped * kNear] = {0};
    int cnt[kMaxTyped] = {0};
};

// Neighbours on a QWERTY keyboard (left, right, up, up-right, down-left, down), as E2ETest.codesFor.
inline std::u16string qwertyNear(char16_t c, const std::vector<std::string>& rows) {
    std::u16string out;
    for (size_t r = 0; r < rows.size(); r++) {
        std::u16string row = utf16(rows[r]);
        size_t k = row.find(c);
        if (k == std::u16string::npos) continue;
        int dr[6] = {0, 0, -1, -1, 1, 1};
        int dk[6] = {-1, 1, 0, 1, -1, 0};
        for (int i = 0; i < 6; i++) {
            int rr = static_cast<int>(r) + dr[i], kk = static_cast<int>(k) + dk[i];
            if (rr < 0 || rr >= static_cast<int>(rows.size()) || kk < 0) continue;
            std::u16string other = utf16(rows[rr]);
            if (kk >= static_cast<int>(other.size())) continue;
            out.push_back(other[kk]);
        }
    }
    return out;
}

inline bool makeQuery(const Tables& t, const std::string& typed, const std::vector<std::string>& rows, Query* q) {
    std::u16string w = utf16(typed);
    q->n = static_cast<int>(std::min<size_t>(w.size(), kMaxTyped));
    if (q->n < 1) return false;
    for (int j = 0; j < q->n; j++) {
        q->tb[j] = t.baseOf(w[j]);
        q->cnt[j] = 0;
        std::u16string nj = qwertyNear(t.lowerOf(w[j]), rows);
        for (char16_t c : nj) {
            char16_t b = t.baseOf(c);
            if (b == q->tb[j] || q->cnt[j] >= kNear) continue;
            q->near[j * kNear + q->cnt[j]++] = b;
        }
    }
    return true;
}

inline std::string render(const Fuzzy& f) {
    std::string out;
    for (int i = 0; i < f.count(); i++) {
        out += toUtf8(f.word(i), f.wordLen(i));
        out += "|" + std::to_string(f.score(i)) + "|" + std::to_string(f.cost(i)) + ";";
    }
    out += "v=" + std::to_string(f.visits());
    return out;
}

inline std::vector<std::string> keyRows(const std::string& lang) {
    if (lang == "pt-BR") return {"qwertyuiop", "asdfghjklç", "zxcvbnm"};
    if (lang == "es") return {"qwertyuiop", "asdfghjklñ", "zxcvbnm"};
    return {"qwertyuiop", "asdfghjkl", "zxcvbnm"};
}

// ------------------------------------------------------------------------------------------ trigrams.bin, independent of TriStore
// A second, simple reader and writer of the two formats (MRT1 and MRT2), so that the tests can build the same data in both formats and compare
// what TriStore answers. It shares no code with TriStore or with docs/tools/mrt_format.py (a third implementation, in Python).

struct TriData {
    std::vector<std::string> words;
    struct Ctx {
        uint32_t a, b;
        std::vector<std::pair<uint32_t, int>> c;   // (id, score)
    };
    std::vector<Ctx> ctx;
};

inline uint32_t rdBe(const std::vector<uint8_t>& d, size_t p, int bytes) {
    uint32_t v = 0;
    for (int i = 0; i < bytes; i++) v = (v << 8) | d.at(p + static_cast<size_t>(i));   // at(): a wrong file throws, it does not read outside
    return v;
}

inline void putBe(std::vector<uint8_t>& o, uint32_t v, int bytes) {
    for (int i = bytes - 1; i >= 0; i--) o.push_back(static_cast<uint8_t>(v >> (8 * i)));
}

// false = not a valid MRT1/MRT2 (or too big for this simple reader)
inline bool parseTri(const std::vector<uint8_t>& d, TriData* t) {
    try {
        t->words.clear();
        t->ctx.clear();
        if (d.size() < 12) return false;
        std::string magic(d.begin(), d.begin() + 4);
        if (magic == "MRT1") {
            uint32_t n = rdBe(d, 4, 4);
            size_t p = 8;
            for (uint32_t i = 0; i < n; i++) {
                size_t len = d.at(p);
                t->words.emplace_back(d.begin() + static_cast<long>(p) + 1, d.begin() + static_cast<long>(p) + 1 + static_cast<long>(len));
                p += 1 + len;
            }
            uint32_t m = rdBe(d, p, 4);
            p += 4;
            for (uint32_t i = 0; i < m; i++) {
                TriData::Ctx c;
                c.a = rdBe(d, p, 3);
                c.b = rdBe(d, p + 3, 3);
                int k = d.at(p + 6);
                p += 7;
                for (int j = 0; j < k; j++) { c.c.push_back({rdBe(d, p, 3), d.at(p + 3)}); p += 4; }
                t->ctx.push_back(c);
            }
            return p == d.size();
        }
        if (magic == "MRT2") {
            uint32_t n = rdBe(d, 4, 4), m = rdBe(d, 8, 4);
            size_t off = 12, csr = off + 4 * (static_cast<size_t>(n) + 1), rec = csr + 4 * (static_cast<size_t>(n) + 1);
            size_t blob = rec + static_cast<size_t>(m) * 11;
            for (uint32_t i = 0; i < n; i++) {
                size_t p = blob + rdBe(d, off + 4 * i, 4);
                size_t len = d.at(p);
                t->words.emplace_back(d.begin() + static_cast<long>(p) + 1, d.begin() + static_cast<long>(p) + 1 + static_cast<long>(len));
            }
            for (uint32_t a = 0; a < n; a++) {
                for (uint32_t r = rdBe(d, csr + 4 * a, 4); r < rdBe(d, csr + 4 * (a + 1), 4); r++) {
                    size_t p = rec + static_cast<size_t>(r) * 11;
                    TriData::Ctx c;
                    c.a = a;
                    c.b = rdBe(d, p, 2);
                    for (int j = 0; j < 3; j++) {
                        uint32_t id = rdBe(d, p + 2 + 3 * static_cast<size_t>(j), 2);
                        if (id != 0xFFFF) c.c.push_back({id, d.at(p + 4 + 3 * static_cast<size_t>(j))});
                    }
                    t->ctx.push_back(c);
                }
            }
            return true;
        }
    } catch (const std::exception&) {
    }
    return false;
}

inline std::vector<uint8_t> writeTri1(const TriData& t) {
    std::vector<uint8_t> o = {'M', 'R', 'T', '1'};
    putBe(o, static_cast<uint32_t>(t.words.size()), 4);
    for (const auto& w : t.words) { o.push_back(static_cast<uint8_t>(w.size())); o.insert(o.end(), w.begin(), w.end()); }
    putBe(o, static_cast<uint32_t>(t.ctx.size()), 4);
    for (const auto& c : t.ctx) {
        putBe(o, c.a, 3);
        putBe(o, c.b, 3);
        o.push_back(static_cast<uint8_t>(c.c.size()));
        for (const auto& x : c.c) { putBe(o, x.first, 3); o.push_back(static_cast<uint8_t>(x.second)); }
    }
    return o;
}

// Needs: at most 65535 words and 3 continuations per context (the caller makes sure).
inline std::vector<uint8_t> writeTri2(const TriData& t) {
    std::vector<uint8_t> o = {'M', 'R', 'T', '2'};
    const uint32_t n = static_cast<uint32_t>(t.words.size());
    putBe(o, n, 4);
    putBe(o, static_cast<uint32_t>(t.ctx.size()), 4);
    uint32_t pos = 0;
    for (const auto& w : t.words) { putBe(o, pos, 4); pos += 1 + static_cast<uint32_t>(w.size()); }
    putBe(o, pos, 4);
    std::vector<uint32_t> first(n + 1, 0);
    for (const auto& c : t.ctx) first[c.a + 1]++;
    for (uint32_t i = 0; i < n; i++) first[i + 1] += first[i];
    for (uint32_t i = 0; i <= n; i++) putBe(o, first[i], 4);
    for (const auto& c : t.ctx) {
        putBe(o, c.b, 2);
        for (size_t j = 0; j < 3; j++) {
            if (j < c.c.size()) { putBe(o, c.c[j].first, 2); o.push_back(static_cast<uint8_t>(c.c[j].second)); }
            else { putBe(o, 0xFFFF, 2); o.push_back(0); }
        }
    }
    for (const auto& w : t.words) { o.push_back(static_cast<uint8_t>(w.size())); o.insert(o.end(), w.begin(), w.end()); }
    return o;
}

inline bool writeFile(const std::string& path, const std::vector<uint8_t>& d) {
    std::ofstream f(path, std::ios::binary | std::ios::trunc);
    if (!f) return false;
    f.write(reinterpret_cast<const char*>(d.data()), static_cast<std::streamsize>(d.size()));
    return static_cast<bool>(f);
}

}  // namespace mrtest
