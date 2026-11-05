// Port of MrTrigram.java (lookup) and UTF-8 conversions. File format in docs/tools/make_trigrams.py (app).
#include "mr_engine.h"

#include <algorithm>
#include <cstdio>
#include <cstring>

namespace mr {

// ---------------------------------------------------------------------------------------------- file

bool TriStore::open(const char* path) {
    data_.clear();
    word_.clear();
    ctx_.clear();
    if (path == nullptr) return false;
    FILE* f = std::fopen(path, "rb");
    if (f == nullptr) return false;
    bool ok = false;
    if (std::fseek(f, 0, SEEK_END) == 0) {
        long size = std::ftell(f);
        // 256 MB cap: the indexes use 32-bit positions and a real trigrams.bin is only a few MB
        if (size >= 12 && size <= (256L << 20) && std::fseek(f, 0, SEEK_SET) == 0) {
            data_.resize(static_cast<size_t>(size));
            ok = std::fread(data_.data(), 1, data_.size(), f) == data_.size();
        }
    }
    std::fclose(f);
    if (!ok || !parse()) {
        data_.clear();
        word_.clear();
        ctx_.clear();
        return false;
    }
    return true;
}

bool TriStore::openBytes(const uint8_t* data, size_t size) {
    data_.clear();
    word_.clear();
    ctx_.clear();
    if (data == nullptr || size < 12 || size > (256u << 20)) return false;
    data_.assign(data, data + size);
    if (!parse()) {
        data_.clear();
        word_.clear();
        ctx_.clear();
        return false;
    }
    return true;
}

// Checks the whole file once and builds the indexes. After that find() does not need to check anything:
// every position, length and id has already been validated here.
bool TriStore::parse() {
    const size_t size = data_.size();
    if (size < 12 || std::memcmp(data_.data(), "MRT1", 4) != 0) return false;
    auto be32 = [&](size_t p) -> uint32_t {
        return (uint32_t(data_[p]) << 24) | (uint32_t(data_[p + 1]) << 16) | (uint32_t(data_[p + 2]) << 8) | data_[p + 3];
    };
    size_t pos = 4;
    uint32_t n = be32(pos);
    pos += 4;
    if (n > size) return false;                 // each word takes at least 1 byte
    word_.reserve(n);
    const uint8_t* prevWord = nullptr;
    int prevLen = 0;
    for (uint32_t i = 0; i < n; i++) {
        if (pos >= size) return false;
        int len = data_[pos];
        if (pos + 1 + static_cast<size_t>(len) > size) return false;
        const uint8_t* w = data_.data() + pos + 1;
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
        int k = data_[pos + 6];
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

// --------------------------------------------------------------------------------------------- query

bool TriStore::wordBytes(uint32_t id, const uint8_t** p, int* len) const {
    if (id >= word_.size()) return false;
    size_t at = word_[id];
    *len = data_[at];
    *p = data_.data() + at + 1;
    return true;
}

int TriStore::wordId(const std::string& w) const {
    if (w.size() > 255) return -1;
    size_t lo = 0, hi = word_.size();
    while (lo < hi) {
        size_t mid = lo + (hi - lo) / 2;
        size_t at = word_[mid];
        int len = data_[at];
        const uint8_t* cand = data_.data() + at + 1;
        int cmp = std::memcmp(cand, w.data(), std::min(static_cast<size_t>(len), w.size()));
        if (cmp == 0) cmp = len < static_cast<int>(w.size()) ? -1 : len > static_cast<int>(w.size()) ? 1 : 0;
        if (cmp == 0) return static_cast<int>(mid);
        if (cmp < 0) lo = mid + 1;
        else hi = mid;
    }
    return -1;
}

int TriStore::find(const std::string* a1, const std::string* a2, const std::string* b1, const std::string* b2,
                   int max, Hit* out) const {
    if (data_.empty() || max <= 0 || out == nullptr) return 0;
    const std::string* as[2] = {a1, a2};
    const std::string* bs[2] = {b1, b2};
    for (const std::string* a : as) {
        if (a == nullptr) continue;
        int ia = wordId(*a);
        if (ia < 0) continue;
        for (const std::string* b : bs) {
            if (b == nullptr) continue;
            int ib = wordId(*b);
            if (ib < 0) continue;
            const uint64_t want = (static_cast<uint64_t>(ia) << 32) | static_cast<uint32_t>(ib);
            size_t lo = 0, hi = ctx_.size();
            while (lo < hi) {
                size_t mid = lo + (hi - lo) / 2;
                size_t at = ctx_[mid];
                uint64_t key = (static_cast<uint64_t>(be24(at)) << 32) | be24(at + 3);
                if (key == want) {
                    int k = data_[at + 6];
                    int n = 0;
                    for (int j = 0; j < k && n < max; j++) {
                        size_t q = at + 7 + static_cast<size_t>(j) * 4;
                        out[n].id = be24(q);
                        out[n].score = data_[q + 3];
                        n++;
                    }
                    return n;
                }
                if (key < want) lo = mid + 1;
                else hi = mid;
            }
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
