// Search of the words of a gesture in main.dict, from the table of the network. See mr_gesture.h.
#include "mr_gesture.h"

#include <algorithm>
#include <cmath>

namespace mr {

namespace {

constexpr float kNeg = -1e30f;          // "impossible" (log of zero)
constexpr int kFreeKey = -2;            // part of the word, but not a key of the gesture
constexpr int kNoKey = -1;
constexpr int kMaxDictBytes = 1 << 30;  // the largest position an address of the format v2 can hold (6 + 24 bits)

// log(exp(a) + exp(b))
inline float lse(float a, float b) {
    if (a <= kNeg) return b;
    if (b <= kNeg) return a;
    const float hi = a > b ? a : b, lo = a > b ? b : a;
    const float d = lo - hi;
    return d < -30.f ? hi : hi + std::log1p(std::exp(d));
}

}  // namespace

// --------------------------------------------------------------------------------------------- main.dict

bool GestureDict::attach(const uint8_t* data, int size) {
    d_ = nullptr;
    size_ = 0;
    ab_ = 3;
    root_ = 0;
    latest_ = false;
    if (data == nullptr || size <= 2) return false;
    // same reading of the header as Fuzzy::attach
    const int v = data[0];
    const int b = data[1];
    latest_ = v >= 200 && (b == 0 || b == 1 || b == 2);
    if (latest_ && b == 2) ab_ = 4;
    root_ = latest_ ? 2 : 0;
    d_ = data;
    size_ = size > kMaxDictBytes ? kMaxDictBytes : size;   // nothing can point past it, and positions stay far from INT_MAX
    return true;
}

// Same walk over a group as Fuzzy::walk: character (1 byte, or 0xFF + 2), flags with or without the address of the children,
// frequency if the entry is a word and, in the format with bigrams, the list that follows it.
bool GestureDict::readGroup(int pos, std::vector<Entry>* out) const {
    if (d_ == nullptr || pos < 0 || pos >= size_) return false;
    const int count = d_[pos++];
    for (int i = 0; i < count; i++) {
        if (pos >= size_) return false;
        Entry e;
        e.at = pos;
        int c = d_[pos++];
        if (c == 0xFF) {
            if (pos + 1 >= size_) return false;
            c = (d_[pos] << 8) | d_[pos + 1];
            pos += 2;
        }
        if (pos >= size_) return false;
        const int flags = d_[pos];
        e.ch = static_cast<char16_t>(c);
        e.terminal = (flags & 0x80) != 0;
        if ((flags & 0x40) != 0) {
            if (pos + ab_ - 1 >= size_) return false;
            int a = ((flags & 0x3F) << 8) | d_[pos + 1];
            a = (a << 8) | d_[pos + 2];
            if (ab_ == 4) a = (a << 8) | d_[pos + 3];
            e.kids = (a > 0 && a < size_) ? a : 0;
            pos += ab_;
        } else {
            pos += 1;
        }
        if (e.terminal) {
            if (pos >= size_) return false;
            e.freq = d_[pos++];
            if (latest_) {
                e.bigramAt = pos;
                if (pos < size_) {
                    if ((d_[pos] & 0x80) != 0) {
                        int guard = 0;
                        while (pos + ab_ < size_ && guard++ < 10000) {
                            pos += ab_;
                            const int more = d_[pos++] & 0x80;
                            if (more == 0) break;
                        }
                    } else {
                        pos += 1;
                    }
                }
            }
        }
        out->push_back(e);
    }
    return true;
}

bool GestureDict::find(const char16_t* w, int len, Entry* e) const {
    if (d_ == nullptr || w == nullptr || e == nullptr || len < 1 || len > kMaxWord) return false;
    int pos = root_;
    std::vector<Entry> g;
    for (int i = 0; i < len; ++i) {
        g.clear();
        readGroup(pos, &g);
        bool down = false;
        for (const Entry& x : g) {
            if (x.ch != w[i]) continue;
            if (i + 1 == len) {
                if (!x.terminal) continue;
                *e = x;
                return true;
            }
            if (x.kids == 0) continue;
            pos = x.kids;
            down = true;
            break;
        }
        if (!down) return false;
    }
    return false;
}

int GestureDict::bigrams(const Entry& e, int* addr, int* freq, int max) const {
    if (d_ == nullptr || !latest_ || !e.terminal || addr == nullptr || freq == nullptr) return 0;
    int pos = e.bigramAt;
    if (pos <= 0 || pos >= size_ || (d_[pos] & 0x80) == 0) return 0;
    int n = 0;
    while (n < max && pos + ab_ < size_) {
        int a = ((d_[pos] & 0x3F) << 8) | d_[pos + 1];
        a = (a << 8) | d_[pos + 2];
        if (ab_ == 4) a = (a << 8) | d_[pos + 3];
        pos += ab_;
        const int b = d_[pos++];
        addr[n] = a;
        freq[n] = b & 0x7F;
        ++n;
        if ((b & 0x80) == 0) break;
    }
    return n;
}

// ------------------------------------------------------------------------------------------------ search

size_t GestureSearch::heapBytes() const {
    return dn_.capacity() * sizeof(DNode) + vn_.capacity() * sizeof(VNode) + (pool_.capacity() + tmpMem_.capacity()) * sizeof(int) +
           tmpKids_.capacity() * sizeof(Kid) + (cur_.capacity() + nxt_.capacity()) * sizeof(Item) +
           group_.capacity() * sizeof(GestureDict::Entry) + hits_.capacity() * sizeof(Hit) + out_.capacity() * sizeof(GestureWord);
}

void GestureSearch::trim(size_t maxBytes, size_t keepWords) {
    if (heapBytes() <= maxBytes) return;
    ++trims_;
    std::vector<DNode>().swap(dn_);
    std::vector<VNode>().swap(vn_);
    std::vector<int>().swap(pool_);
    std::vector<int>().swap(tmpMem_);
    std::vector<Kid>().swap(tmpKids_);
    std::vector<Item>().swap(cur_);
    std::vector<Item>().swap(nxt_);
    std::vector<GestureDict::Entry>().swap(group_);
    std::vector<Hit>().swap(hits_);
    const size_t keep = std::min(out_.size(), keepWords);
    std::vector<GestureWord>(out_.begin(), out_.begin() + static_cast<std::ptrdiff_t>(keep)).swap(out_);
}

void GestureSearch::release() {
    const int trims = trims_;
    trim(0, 0);
    trims_ = trims;                      // giving everything back on request is not a trim
    std::vector<GestureWord>().swap(out_);
    nodes_ = 0;
    sequences_ = 0;
}

// The key of a dictionary character: its own key if the layout has one (the n-tilde of a Spanish keyboard), else the key of the
// letter without the accent (MrText.base, through Tables), else none; the characters Java listed as free take no key.
int GestureSearch::keyFor(int c) const {
    int k = layout_->find(t_->lowerOf(c));
    if (k >= 0) return k;
    k = layout_->find(t_->baseOf(c));
    if (k >= 0) return k;
    return layout_->isFree(c) ? kFreeKey : kNoKey;
}

// Reads the children of every prefix of a key sequence and builds the sequences that follow it.
//
// Two kinds of child take no key and join the set of the sequence itself: the free characters (' and -: part of the word, not of
// the gesture) and a letter equal to the previous one (who slides "carro" goes over the r only once). The doubled letter also
// becomes a real child sequence, for the case in which the network gives the two.
void GestureSearch::expand(int v) {
    if (vn_[v].expanded) return;
    vn_[v].expanded = true;
    vn_[v].kidBegin = static_cast<int>(vn_.size());
    vn_[v].kidCount = 0;
    const int vkey = vn_[v].key;
    tmpMem_.assign(pool_.begin() + vn_[v].memBegin, pool_.begin() + vn_[v].memBegin + vn_[v].memCount);
    tmpKids_.clear();
    for (size_t i = 0; i < tmpMem_.size(); ++i) {
        const DNode dm = dn_[static_cast<size_t>(tmpMem_[i])];
        if (dm.kidsPos < 0 || dm.raw >= kMaxWord) continue;
        if (static_cast<int>(dn_.size()) > budget_) break;
        group_.clear();
        dict_->readGroup(dm.kidsPos, &group_);            // a group cut by the end of the file still gives what came before
        for (const GestureDict::Entry& e : group_) {
            const int k = e.ch < 256 ? keyOf_[e.ch] : keyFor(e.ch);
            if (k == kNoKey) continue;                    // a letter with no key: the words below cannot come from a gesture
            DNode d;
            d.parent = tmpMem_[i];
            d.at = e.at;
            d.kidsPos = e.kids != 0 ? e.kids : -1;
            d.ch = e.ch;
            d.freq = e.freq;
            d.raw = static_cast<uint8_t>(dm.raw + 1);
            d.terminal = e.terminal;
            const int di = static_cast<int>(dn_.size());
            dn_.push_back(d);
            if (k == kFreeKey) {
                tmpMem_.push_back(di);
                continue;
            }
            if (k == vkey) tmpMem_.push_back(di);
            tmpKids_.push_back(Kid{k, di});
        }
    }
    vn_[v].memBegin = static_cast<int>(pool_.size());
    vn_[v].memCount = static_cast<int>(tmpMem_.size());
    pool_.insert(pool_.end(), tmpMem_.begin(), tmpMem_.end());
    if (tmpKids_.empty() || vn_[v].len >= kMaxWord) return;
    std::stable_sort(tmpKids_.begin(), tmpKids_.end(), [](const Kid& a, const Kid& b) { return a.key < b.key; });
    const uint8_t len = static_cast<uint8_t>(vn_[v].len + 1);
    int made = 0;
    for (size_t i = 0; i < tmpKids_.size();) {
        size_t j = i;
        VNode w;
        w.parent = v;
        w.memBegin = static_cast<int>(pool_.size());
        while (j < tmpKids_.size() && tmpKids_[j].key == tmpKids_[i].key) pool_.push_back(tmpKids_[j++].dnode);
        w.memCount = static_cast<int>(j - i);
        w.kidBegin = 0;
        w.kidCount = 0;
        w.slot = 0;
        w.stamp = 0;
        w.key = static_cast<int16_t>(tmpKids_[i].key);
        w.len = len;
        w.expanded = false;
        vn_.push_back(w);
        ++made;
        i = j;
    }
    vn_[v].kidCount = made;
}

int GestureSearch::slotFor(int v, std::vector<Item>* items) {
    VNode& n = vn_[static_cast<size_t>(v)];
    if (n.stamp != stamp_) {
        n.stamp = stamp_;
        n.slot = static_cast<int>(items->size());
        items->push_back(Item{v, kNeg, kNeg, 0.f});
    }
    return n.slot;
}

void GestureSearch::decode(const Tables& t, const GestureDict& dict, const GestureLayout& layout, const float* logEm,
                           const GestureParams& p, const int* ctxAddr, const int* ctxFreq, int nCtx) {
    out_.clear();
    nodes_ = 0;
    sequences_ = 0;
    t_ = &t;
    dict_ = &dict;
    layout_ = &layout;
    const int nKeys = layout.n;
    if (nKeys <= 0 || nKeys > kGestureKeys || logEm == nullptr || p.beam < 1 || p.nodeBudget < 1) return;
    if (ctxAddr == nullptr || ctxFreq == nullptr || nCtx < 0) nCtx = 0;
    if (nCtx > kGestureContext) nCtx = kGestureContext;
    // the bigrams of the previous word ordered by address: each word found looks its own up with a binary search
    struct Ctx {
        int addr, freq, order;
    };
    Ctx ctx[kGestureContext];
    for (int q = 0; q < nCtx; ++q) ctx[q] = Ctx{ctxAddr[q], ctxFreq[q], q};
    std::sort(ctx, ctx + nCtx, [](const Ctx& a, const Ctx& b) { return a.addr != b.addr ? a.addr < b.addr : a.order < b.order; });
    for (int c = 0; c < 256; c++) keyOf_[c] = static_cast<int16_t>(keyFor(c));
    const int cols = nKeys + 1;
    float powG[kMaxWord + 2], powP[kMaxWord + 2];
    for (int d = 0; d <= kMaxWord + 1; ++d) {
        const float dd = d < 1 ? 1.f : static_cast<float>(d);
        powG[d] = std::pow(dd, p.gamma);
        powP[d] = std::pow(dd, p.gammaPrune);
    }
    budget_ = p.nodeBudget;
    dn_.clear();
    vn_.clear();
    pool_.clear();
    DNode rd;
    rd.parent = -1;
    rd.at = 0;
    rd.kidsPos = dict.root();
    rd.ch = 0;
    rd.freq = 0;
    rd.raw = 0;
    rd.terminal = false;
    dn_.push_back(rd);
    pool_.push_back(0);
    VNode rv;
    rv.parent = -1;
    rv.memBegin = 0;
    rv.memCount = 1;
    rv.kidBegin = 0;
    rv.kidCount = 0;
    rv.slot = 0;
    rv.stamp = 0;
    rv.key = -1;
    rv.len = 0;
    rv.expanded = false;
    vn_.push_back(rv);
    stamp_ = 0;
    cur_.clear();
    cur_.push_back(Item{0, 0.f, kNeg, 0.f});
    const size_t beam = static_cast<size_t>(p.beam);

    for (int f = 0; f < kGestureFrames; ++f) {
        const float* le = logEm + static_cast<size_t>(f) * cols;
        const float blank = le[nKeys];
        ++stamp_;
        nxt_.clear();
        for (size_t i = 0; i < cur_.size(); ++i) {
            const Item it = cur_[i];
            const int key = vn_[static_cast<size_t>(it.node)].key;
            const float tot = lse(it.pb, it.pnb);
            // 1. stays on the same sequence: blank, or the last key again
            int s = slotFor(it.node, &nxt_);
            nxt_[s].pb = lse(nxt_[s].pb, tot + blank);
            if (key >= 0 && it.pnb > kNeg) nxt_[s].pnb = lse(nxt_[s].pnb, it.pnb + le[key]);
            // 2. goes on to one more key
            expand(it.node);
            const int kb = vn_[static_cast<size_t>(it.node)].kidBegin, kn = vn_[static_cast<size_t>(it.node)].kidCount;
            for (int j = 0; j < kn; ++j) {
                const int w = kb + j;
                const int k = vn_[static_cast<size_t>(w)].key;
                const float m = k == key ? it.pb : tot;   // the same key as the previous one only after a blank (CTC)
                if (m <= kNeg) continue;
                s = slotFor(w, &nxt_);
                nxt_[s].pnb = lse(nxt_[s].pnb, m + le[k]);
            }
        }
        // 3. pruning. The ties are broken by the number of the sequence and the survivors go back to the order of creation, so
        // the result does not depend on how the C++ library of each system implements nth_element.
        if (nxt_.size() > beam) {
            for (Item& it : nxt_) {
                const int d = vn_[static_cast<size_t>(it.node)].len;
                it.score = lse(it.pb, it.pnb) / powP[d] + p.betaPrune * static_cast<float>(d);
            }
            std::nth_element(nxt_.begin(), nxt_.begin() + static_cast<std::ptrdiff_t>(beam), nxt_.end(),
                             [](const Item& a, const Item& b) { return a.score != b.score ? a.score > b.score : a.node < b.node; });
            nxt_.resize(beam);
            std::sort(nxt_.begin(), nxt_.end(), [](const Item& a, const Item& b) { return a.node < b.node; });
        }
        cur_.swap(nxt_);
    }

    // Words: the prefixes that are words in each sequence alive at the end. The same word can be in two sequences ("off" in
    // o-f and in o-f-f): the two probabilities are added and the number of keys of the more likely one counts.
    hits_.clear();
    for (size_t i = 0; i < cur_.size(); ++i) {
        const Item it = cur_[i];
        expand(it.node);
        const VNode n = vn_[static_cast<size_t>(it.node)];
        if (n.len < p.minKeys) continue;
        const float tot = lse(it.pb, it.pnb);
        for (int k = 0; k < n.memCount; ++k) {
            const int m = pool_[static_cast<size_t>(n.memBegin + k)];
            if (dn_[static_cast<size_t>(m)].terminal) hits_.push_back(Hit{dn_[static_cast<size_t>(m)].at, m, n.len, tot});
        }
    }
    std::sort(hits_.begin(), hits_.end(), [](const Hit& a, const Hit& b) {
        if (a.at != b.at) return a.at < b.at;
        if (a.logp != b.logp) return a.logp > b.logp;
        if (a.len != b.len) return a.len > b.len;
        return a.dnode < b.dnode;
    });
    for (size_t i = 0; i < hits_.size();) {
        size_t j = i + 1;
        float logp = hits_[i].logp;
        while (j < hits_.size() && hits_[j].at == hits_[i].at) logp = lse(logp, hits_[j++].logp);
        const DNode& d = dn_[static_cast<size_t>(hits_[i].dnode)];
        GestureWord c;
        c.logp = logp;
        c.keys = hits_[i].len;
        c.freq = d.freq;
        c.at = d.at;
        const Ctx* hit = std::lower_bound(ctx, ctx + nCtx, d.at, [](const Ctx& a, int at) { return a.addr < at; });
        if (hit != ctx + nCtx && hit->addr == d.at) c.bigram = hit->freq;   // an address listed twice: the first one counts
        c.score = c.logp / powG[c.keys] + p.lambdaF * static_cast<float>(c.freq) + p.beta * static_cast<float>(c.keys) +
                  p.ctx * static_cast<float>(c.bigram);
        char16_t rev[kGestureChars];
        int len = 0;
        for (int q = hits_[i].dnode; q > 0 && len < kGestureChars; q = dn_[static_cast<size_t>(q)].parent) {
            rev[len++] = dn_[static_cast<size_t>(q)].ch;
        }
        c.len = len;
        for (int q = 0; q < len; ++q) c.word[q] = rev[len - 1 - q];
        out_.push_back(c);
        i = j;
    }
    // Best first. Two words of the same key sequence with the same frequency tie exactly ("governors" and "governor's"): the
    // shorter one, the plainer reading of the trace, goes first; then the dictionary address, so that the order never depends
    // on the sort of the C++ library.
    std::sort(out_.begin(), out_.end(), [](const GestureWord& a, const GestureWord& b) {
        if (a.score != b.score) return a.score > b.score;
        if (a.len != b.len) return a.len < b.len;
        return a.at < b.at;
    });
    nodes_ = static_cast<int>(dn_.size());
    sequences_ = static_cast<int>(vn_.size());
}

// ------------------------------------------------------------------------------------------------ Gesture

bool Gesture::open(const char* path) {
    forget();
    return net_.open(path);
}

bool Gesture::openBytes(const uint8_t* data, size_t size) {
    forget();
    return net_.openBytes(data, size);
}

void Gesture::close() {
    net_.close();
    forget();
    search_.release();
    std::vector<float>().swap(em_);
    std::vector<float>().swap(px_);
    std::vector<float>().swap(py_);
    std::vector<GestureWord>().swap(both_);
}

bool Gesture::setLayout(const char16_t* keys, const float* xy, int nKeys, const char16_t* freeChars, int nFreeChars) {
    forget();                // the table has one column per key of the layout it was made with
    return layout_.set(keys, xy, nKeys, freeChars, nFreeChars);
}

size_t Gesture::heapBytes() const {
    return net_.heapBytes() + search_.heapBytes() + layout_.basis.capacity() * sizeof(float) +
           (em_.capacity() + px_.capacity() + py_.capacity()) * sizeof(float) + both_.capacity() * sizeof(GestureWord);
}

int Gesture::decode(const Tables& t, const uint8_t* dict, int dictSize, const float* x, const float* y, const int32_t* tMs, int n,
                    const char16_t* const* prev, const int* prevLen, int nPrev, const GestureParams& p) {
    forget();
    if (!net_.isOpen() || layout_.n < 1 || x == nullptr || y == nullptr || tMs == nullptr || n < 1 || n > kGestureMaxTouches) return -1;
    if (t.lower.size() < 65536) return -1;                 // tables not handed over (nInit)
    if (p.beam < 1 || p.minKeys < 1 || p.nodeBudget < 1) return -1;
    px_.resize(static_cast<size_t>(n));
    py_.resize(static_cast<size_t>(n));
    for (int i = 0; i < n; i++) {
        if (!std::isfinite(x[i]) || !std::isfinite(y[i])) return -1;
        // far outside the keyboard nothing changes any more; the limit only keeps the arithmetic of the network in range
        px_[static_cast<size_t>(i)] = x[i] < -8.f ? -8.f : (x[i] > 8.f ? 8.f : x[i]);
        py_[static_cast<size_t>(i)] = y[i] < -8.f ? -8.f : (y[i] > 8.f ? 8.f : y[i]);
    }
    float feats[2 * kGesturePoints];
    if (!gestureResample(px_.data(), py_.data(), tMs, n, feats)) return -1;
    em_.resize(static_cast<size_t>(kGestureFrames) * static_cast<size_t>(layout_.n + 1));
    net_.forward(feats, layout_, em_.data());
    table_ = true;
    return search(t, dict, dictSize, prev, prevLen, nPrev, p);
}

namespace {

// The same word but for upper and lower case, with the table of the app.
bool sameWord(const Tables& t, const GestureWord& a, const GestureWord& b) {
    if (a.len != b.len) return false;
    for (int i = 0; i < a.len; i++) {
        if (t.lowerOf(a.word[i]) != t.lowerOf(b.word[i])) return false;
    }
    return true;
}

}  // namespace

int Gesture::more(const Tables& t, const uint8_t* dict, int dictSize, const char16_t* const* prev, const int* prevLen, int nPrev,
                  const GestureParams& p) {
    if (!table_ || !net_.isOpen() || layout_.n < 1) return -1;
    if (em_.size() != static_cast<size_t>(kGestureFrames) * static_cast<size_t>(layout_.n + 1)) return -1;
    if (t.lower.size() < 65536) return -1;                 // tables not handed over (nInit)
    if (p.beam < 1 || p.minKeys < 1 || p.nodeBudget < 1) return -1;
    if (!merged_) {                                        // the results of decode(), which the search below writes over
        const std::vector<GestureWord>& first = search_.all();
        both_.assign(first.begin(), first.begin() + count_);
        merged_ = true;
    }
    nodesBefore_ += search_.nodes();
    const int found = search(t, dict, dictSize, prev, prevLen, nPrev, p);
    const std::vector<GestureWord>& added = search_.all();
    bool changed = false;
    for (int i = 0; i < found; i++) {
        GestureWord w = added[static_cast<size_t>(i)];
        w.source = 1;
        size_t same = both_.size();          // the best spelling of this word already there
        for (size_t j = 0; j < both_.size() && same == both_.size(); j++) {
            if (sameWord(t, both_[j], w)) same = j;
        }
        if (same == both_.size()) {
            both_.push_back(w);
            changed = true;
        } else if (w.score > both_[same].score) {
            both_[same] = w;
            // the first dictionary may have had the word in two spellings ("the" and "The"): the other one goes too
            both_.erase(std::remove_if(both_.begin() + static_cast<std::ptrdiff_t>(same) + 1, both_.end(),
                                       [&](const GestureWord& x) { return sameWord(t, x, w); }),
                        both_.end());
            changed = true;
        }
    }
    if (changed) {
        // best first; with the same score the shorter word first, as in the search, and then the one that was there before
        std::stable_sort(both_.begin(), both_.end(), [](const GestureWord& a, const GestureWord& b) {
            return a.score != b.score ? a.score > b.score : a.len < b.len;
        });
        if (both_.size() > static_cast<size_t>(kGestureResults)) both_.resize(static_cast<size_t>(kGestureResults));
    }
    count_ = static_cast<int>(both_.size());
    return count_;
}

// The table in em_ against one dictionary: the words are left in search_, and count_ says how many of them are results.
int Gesture::search(const Tables& t, const uint8_t* dict, int dictSize, const char16_t* const* prev, const int* prevLen, int nPrev,
                    const GestureParams& p) {
    count_ = 0;
    nCtx_ = 0;
    search_.clear();
    GestureDict d;
    if (!d.attach(dict, dictSize)) return 0;               // no dictionary: no words
    int ctxAddr[kGestureContext], ctxFreq[kGestureContext];
    if (prev != nullptr && prevLen != nullptr) {
        for (int i = 0; i < nPrev && i < kGestureSpellings; i++) {
            GestureDict::Entry e;
            if (prev[i] == nullptr || !d.find(prev[i], prevLen[i], &e)) continue;
            nCtx_ = d.bigrams(e, ctxAddr, ctxFreq, kGestureContext);
            break;
        }
    }
    search_.decode(t, d, layout_, em_.data(), p, ctxAddr, ctxFreq, nCtx_);
    search_.trim(kGestureKeepBytes, kGestureKeepWords);
    count_ = static_cast<int>(std::min<size_t>(search_.all().size(), static_cast<size_t>(kGestureResults)));
    return count_;
}

}  // namespace mr
