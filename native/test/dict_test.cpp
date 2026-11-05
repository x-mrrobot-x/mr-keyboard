// Tests a generated dictionary with the original Hacker's Keyboard reader (dictionary.cpp).
//
// Compile on the PC (-funsigned-char reproduces the unsigned char of ARM; without it you can see the
// x86 defect with accents in the bigrams):
//   g++ -O2 -funsigned-char -I<Hacker's Keyboard cpp> dict_test.cpp \
//       <cpp>/dictionary.cpp <cpp>/char_utils.cpp -o dict_test
//
// Usage: dict_test file.dict words.tsv [bigrams.tsv] [queries.tsv] [repetitions]
//   words.tsv   : word<TAB>f        -> all must pass isValidWord
//   bigrams.tsv : previous<TAB>next<TAB>f, grouped by "previous" in the order stored in the
//                 dictionary -> getBigrams with all the initials (like MrText.allInitials)
//                 must return exactly these words with these frequencies
//   queries.tsv : typed<TAB>expected -> expected must appear in getSuggestions
//   repetitions : repeats the queries to measure time (default 20)
#include <chrono>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <fstream>
#include <map>
#include <set>
#include <string>
#include <vector>
#include "dictionary.h"

using namespace latinime;

static std::vector<unsigned short> utf16(const std::string &s) {
    std::vector<unsigned short> out;
    for (size_t i = 0; i < s.size();) {
        unsigned char c = s[i];
        unsigned int cp;
        int n;
        if (c < 0x80) { cp = c; n = 1; }
        else if ((c >> 5) == 6) { cp = c & 0x1F; n = 2; }
        else if ((c >> 4) == 14) { cp = c & 0x0F; n = 3; }
        else { cp = c & 0x07; n = 4; }
        for (int k = 1; k < n; k++) cp = (cp << 6) | (s[i + k] & 0x3F);
        out.push_back((unsigned short) cp);
        i += n;
    }
    return out;
}

static std::string utf8(const unsigned short *w, int max) {
    std::string o;
    for (int i = 0; i < max && w[i]; i++) {
        unsigned int c = w[i];
        if (c < 0x80) o += (char) c;
        else if (c < 0x800) { o += (char) (0xC0 | (c >> 6)); o += (char) (0x80 | (c & 0x3F)); }
        else { o += (char) (0xE0 | (c >> 12)); o += (char) (0x80 | ((c >> 6) & 0x3F)); o += (char) (0x80 | (c & 0x3F)); }
    }
    return o;
}

static std::vector<std::string> split(const std::string &s) {
    std::vector<std::string> v;
    size_t a = 0, b;
    while ((b = s.find('\t', a)) != std::string::npos) { v.push_back(s.substr(a, b - a)); a = b + 1; }
    v.push_back(s.substr(a));
    return v;
}

static double now_ms() {
    return std::chrono::duration<double, std::milli>(
            std::chrono::steady_clock::now().time_since_epoch()).count();
}

// Same initials as MrText.allInitials()
static const char *INITIALS = "abcdefghijklmnopqrstuvwxyzàáâãéêíóôõúüçABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÉÊÍÓÔÕÚÜÇ";

int main(int argc, char **argv) {
    if (argc < 3) { fprintf(stderr, "usage: %s dict words.tsv [bigrams.tsv] [queries.tsv] [rep]\n", argv[0]); return 2; }
    FILE *f = fopen(argv[1], "rb");
    if (!f) { perror(argv[1]); return 2; }
    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    fseek(f, 0, SEEK_SET);
    unsigned char *buf = (unsigned char *) malloc(size);
    if (fread(buf, 1, size, f) != (size_t) size) { perror("fread"); return 2; }
    fclose(f);
    // Same parameters as BinaryDictionary.loadDictionary: openNative(buf, 2, 2, size)
    Dictionary dict(buf, 2, 2, (int) size);
    int fails = 0;

    // 1) all the words are valid
    {
        std::ifstream in(argv[2]);
        std::string line;
        long total = 0, bad = 0;
        double t0 = now_ms();
        while (std::getline(in, line)) {
            if (line.empty()) continue;
            std::string w = split(line)[0];
            std::vector<unsigned short> u = utf16(w);
            total++;
            if (!dict.isValidWord(u.data(), (int) u.size())) {
                if (bad < 10) printf("INVALID: %s\n", w.c_str());
                bad++;
            }
        }
        printf("isValidWord: %ld/%ld valid (%.1f ms)\n", total - bad, total, now_ms() - t0);
        const char *nonwords[] = {"xqzwv", "nao", "voce", "abcdefghij", "obrigadoo", "náo"};
        for (const char *nw : nonwords) {
            std::vector<unsigned short> u = utf16(nw);
            bool v = dict.isValidWord(u.data(), (int) u.size());
            printf("  non-word %-10s valid=%d\n", nw, v);
            if (v) fails++;
        }
        if (bad) fails++;
    }

    // 2) bigrams: getBigrams returns exactly what was stored
    if (argc > 3 && strcmp(argv[3], "-") != 0) {
        std::vector<unsigned short> init = utf16(INITIALS);
        std::set<unsigned short> initSet(init.begin(), init.end());
        const int MAXLEN = 48, MAXB = 60;
        std::vector<int> codes(48 * 16, -1);
        for (size_t i = 0; i < init.size(); i++) codes[i] = init[i];
        std::ifstream in(argv[3]);
        std::string line;
        std::vector<std::pair<std::string, std::vector<std::pair<std::string, int>>>> groups;
        while (std::getline(in, line)) {
            if (line.empty()) continue;
            std::vector<std::string> p = split(line);
            if (groups.empty() || groups.back().first != p[0]) groups.push_back({p[0], {}});
            groups.back().second.push_back({p[1], atoi(p[2].c_str())});
        }
        long words = 0, pairs = 0, badw = 0;
        double worst = 0, sum = 0;
        std::vector<unsigned short> out(MAXB * MAXLEN);
        std::vector<int> fr(MAXB);
        for (auto &g : groups) {
            std::vector<unsigned short> prev = utf16(g.first);
            std::fill(out.begin(), out.end(), 0);
            std::fill(fr.begin(), fr.end(), 0);
            double t0 = now_ms();
            dict.getBigrams(prev.data(), (int) prev.size(), codes.data(), 1, out.data(), fr.data(),
                    MAXLEN, MAXB, (int) init.size());
            double dt = now_ms() - t0;
            sum += dt;
            if (dt > worst) worst = dt;
            std::multiset<std::pair<std::string, int>> got, want;
            for (int i = 0; i < MAXB && fr[i] > 0; i++) got.insert({utf8(&out[i * MAXLEN], MAXLEN), fr[i]});
            for (auto &e : g.second) {
                std::vector<unsigned short> u = utf16(e.first);
                if (initSet.count(u[0])) want.insert(e);
            }
            words++;
            pairs += (long) want.size();
            if (got != want) {
                if (badw < 5) {
                    printf("BIGRAM MISMATCH: %s (expected %zu, got %zu):", g.first.c_str(), want.size(), got.size());
                    int k = 0;
                    for (auto &x : got) { if (!want.count(x) && k++ < 6) printf(" +%s(%d)", x.first.c_str(), x.second); }
                    k = 0;
                    for (auto &x : want) { if (!got.count(x) && k++ < 6) printf(" -%s(%d)", x.first.c_str(), x.second); }
                    printf("\n");
                }
                badw++;
            }
        }
        printf("getBigrams: %ld/%ld words with the exact list (%ld pairs); average %.4f ms, worst %.4f ms\n",
               words - badw, words, pairs, words ? sum / words : 0.0, worst);
        if (badw) fails++;
    }

    // 3) suggestions
    if (argc > 4) {
        const int MAX_WORD_LENGTH = 48, MAX_WORDS = 18, MAX_ALTERNATIVES = 16, NEXT = 1280;
        int rep = argc > 5 ? atoi(argv[5]) : 20;
        std::ifstream in(argv[4]);
        std::string line;
        std::vector<std::pair<std::string, std::string>> qs;
        while (std::getline(in, line)) {
            if (line.empty()) continue;
            std::vector<std::string> p = split(line);
            qs.push_back({p[0], p.size() > 1 ? p[1] : ""});
        }
        int ok = 0;
        double total = 0, worst = 0;
        std::vector<unsigned short> out(MAX_WORDS * MAX_WORD_LENGTH);
        std::vector<int> freqs(MAX_WORDS), next(NEXT);
        for (auto &q : qs) {
            std::vector<unsigned short> t = utf16(q.first);
            std::vector<int> codes(t.size() * MAX_ALTERNATIVES, -1);
            for (size_t i = 0; i < t.size(); i++) codes[i * MAX_ALTERNATIVES] = t[i];
            int n = 0;
            double t0 = now_ms();
            for (int r = 0; r < rep; r++) {
                std::fill(out.begin(), out.end(), 0);
                std::fill(freqs.begin(), freqs.end(), 0);
                n = dict.getSuggestions(codes.data(), (int) t.size(), out.data(), freqs.data(),
                        MAX_WORD_LENGTH, MAX_WORDS, MAX_ALTERNATIVES, -1, next.data(), NEXT);
            }
            double dt = (now_ms() - t0) / rep;
            total += dt;
            if (dt > worst) worst = dt;
            bool found = q.second.empty();
            std::string list;
            for (int i = 0; i < n; i++) {
                std::string s = utf8(&out[i * MAX_WORD_LENGTH], MAX_WORD_LENGTH);
                if (s == q.second) found = true;
                if (i < 5) { list += s; list += ' '; }
            }
            if (found) ok++;
            if (!q.second.empty())
                printf("%s %-12s -> %-12s | %s\n", found ? "OK   " : "FAIL ", q.first.c_str(), q.second.c_str(), list.c_str());
        }
        printf("getSuggestions: %d/%zu with the expected one; average %.3f ms, worst %.3f ms per query\n",
               ok, qs.size(), qs.empty() ? 0.0 : total / qs.size(), worst);
    }
    free(buf);
    return fails ? 1 : 0;
}
