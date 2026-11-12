// The encoder of "FUTO Swipe" (honorable_sturgeon) run by this project's own code. See mr_gesture.h.
//
// The architecture was read from the exported graph and is checked number by number against the official runtime
// (test/mr_gesture_test.cpp with test/data/gesture_vectors.bin). Summary:
//   8 features per point (x, y, velocity, acceleration, speed, curvature) from 7-point filters
//   -> conv 8->128 (k=7) + hardswish
//   -> 5 blocks [depthwise conv k=7 dilated (1,2,3,5,8) -> 1x1 128->512 -> gate sigmoid(a)*b -> GRN -> 1x1 256->128
//                -> squeeze-excitation -> residual sum]
//   -> conv 128->256 (k=2, stride 2): 64 points become 32 steps
//   -> lambda (1 value per step: "is there a letter here?") and 64 cosine coefficients per step
//   -> value per key = coefficients x cosine basis at the centre of the key -> log-softmax.
//
// Weights file (little-endian; docs/tools/gesture/extract_weights.py writes it from the file FUTO publishes):
//   8 bytes "MRSWENC1"; u32 number of tensors; per tensor: u8 name length, name (ASCII), u8 number of dimensions,
//   u32 x dimensions, f32 x product(dimensions).
//
// Speed: nearly all the time goes in the 1x1 convolutions (gemmRows). They are plain loops over rows of 64 or 32 floats that
// the compiler turns into SIMD (NEON, SSE); MR_SIMD asks for it where the default would refuse (32-bit ARM) and CMakeLists.txt
// adds -ftree-vectorize to this file for GCC. No -ffast-math: only loops whose result does not depend on the order are marked.
#include "mr_gesture.h"

#include <cmath>
#include <cstring>
#include <limits>
#include <string>

#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>

#if !defined(__BYTE_ORDER__) || __BYTE_ORDER__ != __ORDER_LITTLE_ENDIAN__
#error "the weights file is little-endian and is copied as it is"
#endif

#if defined(__clang__)
#define MR_SIMD _Pragma("clang loop vectorize(enable)")
#elif defined(__GNUC__)
#define MR_SIMD _Pragma("GCC ivdep")
#else
#define MR_SIMD
#endif

namespace mr {

namespace {

static_assert(std::numeric_limits<float>::is_iec559 && sizeof(float) == 4, "float must be IEEE 754 single");

constexpr int L = kGesturePoints;
constexpr int F = kGestureFrames;
constexpr float kPi = 3.1415927f;
constexpr float kTwoPi = 6.2831855f;
const int kDil[5] = {1, 2, 3, 5, 8};

// rows of work memory: features 8, h 128, u 128, v 512, g 256, r 128 (of L); hs 256, z 256, co 64, lg kGestureKeys (of F)
constexpr size_t kWork = static_cast<size_t>(8 + 128 + 128 + 512 + 256 + 128) * L +
                         static_cast<size_t>(256 + 256 + kGestureCoeff + kGestureKeys) * F;

inline uint32_t u32le(const uint8_t* p) {
    return static_cast<uint32_t>(p[0]) | (static_cast<uint32_t>(p[1]) << 8) | (static_cast<uint32_t>(p[2]) << 16) |
           (static_cast<uint32_t>(p[3]) << 24);
}

inline float sigmoidf(float v) {
    if (v >= 0.f) return 1.f / (1.f + std::exp(-v));
    float e = std::exp(v);
    return e / (1.f + e);
}

// out[o][0..N) = bias[o] + sum over i of W[o][i] * in[i][0..N). The rows of in and out have N elements.
template <int N>
void gemmRows(const float* W, const float* bias, int O, int I, const float* in, float* out) {
    for (int o = 0; o < O; ++o) {
        float* __restrict y = out + static_cast<size_t>(o) * N;
        const float b = bias ? bias[o] : 0.f;
        for (int t = 0; t < N; ++t) y[t] = b;
        const float* w = W + static_cast<size_t>(o) * I;
        int i = 0;
        for (; i + 4 <= I; i += 4) {
            const float w0 = w[i], w1 = w[i + 1], w2 = w[i + 2], w3 = w[i + 3];
            const float* __restrict a0 = in + static_cast<size_t>(i) * N;
            const float* __restrict a1 = a0 + N;
            const float* __restrict a2 = a1 + N;
            const float* __restrict a3 = a2 + N;
            MR_SIMD
            for (int t = 0; t < N; ++t) y[t] += w0 * a0[t] + w1 * a1[t] + w2 * a2[t] + w3 * a3[t];
        }
        for (; i < I; ++i) {
            const float w0 = w[i];
            const float* __restrict a0 = in + static_cast<size_t>(i) * N;
            MR_SIMD
            for (int t = 0; t < N; ++t) y[t] += w0 * a0[t];
        }
    }
}

// 7-point filter with the edge repeated (as in the exported model).
//
// The sum uses fma, in the order of the coefficients, on purpose. When the finger stands still the velocity is zero plus the
// rounding error, and the model takes an angle with atan2 of that velocity: the last bit decides the angle. With fma in
// sequence the result is that of the official runtime on every test vector; with an ordinary sum, 18 gestures out of 201
// come out different (with no effect on the words found, but then the comparison with the official runtime means less).
void savgol(const float* k, const float* v, float* out) {
    float p[L + 6];
    for (int i = 0; i < 3; ++i) {
        p[i] = v[0];
        p[L + 3 + i] = v[L - 1];
    }
    std::memcpy(p + 3, v, sizeof(float) * L);
    for (int t = 0; t < L; ++t) {
        float s = 0.f;
        for (int j = 0; j < 7; ++j) s = std::fma(k[j], p[t + j], s);
        out[t] = s;
    }
}

}  // namespace

bool GestureParams::set(const float* f, const int* i) {
    if (f == nullptr || i == nullptr) return false;
    for (int k = 0; k < kFloats; k++) {
        if (!(f[k] >= -100.f && f[k] <= 100.f)) return false;   // also refuses NaN
    }
    if (f[0] < 0.f || f[0] > 4.f || f[4] < 0.f || f[4] > 4.f) return false;   // the two exponents
    if (i[0] < 1 || i[0] > kGestureMaxBeam || i[1] < 1 || i[1] > kMaxWord || i[2] < 1 || i[2] > kGestureMaxBudget) return false;
    gamma = f[0]; lambdaF = f[1]; beta = f[2]; ctx = f[3]; gammaPrune = f[4]; betaPrune = f[5];
    beam = i[0]; minKeys = i[1]; nodeBudget = i[2];
    return true;
}

void GestureLayout::clear() {
    n = 0;
    nFree = 0;
    std::vector<float>().swap(basis);
    for (int i = 0; i < 256; i++) low[i] = -1;
}

bool GestureLayout::set(const char16_t* keys, const float* xy, int nKeys, const char16_t* freeChars, int nFreeChars) {
    clear();
    if (keys == nullptr || xy == nullptr || nKeys < 2 || nKeys > kGestureKeys || nFreeChars < 0 || nFreeChars > kGestureFree ||
        (nFreeChars > 0 && freeChars == nullptr)) {
        return false;
    }
    for (int i = 0; i < nKeys; i++) {
        if (keys[i] == 0) return false;
        for (int j = 0; j < i; j++) {
            if (keys[j] == keys[i]) return false;
        }
        const float x = xy[2 * i], y = xy[2 * i + 1];
        if (!(x >= -1.f && x <= 2.f) || !(y >= -1.f && y <= 2.f)) return false;   // also refuses NaN
    }
    basis.assign(static_cast<size_t>(nKeys) * kGestureCoeff, 0.f);
    for (int k = 0; k < nKeys; ++k) {
        key[k] = keys[k];
        if (keys[k] < 256) low[keys[k]] = static_cast<int16_t>(k);
        float cx[8], cy[8];
        for (int u = 0; u < 8; ++u) {
            cx[u] = std::cos(xy[2 * k] * kPi * static_cast<float>(u));
            cy[u] = std::cos(xy[2 * k + 1] * kPi * static_cast<float>(u));
        }
        for (int u = 0; u < 8; ++u) {
            for (int v = 0; v < 8; ++v) basis[static_cast<size_t>(k) * kGestureCoeff + u * 8 + v] = cx[u] * cy[v];
        }
    }
    for (int i = 0; i < nFreeChars; i++) free[i] = freeChars[i];
    nFree = nFreeChars;
    n = nKeys;
    return true;
}

int GestureLayout::find(int c) const {
    if (c < 0) return -1;
    if (c < 256) return low[c];
    for (int i = 0; i < n; i++) {
        if (key[i] == c) return i;
    }
    return -1;
}

bool GestureLayout::isFree(int c) const {
    for (int i = 0; i < nFree; i++) {
        if (free[i] == c) return true;
    }
    return false;
}

bool gestureResample(const float* x, const float* y, const int32_t* tMs, int n, float* out) {
    if (x == nullptr || y == nullptr || tMs == nullptr || out == nullptr || n < 1) return false;
    std::vector<double> t(static_cast<size_t>(n)), xs, ys;
    t[0] = 0.0;
    for (int i = 1; i < n; ++i) {
        const double d = static_cast<double>(tMs[i]) - static_cast<double>(tMs[0]);
        t[i] = d < t[i - 1] ? t[i - 1] : d;
    }
    const double dur = t[n - 1];
    if (dur > 1e-3) {
        int n60 = 60 * 60;                               // one minute: not a gesture, but it must not hang
        if (dur < 60000.0) {
            n60 = static_cast<int>(std::nearbyint(dur / (1000.0 / 60.0))) + 1;
            if (n60 < 2) n60 = 2;
        }
        xs.resize(static_cast<size_t>(n60));
        ys.resize(static_cast<size_t>(n60));
        int j = 0;
        const double step = dur / (n60 - 1);
        for (int i = 0; i < n60; ++i) {
            const double tt = (i == n60 - 1) ? dur : step * i;
            while (j + 1 < n - 1 && t[j + 1] <= tt) ++j;
            if (tt >= t[n - 1] || n == 1) {
                xs[i] = x[n - 1];
                ys[i] = y[n - 1];
            } else {
                const double den = t[j + 1] - t[j];
                const double f = den > 0.0 ? (tt - t[j]) / den : 0.0;
                xs[i] = x[j] + f * (static_cast<double>(x[j + 1]) - x[j]);
                ys[i] = y[j] + f * (static_cast<double>(y[j + 1]) - y[j]);
            }
        }
    } else {
        xs.assign(x, x + n);
        ys.assign(y, y + n);
    }
    const int m = static_cast<int>(xs.size());
    for (int i = 0; i < L; ++i) {
        const double idx = (i == L - 1) ? (m - 1) : (static_cast<double>(m - 1) * i) / (L - 1);
        const int lo = static_cast<int>(idx);
        if (lo >= m - 1) {
            out[i] = static_cast<float>(xs[m - 1]);
            out[L + i] = static_cast<float>(ys[m - 1]);
        } else {
            const double f = idx - lo;
            out[i] = static_cast<float>(xs[lo] + f * (xs[lo + 1] - xs[lo]));
            out[L + i] = static_cast<float>(ys[lo] + f * (ys[lo + 1] - ys[lo]));
        }
    }
    return true;
}

void GestureNet::close() {
    open_ = false;
    std::vector<float>().swap(w_);
    std::vector<float>().swap(buf_);
}

bool GestureNet::open(const char* path) {
    close();
    if (path == nullptr) return false;
    int fd = ::open(path, O_RDONLY | O_CLOEXEC);
    if (fd < 0) return false;
    struct stat st;
    if (fstat(fd, &st) != 0 || !S_ISREG(st.st_mode) || st.st_size < 12 || static_cast<unsigned long long>(st.st_size) > kMaxFile) {
        ::close(fd);
        return false;
    }
    const size_t size = static_cast<size_t>(st.st_size);
    std::vector<uint8_t> d(size);
    size_t got = 0;
    while (got < size) {
        ssize_t r = ::read(fd, d.data() + got, size - got);
        if (r <= 0) break;
        got += static_cast<size_t>(r);
    }
    ::close(fd);
    if (got != size) return false;
    return openBytes(d.data(), size);
}

bool GestureNet::openBytes(const uint8_t* d, size_t size) {
    close();
    if (d == nullptr || size < 12 || size > kMaxFile || std::memcmp(d, "MRSWENC1", 8) != 0) return false;
    const uint32_t count = u32le(d + 8);
    if (count == 0 || count > 1024) return false;
    struct Tensor {
        std::string name;
        size_t at, n;
    };
    std::vector<Tensor> tensors;
    constexpr size_t kMaxValues = kMaxFile / 4;
    w_.reserve(size / 4);
    size_t p = 12;
    for (uint32_t i = 0; i < count; ++i) {
        if (p >= size) return close(), false;
        const size_t ln = d[p++];
        if (ln == 0 || ln >= size - p) return close(), false;           // the name and at least the byte after it
        std::string name(reinterpret_cast<const char*>(d + p), ln);
        p += ln;
        const size_t nd = d[p++];
        if (nd == 0 || nd > 4 || nd * 4 > size - p) return close(), false;
        size_t n = 1;
        for (size_t k = 0; k < nd; ++k) {
            const uint32_t dim = u32le(d + p);
            p += 4;
            if (dim == 0 || dim > kMaxValues || n > kMaxValues / dim) return close(), false;
            n *= dim;
        }
        if (n > (size - p) / 4) return close(), false;
        const size_t at = w_.size();
        w_.resize(at + n);
        std::memcpy(w_.data() + at, d + p, n * 4);
        p += n * 4;
        tensors.push_back(Tensor{name, at, n});
    }
    if (p != size) return close(), false;                               // bytes left over: not a file of this format
    for (float v : w_) {
        if (!std::isfinite(v)) return close(), false;
    }
    bool ok = true;
    auto get = [&](const std::string& name, size_t n) -> const float* {
        for (const Tensor& t : tensors) {
            if (t.name == name) {
                if (t.n != n) break;
                return w_.data() + t.at;
            }
        }
        ok = false;
        return nullptr;
    };
    static const char* const kSg[5] = {"savgol.d1_x", "savgol.d1_y", "savgol.d2_x", "savgol.d2_y", "savgol.d1_curv"};
    for (int i = 0; i < 5; ++i) sg_[i] = get(kSg[i], 7);
    stemW_ = get("stem.w", 128 * 7 * 8);
    stemB_ = get("stem.b", 128);
    for (int b = 0; b < 5; ++b) {
        const std::string q = "b" + std::to_string(b) + ".";
        Block& k = blk_[b];
        k.dwW = get(q + "dw.w", 7 * 128);
        k.dwB = get(q + "dw.b", 128);
        k.pw1W = get(q + "pw1.w", 512 * 128);
        k.pw1B = get(q + "pw1.b", 512);
        k.grnG = get(q + "grn.g", 256);
        k.grnB = get(q + "grn.b", 256);
        k.pw2W = get(q + "pw2.w", 128 * 256);
        k.pw2B = get(q + "pw2.b", 128);
        k.se1W = get(q + "se1.w", 32 * 128);
        k.se1B = get(q + "se1.b", 32);
        k.se2W = get(q + "se2.w", 128 * 32);
        k.se2B = get(q + "se2.b", 128);
    }
    adW_ = get("adapter.w", 256 * 2 * 128);
    adB_ = get("adapter.b", 256);
    lamW_ = get("lambda.w", 256);
    lamB_ = get("lambda.b", 1);
    coW_ = get("coeff.w", kGestureCoeff * 256);
    coB_ = get("coeff.b", kGestureCoeff);
    if (!ok) return close(), false;
    buf_.assign(kWork, 0.f);
    open_ = true;
    return true;
}

void GestureNet::forward(const float* feats, const GestureLayout& layout, float* out) {
    const int nk = layout.n;
    if (!open_ || feats == nullptr || out == nullptr || nk < 1 || nk > kGestureKeys) return;
    float* ft = buf_.data();
    float* h = ft + 8 * L;
    float* u = h + 128 * L;
    float* v = u + 128 * L;
    float* g = v + 512 * L;
    float* r = g + 256 * L;
    float* hs = r + 128 * L;
    float* z = hs + 256 * F;
    float* co = z + 256 * F;
    float* lg = co + kGestureCoeff * F;

    // 1. features
    const float* x = feats;
    const float* y = feats + L;
    float* dx = ft + 2 * L;
    float* dy = ft + 3 * L;
    float th[L], thu[L];
    std::memcpy(ft, x, sizeof(float) * L);
    std::memcpy(ft + L, y, sizeof(float) * L);
    savgol(sg_[0], x, dx);
    savgol(sg_[1], y, dy);
    savgol(sg_[2], x, ft + 4 * L);
    savgol(sg_[3], y, ft + 5 * L);
    for (int t = 0; t < L; ++t) {
        th[t] = std::atan2(dy[t], dx[t]);
        ft[6 * L + t] = std::sqrt(dx[t] * dx[t] + dy[t] * dy[t] + 1e-8f);
    }
    float acc = 0.f;                       // undoes the 2*pi jumps of the angle
    thu[0] = th[0];
    for (int t = 1; t < L; ++t) {
        const float d = th[t] - th[t - 1];
        float c = d > kPi ? -kTwoPi : 0.f;
        if (d < -kPi) c += kTwoPi;
        acc += c;
        thu[t] = th[t] + acc;
    }
    savgol(sg_[4], thu, ft + 7 * L);
    for (int t = 0; t < L; ++t) {
        const float c = ft[7 * L + t];
        ft[7 * L + t] = c < -2.f ? -2.f : (c > 2.f ? 2.f : c);
    }

    // 2. stem: conv 8->128, k=7, zeros at the edge, and hardswish
    for (int o = 0; o < 128; ++o) {
        float* __restrict yo = h + o * L;
        for (int t = 0; t < L; ++t) yo[t] = stemB_[o];
        const float* w = stemW_ + static_cast<size_t>(o) * 56;      // [k][i]
        for (int k = 0; k < 7; ++k) {
            const int s = k - 3;
            const int t0 = s < 0 ? -s : 0, t1 = s > 0 ? L - s : L;
            for (int i = 0; i < 8; ++i) {
                const float wv = w[k * 8 + i];
                const float* __restrict a = ft + i * L + s;
                MR_SIMD
                for (int t = t0; t < t1; ++t) yo[t] += wv * a[t];
            }
        }
        for (int t = 0; t < L; ++t) {
            const float q = yo[t];
            float c = q + 3.f;
            c = c < 0.f ? 0.f : (c > 6.f ? 6.f : c);
            yo[t] = q * c / 6.f;
        }
    }

    // 3. blocks
    for (int b = 0; b < 5; ++b) {
        const Block& k = blk_[b];
        const int dil = kDil[b];
        for (int c = 0; c < 128; ++c) {
            float* __restrict yo = u + c * L;
            const float* hc = h + c * L;
            for (int t = 0; t < L; ++t) yo[t] = k.dwB[c];
            for (int j = 0; j < 7; ++j) {
                const int s = (j - 3) * dil;
                const int t0 = s < 0 ? -s : 0, t1 = s > 0 ? L - s : L;
                const float wv = k.dwW[j * 128 + c];
                const float* __restrict a = hc + s;
                MR_SIMD
                for (int t = t0; t < t1; ++t) yo[t] += wv * a[t];
            }
        }
        gemmRows<L>(k.pw1W, k.pw1B, 512, 128, u, v);
        float gx[256];
        float mean = 0.f;
        for (int c = 0; c < 256; ++c) {
            const float* va = v + c * L;
            const float* vb = v + (256 + c) * L;
            float* gc = g + c * L;
            float ss = 0.f;
            for (int t = 0; t < L; ++t) {
                const float q = sigmoidf(va[t]) * vb[t];
                gc[t] = q;
                ss += q * q;
            }
            gx[c] = std::sqrt(ss / L + 1e-6f);
            mean += gx[c];
        }
        mean = mean / 256.f + 1e-6f;
        for (int c = 0; c < 256; ++c) {
            const float m = k.grnG[c] * (gx[c] / mean) + 1.f;
            const float bb = k.grnB[c];
            float* gc = g + c * L;
            for (int t = 0; t < L; ++t) gc[t] = gc[t] * m + bb;
        }
        gemmRows<L>(k.pw2W, k.pw2B, 128, 256, g, r);
        float pool[128], s1[32], s2[128];
        for (int c = 0; c < 128; ++c) {
            const float* rc = r + c * L;
            float s = 0.f;
            for (int t = 0; t < L; ++t) s += rc[t];
            pool[c] = s / L;
        }
        for (int o = 0; o < 32; ++o) {
            float s = k.se1B[o];
            for (int i = 0; i < 128; ++i) s += k.se1W[o * 128 + i] * pool[i];
            s1[o] = s > 0.f ? s : 0.f;
        }
        for (int o = 0; o < 128; ++o) {
            float s = k.se2B[o];
            for (int i = 0; i < 32; ++i) s += k.se2W[o * 32 + i] * s1[i];
            s2[o] = sigmoidf(s);
        }
        for (int c = 0; c < 128; ++c) {
            float* __restrict hc = h + c * L;
            const float* __restrict rc = r + c * L;
            const float s = s2[c];
            MR_SIMD
            for (int t = 0; t < L; ++t) hc[t] += rc[t] * s;
        }
    }

    // 4. adapter: conv 128->256, k=2, stride 2 (the even points and the odd ones become 256 rows of 32)
    for (int c = 0; c < 128; ++c) {
        const float* hc = h + c * L;
        float* e0 = hs + c * F;
        float* e1 = hs + (128 + c) * F;
        for (int t = 0; t < F; ++t) {
            e0[t] = hc[2 * t];
            e1[t] = hc[2 * t + 1];
        }
    }
    gemmRows<F>(adW_, adB_, 256, 256, hs, z);

    // 5. head: lambda and coefficients; value per key = coefficients x basis
    float lam[F];
    for (int t = 0; t < F; ++t) lam[t] = lamB_[0];
    for (int o = 0; o < 256; ++o) {
        const float wv = lamW_[o];
        const float* zo = z + o * F;
        for (int t = 0; t < F; ++t) lam[t] += wv * zo[t];
    }
    gemmRows<F>(coW_, coB_, kGestureCoeff, 256, z, co);
    gemmRows<F>(layout.basis.data(), nullptr, nk, kGestureCoeff, co, lg);
    for (int t = 0; t < F; ++t) {
        const float ls = sigmoidf(lam[t]);
        float mx = -1e30f;
        for (int q = 0; q < nk; ++q) mx = lg[q * F + t] > mx ? lg[q * F + t] : mx;
        float sum = 0.f;
        for (int q = 0; q < nk; ++q) sum += std::exp(lg[q * F + t] - mx);
        const float lz = mx + std::log(sum);
        const float logKey = ls > 0.f ? std::log(ls) : -1e30f;
        const float rest = 1.f - ls;
        const float logBlank = rest > 0.f ? std::log(rest) : -1e30f;
        float* row = out + static_cast<size_t>(t) * (nk + 1);
        for (int q = 0; q < nk; ++q) row[q] = lg[q * F + t] - lz + logKey;
        row[nk] = logBlank;
        // A log-probability is never above 0; the floor keeps the sums of the search far from overflow. Written so that a NaN
        // (absurd input, weights that overflow) also becomes the floor: nothing after this point ever sees one.
        for (int q = 0; q <= nk; ++q) {
            const float val = row[q];
            row[q] = !(val > kGestureMinLog) ? kGestureMinLog : (val > 0.f ? 0.f : val);
        }
    }
}

}  // namespace mr
