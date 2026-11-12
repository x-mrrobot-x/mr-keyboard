// Tests of the gesture recognition (src/mr_gesture.h): on the PC, and on the Android builds under qemu-user or adb shell
// (README.md, "The tests on the Android builds").
// Usage:
//   mr_gesture_test dicts_dir weights_file data_dir [corruption_rounds] [quick]
//       dicts_dir:    the project dicts/ folder (pt-BR/, en-US/, es/ with main.dict)
//       weights_file: gesture/encoder.bin
//       quick:        each file of gestures is gone through once instead of three times (for a run under an emulator, which is
//                     50 times slower: test/run_android_tests.sh)
//       data_dir:     gesture/test (gesture_vectors.bin and gestures_<language>.tsv; README.md there says where they come from)
//   mr_gesture_test eval main.dict weights_file gestures.tsv [max] [context|nocontext] [detail.tsv]
//       measures a file of gestures of any size and prints the counts and the times. It checks nothing. max -1 = all;
//       detail.tsv gets one line per gesture: word, 1 if it is in the dictionary, place it came in (0 = first, -1 = not found),
//       the first three words returned, each as word(score,logp,keys). A word that is not in the dictionary still gets its
//       first three: that is what a gesture that is no word looks like (the threshold MrGestureInput.MIN_LOGP comes from there).
//
// What this program proves:
//   1. the weights file: the real one opens; cut at any point, with a byte too many, with another magic, a tensor renamed or
//      resized, or with a value that is not a number, it is refused and nothing crashes; with absurd (but finite) weights the
//      network still gives only log-probabilities between -100 and 0;
//   2. the network gives the numbers of the official runtime (ExecuTorch + XNNPACK) on 201 real gestures, within a tolerance;
//   3. the search, on hand-made tables and a hand-made dictionary (no network involved): doubled letters, the characters that
//      take no key, accents, a key of its own for an accented letter, upper and lower case, the previous word, a character with
//      no key, a 2-byte character, the two dictionary formats, the limits, and the same answer when asked twice;
//   4. real gestures (English, Spanish) and synthetic ones (Portuguese) on the dictionaries of the app: how many words come first
//      and among the first three must not go down; a gesture gives the same answer whatever came before it;
//   5. a corrupt dictionary (cut, swapped bytes, garbage) and absurd input (no points, NaN, huge values): nothing may crash, read
//      out of the file or hang, and the work per gesture stays under its ceiling.
// What it does NOT prove: the result with the app's real letter tables (the ones here are test_util.h's, equal to the app's for
// the letters below U+0100) and through the JNI: that is docs/tools/e2e/GestureEval.java, in the app CI. Nor the speed on a phone.
// With -DMR_SANITIZE=ON, out-of-bounds accesses and undefined behaviour become errors.
#include <algorithm>
#include <chrono>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <fstream>
#include <limits>
#include <string>
#include <vector>

#include "mr_gesture.h"
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

struct Lcg {
    uint64_t s;
    explicit Lcg(uint64_t seed) : s(seed) {}
    uint32_t next() { s = s * 6364136223846793005ULL + 1442695040888963407ULL; return static_cast<uint32_t>(s >> 33); }
};

double nowMs() {
    return std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now().time_since_epoch()).count();
}

// The values of MrGesture.java. The app's own arrive through the JNI; these are only for the test.
GestureParams appParams() {
    const float f[GestureParams::kFloats] = {0.f, 0.075f, 2.9f, 0.066f, 0.4234f, 1.0382f};
    const int i[GestureParams::kInts] = {200, 2, 60000};
    GestureParams p;
    p.set(f, i);
    return p;
}

std::string utf8(const char16_t* w, int len) { return toUtf8(w, len); }
std::string utf8(const std::u16string& w) { return toUtf8(w.data(), static_cast<int>(w.size())); }

std::u16string lowered(const Tables& t, const std::u16string& w) {
    std::u16string o(w);
    for (auto& c : o) c = t.lowerOf(c);
    return o;
}

// First letter in upper case, the rest in lower case (Latin-1 only: what the dictionaries have).
std::u16string capitalized(const Tables& t, const std::u16string& w) {
    std::u16string o = lowered(t, w);
    if (!o.empty()) {
        const char16_t c = o[0];
        if ((c >= u'a' && c <= u'z') || (c >= 0xE0 && c <= 0xFE && c != 0xF7)) o[0] = static_cast<char16_t>(c - 32);
    }
    return o;
}

// ------------------------------------------------------------------------------------ files of gestures

struct Sample {
    std::u16string word, prev;
    std::vector<float> x, y;
    std::vector<int32_t> t;
};

// gestures_<language>.tsv: lines "# comment"; one line "@keys letter x y letter x y ..." (the layout the gestures were made on);
// then one gesture per line: word TAB previous word (may be empty) TAB "x y t x y t ..." (frame of GestureLayout, t in ms).
struct SampleSet {
    std::vector<char16_t> keys;
    std::vector<float> xy;
    std::vector<Sample> items;
    GestureLayout layout;
};

bool loadSamples(const std::string& path, SampleSet* set, long max = -1) {
    std::ifstream in(path);
    if (!in) return false;
    std::string line;
    while (std::getline(in, line)) {
        if (!line.empty() && line.back() == '\r') line.pop_back();
        if (line.empty() || line[0] == '#') continue;
        if (line.compare(0, 5, "@keys") == 0) {
            const char* q = line.c_str() + 5;
            for (;;) {
                while (*q == ' ') ++q;
                if (*q == 0) break;
                const char* b = q;
                while (*q != 0 && *q != ' ') ++q;
                std::u16string k = utf16(std::string(b, q));
                char* end = nullptr;
                const double x = std::strtod(q, &end);
                if (end == q) return false;
                q = end;
                const double y = std::strtod(q, &end);
                if (end == q || k.size() != 1) return false;
                q = end;
                set->keys.push_back(k[0]);
                set->xy.push_back(static_cast<float>(x));
                set->xy.push_back(static_cast<float>(y));
            }
            continue;
        }
        if (max >= 0 && static_cast<long>(set->items.size()) >= max) break;
        const size_t p1 = line.find('\t');
        const size_t p2 = p1 == std::string::npos ? p1 : line.find('\t', p1 + 1);
        if (p2 == std::string::npos) return false;
        Sample s;
        s.word = utf16(line.substr(0, p1));
        s.prev = utf16(line.substr(p1 + 1, p2 - p1 - 1));
        const char* q = line.c_str() + p2 + 1;
        char* end = nullptr;
        for (;;) {
            const double x = std::strtod(q, &end);
            if (end == q) break;
            q = end;
            const double y = std::strtod(q, &end);
            if (end == q) break;
            q = end;
            const double t = std::strtod(q, &end);
            if (end == q) break;
            q = end;
            s.x.push_back(static_cast<float>(x));
            s.y.push_back(static_cast<float>(y));
            s.t.push_back(static_cast<int32_t>(t));
        }
        set->items.push_back(std::move(s));
    }
    static const char16_t kFree[] = {u'\'', u'-'};
    return !set->keys.empty() &&
           set->layout.set(set->keys.data(), set->xy.data(), static_cast<int>(set->keys.size()), kFree, 2);
}

// Is the word in the dictionary, whatever its upper and lower case?
bool hasRec(const Tables& t, const GestureDict& d, int pos, const std::u16string& w, size_t i, int* guard) {
    if (++*guard > 4096) return false;
    std::vector<GestureDict::Entry> g;
    d.readGroup(pos, &g);
    for (const GestureDict::Entry& x : g) {
        if (t.lowerOf(x.ch) != t.lowerOf(w[i])) continue;
        if (i + 1 == w.size()) {
            if (x.terminal) return true;
        } else if (x.kids != 0 && hasRec(t, d, x.kids, w, i + 1, guard)) {
            return true;
        }
    }
    return false;
}

bool hasIgnoreCase(const Tables& t, const GestureDict& d, const std::u16string& w) {
    if (w.empty() || w.size() > static_cast<size_t>(kMaxWord)) return false;
    int guard = 0;
    return hasRec(t, d, d.root(), w, 0, &guard);
}

struct Counts {
    long gestures = 0, oneLetter = 0, known = 0, withContext = 0;
    long top1 = 0, top3 = 0, top5 = 0, top10 = 0, alive = 0;
    long maxNodes = 0, failed = 0;
    double totalMs = 0, maxMs = 0;
    std::vector<std::string> firsts;   // the first word of each gesture, as it came (to compare two runs)
};

// Decodes every gesture of the set and counts where the right word came. Two words that differ only in upper and lower case
// count as one place (the app decides the case when it writes the word). "known" = the word is in the dictionary and every
// letter of it has a key: the percentages are over those.
Counts evaluate(Gesture& g, const Tables& t, const std::vector<uint8_t>& dict, const SampleSet& set, const GestureParams& p,
                bool useContext, FILE* detail = nullptr) {
    Counts c;
    GestureDict d;
    d.attach(dict.data(), static_cast<int>(dict.size()));
    std::vector<std::u16string> seen;
    for (const Sample& s : set.items) {
        if (s.x.size() < 2) continue;
        int letters = 0;
        bool typable = true;
        for (char16_t ch : s.word) {
            if (set.layout.isFree(ch)) continue;
            if (set.layout.find(t.lowerOf(ch)) >= 0 || set.layout.find(t.baseOf(ch)) >= 0) letters++;
            else typable = false;
        }
        if (typable && letters < 2) {          // a single letter is a tap, not a gesture
            c.oneLetter++;
            continue;
        }
        c.gestures++;
        const bool known = typable && hasIgnoreCase(t, d, s.word);
        if (known) c.known++;
        const std::u16string lo = lowered(t, s.prev), cap = capitalized(t, s.prev);
        const char16_t* prev[3] = {s.prev.data(), lo.data(), cap.data()};
        const int prevLen[3] = {static_cast<int>(s.prev.size()), static_cast<int>(lo.size()), static_cast<int>(cap.size())};
        const double t0 = nowMs();
        const int n = g.decode(t, dict.data(), static_cast<int>(dict.size()), s.x.data(), s.y.data(), s.t.data(),
                               static_cast<int>(s.x.size()), prev, prevLen, useContext && !s.prev.empty() ? 3 : 0, p);
        const double ms = nowMs() - t0;
        c.totalMs += ms;
        c.maxMs = std::max(c.maxMs, ms);
        c.maxNodes = std::max<long>(c.maxNodes, g.nodes());
        if (n < 0) c.failed++;
        if (g.contextSize() > 0) c.withContext++;
        c.firsts.push_back(n > 0 ? utf8(g.result(0).word, g.result(0).len) : std::string());
        if (!known) {
            if (detail) {
                std::fprintf(detail, "%s\t0\t-1", utf8(s.word).c_str());
                for (size_t i = 0; i < g.all().size() && i < 3; i++) {
                    const GestureWord& w = g.all()[i];
                    std::fprintf(detail, "\t%s(%.4f,%.3f,%d)", utf8(w.word, w.len).c_str(), static_cast<double>(w.score),
                                 static_cast<double>(w.logp), w.keys);
                }
                std::fprintf(detail, "\n");
            }
            continue;
        }
        const std::u16string target = lowered(t, s.word);
        seen.clear();
        int rank = -1;
        for (const GestureWord& w : g.all()) {
            const std::u16string wl = lowered(t, std::u16string(w.word, w.word + w.len));
            if (std::find(seen.begin(), seen.end(), wl) != seen.end()) continue;
            if (wl == target) {
                rank = static_cast<int>(seen.size());
                break;
            }
            seen.push_back(wl);
        }
        if (rank >= 0) c.alive++;
        if (rank == 0) c.top1++;
        if (rank >= 0 && rank < 3) c.top3++;
        if (rank >= 0 && rank < 5) c.top5++;
        if (rank >= 0 && rank < 10) c.top10++;
        if (detail) {
            std::fprintf(detail, "%s\t1\t%d", utf8(s.word).c_str(), rank);
            for (size_t i = 0; i < g.all().size() && i < 3; i++) {
                const GestureWord& w = g.all()[i];
                std::fprintf(detail, "\t%s(%.4f,%.3f,%d)", utf8(w.word, w.len).c_str(), static_cast<double>(w.score),
                             static_cast<double>(w.logp), w.keys);
            }
            std::fprintf(detail, "\n");
        }
    }
    return c;
}

double pct(long a, long b) { return b ? 100.0 * static_cast<double>(a) / static_cast<double>(b) : 0.0; }

// ------------------------------------------------------------------------------- hand-made dictionary and table

struct TestWord {
    std::u16string w;
    int freq;
    std::vector<std::pair<std::u16string, int>> next;   // bigrams: next word and frequency (1..127)
};

void putAddr(std::vector<uint8_t>& o, int at, int flags, int a, int ab) {
    o[static_cast<size_t>(at)] = static_cast<uint8_t>(flags | (a >> (8 * (ab - 1))));
    for (int k = 1; k < ab; k++) o[static_cast<size_t>(at + k)] = static_cast<uint8_t>((a >> (8 * (ab - 1 - k))) & 0xFF);
}

// A small writer of main.dict (format v1 or v2, with bigram lists), independent of docs/tools/build_dict.py: unlike it, this
// one also writes characters from U+00FF on (0xFF + 2 bytes), which the readers accept.
std::vector<uint8_t> makeDict(const std::vector<TestWord>& words, int version) {
    struct Node {
        char16_t ch = 0;
        std::vector<int> kids;
        bool term = false;
        int freq = 0;
        std::vector<std::pair<int, int>> big;
        int at = 0, group = 0;
    };
    std::vector<Node> nodes(1);
    auto insert = [&](const std::u16string& w) {
        int cur = 0;
        for (char16_t c : w) {
            int nx = -1;
            for (int k : nodes[static_cast<size_t>(cur)].kids) {
                if (nodes[static_cast<size_t>(k)].ch == c) nx = k;
            }
            if (nx < 0) {
                nx = static_cast<int>(nodes.size());
                nodes.push_back(Node());
                nodes[static_cast<size_t>(nx)].ch = c;
                nodes[static_cast<size_t>(cur)].kids.push_back(nx);
            }
            cur = nx;
        }
        return cur;
    };
    std::vector<int> term;
    for (const TestWord& w : words) {
        const int n = insert(w.w);
        nodes[static_cast<size_t>(n)].term = true;
        nodes[static_cast<size_t>(n)].freq = w.freq;
        term.push_back(n);
    }
    for (size_t i = 0; i < words.size(); i++) {
        for (const auto& nx : words[i].next) {
            const int target = insert(nx.first);
            nodes[static_cast<size_t>(term[i])].big.push_back({target, nx.second});
        }
    }
    const int ab = version == 2 ? 4 : 3;
    auto entrySize = [&](const Node& n) {
        return (n.ch >= 0xFF ? 3 : 1) + (n.kids.empty() ? 1 : ab) +
               (n.term ? 1 + (n.big.empty() ? 1 : static_cast<int>(n.big.size()) * (ab + 1)) : 0);
    };
    std::vector<int> order{0};
    int pos = 2;
    for (size_t q = 0; q < order.size(); q++) {
        const int pi = order[q];
        if (nodes[static_cast<size_t>(pi)].kids.empty()) continue;
        nodes[static_cast<size_t>(pi)].group = pos;
        pos += 1;
        for (int k : nodes[static_cast<size_t>(pi)].kids) {
            nodes[static_cast<size_t>(k)].at = pos;
            pos += entrySize(nodes[static_cast<size_t>(k)]);
            order.push_back(k);
        }
    }
    std::vector<uint8_t> out(static_cast<size_t>(pos), 0);
    out[0] = 200;
    out[1] = static_cast<uint8_t>(version == 2 ? 2 : 1);
    for (int pi : order) {
        const Node& par = nodes[static_cast<size_t>(pi)];
        if (par.kids.empty()) continue;
        int w = par.group;
        out[static_cast<size_t>(w++)] = static_cast<uint8_t>(par.kids.size());
        for (int k : par.kids) {
            const Node& n = nodes[static_cast<size_t>(k)];
            if (n.ch >= 0xFF) {
                out[static_cast<size_t>(w++)] = 0xFF;
                out[static_cast<size_t>(w++)] = static_cast<uint8_t>(n.ch >> 8);
                out[static_cast<size_t>(w++)] = static_cast<uint8_t>(n.ch & 0xFF);
            } else {
                out[static_cast<size_t>(w++)] = static_cast<uint8_t>(n.ch);
            }
            const int flags = n.term ? 0x80 : 0;
            if (!n.kids.empty()) {
                putAddr(out, w, flags | 0x40, n.group, ab);
                w += ab;
            } else {
                out[static_cast<size_t>(w++)] = static_cast<uint8_t>(flags);
            }
            if (n.term) {
                out[static_cast<size_t>(w++)] = static_cast<uint8_t>(n.freq);
                if (n.big.empty()) {
                    out[static_cast<size_t>(w++)] = 0;
                } else {
                    for (size_t j = 0; j < n.big.size(); j++) {
                        putAddr(out, w, 0x80, nodes[static_cast<size_t>(n.big[j].first)].at, ab);
                        w += ab;
                        out[static_cast<size_t>(w++)] = static_cast<uint8_t>((j + 1 < n.big.size() ? 0x80 : 0) | (n.big[j].second & 0x7F));
                    }
                }
            }
        }
    }
    return out;
}

// A table in which the network "saw" the keys of seq, in order: step 0 is blank, then each key takes one step and a blank step
// follows it. The chosen symbol of each step has nearly all the probability and each of the others e^-14: about what the real
// network gives when it is sure, and enough for no frequency (at most 255 * 0.075 = 19) to pay for two wrong steps.
std::vector<float> tableFor(const GestureLayout& l, const std::u16string& keys) {
    const int cols = l.n + 1;
    std::vector<float> em(static_cast<size_t>(kGestureFrames) * static_cast<size_t>(cols));
    const float miss = -14.f, hit = std::log1p(-static_cast<float>(l.n) * std::exp(miss));
    for (int f = 0; f < kGestureFrames; f++) {
        int sym = l.n;
        const int i = f - 1;
        if (i >= 0 && i % 2 == 0 && i / 2 < static_cast<int>(keys.size())) sym = l.find(keys[static_cast<size_t>(i / 2)]);
        for (int c = 0; c < cols; c++) em[static_cast<size_t>(f * cols + c)] = c == sym ? hit : miss;
    }
    return em;
}

std::string render(const std::vector<GestureWord>& all, size_t max = 6) {
    std::string s;
    for (size_t i = 0; i < all.size() && i < max; i++) {
        char b[64];
        std::snprintf(b, sizeof(b), "(%.2f k%d f%d b%d) ", static_cast<double>(all[i].score), all[i].keys, all[i].freq, all[i].bigram);
        s += utf8(all[i].word, all[i].len) + b;
    }
    return s.empty() ? "(nothing)" : s;
}

const GestureWord* findWord(const std::vector<GestureWord>& all, const std::u16string& w) {
    for (const GestureWord& x : all) {
        if (std::u16string(x.word, x.word + x.len) == w) return &x;
    }
    return nullptr;
}

std::u16string wordAt(const std::vector<GestureWord>& all, size_t i) {
    return i < all.size() ? std::u16string(all[i].word, all[i].word + all[i].len) : std::u16string();
}

struct TestLayout {
    std::vector<char16_t> keys;
    std::vector<float> xy;
    GestureLayout l;
};

// The 26 letters in three rows (the centres of the app's standard keyboard), plus extra keys at the right end.
TestLayout qwertyKeys(const std::u16string& extraKeys, const std::u16string& freeChars) {
    static const char* const kRows[3] = {"qwertyuiop", "asdfghjkl", "zxcvbnm"};
    TestLayout tl;
    std::vector<char16_t>& keys = tl.keys;
    std::vector<float>& xy = tl.xy;
    for (int r = 0; r < 3; r++) {
        const int n = static_cast<int>(std::strlen(kRows[r]));
        for (int i = 0; i < n; i++) {
            keys.push_back(static_cast<char16_t>(kRows[r][i]));
            xy.push_back((static_cast<float>(i) + 0.5f + 0.5f * static_cast<float>(r == 2 ? 3 : r)) / 10.f);
            xy.push_back((static_cast<float>(r) + 0.5f) / 3.f);
        }
    }
    for (size_t i = 0; i < extraKeys.size(); i++) {      // extra keys at the right end of the second row and below it
        keys.push_back(extraKeys[i]);
        xy.push_back(0.95f);
        xy.push_back((static_cast<float>(i) + 1.5f) / 3.f);
    }
    tl.l.set(keys.data(), xy.data(), static_cast<int>(keys.size()), freeChars.data(), static_cast<int>(freeChars.size()));
    return tl;
}

GestureLayout qwerty(const std::u16string& extraKeys, const std::u16string& freeChars) { return qwertyKeys(extraKeys, freeChars).l; }

// ----------------------------------------------------------------------------------------------- the tests

void paramsAndLayout() {
    const float f[6] = {0.f, 0.075f, 2.9f, 0.066f, 0.4234f, 1.0382f};
    const int i[3] = {200, 2, 60000};
    GestureParams p;
    CHECK(p.set(f, i) && p.beam == 200 && p.minKeys == 2 && p.nodeBudget == 60000 && p.beta == 2.9f, "the app's values are accepted");
    CHECK(!p.set(nullptr, i) && !p.set(f, nullptr), "null arrays are refused");
    for (int k = 0; k < 6; k++) {
        float g[6];
        std::memcpy(g, f, sizeof(g));
        g[k] = std::numeric_limits<float>::quiet_NaN();
        CHECK(!p.set(g, i), "NaN in value %d is refused", k);
        g[k] = std::numeric_limits<float>::infinity();
        CHECK(!p.set(g, i), "infinity in value %d is refused", k);
        g[k] = -1e9f;
        CHECK(!p.set(g, i), "absurd value %d is refused", k);
    }
    float g[6];
    std::memcpy(g, f, sizeof(g));
    g[0] = -0.1f;
    CHECK(!p.set(g, i), "negative exponent is refused");
    const int bad[][3] = {{0, 2, 60000}, {kGestureMaxBeam + 1, 2, 60000}, {200, 0, 60000}, {200, kMaxWord + 1, 60000},
                          {200, 2, 0}, {200, 2, kGestureMaxBudget + 1}, {-5, 2, 60000}};
    for (const auto& b : bad) CHECK(!p.set(f, b), "limits %d %d %d are refused", b[0], b[1], b[2]);
    CHECK(p.beam == 200 && p.nodeBudget == 60000, "a refused call changes nothing");

    GestureLayout l = qwerty(u"", u"'-");
    CHECK(l.n == 26 && l.nFree == 2 && l.find('q') == 0 && l.find('m') == 25 && l.find('Q') < 0 && l.find(0x151) < 0, "qwerty layout");
    CHECK(l.isFree('\'') && l.isFree('-') && !l.isFree('a'), "characters that take no key");
    CHECK(l.basis.size() == 26u * kGestureCoeff && l.basis[0] == 1.f, "cosine basis: 64 values per key, the first is 1");
    const char16_t two[] = {u'a', u'b'};
    const float xy2[] = {0.25f, 0.5f, 0.75f, 0.5f};
    GestureLayout m;
    CHECK(m.set(two, xy2, 2, nullptr, 0) && m.n == 2, "two keys and no free character");
    CHECK(!m.set(two, xy2, 1, nullptr, 0) && m.n == 0, "one key is refused and leaves the layout empty");
    const char16_t dup[] = {u'a', u'a'};
    CHECK(!m.set(dup, xy2, 2, nullptr, 0), "repeated key is refused");
    const char16_t zero[] = {u'a', 0};
    CHECK(!m.set(zero, xy2, 2, nullptr, 0), "key 0 is refused");
    const float nan2[] = {0.25f, 0.5f, std::numeric_limits<float>::quiet_NaN(), 0.5f};
    CHECK(!m.set(two, nan2, 2, nullptr, 0), "NaN centre is refused");
    const float far2[] = {0.25f, 0.5f, 0.75f, 2.5f};
    CHECK(!m.set(two, far2, 2, nullptr, 0), "centre far outside the frame is refused");
    CHECK(!m.set(nullptr, xy2, 2, nullptr, 0) && !m.set(two, nullptr, 2, nullptr, 0) && !m.set(two, xy2, 2, nullptr, 1), "null arrays are refused");
    std::vector<char16_t> many;
    std::vector<float> manyXy;
    for (int k = 0; k < kGestureKeys + 1; k++) {
        many.push_back(static_cast<char16_t>(0x100 + k));
        manyXy.push_back(static_cast<float>(k) / 70.f);
        manyXy.push_back(0.5f);
    }
    CHECK(!m.set(many.data(), manyXy.data(), kGestureKeys + 1, nullptr, 0), "65 keys are refused");
    CHECK(m.set(many.data(), manyXy.data(), kGestureKeys, nullptr, 0) && m.find(0x100) == 0 && m.find(0x13F) == 63, "64 keys above U+00FF are accepted");
    const char16_t nine[9] = {u'1', u'2', u'3', u'4', u'5', u'6', u'7', u'8', u'9'};
    CHECK(!m.set(two, xy2, 2, nine, 9), "9 free characters are refused");

    // resampling
    float out[2 * kGesturePoints];
    const float x1[] = {0.3f}, y1[] = {0.7f};
    const int32_t t1[] = {5};
    CHECK(gestureResample(x1, y1, t1, 1, out) && out[0] == 0.3f && out[63] == 0.3f && out[64] == 0.7f && out[127] == 0.7f, "one point fills the 64");
    CHECK(!gestureResample(x1, y1, t1, 0, out) && !gestureResample(nullptr, y1, t1, 1, out), "no points is refused");
    const float xa[] = {0.f, 1.f}, ya[] = {1.f, 0.f};
    const int32_t ta[] = {1000, 2050};
    CHECK(gestureResample(xa, ya, ta, 2, out), "two points");
    bool line = out[0] == 0.f && out[63] == 1.f && out[64] == 1.f && out[127] == 0.f;
    for (int k = 0; k < 64; k++) {
        if (std::fabs(out[k] - static_cast<float>(k) / 63.f) > 1e-5f || std::fabs(out[64 + k] - (1.f - static_cast<float>(k) / 63.f)) > 1e-5f) line = false;
    }
    CHECK(line, "a straight trace at constant speed stays straight and evenly spaced");
    const float xb[] = {0.f, 0.5f, 1.f};
    const int32_t tb[] = {100, 50, 100};      // the time goes back and then returns: no time passed at all
    CHECK(gestureResample(xb, xb, tb, 3, out) && out[0] == 0.f && out[63] == 1.f && std::fabs(out[32] - 0.5079f) < 1e-3f, "no time passed: spaced by index");
    const int32_t tc[] = {0, 2000000000, 2147483647};
    CHECK(gestureResample(xb, xb, tc, 3, out) && out[0] == 0.f && out[63] == 1.f, "a gesture of 24 days does not hang");
    const int32_t td[] = {2147483647, -2147483647 - 1, 0};
    CHECK(gestureResample(xb, xb, td, 3, out) && std::isfinite(out[10]), "times at the ends of the int range");
    std::printf("parameters, layout and resampling ok\n");
}

// The search alone, on hand-made tables.
void searchByHand(const Tables& t) {
    const GestureParams p = appParams();
    const std::vector<TestWord> words = {
        {u"caro", 120, {}},   {u"carro", 150, {}}, {u"of", 200, {}},  {u"off", 140, {}},  {u"dont", 50, {}},
        {u"don't", 180, {}},  {u"ano", 160, {}},   {u"a\u00F1o", 170, {}}, {u"esta", 190, {}}, {u"est\u00E1", 185, {}},
        {u"the", 250, {{u"caro", 100}, {u"off", 7}}}, {u"The", 100, {{u"carro", 90}}}, {u"a", 255, {}}, {u"ab", 10, {}},
        {u"x1", 90, {}},      {u"xo", 20, {}},     {u"a\u0151", 60, {}}, {u"co-op", 70, {}}, {u"\u00C1rea", 80, {}},
        {u"can't", 90, {}},   {u"cant", 90, {}},   {u"bell", 70, {}},  {u"bel", 70, {}},   {u"s\u00F3", 66, {}}, {u"so", 66, {}},
    };
    for (int version = 1; version <= 2; version++) {
        const std::vector<uint8_t> bytes = makeDict(words, version);
        GestureDict d;
        CHECK(d.attach(bytes.data(), static_cast<int>(bytes.size())) && d.root() == 2, "v%d: hand-made dictionary", version);
        const GestureLayout l = qwerty(u"", u"'-");
        GestureSearch s;
        auto run = [&](const GestureLayout& lay, const std::u16string& keys, const GestureParams& par, const int* ca, const int* cf, int nc) {
            const std::vector<float> em = tableFor(lay, keys);
            s.decode(t, d, lay, em.data(), par, ca, cf, nc);
        };
        // every word the dictionary reader finds, and only those
        for (const TestWord& w : words) {
            GestureDict::Entry e;
            CHECK(d.find(w.w.data(), static_cast<int>(w.w.size()), &e) && e.terminal && e.freq == w.freq, "v%d: find %s", version, utf8(w.w).c_str());
        }
        GestureDict::Entry e;
        CHECK(!d.find(u"car", 3, &e) && !d.find(u"carros", 6, &e) && !d.find(u"THE", 3, &e) && !d.find(u"", 0, &e), "v%d: prefixes and other spellings are not words", version);

        run(l, u"caro", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"carro" && wordAt(s.all(), 1) == u"caro", "v%d c-a-r-o: carro (more frequent) then caro, got %s", version, render(s.all()).c_str());
        CHECK(s.all().size() >= 2 && s.all()[0].keys == 4 && s.all()[1].keys == 4 && s.all()[0].freq == 150, "v%d c-a-r-o: the doubled r is passed over once", version);
        // carro also gets the (tiny) probability of c-a-r-r-o, so it is a little above caro, never below
        CHECK(s.all().size() >= 2 && s.all()[0].logp >= s.all()[1].logp && s.all()[0].logp - s.all()[1].logp < 0.05f, "v%d c-a-r-o: both have the probability of the same key sequence", version);
        CHECK(s.all().size() >= 3 && s.all()[2].logp < s.all()[1].logp - 4.f, "v%d c-a-r-o: every other word is far less likely, got %s", version, render(s.all()).c_str());
        run(l, u"carro", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"carro" && s.all()[0].keys == 5, "v%d c-a-r-r-o: carro with five keys, got %s", version, render(s.all()).c_str());
        run(l, u"of", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"of" && wordAt(s.all(), 1) == u"off", "v%d o-f: of then off, got %s", version, render(s.all()).c_str());
        run(l, u"off", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"off" && s.all()[0].keys == 3, "v%d o-f-f: off, got %s", version, render(s.all()).c_str());
        run(l, u"dont", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"don't" && wordAt(s.all(), 1) == u"dont" && s.all()[0].keys == 4, "v%d d-o-n-t: don't (the apostrophe takes no key) then dont, got %s", version, render(s.all()).c_str());
        // an exact tie (same key sequence, same frequency): the shorter word first, then the order in the dictionary
        run(l, u"cant", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"cant" && wordAt(s.all(), 1) == u"can't" && s.all()[0].score == s.all()[1].score,
              "v%d c-a-n-t: cant and can't tie, the shorter first, got %s", version, render(s.all()).c_str());
        // a doubled letter is never an exact tie: bell also has the (tiny) probability of b-e-l-l, so with the same frequency it
        // comes before bel
        run(l, u"bel", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"bell" && wordAt(s.all(), 1) == u"bel" && s.all()[0].logp > s.all()[1].logp && s.all()[0].logp - s.all()[1].logp < 0.05f,
              "v%d b-e-l: bell a hair before bel with the same frequency, got %s", version, render(s.all()).c_str());
        run(l, u"so", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"s\u00F3" && wordAt(s.all(), 1) == u"so" && s.all()[0].score == s.all()[1].score && s.all()[0].at < s.all()[1].at,
              "v%d s-o: so and só tie with the same length: the one that comes first in the dictionary, got %s", version, render(s.all()).c_str());
        run(l, u"coop", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"co-op" && s.all()[0].keys == 4, "v%d c-o-o-p: co-op (hyphen between two equal letters), got %s", version, render(s.all()).c_str());
        const GestureLayout noFree = qwerty(u"", u"");
        run(noFree, u"dont", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"dont" && findWord(s.all(), u"don't") == nullptr && findWord(s.all(), u"co-op") == nullptr,
              "v%d d-o-n-t with no free character: dont, and the words with ' or - never come, got %s", version, render(s.all()).c_str());
        run(l, u"ano", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"a\u00F1o" && wordAt(s.all(), 1) == u"ano", "v%d a-n-o: the n-tilde has no key and uses the n, got %s", version, render(s.all()).c_str());
        const GestureLayout spanish = qwerty(u"\u00F1", u"'-");
        run(spanish, u"ano", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"ano" && findWord(s.all(), u"a\u00F1o") != nullptr && findWord(s.all(), u"a\u00F1o")->logp < s.all()[0].logp - 4.f,
              "v%d a-n-o on a keyboard with n-tilde: ano; the word with it is another key sequence, far less likely, got %s", version, render(s.all()).c_str());
        run(spanish, u"a\u00F1o", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"a\u00F1o" && findWord(s.all(), u"ano") != nullptr && findWord(s.all(), u"ano")->logp < s.all()[0].logp - 4.f,
              "v%d a-n-tilde-o: the word with it; ano is far less likely, got %s", version, render(s.all()).c_str());
        run(l, u"esta", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"esta" && wordAt(s.all(), 1) == u"est\u00E1", "v%d e-s-t-a: esta and está, got %s", version, render(s.all()).c_str());
        run(l, u"area", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"\u00C1rea", "v%d a-r-e-a: accented capital at the start, got %s", version, render(s.all()).c_str());
        run(l, u"the", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"the" && wordAt(s.all(), 1) == u"The", "v%d t-h-e: the and The are two results, got %s", version, render(s.all()).c_str());
        // one key: only with minKeys 1
        run(l, u"a", p, nullptr, nullptr, 0);
        CHECK(findWord(s.all(), u"a") == nullptr, "v%d: a one-key word does not come with minKeys 2, got %s", version, render(s.all()).c_str());
        GestureParams one = p;
        one.minKeys = 1;
        run(l, u"a", one, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"a", "v%d: with minKeys 1 it does, got %s", version, render(s.all()).c_str());
        // a character with no key: the word never comes; its neighbour does
        run(l, u"xo", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"xo" && findWord(s.all(), u"x1") == nullptr, "v%d x-o: xo, never x1, got %s", version, render(s.all()).c_str());
        // a key above U+00FF (2-byte character in the dictionary)
        const GestureLayout wide = qwerty(u"\u0151", u"'-");
        run(wide, u"a\u0151", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"a\u0151" && s.all()[0].freq == 60, "v%d a-o-double-acute: 2-byte character, got %s", version, render(s.all()).c_str());
        run(l, u"ab", p, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"ab" && findWord(s.all(), u"a\u0151") == nullptr, "v%d a-b without that key, got %s", version, render(s.all()).c_str());

        // the previous word: "the" has caro (100) and off (7) after it
        int ca[kGestureContext], cf[kGestureContext];
        CHECK(d.find(u"the", 3, &e), "v%d: the", version);
        const int nc = d.bigrams(e, ca, cf, kGestureContext);
        GestureDict::Entry caro, off;
        CHECK(nc == 2 && d.find(u"caro", 4, &caro) && d.find(u"off", 3, &off) && ca[0] == caro.at && cf[0] == 100 && ca[1] == off.at && cf[1] == 7,
              "v%d: bigrams of the: %d", version, nc);
        CHECK(d.find(u"caro", 4, &e) && d.bigrams(e, ca, cf, kGestureContext) == 0, "v%d: caro has no bigrams", version);
        CHECK(d.find(u"the", 3, &e) && d.bigrams(e, ca, cf, 1) == 1 && d.bigrams(e, ca, cf, 0) == 0, "v%d: bigrams respects max", version);
        d.bigrams(e, ca, cf, kGestureContext);
        run(l, u"caro", p, ca, cf, 2);
        CHECK(wordAt(s.all(), 0) == u"caro" && s.all()[0].bigram == 100 && wordAt(s.all(), 1) == u"carro" && s.all()[1].bigram == 0,
              "v%d c-a-r-o after the: caro comes first, got %s", version, render(s.all()).c_str());
        run(l, u"of", p, ca, cf, 2);
        CHECK(wordAt(s.all(), 0) == u"of" && findWord(s.all(), u"off") != nullptr && findWord(s.all(), u"off")->bigram == 7,
              "v%d o-f after the: a weak bigram does not beat the frequency, got %s", version, render(s.all()).c_str());

        // the list of the previous word may be anything: an address twice (the first counts), an address that is no word,
        // more entries than the limit (only the first kGestureContext are read), a negative count
        {
            const int twiceA[2] = {caro.at, caro.at}, twiceF[2] = {100, 5};
            run(l, u"caro", p, twiceA, twiceF, 2);
            CHECK(wordAt(s.all(), 0) == u"caro" && s.all()[0].bigram == 100, "v%d: an address twice in the context: the first counts, got %s", version, render(s.all()).c_str());
            const int swapF[2] = {5, 100};
            run(l, u"caro", p, twiceA, swapF, 2);
            CHECK(findWord(s.all(), u"caro") != nullptr && findWord(s.all(), u"caro")->bigram == 5, "v%d: the first one, whatever its value", version);
            const int noWordA[3] = {1, 0x7FFFFFFF, -5}, noWordF[3] = {127, 127, 127};
            run(l, u"caro", p, noWordA, noWordF, 3);
            CHECK(wordAt(s.all(), 0) == u"carro" && s.all()[0].bigram == 0 && s.all()[1].bigram == 0, "v%d: context addresses that are no word change nothing", version);
            std::vector<int> manyA(static_cast<size_t>(kGestureContext) + 50, 1), manyF(static_cast<size_t>(kGestureContext) + 50, 9);
            manyA[static_cast<size_t>(kGestureContext) + 10] = caro.at;      // past the limit: not read
            manyF[static_cast<size_t>(kGestureContext) + 10] = 100;
            run(l, u"caro", p, manyA.data(), manyF.data(), static_cast<int>(manyA.size()));
            CHECK(findWord(s.all(), u"caro") != nullptr && findWord(s.all(), u"caro")->bigram == 0, "v%d: context entries past the limit are not read", version);
            manyA[static_cast<size_t>(kGestureContext) - 1] = caro.at;      // the last one inside the limit
            manyF[static_cast<size_t>(kGestureContext) - 1] = 100;
            run(l, u"caro", p, manyA.data(), manyF.data(), static_cast<int>(manyA.size()));
            CHECK(wordAt(s.all(), 0) == u"caro" && s.all()[0].bigram == 100, "v%d: the last context entry inside the limit is read", version);
            run(l, u"caro", p, twiceA, twiceF, -3);
            CHECK(wordAt(s.all(), 0) == u"carro" && findWord(s.all(), u"caro")->bigram == 0, "v%d: a negative context count is no context", version);
            d.bigrams(e, ca, cf, kGestureContext);    // back to the bigrams of "the" for the checks below
        }

        // the score is the formula; the results come best first; asked twice, the same answer
        run(l, u"caro", p, ca, cf, 2);
        bool formula = true, ordered = true;
        for (size_t i = 0; i < s.all().size(); i++) {
            const GestureWord& w = s.all()[i];
            const float want = w.logp + p.lambdaF * static_cast<float>(w.freq) + p.beta * static_cast<float>(w.keys) + p.ctx * static_cast<float>(w.bigram);
            if (std::fabs(w.score - want) > 1e-3f) formula = false;
            if (i > 0 && s.all()[i - 1].score < w.score) ordered = false;
        }
        CHECK(formula && ordered, "v%d: score = logp + lambda*freq + beta*keys + ctx*bigram (gamma 0), best first", version);
        const std::vector<GestureWord> first = s.all();
        run(l, u"the", p, nullptr, nullptr, 0);
        run(l, u"caro", p, ca, cf, 2);
        bool same = first.size() == s.all().size();
        for (size_t i = 0; same && i < first.size(); i++) {
            same = first[i].at == s.all()[i].at && first[i].score == s.all()[i].score && first[i].logp == s.all()[i].logp;
        }
        CHECK(same, "v%d: the same table gives the same answer after another query", version);

        // limits: nothing crashes, the ceilings hold
        GestureParams tight = p;
        tight.beam = 1;
        run(l, u"caro", tight, nullptr, nullptr, 0);
        CHECK(wordAt(s.all(), 0) == u"carro", "v%d: beam 1 still follows a clear table, got %s", version, render(s.all()).c_str());
        tight = p;
        tight.nodeBudget = 1;
        run(l, u"caro", tight, nullptr, nullptr, 0);
        CHECK(s.nodes() <= 1 + 255 + 1 && findWord(s.all(), u"caro") == nullptr, "v%d: node budget 1 reads one group and stops (%d entries)", version, s.nodes());
        // A table no word explains: the words that are left have a very low probability. The search always answers with what
        // it has; logp is what tells a gesture that is not a word.
        run(l, u"qqqqqqqqqqqqqqqq", p, nullptr, nullptr, 0);
        bool unlikely = true;
        for (const GestureWord& w : s.all()) {
            if (w.logp > -40.f) unlikely = false;
        }
        CHECK(unlikely, "v%d: a table no word explains only leaves very unlikely words, got %s", version, render(s.all()).c_str());
        CHECK(s.heapBytes() > 0, "v%d: heap accounted", version);
        s.release();
        CHECK(s.heapBytes() == 0 && s.all().empty(), "v%d: release gives the memory back", version);
    }

    // The dictionary of older apps (no bigram lists, root at 0): the words still come.
    const uint8_t old[] = {2, 'o', 0x40, 0x00, 0x09, 'a', 0x40, 0x00, 0x0D,
                           1, 'f', 0x80, 77,
                           1, 'b', 0x80, 55};
    GestureDict d;
    CHECK(d.attach(old, sizeof(old)) && d.root() == 0, "old format: root at 0");
    const GestureLayout l = qwerty(u"", u"'-");
    GestureSearch s;
    std::vector<float> em = tableFor(l, u"of");
    s.decode(t, d, l, em.data(), p, nullptr, nullptr, 0);
    CHECK(wordAt(s.all(), 0) == u"of" && s.all()[0].freq == 77, "old format o-f: of, got %s", render(s.all()).c_str());
    GestureDict::Entry e;
    int ca[4], cf[4];
    CHECK(d.find(u"ab", 2, &e) && e.freq == 55 && d.bigrams(e, ca, cf, 4) == 0, "old format: find works, there are no bigrams");

    // no dictionary, tiny dictionary, an address pointing to itself
    GestureDict none;
    CHECK(!none.attach(nullptr, 100) && !none.attach(old, 2) && !none.find(u"of", 2, &e), "no dictionary");
    std::vector<GestureDict::Entry> g;
    CHECK(!none.readGroup(0, &g) && g.empty(), "reading a group with no dictionary");
    const uint8_t loop[] = {200, 1, 1, 'a', 0x40, 0x00, 0x02};     // the children of "a" are the root group again
    CHECK(d.attach(loop, sizeof(loop)), "looping dictionary attaches");
    em = tableFor(l, u"aaaaaaaaaaaaaaaa");
    GestureParams small = p;
    small.nodeBudget = 500;
    s.decode(t, d, l, em.data(), small, nullptr, nullptr, 0);
    CHECK(s.all().empty() && s.nodes() <= 500 + 256, "a dictionary that loops stops at the ceilings (%d entries, %d sequences)", s.nodes(), s.sequences());
    std::printf("search on hand-made tables ok (both dictionary formats)\n");
}

std::vector<uint8_t> gWeights;

// Where the values of each tensor start in a weights file (a second reader of the format, apart from the engine's).
struct TensorAt {
    std::string name;
    size_t nameAt, dimsAt, dims, at, values;   // positions of the name, of the dimensions and of the values
};

std::vector<TensorAt> tensorsOf(const std::vector<uint8_t>& w) {
    std::vector<TensorAt> out;
    if (w.size() < 12) return out;
    uint32_t count = 0;
    std::memcpy(&count, w.data() + 8, 4);
    size_t p = 12;
    for (uint32_t i = 0; i < count; i++) {
        if (p >= w.size()) return {};
        const size_t ln = w[p++];
        if (p + ln + 1 > w.size()) return {};
        TensorAt t;
        t.name.assign(reinterpret_cast<const char*>(w.data() + p), ln);
        t.nameAt = p;
        p += ln;
        const size_t nd = w[p++];
        t.dimsAt = p;
        t.dims = nd;
        t.values = 1;
        for (size_t k = 0; k < nd; k++) {
            if (p + 4 > w.size()) return {};
            uint32_t dim = 0;
            std::memcpy(&dim, w.data() + p, 4);
            p += 4;
            t.values *= dim;
        }
        t.at = p;
        if (t.values > (w.size() - p) / 4) return {};
        p += t.values * 4;
        out.push_back(t);
    }
    if (p != w.size()) return {};
    return out;
}

void weightsFile(const std::string& path, int rounds) {
    GestureNet net;
    CHECK(!net.isOpen() && net.values() == 0 && net.heapBytes() == 0, "closed at first");
    CHECK(!net.open(nullptr) && !net.open("/does/not/exist.bin") && !net.open("/"), "a path that is not a file is refused");
    CHECK(net.open(path.c_str()) && net.isOpen(), "the weights file opens: %s", path.c_str());
    CHECK(net.values() == 633988u, "633,988 values, got %zu", net.values());
    std::printf("weights: %zu values, %.2f MB on the heap with the work memory\n", net.values(), static_cast<double>(net.heapBytes()) / 1048576.0);
    CHECK(net.heapBytes() < (4u << 20), "under 4 MB on the heap");
    net.close();
    CHECK(!net.isOpen() && net.heapBytes() == 0, "close gives the memory back");
    gWeights = readFile(path);
    const std::vector<uint8_t>& w = gWeights;
    CHECK(w.size() == 2537110u, "the file has 2,537,110 bytes, got %zu", w.size());
    if (w.size() < 1024) return;
    CHECK(net.openBytes(w.data(), w.size()) && net.values() == 633988u, "the same bytes from memory");

    // cut at any point: refused
    int refused = 0, cuts = 0;
    std::vector<size_t> at;
    for (size_t k = 0; k < 300; k++) at.push_back(k);
    for (size_t k = 300; k < w.size(); k += 40961) at.push_back(k);
    for (size_t k = 1; k <= 9; k++) at.push_back(w.size() - k);
    for (size_t cut : at) {
        cuts++;
        if (!net.openBytes(w.data(), cut) && !net.isOpen()) refused++;
    }
    CHECK(refused == cuts, "a cut file is always refused: %d of %d", refused, cuts);
    CHECK(!net.openBytes(nullptr, w.size()), "null bytes are refused");
    std::vector<uint8_t> m = w;
    m.push_back(0);
    CHECK(!net.openBytes(m.data(), m.size()), "one byte too many is refused");
    m = w;
    m[7] = '2';
    CHECK(!net.openBytes(m.data(), m.size()), "another magic is refused");
    for (uint32_t count : {0u, 72u, 74u, 1025u, 0xFFFFFFFFu}) {
        m = w;
        m[8] = static_cast<uint8_t>(count); m[9] = static_cast<uint8_t>(count >> 8); m[10] = static_cast<uint8_t>(count >> 16); m[11] = static_cast<uint8_t>(count >> 24);
        CHECK(!net.openBytes(m.data(), m.size()), "tensor count %u is refused", count);
    }
    // the first tensor is "savgol.d1_x": [12] = name length 11, [13..23] = name, [24] = 1 dimension, [25..28] = 7, then 7 floats
    CHECK(w[12] == 11 && std::memcmp(w.data() + 13, "savgol.d1_x", 11) == 0 && w[24] == 1 && w[25] == 7, "layout of the first tensor");
    m = w;
    m[13] = 'x';
    CHECK(!net.openBytes(m.data(), m.size()), "a renamed tensor is refused");
    m = w;
    m[12] = 0;
    CHECK(!net.openBytes(m.data(), m.size()), "an empty name is refused");
    m = w;
    m[24] = 0;
    CHECK(!net.openBytes(m.data(), m.size()), "a tensor with no dimensions is refused");
    m = w;
    m[24] = 9;
    CHECK(!net.openBytes(m.data(), m.size()), "a tensor with 9 dimensions is refused");
    for (uint32_t dim : {0u, 6u, 8u, 0x7FFFFFFFu, 0xFFFFFFFFu}) {
        m = w;
        m[25] = static_cast<uint8_t>(dim); m[26] = static_cast<uint8_t>(dim >> 8); m[27] = static_cast<uint8_t>(dim >> 16); m[28] = static_cast<uint8_t>(dim >> 24);
        CHECK(!net.openBytes(m.data(), m.size()), "dimension %u in place of 7 is refused", dim);
    }
    const std::vector<TensorAt> tensors = tensorsOf(w);
    size_t total = 0;
    for (const TensorAt& t : tensors) total += t.values;
    CHECK(tensors.size() == 73 && total == 633988u && tensors[0].at == 29 && tensors.back().at + tensors.back().values * 4 == w.size(),
          "the second reader sees 73 tensors and 633,988 values: %zu and %zu", tensors.size(), total);
    if (tensors.size() != 73) return;
    const float notNumbers[] = {std::numeric_limits<float>::quiet_NaN(), std::numeric_limits<float>::infinity(), -std::numeric_limits<float>::infinity()};
    int refusedValues = 0, triedValues = 0;
    for (const TensorAt& t : tensors) {          // the first, a middle and the last value of every tensor
        for (size_t idx : {static_cast<size_t>(0), t.values / 2, t.values - 1}) {
            for (float bad : notNumbers) {
                m = w;
                std::memcpy(m.data() + t.at + idx * 4, &bad, 4);
                triedValues++;
                if (!net.openBytes(m.data(), m.size()) && !net.isOpen()) refusedValues++;
            }
        }
    }
    CHECK(refusedValues == triedValues, "a value that is not a number is refused in any tensor: %d of %d", refusedValues, triedValues);
    // every tensor is needed, with its exact name and size
    int refusedNames = 0, refusedSizes = 0;
    for (const TensorAt& t : tensors) {
        m = w;
        m[t.nameAt + t.name.size() - 1] ^= 0x01;       // the last letter of the name
        if (!net.openBytes(m.data(), m.size())) refusedNames++;
        m = w;
        m[t.dimsAt + (t.dims - 1) * 4] ^= 0x01;        // the low byte of the last dimension: one more or one less
        if (!net.openBytes(m.data(), m.size())) refusedSizes++;
    }
    CHECK(refusedNames == 73 && refusedSizes == 73, "a renamed or resized tensor is refused: %d and %d of 73", refusedNames, refusedSizes);
    // two tensors that trade their names (same number of values, so the file still parses): b0.dw.b and b1.dw.b are both [128]
    {
        const TensorAt *a = nullptr, *b = nullptr;
        for (const TensorAt& t : tensors) {
            if (t.name == "b0.dw.b") a = &t;
            if (t.name == "b1.dw.b") b = &t;
        }
        CHECK(a != nullptr && b != nullptr && a->values == 128 && b->values == 128, "b0.dw.b and b1.dw.b are there");
        if (a != nullptr && b != nullptr) {
            m = w;
            m[a->nameAt + 1] = '1';
            m[b->nameAt + 1] = '0';
            CHECK(net.openBytes(m.data(), m.size()), "tensors are found by name, not by position: traded names still open");
            m = w;
            m[a->nameAt + 1] = '1';                    // now b1.dw.b is there twice and b0.dw.b is missing
            CHECK(!net.openBytes(m.data(), m.size()), "a missing tensor is refused even with another one twice");
        }
    }
    CHECK(!net.isOpen(), "closed after a refusal");

    // Absurd but finite weights: the file opens (there is nothing to tell it by) and the network must still give only
    // log-probabilities between the floor and 0, with no NaN. A real gesture shape is not needed for that.
    const GestureLayout l = qwerty(u"", u"'-");
    float feats[2 * kGesturePoints];
    for (int i = 0; i < kGesturePoints; i++) {
        feats[i] = 0.1f + 0.8f * static_cast<float>(i) / 63.f;
        feats[kGesturePoints + i] = 0.5f + 0.3f * std::sin(static_cast<float>(i) * 0.2f);
    }
    std::vector<float> out(static_cast<size_t>(kGestureFrames) * 27);
    Lcg rnd(0x5EED);
    int opened = 0, inRange = 0;
    const float big[] = {3e38f, -3e38f, 1e20f, -1e20f, 1e-38f, 0.f};
    for (int r = 0; r < rounds; r++) {
        m = w;
        const int n = 1 + static_cast<int>(rnd.next() % 4000);
        for (int k = 0; k < n; k++) {
            const size_t where = 29 + (rnd.next() % ((m.size() - 29 - 4) / 4)) * 4;   // may hit names and sizes too: then it is refused
            const float v = big[rnd.next() % 6];
            std::memcpy(m.data() + where, &v, 4);
        }
        if (!net.openBytes(m.data(), m.size())) continue;
        opened++;
        std::fill(out.begin(), out.end(), std::numeric_limits<float>::quiet_NaN());
        net.forward(feats, l, out.data());
        bool ok = true;
        for (float v : out) {
            if (!(v >= kGestureMinLog && v <= 0.f)) ok = false;
        }
        if (ok) inRange++;
    }
    CHECK(opened == inRange, "absurd weights: %d files opened, %d gave only values between -100 and 0", opened, inRange);
    std::printf("weights file: %d cuts refused; %d files with absurd weights opened and stayed in range\n", cuts, opened);
    CHECK(net.open(path.c_str()), "the real file opens again");
    std::fill(out.begin(), out.end(), std::numeric_limits<float>::quiet_NaN());
    net.forward(feats, l, out.data());
    double sum = 0;
    for (int c = 0; c < 27; c++) sum += std::exp(static_cast<double>(out[static_cast<size_t>(c)]));
    CHECK(std::fabs(sum - 1.0) < 1e-3, "the probabilities of a step add up to 1: %.6f", sum);
    net.forward(nullptr, l, out.data());
    GestureLayout empty;
    empty.clear();
    net.forward(feats, empty, out.data());      // no layout: does nothing
}

// The network against the official runtime: gesture_vectors.bin has, for 201 real gestures, the raw points, the layout, the
// resampling and the output of the model run by ExecuTorch + XNNPACK (docs/tools/gesture/make_vectors.py).
void officialVectors(const std::string& dataDir) {
    const std::vector<uint8_t> d = readFile(dataDir + "/gesture_vectors.bin");
    CHECK(d.size() > 12 && std::memcmp(d.data(), "MRSWVEC1", 8) == 0, "gesture_vectors.bin is there");
    if (d.size() <= 12 || gWeights.empty()) return;
    GestureNet net;
    if (!net.openBytes(gWeights.data(), gWeights.size())) return;
    uint32_t count = 0;
    std::memcpy(&count, d.data() + 8, 4);
    size_t p = 12;
    double maxFeat = 0, maxProb = 0, maxLog = 0, sumLog = 0, ms = 0;
    long nLog = 0, frames = 0, argmaxDiff = 0, records = 0;
    bool whole = true;
    for (uint32_t r = 0; r < count && whole; r++) {
        if (p + 2 > d.size()) { whole = false; break; }
        uint16_t n = 0;
        std::memcpy(&n, d.data() + p, 2);
        p += 2;
        if (n < 1 || p + static_cast<size_t>(n) * 16 + 1 > d.size()) { whole = false; break; }
        std::vector<float> x(n), y(n);
        std::vector<int32_t> tm(n);
        for (int i = 0; i < n; i++) {
            double tt = 0;
            std::memcpy(&x[static_cast<size_t>(i)], d.data() + p, 4);
            std::memcpy(&y[static_cast<size_t>(i)], d.data() + p + 4, 4);
            std::memcpy(&tt, d.data() + p + 8, 8);
            tm[static_cast<size_t>(i)] = static_cast<int32_t>(tt);
            if (static_cast<double>(tm[static_cast<size_t>(i)]) != tt) whole = false;   // the times are whole milliseconds
            p += 16;
        }
        const int nk = d[p++];
        const size_t cols = static_cast<size_t>(nk) + 1;
        const size_t need = (static_cast<size_t>(nk) * 2 + 2 * kGesturePoints + kGestureFrames * cols) * 4;
        if (nk < 2 || nk > kGestureKeys || p + need > d.size()) { whole = false; break; }
        std::vector<float> keys(static_cast<size_t>(nk) * 2), featsRef(2 * kGesturePoints), ref(kGestureFrames * cols);
        std::memcpy(keys.data(), d.data() + p, keys.size() * 4);
        p += keys.size() * 4;
        std::memcpy(featsRef.data(), d.data() + p, featsRef.size() * 4);
        p += featsRef.size() * 4;
        std::memcpy(ref.data(), d.data() + p, ref.size() * 4);
        p += ref.size() * 4;
        std::vector<char16_t> letters;
        for (int k = 0; k < nk; k++) letters.push_back(static_cast<char16_t>(u'a' + k));
        GestureLayout l;
        if (!l.set(letters.data(), keys.data(), nk, nullptr, 0)) { whole = false; break; }
        float feats[2 * kGesturePoints];
        std::vector<float> out(ref.size());
        const double t0 = nowMs();
        gestureResample(x.data(), y.data(), tm.data(), n, feats);
        net.forward(feats, l, out.data());
        ms += nowMs() - t0;
        records++;
        for (int i = 0; i < 2 * kGesturePoints; i++) maxFeat = std::fmax(maxFeat, std::fabs(static_cast<double>(feats[i]) - static_cast<double>(featsRef[static_cast<size_t>(i)])));
        for (int f = 0; f < kGestureFrames; f++) {
            size_t a = 0, b = 0;
            for (size_t c = 0; c < cols; c++) {
                const float o = out[static_cast<size_t>(f) * cols + c], e = ref[static_cast<size_t>(f) * cols + c];
                if (o > out[static_cast<size_t>(f) * cols + a]) a = c;
                if (e > ref[static_cast<size_t>(f) * cols + b]) b = c;
                maxProb = std::fmax(maxProb, std::fabs(std::exp(static_cast<double>(o)) - std::exp(static_cast<double>(e))));
                // Below -10 (a probability of 5e-5) the 32-bit sigmoids of the official runtime and the ones here already differ
                // in the rounding; there only the probability is compared.
                if (e > -10.f || o > -10.f) {
                    const double diff = std::fabs(static_cast<double>(o) - static_cast<double>(e));
                    maxLog = std::fmax(maxLog, diff);
                    sumLog += diff;
                    nLog++;
                }
            }
            argmaxDiff += a != b;
            frames++;
        }
    }
    CHECK(whole && records == static_cast<long>(count) && p == d.size(), "gesture_vectors.bin read to the end: %ld of %u records", records, count);
    CHECK(records == 201, "201 records, got %ld", records);
    std::printf("official runtime, %ld gestures: resampling differs by at most %.3g; probability by at most %.3g; log-probability above -10 by at "
                "most %.3g (average %.3g); most likely key differs in %ld of %ld steps; %.2f ms per gesture\n",
                records, maxFeat, maxProb, maxLog, nLog ? sumLog / static_cast<double>(nLog) : 0.0, argmaxDiff, frames,
                records ? ms / static_cast<double>(records) : 0.0);
    CHECK(maxFeat < 1e-5, "resampling as the reference: %.3g", maxFeat);
    CHECK(maxProb < 1e-3, "probabilities as the official runtime: %.3g", maxProb);
    CHECK(maxLog < 2e-2, "log-probabilities as the official runtime: %.3g", maxLog);
    CHECK(argmaxDiff <= 2, "most likely key as the official runtime: differs in %ld steps", argmaxDiff);
}

struct LangCase {
    const char* id;
    int top1, top3;          // of the gestures whose word is in the dictionary, at least this many come first / among the first 3
    int top1NoContext;       // the same without the previous word
};

// Floors: two gestures under what was measured when the files were added. The PC build (GCC) and the four Android builds
// (clang; the ARM ones under qemu-user) all gave exactly the measured counts, in the comment of each line; the margin is for
// another compiler or libm turning a near tie. They must not go down: a change that loses words has to explain itself, here
// and in JniSmoke.java and docs/tools/e2e/GestureTest.java, which have the same floors.
const LangCase kLangs[] = {
    {"en-US", 254, 270, 248},   // measured: 256 first, 272 among 3, 250 first without the previous word (281 words in the dictionary)
    {"es", 258, 274, 254},      // measured: 260, 276, 256 (277 words)
    {"pt-BR", 286, 292, 281},   // measured: 288, 294, 283 (300 words; synthetic gestures)
};

void samples(const std::string& dicts, const std::string& dataDir, const Tables& t, int rounds, bool quick) {
    Gesture g;
    if (gWeights.empty() || !g.openBytes(gWeights.data(), gWeights.size())) return;
    const GestureParams p = appParams();
    int corruptTrims = 0;
    for (const LangCase& lang : kLangs) {
        const std::vector<uint8_t> dict = readFile(dicts + "/" + lang.id + "/main.dict");
        SampleSet set;
        const bool loaded = loadSamples(dataDir + "/gestures_" + lang.id + ".tsv", &set);
        CHECK(loaded && !dict.empty(), "%s: gestures_%s.tsv and main.dict", lang.id, lang.id);
        if (!loaded || dict.empty()) continue;
        CHECK(g.setLayout(set.keys.data(), set.xy.data(), static_cast<int>(set.keys.size()), set.layout.free, set.layout.nFree), "%s: layout", lang.id);
        const int trimsBefore = g.trims();
        const Counts c = evaluate(g, t, dict, set, p, true);
        std::printf("%-6s %ld gestures (%ld of one letter left out), %ld in the dictionary, %ld with previous word: first %ld (%.1f%%), "
                    "among 3 %ld (%.1f%%), among 10 %ld; %.2f ms per gesture, worst %.1f; at most %ld dictionary entries read\n",
                    lang.id, c.gestures, c.oneLetter, c.known, c.withContext, c.top1, pct(c.top1, c.known), c.top3, pct(c.top3, c.known),
                    c.top10, c.totalMs / static_cast<double>(std::max<long>(1, c.gestures)), c.maxMs, c.maxNodes);
        CHECK(c.failed == 0, "%s: every gesture is answered", lang.id);
        CHECK(c.top1 >= lang.top1, "%s: %ld words came first, at least %d expected", lang.id, c.top1, lang.top1);
        CHECK(c.top3 >= lang.top3, "%s: %ld words came among the first 3, at least %d expected", lang.id, c.top3, lang.top3);
        CHECK(c.withContext > c.gestures / 2, "%s: the previous word is found in most gestures (%ld)", lang.id, c.withContext);
        CHECK(c.maxNodes <= p.nodeBudget + 256, "%s: entries read under the ceiling: %ld", lang.id, c.maxNodes);
        if (!quick) {
            const Counts n = evaluate(g, t, dict, set, p, false);
            std::printf("%-6s without previous word: first %ld, among 3 %ld, among 10 %ld\n", lang.id, n.top1, n.top3, n.top10);
            CHECK(n.failed == 0 && n.withContext == 0, "%s without previous word: every gesture is answered, none with context", lang.id);
            CHECK(n.top1 >= lang.top1NoContext, "%s without previous word: %ld words came first, at least %d expected", lang.id, n.top1, lang.top1NoContext);
        }
        std::printf("%-6s work memory of the search after these gestures: %.2f MB\n", lang.id, static_cast<double>(g.searchHeapBytes()) / 1048576.0);
        CHECK(g.trims() == trimsBefore, "%s: ordinary gestures keep their work memory (no allocation per gesture): %d trims", lang.id, g.trims() - trimsBefore);
        CHECK(g.searchHeapBytes() <= kGestureKeepBytes, "%s: work memory under the limit kept between gestures: %zu", lang.id, g.searchHeapBytes());
        if (!quick) {
            // the same gestures again, backwards: each one gives the same first word whatever came before it
            SampleSet back = set;
            std::reverse(back.items.begin(), back.items.end());
            Counts r = evaluate(g, t, dict, back, p, true);
            std::reverse(r.firsts.begin(), r.firsts.end());
            CHECK(r.firsts == c.firsts && r.top1 == c.top1 && r.top3 == c.top3, "%s: a gesture does not depend on the ones before it", lang.id);
        }

        // corrupt dictionary: nothing may crash, read outside the file or hang
        Lcg rnd(0xBADD1C7 + std::strlen(lang.id));
        SampleSet few = set;
        if (few.items.size() > 5) few.items.resize(5);
        long decodes = 0, words = 0, worstNodes = 0;
        double worstMs = 0;
        bool sane = true;
        for (int round = 0; round < rounds; round++) {
            std::vector<uint8_t> d = dict;
            const int mode = static_cast<int>(rnd.next() % 4);
            if (mode == 0) {                       // cut at any point
                d.resize(rnd.next() % (d.size() + 1));
            } else if (mode == 1) {                // some bytes swapped
                const int k = 1 + static_cast<int>(rnd.next() % 20);
                for (int i = 0; i < k; i++) d[rnd.next() % d.size()] = static_cast<uint8_t>(rnd.next());
            } else if (mode == 2) {                // many bytes swapped at the start (root and first groups)
                for (int i = 0; i < 200; i++) d[rnd.next() % std::min<size_t>(d.size(), 4096)] = static_cast<uint8_t>(rnd.next());
            } else {                               // pure garbage
                for (auto& b : d) b = static_cast<uint8_t>(rnd.next());
            }
            if (d.size() <= 2) d.resize(3, 0);
            for (const Sample& s : few.items) {
                const std::u16string lo = lowered(t, s.prev);
                const char16_t* prev[2] = {s.prev.data(), lo.data()};
                const int prevLen[2] = {static_cast<int>(s.prev.size()), static_cast<int>(lo.size())};
                const double t0 = nowMs();
                const int cnt = g.decode(t, d.data(), static_cast<int>(d.size()), s.x.data(), s.y.data(), s.t.data(),
                                         static_cast<int>(s.x.size()), prev, prevLen, 2, p);
                worstMs = std::max(worstMs, nowMs() - t0);
                decodes++;
                worstNodes = std::max<long>(worstNodes, g.nodes());
                if (cnt < 0 || cnt > kGestureResults || g.nodes() > p.nodeBudget + 256 || g.contextSize() > kGestureContext) sane = false;
                for (int i = 0; i < cnt; i++) {
                    const GestureWord& w = g.result(i);
                    words++;
                    if (w.len < 1 || w.len > kGestureChars || !std::isfinite(w.score) || !std::isfinite(w.logp) || w.keys < p.minKeys ||
                        w.keys > kMaxWord || w.freq < 0 || w.freq > 255 || w.bigram < 0 || w.bigram > 127) {
                        sane = false;
                    }
                    if (i > 0 && g.result(i - 1).score < w.score) sane = false;
                }
            }
        }
        CHECK(sane, "%s: corrupt dictionary: counts, lengths, scores and ceilings stay valid", lang.id);
        CHECK(g.searchHeapBytes() <= kGestureKeepBytes, "%s: the memory a corrupt dictionary took was given back: %zu", lang.id, g.searchHeapBytes());
        corruptTrims += g.trims() - trimsBefore;
        std::printf("%-6s corrupt dictionary: %d files, %ld gestures, %ld words returned, no crash; at most %ld entries read, worst gesture %.1f ms\n",
                    lang.id, rounds, decodes, words, worstNodes, worstMs);
    }
    std::printf("recognition memory after the three languages: %.2f MB on the heap; a corrupt dictionary made the search give memory back %d times\n",
                static_cast<double>(g.heapBytes()) / 1048576.0, corruptTrims);
    CHECK(g.heapBytes() < (5u << 20), "under 5 MB on the heap: %zu", g.heapBytes());
    CHECK(rounds < 50 || corruptTrims > 0, "the limit of work memory was exercised: %d trims", corruptTrims);
}

// Absurd calls through Gesture, the class the JNI uses.
void badInput(const std::string& dicts, const Tables& t) {
    const std::vector<uint8_t> dict = readFile(dicts + "/en-US/main.dict");
    if (dict.empty() || gWeights.empty()) return;
    const GestureParams p = appParams();
    const TestLayout tl = qwertyKeys(u"", u"'-");
    const GestureLayout& l = tl.l;
    // "hello" drawn through the centres of its keys (the doubled l once), one point every 16 ms. Each stretch starts and ends
    // slowly (minimum-jerk profile), as a hand does: at constant speed with sharp corners the network, trained on people, reads
    // the end of this trace as "help".
    std::vector<float> x, y;
    std::vector<int32_t> tm;
    const char* word = "helo";
    for (int k = 0; k + 1 < 4; k++) {
        const size_t a = static_cast<size_t>(l.find(word[k])), b = static_cast<size_t>(l.find(word[k + 1]));
        for (int i = 0; i < 14; i++) {
            const float u = static_cast<float>(i) / 14.f;
            const float f = u * u * u * (10.f - 15.f * u + 6.f * u * u);
            x.push_back(tl.xy[2 * a] + f * (tl.xy[2 * b] - tl.xy[2 * a]));
            y.push_back(tl.xy[2 * a + 1] + f * (tl.xy[2 * b + 1] - tl.xy[2 * a + 1]));
            tm.push_back(static_cast<int32_t>(tm.size()) * 16);
        }
    }
    x.push_back(tl.xy[2 * static_cast<size_t>(l.find('o'))]);
    y.push_back(tl.xy[2 * static_cast<size_t>(l.find('o')) + 1]);
    tm.push_back(static_cast<int32_t>(tm.size()) * 16);
    const int n = static_cast<int>(x.size());
    const int size = static_cast<int>(dict.size());
    Gesture g;
    CHECK(g.decode(t, dict.data(), size, x.data(), y.data(), tm.data(), n, nullptr, nullptr, 0, p) == -1 && g.count() == 0, "not open: -1");
    CHECK(!g.setLayout(l.key, nullptr, l.n, l.free, l.nFree) && !g.hasLayout(), "a refused layout leaves none");
    CHECK(g.openBytes(gWeights.data(), gWeights.size()), "open");
    CHECK(g.decode(t, dict.data(), size, x.data(), y.data(), tm.data(), n, nullptr, nullptr, 0, p) == -1, "no layout: -1");
    CHECK(g.setLayout(l.key, tl.xy.data(), l.n, l.free, l.nFree) && g.hasLayout(), "layout");
    int cnt = g.decode(t, dict.data(), size, x.data(), y.data(), tm.data(), n, nullptr, nullptr, 0, p);
    CHECK(cnt >= 1 && cnt <= kGestureResults && utf8(g.result(0).word, g.result(0).len) == "hello", "a clean trace of hello gives hello, got %s", render(g.all()).c_str());
    const std::vector<GestureWord> clean = g.all();
    CHECK(g.emissions() != nullptr && g.columns() == 27, "the table of the last gesture is there");

    CHECK(g.decode(t, dict.data(), size, x.data(), y.data(), tm.data(), 0, nullptr, nullptr, 0, p) == -1 && g.count() == 0, "no points: -1");
    CHECK(g.decode(t, dict.data(), size, x.data(), y.data(), tm.data(), -3, nullptr, nullptr, 0, p) == -1, "negative count: -1");
    CHECK(g.decode(t, dict.data(), size, x.data(), y.data(), tm.data(), kGestureMaxTouches + 1, nullptr, nullptr, 0, p) == -1, "too many points: -1");
    CHECK(g.decode(t, dict.data(), size, nullptr, y.data(), tm.data(), n, nullptr, nullptr, 0, p) == -1, "null x: -1");
    CHECK(g.decode(t, dict.data(), size, x.data(), nullptr, tm.data(), n, nullptr, nullptr, 0, p) == -1, "null y: -1");
    CHECK(g.decode(t, dict.data(), size, x.data(), y.data(), nullptr, n, nullptr, nullptr, 0, p) == -1, "null times: -1");
    for (float bad : {std::numeric_limits<float>::quiet_NaN(), std::numeric_limits<float>::infinity(), -std::numeric_limits<float>::infinity()}) {
        std::vector<float> xb = x, yb = y;
        xb[5] = bad;
        CHECK(g.decode(t, dict.data(), size, xb.data(), y.data(), tm.data(), n, nullptr, nullptr, 0, p) == -1, "x that is not a number: -1");
        yb[static_cast<size_t>(n - 1)] = bad;
        CHECK(g.decode(t, dict.data(), size, x.data(), yb.data(), tm.data(), n, nullptr, nullptr, 0, p) == -1 && g.count() == 0, "y that is not a number: -1");
    }
    GestureParams zero;
    CHECK(g.decode(t, dict.data(), size, x.data(), y.data(), tm.data(), n, nullptr, nullptr, 0, zero) == -1, "parameters never set: -1");
    Tables noTables;
    CHECK(g.decode(noTables, dict.data(), size, x.data(), y.data(), tm.data(), n, nullptr, nullptr, 0, p) == -1, "tables never handed over: -1");
    CHECK(g.decode(t, nullptr, size, x.data(), y.data(), tm.data(), n, nullptr, nullptr, 0, p) == 0, "no dictionary: 0 words");
    CHECK(g.decode(t, dict.data(), 2, x.data(), y.data(), tm.data(), n, nullptr, nullptr, 0, p) == 0, "2-byte dictionary: 0 words");

    // values that are numbers but absurd: answered (anything), never a crash
    std::vector<float> huge(static_cast<size_t>(n), 3e38f), tiny(static_cast<size_t>(n), -3e38f), still(static_cast<size_t>(n), 0.45f);
    cnt = g.decode(t, dict.data(), size, huge.data(), tiny.data(), tm.data(), n, nullptr, nullptr, 0, p);
    CHECK(cnt >= 0 && cnt <= kGestureResults, "huge coordinates are answered: %d", cnt);
    cnt = g.decode(t, dict.data(), size, still.data(), still.data(), tm.data(), n, nullptr, nullptr, 0, p);
    CHECK(cnt >= 0 && cnt <= kGestureResults, "a finger that never moved is answered: %d", cnt);
    std::vector<int32_t> zeroT(static_cast<size_t>(n), 0), backT(tm.rbegin(), tm.rend());
    cnt = g.decode(t, dict.data(), size, x.data(), y.data(), zeroT.data(), n, nullptr, nullptr, 0, p);
    CHECK(cnt >= 1 && utf8(g.result(0).word, g.result(0).len) == "hello", "no time at all between the points (they are evenly spaced in time anyway): still hello, got %s", render(g.all()).c_str());
    cnt = g.decode(t, dict.data(), size, x.data(), y.data(), backT.data(), n, nullptr, nullptr, 0, p);
    CHECK(cnt >= 0 && cnt <= kGestureResults, "times that go back are answered: %d", cnt);
    cnt = g.decode(t, dict.data(), size, x.data(), y.data(), tm.data(), 1, nullptr, nullptr, 0, p);
    CHECK(cnt >= 0 && cnt <= kGestureResults, "one point is answered: %d", cnt);
    std::vector<float> lx(kGestureMaxTouches), ly(kGestureMaxTouches);
    std::vector<int32_t> lt(kGestureMaxTouches);
    for (int i = 0; i < kGestureMaxTouches; i++) {
        lx[static_cast<size_t>(i)] = 0.5f + 0.45f * std::sin(static_cast<float>(i) * 0.05f);
        ly[static_cast<size_t>(i)] = 0.5f + 0.45f * std::cos(static_cast<float>(i) * 0.031f);
        lt[static_cast<size_t>(i)] = i * 8;
    }
    const double t0 = nowMs();
    cnt = g.decode(t, dict.data(), size, lx.data(), ly.data(), lt.data(), kGestureMaxTouches, nullptr, nullptr, 0, p);
    CHECK(cnt >= 0 && cnt <= kGestureResults && g.nodes() <= p.nodeBudget + 256, "a 33-second scribble of 4096 points is answered: %d words, %d entries, %.1f ms", cnt, g.nodes(), nowMs() - t0);

    // spellings of the previous word: null, empty and too long ones are skipped; the first one found is used
    const std::u16string of = u"of", longWord(60, u'a');
    const char16_t* prev[4] = {nullptr, longWord.data(), u"", of.data()};
    const int prevLen[4] = {5, 60, 0, 2};
    cnt = g.decode(t, dict.data(), size, x.data(), y.data(), tm.data(), n, prev, prevLen, 4, p);
    CHECK(cnt >= 1 && g.contextSize() > 0, "the fourth spelling is found: %d bigrams", g.contextSize());
    cnt = g.decode(t, dict.data(), size, x.data(), y.data(), tm.data(), n, prev, prevLen, 3, p);
    CHECK(cnt >= 1 && g.contextSize() == 0, "the first three are not words: no context");
    cnt = g.decode(t, dict.data(), size, x.data(), y.data(), tm.data(), n, prev, prevLen, 400, p);
    CHECK(cnt >= 1 && g.contextSize() > 0, "a count above the limit only tries the first %d", kGestureSpellings);
    cnt = g.decode(t, dict.data(), size, x.data(), y.data(), tm.data(), n, nullptr, prevLen, 4, p);
    CHECK(cnt >= 1 && g.contextSize() == 0, "null spellings: no context");

    // after all that, the clean trace gives exactly what it gave before
    cnt = g.decode(t, dict.data(), size, x.data(), y.data(), tm.data(), n, nullptr, nullptr, 0, p);
    bool same = clean.size() == g.all().size();
    for (size_t i = 0; same && i < clean.size(); i++) same = clean[i].at == g.all()[i].at && clean[i].score == g.all()[i].score;
    CHECK(same, "the clean trace gives the same answer after the absurd calls");
    g.close();
    CHECK(!g.isOpen() && g.count() == 0 && g.heapBytes() < 16384, "close frees the weights and the work memory: %zu bytes left", g.heapBytes());
    CHECK(g.decode(t, dict.data(), size, x.data(), y.data(), tm.data(), n, nullptr, nullptr, 0, p) == -1, "closed: -1");
    CHECK(g.hasLayout() && g.openBytes(gWeights.data(), gWeights.size()), "the layout survives close; open again");
    cnt = g.decode(t, dict.data(), size, x.data(), y.data(), tm.data(), n, nullptr, nullptr, 0, p);
    same = clean.size() == g.all().size();
    for (size_t i = 0; same && i < clean.size(); i++) same = clean[i].at == g.all()[i].at && clean[i].score == g.all()[i].score;
    CHECK(same, "closed and opened again, the same answer with the layout set before");
    CHECK(!g.openBytes(gWeights.data(), 100) && !g.isOpen() && g.hasLayout(), "a failed open leaves it closed, the layout stays");
    CHECK(!g.setLayout(l.key, tl.xy.data(), 1, l.free, l.nFree) && !g.hasLayout(), "a refused layout leaves none");
    std::printf("absurd input ok\n");
}

// Place of the word among the results (0 = first; -1 = not there), counting words that differ only in upper and lower case once.
int rankOf(const Tables& t, const std::vector<GestureWord>& all, size_t max, const std::u16string& target) {
    std::vector<std::u16string> seen;
    for (size_t i = 0; i < all.size() && i < max; i++) {
        const std::u16string wl = lowered(t, std::u16string(all[i].word, all[i].word + all[i].len));
        if (std::find(seen.begin(), seen.end(), wl) != seen.end()) continue;
        if (wl == target) return static_cast<int>(seen.size());
        seen.push_back(wl);
    }
    return -1;
}

// Can the word be drawn on this keyboard, through at least two keys?
bool drawable(const Tables& t, const GestureLayout& l, const std::u16string& w) {
    int letters = 0;
    for (char16_t ch : w) {
        if (l.isFree(ch)) continue;
        if (l.find(t.lowerOf(ch)) < 0 && l.find(t.baseOf(ch)) < 0) return false;
        letters++;
    }
    return letters >= 2;
}

// Gesture::more (contract 3): a second dictionary, the words of the person, searched with the table of the last gesture.
void secondDictionary(const std::string& dicts, const std::string& dataDir, const Tables& t, int rounds) {
    Gesture g;
    const std::vector<uint8_t> dict = readFile(dicts + "/en-US/main.dict");
    SampleSet set;
    if (gWeights.empty() || dict.empty() || !loadSamples(dataDir + "/gestures_en-US.tsv", &set)) return;
    const GestureParams p = appParams();
    const int dictSize = static_cast<int>(dict.size());
    GestureDict main;
    main.attach(dict.data(), dictSize);
    const std::vector<uint8_t> any = makeDict({{u"hello", 100, {}}, {u"world", 100, {}}}, 1);

    auto decode = [&](const Sample& s, const std::vector<uint8_t>& d, const GestureParams& pp) {
        const std::u16string lo = lowered(t, s.prev), cap = capitalized(t, s.prev);
        const char16_t* prev[3] = {s.prev.data(), lo.data(), cap.data()};
        const int prevLen[3] = {static_cast<int>(s.prev.size()), static_cast<int>(lo.size()), static_cast<int>(cap.size())};
        return g.decode(t, d.data(), static_cast<int>(d.size()), s.x.data(), s.y.data(), s.t.data(), static_cast<int>(s.x.size()), prev,
                        prevLen, s.prev.empty() ? 0 : 3, pp);
    };
    auto more = [&](const std::vector<uint8_t>& d, const GestureParams& pp) {
        return g.more(t, d.data(), static_cast<int>(d.size()), nullptr, nullptr, 0, pp);
    };
    auto results = [&]() { return std::vector<GestureWord>(g.all().begin(), g.all().begin() + g.count()); };
    auto text = [](const GestureWord& w) { return std::u16string(w.word, w.word + w.len); };
    auto same = [&](const std::vector<GestureWord>& a, const std::vector<GestureWord>& b) {
        if (a.size() != b.size()) return false;
        for (size_t i = 0; i < a.size(); i++) {
            if (text(a[i]) != text(b[i]) || a[i].score != b[i].score || a[i].source != b[i].source) return false;
        }
        return true;
    };
    // what every merged list must be: at most kGestureResults words, best first, values in range, and no word of the second
    // dictionary twice whatever the case (main.dict alone may give "the" and "The": two entries, which Java makes one)
    auto sound = [&](const GestureParams& pp) {
        const int n = g.count();
        if (n < 0 || n > kGestureResults || static_cast<size_t>(n) > g.all().size()) return false;
        for (int i = 0; i < n; i++) {
            const GestureWord& w = g.result(i);
            if (w.len < 1 || w.len > kGestureChars || !std::isfinite(w.score) || !std::isfinite(w.logp) || w.keys < pp.minKeys ||
                w.keys > kMaxWord || w.freq < 0 || w.freq > 255 || w.bigram < 0 || w.bigram > 127 || (w.source != 0 && w.source != 1)) {
                return false;
            }
            if (i > 0 && g.result(i - 1).score < w.score) return false;
            for (int j = 0; j < n; j++) {
                if (j != i && w.source == 1 && lowered(t, text(g.result(j))) == lowered(t, text(w))) return false;
            }
        }
        return true;
    };

    // ---- without a table there is nothing to search
    CHECK(!g.hasTable() && more(any, p) == -1, "more: not open, no layout, no gesture: -1");
    CHECK(g.openBytes(gWeights.data(), gWeights.size()), "more: weights");
    CHECK(more(any, p) == -1, "more: open but no layout: -1");
    CHECK(g.setLayout(set.keys.data(), set.xy.data(), static_cast<int>(set.keys.size()), set.layout.free, set.layout.nFree), "more: layout");
    CHECK(!g.hasTable() && more(any, p) == -1 && g.count() == 0, "more: no gesture since the layout was set: -1");

    // the gestures of words that can be drawn, apart: the ones main.dict has and the ones it does not
    std::vector<const Sample*> known, unknown;
    std::vector<std::u16string> own;
    for (const Sample& s : set.items) {
        if (s.x.size() < 2 || !drawable(t, set.layout, s.word)) continue;
        if (hasIgnoreCase(t, main, s.word)) {
            known.push_back(&s);
        } else {
            unknown.push_back(&s);
            const std::u16string lo = lowered(t, s.word);
            if (std::find(own.begin(), own.end(), lo) == own.end()) own.push_back(lo);
        }
    }
    CHECK(known.size() >= 250 && unknown.size() >= 10 && own.size() >= 10, "more: the English gestures have words main.dict lacks: %zu and %zu (%zu words)",
          known.size(), unknown.size(), own.size());
    if (known.size() < 60 || unknown.empty()) return;

    // ---- one score for both dictionaries: two halves of a small dictionary, searched one after the other, give the list
    //      of the whole (with a beam that cuts nothing, each word has the same score wherever it is)
    {
        std::vector<std::u16string> words;
        for (size_t i = 0; i < 60; i++) {
            const std::u16string lo = lowered(t, known[i]->word);
            if (std::find(words.begin(), words.end(), lo) == words.end()) words.push_back(lo);
        }
        std::vector<TestWord> a, b, ab;
        for (size_t i = 0; i < words.size(); i++) {
            const TestWord w{words[i], 60 + static_cast<int>(i * 37 % 150), {}};
            (i % 2 == 0 ? a : b).push_back(w);
            ab.push_back(w);
        }
        const std::vector<uint8_t> da = makeDict(a, 1), db = makeDict(b, 2), dab = makeDict(ab, 1);
        GestureParams wide = p;
        wide.beam = 100000;
        long compared = 0, different = 0, fromSecond = 0, wrongSource = 0, nodesShort = 0;
        for (size_t i = 0; i < 60; i++) {
            const int whole = decode(*known[i], dab, wide);
            const std::vector<GestureWord> one = results();
            const int first = decode(*known[i], da, wide);
            const int nodesFirst = g.nodes();
            const int both = more(db, wide);
            const std::vector<GestureWord> two = results();
            if (whole < 0 || first < 0 || both != whole || one.size() != two.size() || !sound(wide)) {
                different++;
                continue;
            }
            if (g.nodes() <= nodesFirst) nodesShort++;
            for (size_t k = 0; k < one.size(); k++) {
                compared++;
                if (text(one[k]) != text(two[k]) || std::fabs(one[k].score - two[k].score) > 1e-3f || one[k].keys != two[k].keys ||
                    one[k].freq != two[k].freq) {
                    different++;
                }
                bool inB = false;
                for (const TestWord& w : b) inB = inB || w.w == text(two[k]);
                if (inB) fromSecond++;
                if ((two[k].source == 1) != inB || one[k].source != 0) wrongSource++;
            }
        }
        CHECK(different == 0 && compared > 300, "more: two halves of a dictionary give the list of the whole one: %ld of %ld words differ", different, compared);
        CHECK(wrongSource == 0 && fromSecond > 100, "more: each word says which dictionary it came from: %ld wrong (%ld from the second)", wrongSource, fromSecond);
        CHECK(nodesShort == 0, "more: the entries read count both searches");
    }

    // ---- main.dict and the words of the person: the words it lacks now come out, its own keep their place
    {
        std::vector<TestWord> words;
        for (const std::u16string& w : own) words.push_back({w, 100, {}});
        const std::vector<uint8_t> second = makeDict(words, 1);
        long first = 0, top3 = 0, before = 0, unsound = 0, notSecond = 0;
        for (const Sample* s : unknown) {
            const std::u16string target = lowered(t, s->word);
            if (decode(*s, dict, p) < 0) unsound++;
            if (rankOf(t, g.all(), static_cast<size_t>(kGestureResults), target) >= 0) before++;
            if (more(second, p) < 0 || !sound(p)) unsound++;
            const int r = rankOf(t, g.all(), static_cast<size_t>(g.count()), target);
            if (r == 0) first++;
            if (r >= 0 && r < 3) top3++;
            const std::vector<GestureWord> merged = results();
            const GestureWord* w = findWord(merged, target);
            if (w != nullptr && w->source != 1) notSecond++;
        }
        long kept = 0, was = 0, moved = 0;
        for (const Sample* s : known) {
            const std::u16string target = lowered(t, s->word);
            if (decode(*s, dict, p) < 0) unsound++;
            const bool top = rankOf(t, g.all(), static_cast<size_t>(kGestureResults), target) == 0;
            const std::vector<GestureWord> alone = results();
            if (more(second, p) < 0 || !sound(p)) unsound++;
            if (top) was++;
            if (top && rankOf(t, g.all(), static_cast<size_t>(g.count()), target) == 0) kept++;
            // a word of the second dictionary may come in, but the ones of main.dict that stay keep their order and scores
            const std::vector<GestureWord> merged = results();
            size_t k = 0;
            for (const GestureWord& w : merged) {
                if (w.source != 0) continue;
                while (k < alone.size() && text(alone[k]) != text(w)) k++;
                if (k == alone.size() || alone[k].score != w.score) moved++;
            }
        }
        std::printf("en-US  second dictionary of %zu words (frequency 100, %zu bytes): of %zu gestures of those words, first %ld, among 3 %ld; of %ld "
                    "words of main.dict that came first, %ld still do\n",
                    own.size(), second.size(), unknown.size(), first, top3, was, kept);
        CHECK(unsound == 0, "more: every merged list is in order, with no word twice: %ld bad", unsound);
        CHECK(before == 0 && notSecond == 0, "more: those words were not there before and come from the second dictionary");
        CHECK(first >= 12 && top3 >= 15, "more: words main.dict lacks: %ld first and %ld among 3 of %zu (at least 12 and 15 expected)", first, top3,
              unknown.size());
        CHECK(was - kept <= 1, "more: the words of main.dict keep the first place: %ld of %ld", kept, was);
        CHECK(moved == 0, "more: the words of main.dict keep their scores and their order among themselves: %ld moved", moved);
    }

    // ---- a word both dictionaries have stays once, with the larger of its two scores
    {
        const Sample* s = nullptr;
        for (const Sample* k : known) {       // a gesture whose word comes first, in lower case and in no other spelling
            if (decode(*k, dict, p) <= 1 || text(g.result(0)) != lowered(t, k->word) || g.result(0).freq >= 250) continue;
            int spellings = 0;
            for (int i = 0; i < g.count(); i++) {
                if (lowered(t, text(g.result(i))) == text(g.result(0))) spellings++;
            }
            if (spellings == 1) {
                s = k;
                break;
            }
        }
        CHECK(s != nullptr, "more: a gesture to repeat");
        if (s != nullptr) {
            const std::u16string word = lowered(t, s->word), cap = capitalized(t, s->word);
            decode(*s, dict, p);
            const std::vector<GestureWord> alone = results();
            const std::vector<uint8_t> weak = makeDict({{cap, 1, {}}}, 1), strong = makeDict({{cap, 255, {}}}, 1);
            CHECK(more(weak, p) == static_cast<int>(alone.size()) && same(alone, results()),
                  "more: the same word with a lower score changes nothing (%s)", render(g.all()).c_str());
            decode(*s, dict, p);
            const int replaced = more(strong, p);
            const std::vector<GestureWord> swapped = results();
            CHECK(replaced == static_cast<int>(alone.size()) && sound(p) && text(swapped[0]) == cap && swapped[0].source == 1 &&
                      swapped[0].freq == 255 && swapped[0].score > alone[0].score && findWord(swapped, word) == nullptr,
                  "more: the same word with a higher score takes the place of the other spelling (%d of %zu: %s)", replaced, alone.size(),
                  render(swapped).c_str());
            // nothing to add: no dictionary, a header alone, a word that cannot be drawn, a word of one key
            decode(*s, dict, p);
            const std::vector<uint8_t> header = {200, 1}, digits = makeDict({{u"12345", 255, {}}}, 1), oneKey = makeDict({{u"aaa", 255, {}}}, 1);
            CHECK(g.more(t, nullptr, 0, nullptr, nullptr, 0, p) == static_cast<int>(alone.size()) && same(alone, results()), "more: no dictionary: the results stay");
            CHECK(more(header, p) == static_cast<int>(alone.size()) && same(alone, results()), "more: an empty dictionary: the results stay");
            CHECK(more(digits, p) == static_cast<int>(alone.size()) && more(oneKey, p) == static_cast<int>(alone.size()) && same(alone, results()),
                  "more: words no gesture writes: the results stay");
            // values the search refuses: -1 and the results stay
            GestureParams bad = p;
            bad.beam = 0;
            CHECK(more(strong, bad) == -1 && g.count() == static_cast<int>(alone.size()) && same(alone, results()), "more: refused values: -1, the results stay");
            // twice: a third dictionary joins the two
            const std::vector<uint8_t> third = makeDict({{word + u"'s", 255, {}}}, 1);
            const int two = more(strong, p), three = more(third, p);
            const std::vector<GestureWord> all3 = results();
            const GestureWord* w3 = findWord(all3, word + u"'s");
            CHECK(two >= 1 && three >= 2 && sound(p) && findWord(all3, cap) != nullptr && w3 != nullptr && w3->source == 1 && w3->freq == 255,
                  "more: called twice, the three dictionaries are merged (%s)", render(all3).c_str());
            // the previous word is looked up in the dictionary given: here its pair wins over a more frequent word
            const std::vector<uint8_t> pairs = makeDict({{u"qqq", 50, {{cap, 127}}}, {cap, 10, {}}}, 1);
            const std::u16string q = u"qqq";
            const char16_t* prev[1] = {q.data()};
            const int prevLen[1] = {3};
            decode(*s, any, p);
            const int with = g.more(t, pairs.data(), static_cast<int>(pairs.size()), prev, prevLen, 1, p);
            const std::vector<GestureWord> merged = results();
            const GestureWord* w = with > 0 ? findWord(merged, cap) : nullptr;
            CHECK(w != nullptr && w->bigram == 127 && w->source == 1 && g.contextSize() == 1,
                  "more: the previous word counts when the second dictionary has pairs (%s)", render(merged).c_str());
        }
    }

    // ---- the table goes with the weights, the layout and the last gesture
    {
        const Sample& s = *known[0];
        CHECK(decode(s, dict, p) > 0 && g.hasTable() && more(any, p) >= 0, "more: after a gesture there is a table");
        CHECK(g.setLayout(set.keys.data(), set.xy.data(), static_cast<int>(set.keys.size()), set.layout.free, set.layout.nFree) && !g.hasTable() &&
                  more(any, p) == -1 && g.count() == 0,
              "more: a new layout: no table");
        decode(s, dict, p);
        const float nan = std::numeric_limits<float>::quiet_NaN();
        const int32_t zero = 0;
        const int refused = g.decode(t, dict.data(), dictSize, &nan, &nan, &zero, 1, nullptr, nullptr, 0, p);
        CHECK(refused == -1 && !g.hasTable() && more(any, p) == -1, "more: a gesture that was refused leaves no table");
        decode(s, dict, p);
        CHECK(g.openBytes(gWeights.data(), gWeights.size()) && !g.hasTable() && more(any, p) == -1, "more: weights opened again: no table");
        decode(s, dict, p);
        g.close();
        CHECK(!g.hasTable() && more(any, p) == -1, "more: closed: no table");
        CHECK(g.openBytes(gWeights.data(), gWeights.size()) && decode(s, dict, p) > 0 && more(any, p) >= 0, "more: open again, a gesture, a table");
    }

    // ---- a corrupt second dictionary: nothing may crash, read outside the buffer or hang
    {
        std::vector<TestWord> words;
        for (size_t i = 0; i < set.items.size(); i++) {
            const std::u16string lo = lowered(t, set.items[i].word);
            bool seen = false;
            for (const TestWord& w : words) seen = seen || w.w == lo;
            if (!seen && !lo.empty()) words.push_back({lo, 80 + static_cast<int>(i % 100), {}});
        }
        const std::vector<uint8_t> good = makeDict(words, 1);
        Lcg rnd(0x5EC0D1C7);
        long calls = 0, bad = 0, worstNodes = 0;
        double worstMs = 0;
        for (int round = 0; round < rounds; round++) {
            std::vector<uint8_t> d = good;
            const int mode = static_cast<int>(rnd.next() % 4);
            if (mode == 0) {
                d.resize(rnd.next() % (d.size() + 1));
            } else if (mode == 1) {
                const int k = 1 + static_cast<int>(rnd.next() % 20);
                for (int i = 0; i < k; i++) d[rnd.next() % d.size()] = static_cast<uint8_t>(rnd.next());
            } else if (mode == 2) {
                for (int i = 0; i < 200; i++) d[rnd.next() % std::min<size_t>(d.size(), 4096)] = static_cast<uint8_t>(rnd.next());
            } else {
                for (auto& b : d) b = static_cast<uint8_t>(rnd.next());
            }
            for (size_t i = 0; i < 5; i++) {
                const int first = decode(*known[i], dict, p);
                const double t0 = nowMs();
                const int both = more(d, p);
                worstMs = std::max(worstMs, nowMs() - t0);
                calls++;
                worstNodes = std::max<long>(worstNodes, g.nodes());
                if (first <= 0 || both <= 0 || !sound(p) || g.nodes() > 2 * (p.nodeBudget + 256)) bad++;
            }
        }
        CHECK(bad == 0, "more: corrupt second dictionary: the lists stay valid and never empty: %ld bad of %ld", bad, calls);
        CHECK(g.searchHeapBytes() <= kGestureKeepBytes, "more: the work memory stays under the limit kept between gestures: %zu", g.searchHeapBytes());
        std::printf("en-US  corrupt second dictionary: %d files, %ld searches, no crash; at most %ld entries read in the two searches, worst %.1f ms\n",
                    rounds, calls, worstNodes, worstMs);
    }
}

int evalMain(int argc, char** argv) {
    if (argc < 5) {
        std::printf("usage: mr_gesture_test eval main.dict weights_file gestures.tsv [max] [context|nocontext] [detail.tsv]\n");
        return 2;
    }
    Tables t;
    approxTables(t);
    const std::vector<uint8_t> dict = readFile(argv[2]);
    Gesture g;
    SampleSet set;
    const long max = argc > 5 ? std::atol(argv[5]) : -1;
    const bool context = !(argc > 6 && std::strcmp(argv[6], "nocontext") == 0);
    if (dict.empty() || !g.open(argv[3]) || !loadSamples(argv[4], &set, max) ||
        !g.setLayout(set.keys.data(), set.xy.data(), static_cast<int>(set.keys.size()), set.layout.free, set.layout.nFree)) {
        std::printf("could not read the dictionary, the weights or the gestures (the file of gestures needs its @keys line)\n");
        return 2;
    }
    const GestureParams p = appParams();
    FILE* detail = argc > 7 ? std::fopen(argv[7], "w") : nullptr;
    const Counts c = evaluate(g, t, dict, set, p, context, detail);
    if (detail) std::fclose(detail);
    std::printf("gestures=%ld (left out: %ld of one letter) in_dictionary=%ld (%.1f%%) with_previous_word=%ld unanswered=%ld\n", c.gestures,
                c.oneLetter, c.known, pct(c.known, c.gestures), c.withContext, c.failed);
    std::printf("parameters: beam=%d gamma=%.4f lambda=%.4f beta=%.4f ctx=%.4f gp=%.4f bp=%.4f min_keys=%d node_budget=%d\n", p.beam,
                static_cast<double>(p.gamma), static_cast<double>(p.lambdaF), static_cast<double>(p.beta), static_cast<double>(p.ctx),
                static_cast<double>(p.gammaPrune), static_cast<double>(p.betaPrune), p.minKeys, p.nodeBudget);
    std::printf("words of the dictionary: first=%ld (%.2f%%) among3=%ld (%.2f%%) among5=%ld (%.2f%%) among10=%ld (%.2f%%) alive_at_the_end=%ld (%.2f%%)\n",
                c.top1, pct(c.top1, c.known), c.top3, pct(c.top3, c.known), c.top5, pct(c.top5, c.known), c.top10, pct(c.top10, c.known),
                c.alive, pct(c.alive, c.known));
    std::printf("time: %.2f ms per gesture (network + search, 1 thread), worst %.1f ms; at most %ld dictionary entries read; %.2f MB on the heap\n",
                c.totalMs / static_cast<double>(std::max<long>(1, c.gestures)), c.maxMs, c.maxNodes, static_cast<double>(g.heapBytes()) / 1048576.0);
    return 0;
}

// "words": the words of the user. The words of the file that main.dict does not have stand for what a person taught the
// keyboard: they go into a second dictionary, all with the same frequency, and every gesture is searched in both
// (Gesture::decode and then Gesture::more). Two questions: how many of those words now come out, and how many words of
// main.dict lose their place to one of them.
int wordsMain(int argc, char** argv) {
    if (argc < 5) {
        std::printf("usage: mr_gesture_test words main.dict weights_file gestures.tsv [max] [frequency ...]\n");
        return 2;
    }
    Tables t;
    approxTables(t);
    const std::vector<uint8_t> dict = readFile(argv[2]);
    Gesture g;
    SampleSet set;
    const long max = argc > 5 ? std::atol(argv[5]) : -1;
    if (dict.empty() || !g.open(argv[3]) || !loadSamples(argv[4], &set, max) ||
        !g.setLayout(set.keys.data(), set.xy.data(), static_cast<int>(set.keys.size()), set.layout.free, set.layout.nFree)) {
        std::printf("could not read the dictionary, the weights or the gestures (the file of gestures needs its @keys line)\n");
        return 2;
    }
    std::vector<int> freqs;
    for (int i = 6; i < argc; i++) freqs.push_back(std::atoi(argv[i]));
    if (freqs.empty()) freqs.push_back(130);
    GestureDict d;
    d.attach(dict.data(), static_cast<int>(dict.size()));
    const GestureParams p = appParams();
    // which gestures are of a word of main.dict, which of a word only the person has
    std::vector<int> kind(set.items.size(), -1);        // 0 = main.dict has it, 1 = only the user
    std::vector<std::u16string> own;
    long nMain = 0, nOwn = 0;
    for (size_t i = 0; i < set.items.size(); i++) {
        const Sample& s = set.items[i];
        if (s.x.size() < 2 || !drawable(t, set.layout, s.word)) continue;
        if (hasIgnoreCase(t, d, s.word)) {
            kind[i] = 0;
            nMain++;
        } else {
            kind[i] = 1;
            nOwn++;
            const std::u16string lo = lowered(t, s.word);
            if (std::find(own.begin(), own.end(), lo) == own.end()) own.push_back(lo);
        }
    }
    std::printf("gestures: %ld of a word of main.dict, %ld of a word it does not have (%zu different words: the second dictionary)\n", nMain,
                nOwn, own.size());
    for (int freq : freqs) {
        std::vector<TestWord> words;
        for (const std::u16string& w : own) words.push_back({w, freq, {}});
        const std::vector<uint8_t> second = makeDict(words, 1);
        long before1 = 0, before3 = 0, after1 = 0, after3 = 0, own1 = 0, own3 = 0, lost1 = 0, failed = 0;
        double msFirst = 0, msMore = 0;
        for (size_t i = 0; i < set.items.size(); i++) {
            if (kind[i] < 0) continue;
            const Sample& s = set.items[i];
            const std::u16string lo = lowered(t, s.prev), cap = capitalized(t, s.prev);
            const char16_t* prev[3] = {s.prev.data(), lo.data(), cap.data()};
            const int prevLen[3] = {static_cast<int>(s.prev.size()), static_cast<int>(lo.size()), static_cast<int>(cap.size())};
            const int nPrev = s.prev.empty() ? 0 : 3;
            const std::u16string target = lowered(t, s.word);
            double t0 = nowMs();
            const int n = g.decode(t, dict.data(), static_cast<int>(dict.size()), s.x.data(), s.y.data(), s.t.data(),
                                   static_cast<int>(s.x.size()), prev, prevLen, nPrev, p);
            msFirst += nowMs() - t0;
            if (n < 0) {
                failed++;
                continue;
            }
            const int r0 = rankOf(t, g.all(), static_cast<size_t>(kGestureResults), target);
            t0 = nowMs();
            const int m = g.more(t, second.data(), static_cast<int>(second.size()), prev, prevLen, nPrev, p);
            msMore += nowMs() - t0;
            if (m < 0) failed++;
            const int r1 = rankOf(t, g.all(), static_cast<size_t>(kGestureResults), target);
            if (kind[i] == 0) {
                if (r0 == 0) before1++;
                if (r0 >= 0 && r0 < 3) before3++;
                if (r1 == 0) after1++;
                if (r1 >= 0 && r1 < 3) after3++;
                if (r0 == 0 && r1 != 0) lost1++;
            } else {
                if (r1 == 0) own1++;
                if (r1 >= 0 && r1 < 3) own3++;
            }
        }
        std::printf("frequency %3d: words of the user first=%ld (%.2f%%) among3=%ld (%.2f%%) | words of main.dict first=%ld -> %ld "
                    "(%.2f%% -> %.2f%%; %ld lost the first place) among3=%ld -> %ld | second dictionary %zu bytes, %.3f ms per gesture "
                    "(the first search and the network: %.2f ms) unanswered=%ld\n",
                    freq, own1, pct(own1, nOwn), own3, pct(own3, nOwn), before1, after1, pct(before1, nMain), pct(after1, nMain), lost1,
                    before3, after3, second.size(), msMore / static_cast<double>(std::max<long>(1, nMain + nOwn)),
                    msFirst / static_cast<double>(std::max<long>(1, nMain + nOwn)), failed);
    }
    return 0;
}

// "partial": what the recognition gives while the finger is still sliding (the preview of the word). Each gesture is cut at
// some fractions of its duration and each part is decoded as if the finger had lifted there.
int partialMain(int argc, char** argv) {
    if (argc < 5) {
        std::printf("usage: mr_gesture_test partial main.dict weights_file gestures.tsv [max] [step_ms]\n");
        return 2;
    }
    Tables t;
    approxTables(t);
    const std::vector<uint8_t> dict = readFile(argv[2]);
    Gesture g;
    SampleSet set;
    const long max = argc > 5 ? std::atol(argv[5]) : -1;
    const int step = argc > 6 ? std::max(1, std::atoi(argv[6])) : 100;
    if (dict.empty() || !g.open(argv[3]) || !loadSamples(argv[4], &set, max) ||
        !g.setLayout(set.keys.data(), set.xy.data(), static_cast<int>(set.keys.size()), set.layout.free, set.layout.nFree)) {
        std::printf("could not read the dictionary, the weights or the gestures (the file of gestures needs its @keys line)\n");
        return 2;
    }
    GestureDict d;
    d.attach(dict.data(), static_cast<int>(dict.size()));
    const GestureParams p = appParams();
    const int kFractions[] = {25, 50, 75, 90, 100};
    const int nf = 5;
    long counted = 0, same[5] = {0}, right[5] = {0}, prefix[5] = {0}, nothing[5] = {0};
    // following the gesture every `step` ms, as the keyboard would
    long decodes = 0, changes = 0, shown = 0, lastRight = 0, durations = 0;
    double ms = 0, worstMs = 0;
    long firstRightAt = 0, firstRightN = 0;        // when the final word first shows and stays, as a share of the duration
    for (const Sample& s : set.items) {
        if (s.x.size() < 2 || !drawable(t, set.layout, s.word) || !hasIgnoreCase(t, d, s.word)) continue;
        const std::u16string lo = lowered(t, s.prev), cap = capitalized(t, s.prev);
        const char16_t* prev[3] = {s.prev.data(), lo.data(), cap.data()};
        const int prevLen[3] = {static_cast<int>(s.prev.size()), static_cast<int>(lo.size()), static_cast<int>(cap.size())};
        const int nPrev = s.prev.empty() ? 0 : 3;
        const int total = static_cast<int>(s.x.size());
        const int dur = s.t[static_cast<size_t>(total - 1)] - s.t[0];
        if (dur <= 0) continue;
        const std::u16string target = lowered(t, s.word);
        auto cut = [&](int untilMs) {              // points recorded up to this time
            int n = 0;
            while (n < total && s.t[static_cast<size_t>(n)] - s.t[0] <= untilMs) n++;
            return std::max(n, 1);
        };
        auto first = [&](int n) {
            const double t0 = nowMs();
            const int c = g.decode(t, dict.data(), static_cast<int>(dict.size()), s.x.data(), s.y.data(), s.t.data(), n, prev, prevLen,
                                   nPrev, p);
            const double took = nowMs() - t0;
            ms += took;
            worstMs = std::max(worstMs, took);
            decodes++;
            return c > 0 ? lowered(t, wordAt(g.all(), 0)) : std::u16string();
        };
        const std::u16string whole = first(total);
        counted++;
        durations += dur;
        for (int k = 0; k < nf; k++) {
            const std::u16string w = kFractions[k] == 100 ? whole : first(cut(dur * kFractions[k] / 100));
            if (w.empty()) nothing[k]++;
            if (w == whole && !w.empty()) same[k]++;
            if (w == target) right[k]++;
            if (!w.empty() && w.size() <= target.size() && target.compare(0, w.size(), w) == 0) prefix[k]++;
        }
        std::u16string last;
        int stableSince = -1;
        for (int at = step; at < dur; at += step) {
            const std::u16string w = first(cut(at));
            if (w.empty()) continue;
            shown++;
            if (!last.empty() && w != last) changes++;
            if (w == whole) {
                if (stableSince < 0) stableSince = at;
            } else {
                stableSince = -1;
            }
            last = w;
        }
        if (!last.empty() && last == whole) lastRight++;
        if (stableSince >= 0) {
            firstRightAt += 100L * stableSince / dur;
            firstRightN++;
        }
    }
    std::printf("gestures of a word of the dictionary: %ld; mean duration %ld ms\n", counted, durations / std::max<long>(1, counted));
    for (int k = 0; k < nf; k++) {
        std::printf("after %3d%% of the gesture: the first word is the one of the whole gesture in %.1f%%, the right word in %.1f%%, "
                    "the start of the right word in %.1f%%, no word in %.1f%%\n",
                    kFractions[k], pct(same[k], counted), pct(right[k], counted), pct(prefix[k], counted), pct(nothing[k], counted));
    }
    std::printf("following each gesture every %d ms: %.1f words shown per gesture, the word changes %.1f times; the last one shown before "
                "the finger lifts is the final word in %.1f%%; the final word shows and stays from %ld%% of the duration on (%.1f%% of the "
                "gestures)\n",
                step, static_cast<double>(shown) / static_cast<double>(std::max<long>(1, counted)),
                static_cast<double>(changes) / static_cast<double>(std::max<long>(1, counted)), pct(lastRight, counted),
                firstRightN ? firstRightAt / firstRightN : 0, pct(firstRightN, counted));
    std::printf("time: %.2f ms per decode (%ld decodes), worst %.1f ms\n", ms / static_cast<double>(std::max<long>(1, decodes)), decodes, worstMs);
    return 0;
}

}  // namespace

int main(int argc, char** argv) {
    std::setvbuf(stdout, nullptr, _IOLBF, 0);        // a long measurement sent to a file shows each line as it is ready
    if (argc >= 2 && std::strcmp(argv[1], "eval") == 0) return evalMain(argc, argv);
    if (argc >= 2 && std::strcmp(argv[1], "words") == 0) return wordsMain(argc, argv);
    if (argc >= 2 && std::strcmp(argv[1], "partial") == 0) return partialMain(argc, argv);
    if (argc < 4) {
        std::printf("usage: mr_gesture_test dicts_dir weights_file data_dir [corruption_rounds] [quick]\n"
                    "       mr_gesture_test eval main.dict weights_file gestures.tsv [max] [context|nocontext] [detail.tsv]\n"
                    "       mr_gesture_test words main.dict weights_file gestures.tsv [max] [frequency ...]\n"
                    "       mr_gesture_test partial main.dict weights_file gestures.tsv [max] [step_ms]\n");
        return 2;
    }
    const std::string dicts = argv[1], weights = argv[2], data = argv[3];
    const int rounds = argc > 4 ? std::atoi(argv[4]) : 100;
    const bool quick = argc > 5 && std::strcmp(argv[5], "quick") == 0;
    Tables tables;
    approxTables(tables);
    std::printf("engine contract: version %d; gesture: %d points in, %d steps out, up to %d keys, %d results\n", kEngineVersion, kGesturePoints,
                kGestureFrames, kGestureKeys, kGestureResults);
    paramsAndLayout();
    searchByHand(tables);
    weightsFile(weights, rounds);
    officialVectors(data);
    badInput(dicts, tables);
    secondDictionary(dicts, data, tables, rounds);
    samples(dicts, data, tables, rounds, quick);
    if (gFails == 0) std::printf("ALL OK (%d checks)\n", gChecks); else std::printf("%d FAILURE(S) out of %d checks\n", gFails, gChecks);
    return gFails == 0 ? 0 : 1;
}
