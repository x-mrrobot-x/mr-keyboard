// Port of MrTrigram.java (lookup) and UTF-8 conversions. File formats in docs/tools/make_trigrams.py and
// docs/tools/convert_trigrams.py (app).
#include "mr_engine.h"

#include <algorithm>
#include <cstdio>
#include <cstring>

#include <fcntl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>

namespace mr {

namespace {

constexpr size_t kMaxFile = 256u << 20;   // 256 MB cap: positions are 32-bit and a real trigrams.bin is only a few MB

// madvise over [from, to) of a mapping of len bytes (the start is rounded down to a page). Failures do not matter: it is only a hint.
void advise(void* map, size_t len, size_t from, size_t to, int advice) {
    if (map == nullptr || from >= to || to > len) return;
    long pg = sysconf(_SC_PAGESIZE);
    if (pg <= 0) return;
    size_t a = from & ~(static_cast<size_t>(pg) - 1);
    madvise(static_cast<char*>(map) + a, to - a, advice);
}

}  // namespace

// ---------------------------------------------------------------------------------------------- file

void TriStore::release() {
    if (map_ != nullptr) munmap(map_, mapLen_);
    map_ = nullptr;
    mapLen_ = 0;
    base_ = nullptr;
    size_ = 0;
    heap_.clear();
    heap_.shrink_to_fit();
    word_.clear();
    word_.shrink_to_fit();
    ctx_.clear();
    ctx_.shrink_to_fit();
    fmt_ = 0;
    n_ = m_ = 0;
    offAt_ = csrAt_ = recAt_ = blobAt_ = 0;
}

bool TriStore::open(const char* path) {
    release();
    if (path == nullptr) return false;
    int fd = ::open(path, O_RDONLY | O_CLOEXEC);
    if (fd < 0) return false;
    struct stat st;
    if (fstat(fd, &st) != 0 || !S_ISREG(st.st_mode) || st.st_size < 12 || static_cast<unsigned long long>(st.st_size) > kMaxFile) {
        ::close(fd);
        return false;
    }
    const size_t size = static_cast<size_t>(st.st_size);
    void* p = mmap(nullptr, size, PROT_READ, MAP_PRIVATE, fd, 0);
    if (p != MAP_FAILED) {
        ::close(fd);   // the mapping keeps the file alive
        map_ = p;
        mapLen_ = size;
        base_ = static_cast<const uint8_t*>(p);
        size_ = size;
    } else {
        // no mmap (rare): reads the file into the heap and works the same way
        heap_.resize(size);
        size_t got = 0;
        while (got < size) {
            ssize_t r = ::read(fd, heap_.data() + got, size - got);
            if (r <= 0) break;
            got += static_cast<size_t>(r);
        }
        ::close(fd);
        if (got != size) {
            release();
            return false;
        }
        base_ = heap_.data();
        size_ = size;
    }
    if (!load()) {
        release();
        return false;
    }
    return true;
}

bool TriStore::openBytes(const uint8_t* data, size_t size) {
    release();
    if (data == nullptr || size < 12 || size > kMaxFile) return false;
    heap_.assign(data, data + size);
    base_ = heap_.data();
    size_ = size;
    if (!load()) {
        release();
        return false;
    }
    return true;
}

bool TriStore::load() {
    if (std::memcmp(base_, "MRT1", 4) == 0) {
        fmt_ = 1;
        return parse1();
    }
    if (std::memcmp(base_, "MRT2", 4) == 0) {
        fmt_ = 2;
        return parse2();
    }
    return false;
}

// MRT1. Checks the whole file once and builds the indexes. After that find() does not need to check anything:
// every position, length and id has already been validated here.
bool TriStore::parse1() {
    const size_t size = size_;
    size_t pos = 4;
    uint32_t n = be32(pos);
    pos += 4;
    if (n > size) return false;                 // each word takes at least 1 byte
    word_.reserve(n);
    const uint8_t* prevWord = nullptr;
    int prevLen = 0;
    for (uint32_t i = 0; i < n; i++) {
        if (pos >= size) return false;
        int len = base_[pos];
        if (pos + 1 + static_cast<size_t>(len) > size) return false;
        const uint8_t* w = base_ + pos + 1;
        if (prevWord != nullptr) {
            // binary search needs strictly increasing order (bytes, which is the code order)
            int cmp = std::memcmp(prevWord, w, static_cast<size_t>(std::min(prevLen, len)));
            if (cmp > 0 || (cmp == 0 && prevLen >= len)) return false;
        }
        word_.push_back(static_cast<uint32_t>(pos));
        prevWord = w;
        prevLen = len;
        pos += 1 + static_cast<size_t>(len);
    }
    if (pos + 4 > size) return false;
    uint32_t m = be32(pos);
    pos += 4;
    if (m > size / 7) return false;             // each context takes at least 7 bytes
    ctx_.reserve(m);
    uint64_t prevKey = 0;
    for (uint32_t i = 0; i < m; i++) {
        if (pos + 7 > size) return false;
        uint32_t a = be24(pos), b = be24(pos + 3);
        int k = base_[pos + 6];
        if (a >= n || b >= n) return false;
        if (pos + 7 + static_cast<size_t>(k) * 4 > size) return false;
        uint64_t key = (static_cast<uint64_t>(a) << 32) | b;
        if (i > 0 && key <= prevKey) return false;
        prevKey = key;
        for (int j = 0; j < k; j++) {
            if (be24(pos + 7 + static_cast<size_t>(j) * 4) >= n) return false;
        }
        ctx_.push_back(static_cast<uint32_t>(pos));
        pos += 7 + static_cast<size_t>(k) * 4;
    }
    return pos <= size;
}

// MRT2:  "MRT2" | u32 n | u32 m | (n+1) x u32 word offsets | (n+1) x u32 first record of each first word |
//        m x record (u16 b, 3 x (u16 id, u8 score); id 0xFFFF = empty slot, always at the end) | n x (u8 length + UTF-8).
// Here only what is O(words) is checked; each record is checked when it is read (see find2) or by verifyAll().
bool TriStore::parse2() {
    if (size_ < 12) return false;
    n_ = be32(4);
    m_ = be32(8);
    if (n_ > kMaxWords2) return false;
    const uint64_t tables = 12 + 8ull * (static_cast<uint64_t>(n_) + 1);
    const uint64_t records = static_cast<uint64_t>(m_) * kRecord2;
    if (tables + records > size_) return false;
    offAt_ = 12;
    csrAt_ = offAt_ + 4 * (static_cast<size_t>(n_) + 1);
    recAt_ = static_cast<size_t>(tables);
    blobAt_ = static_cast<size_t>(tables + records);
    const size_t blobLen = size_ - blobAt_;
    // word section: contiguous, starts at 0, ends exactly at the end of the file, strictly increasing in byte order
    if (be32(offAt_) != 0 || be32(offAt_ + 4 * static_cast<size_t>(n_)) != blobLen) return false;
    const uint8_t* prev = nullptr;
    int prevLen = 0;
    for (uint32_t i = 0; i < n_; i++) {
        const uint32_t off = be32(offAt_ + 4 * static_cast<size_t>(i));
        const uint32_t next = be32(offAt_ + 4 * (static_cast<size_t>(i) + 1));
        if (off >= blobLen) return false;
        const int len = base_[blobAt_ + off];
        if (static_cast<uint64_t>(off) + 1 + len != next || next > blobLen) return false;
        const uint8_t* w = base_ + blobAt_ + off + 1;
        if (prev != nullptr) {
            int cmp = std::memcmp(prev, w, static_cast<size_t>(std::min(prevLen, len)));
            if (cmp > 0 || (cmp == 0 && prevLen >= len)) return false;
        }
        prev = w;
        prevLen = len;
    }
    // row table: starts at 0, ends at m, never goes back
    if (be32(csrAt_) != 0 || be32(csrAt_ + 4 * static_cast<size_t>(n_)) != m_) return false;
    uint32_t last = 0;
    for (uint32_t i = 1; i <= n_; i++) {
        const uint32_t v = be32(csrAt_ + 4 * static_cast<size_t>(i));
        if (v < last) return false;
        last = v;
    }
    // the records are searched at random: no read-ahead of the big part
    advise(map_, mapLen_, recAt_, blobAt_, MADV_RANDOM);
    return true;
}

bool TriStore::verifyAll() const {
    if (base_ == nullptr) return false;
    if (fmt_ != 2) return true;
    for (uint32_t a = 0; a < n_; a++) {
        const uint32_t lo = be32(csrAt_ + 4 * static_cast<size_t>(a));
        const uint32_t hi = be32(csrAt_ + 4 * (static_cast<size_t>(a) + 1));
        if (lo > hi || hi > m_) return false;
        for (uint32_t r = lo; r < hi; r++) {
            const size_t at = recAt_ + static_cast<size_t>(r) * kRecord2;
            const uint32_t b = be16(at);
            if (b >= n_) return false;
            if (r > lo && b <= be16(at - kRecord2)) return false;
            bool empty = false;
            for (int j = 0; j < kSlots2; j++) {
                const uint32_t id = be16(at + 2 + 3 * static_cast<size_t>(j));
                if (id == 0xFFFF) { empty = true; continue; }
                if (empty || id >= n_) return false;
            }
        }
    }
    return true;
}

// --------------------------------------------------------------------------------------------- query

// Position (of the bytes, after the length) and length of word id. false if the id or the file do not match.
bool TriStore::wordAt(uint32_t id, size_t* at, int* len) const {
    if (base_ == nullptr) return false;
    if (fmt_ == 1) {
        if (id >= word_.size()) return false;
        const size_t p = word_[id];
        *len = base_[p];
        *at = p + 1;
        return true;
    }
    if (id >= n_) return false;
    const size_t off = be32(offAt_ + 4 * static_cast<size_t>(id));
    const size_t p = blobAt_ + off;
    if (p >= size_) return false;
    const int l = base_[p];
    if (p + 1 + static_cast<size_t>(l) > size_) return false;
    *len = l;
    *at = p + 1;
    return true;
}

bool TriStore::wordBytes(uint32_t id, const uint8_t** p, int* len) const {
    size_t at;
    int l;
    if (!wordAt(id, &at, &l)) return false;
    *len = l;
    *p = base_ + at;
    return true;
}

int TriStore::wordId(const std::string& w) const {
    if (w.size() > 255) return -1;
    size_t lo = 0, hi = vocabulary();
    while (lo < hi) {
        size_t mid = lo + (hi - lo) / 2;
        size_t at;
        int len;
        if (!wordAt(static_cast<uint32_t>(mid), &at, &len)) return -1;
        int cmp = std::memcmp(base_ + at, w.data(), std::min(static_cast<size_t>(len), w.size()));
        if (cmp == 0) cmp = len < static_cast<int>(w.size()) ? -1 : len > static_cast<int>(w.size()) ? 1 : 0;
        if (cmp == 0) return static_cast<int>(mid);
        if (cmp < 0) lo = mid + 1;
        else hi = mid;
    }
    return -1;
}

int TriStore::find1(int ia, int ib, int max, Hit* out, bool* found) const {
    const uint64_t want = (static_cast<uint64_t>(ia) << 32) | static_cast<uint32_t>(ib);
    size_t lo = 0, hi = ctx_.size();
    while (lo < hi) {
        size_t mid = lo + (hi - lo) / 2;
        size_t at = ctx_[mid];
        uint64_t key = (static_cast<uint64_t>(be24(at)) << 32) | be24(at + 3);
        if (key == want) {
            *found = true;
            int k = base_[at + 6];
            int n = 0;
            for (int j = 0; j < k && n < max; j++) {
                size_t q = at + 7 + static_cast<size_t>(j) * 4;
                out[n].id = be24(q);
                out[n].score = base_[q + 3];
                n++;
            }
            return n;
        }
        if (key < want) lo = mid + 1;
        else hi = mid;
    }
    return 0;
}

int TriStore::find2(int ia, int ib, int max, Hit* out, bool* found) const {
    if (static_cast<uint32_t>(ia) >= n_) return 0;
    uint32_t lo = be32(csrAt_ + 4 * static_cast<size_t>(ia));
    uint32_t hi = be32(csrAt_ + 4 * (static_cast<size_t>(ia) + 1));
    if (lo > hi || hi > m_) return 0;   // the row table was checked at open; this is only a guard
    while (lo < hi) {
        const uint32_t mid = lo + (hi - lo) / 2;
        const size_t at = recAt_ + static_cast<size_t>(mid) * kRecord2;
        const uint32_t b = be16(at);
        if (b == static_cast<uint32_t>(ib)) {
            *found = true;
            int n = 0;
            for (int j = 0; j < kSlots2 && n < max; j++) {
                const uint32_t id = be16(at + 2 + 3 * static_cast<size_t>(j));
                if (id == 0xFFFF || id >= n_) break;   // empty slot (or a corrupt record: it stops there)
                out[n].id = id;
                out[n].score = base_[at + 4 + 3 * static_cast<size_t>(j)];
                n++;
            }
            return n;
        }
        if (b < static_cast<uint32_t>(ib)) lo = mid + 1;
        else hi = mid;
    }
    return 0;
}

int TriStore::find(const std::string* a1, const std::string* a2, const std::string* b1, const std::string* b2,
                   int max, Hit* out) const {
    if (base_ == nullptr || max <= 0 || out == nullptr) return 0;
    const std::string* as[2] = {a1, a2};
    const std::string* bs[2] = {b1, b2};
    // the id of each spelling of w2 is looked up once; a repeated spelling is not tried again (it would give the same miss)
    int ibs[2] = {-1, -1};
    for (int j = 0; j < 2; j++) {
        if (bs[j] == nullptr) continue;
        if (j == 1 && bs[0] != nullptr && *bs[0] == *bs[1]) continue;
        ibs[j] = wordId(*bs[j]);
    }
    for (int i = 0; i < 2; i++) {
        const std::string* a = as[i];
        if (a == nullptr) continue;
        if (i == 1 && as[0] != nullptr && *as[0] == *as[1]) continue;
        int ia = wordId(*a);
        if (ia < 0) continue;
        for (int j = 0; j < 2; j++) {
            if (ibs[j] < 0) continue;
            bool found = false;
            int n = fmt_ == 2 ? find2(ia, ibs[j], max, out, &found) : find1(ia, ibs[j], max, out, &found);
            if (found) return n;
        }
    }
    return 0;
}

// ---------------------------------------------------------------------------------------------- UTF-8

std::string toUtf8(const char16_t* s, int len) {
    std::string out;
    out.reserve(static_cast<size_t>(len) * 3);
    for (int i = 0; i < len; i++) {
        uint32_t c = s[i];
        if (c >= 0xD800 && c <= 0xDBFF && i + 1 < len && s[i + 1] >= 0xDC00 && s[i + 1] <= 0xDFFF) {
            c = 0x10000 + ((c - 0xD800) << 10) + (s[i + 1] - 0xDC00);
            i++;
        }
        if (c < 0x80) {
            out.push_back(static_cast<char>(c));
        } else if (c < 0x800) {
            out.push_back(static_cast<char>(0xC0 | (c >> 6)));
            out.push_back(static_cast<char>(0x80 | (c & 0x3F)));
        } else if (c < 0x10000) {
            out.push_back(static_cast<char>(0xE0 | (c >> 12)));
            out.push_back(static_cast<char>(0x80 | ((c >> 6) & 0x3F)));
            out.push_back(static_cast<char>(0x80 | (c & 0x3F)));
        } else {
            out.push_back(static_cast<char>(0xF0 | (c >> 18)));
            out.push_back(static_cast<char>(0x80 | ((c >> 12) & 0x3F)));
            out.push_back(static_cast<char>(0x80 | ((c >> 6) & 0x3F)));
            out.push_back(static_cast<char>(0x80 | (c & 0x3F)));
        }
    }
    return out;
}

int fromUtf8(const uint8_t* s, int len, char16_t* out, int maxOut) {
    int o = 0;
    int i = 0;
    while (i < len && o < maxOut) {
        uint32_t c = s[i];
        int extra = 0;
        uint32_t min = 0;
        if (c < 0x80) {
            extra = 0;
        } else if (c >= 0xC2 && c <= 0xDF) {
            extra = 1; c &= 0x1F; min = 0x80;
        } else if (c >= 0xE0 && c <= 0xEF) {
            extra = 2; c &= 0x0F; min = 0x800;
        } else if (c >= 0xF0 && c <= 0xF4) {
            extra = 3; c &= 0x07; min = 0x10000;
        } else {
            c = 0xFFFD;
            i++;
            out[o++] = static_cast<char16_t>(c);
            continue;
        }
        if (extra > 0) {
            bool ok = (i + extra) <= (len - 1);   // false = sequence cut off at the end
            if (ok) {
                for (int k = 1; k <= extra; k++) {
                    uint8_t cc = s[i + k];
                    if ((cc & 0xC0) != 0x80) { ok = false; break; }
                    c = (c << 6) | (cc & 0x3F);
                }
            }
            if (!ok || c < min || c > 0x10FFFF || (c >= 0xD800 && c <= 0xDFFF)) {
                out[o++] = 0xFFFD;
                i++;
                continue;
            }
        }
        i += extra + 1;
        if (c >= 0x10000) {
            if (o + 2 > maxOut) break;
            c -= 0x10000;
            out[o++] = static_cast<char16_t>(0xD800 + (c >> 10));
            out[o++] = static_cast<char16_t>(0xDC00 + (c & 0x3FF));
        } else {
            out[o++] = static_cast<char16_t>(c);
        }
    }
    return o;
}

}  // namespace mr
