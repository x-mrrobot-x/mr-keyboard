// JNI layer: com.mrkeyboard.app.MrNative (RegisterNatives, no exported Java_... names).
// Anything unexpected (array size, non-direct buffer, C++ exception) returns failure and
// Java carries on with its own code. Nothing here may bring the keyboard down.
#include <jni.h>

#include <algorithm>
#include <cstring>
#include <memory>
#include <mutex>
#include <new>
#include <string>
#include <vector>

#include "mr_engine.h"

namespace {

using namespace mr;

std::mutex gMutex;                       // protects gTables, gRules and gFuzzy (one search at a time)
std::shared_ptr<const Tables> gTables;
std::shared_ptr<const Rules> gRules;
Fuzzy gFuzzy;

std::mutex gTriMutex;
std::shared_ptr<const TriStore> gTri;

constexpr int kInfoSize = 1 + 2 * kMaxResults;

template <typename T>
bool lenAtLeast(JNIEnv* env, T arr, jsize n) {
    return arr != nullptr && env->GetArrayLength(arr) >= n;
}

jint nVersion(JNIEnv*, jclass) { return kEngineVersion; }

jboolean nInit(JNIEnv* env, jclass, jintArray costs, jcharArray lower, jbyteArray upper, jcharArray base256,
               jdoubleArray pow2) {
    try {
        if (!lenAtLeast(env, costs, Costs::kCount) || !lenAtLeast(env, lower, 65536) || !lenAtLeast(env, upper, 65536) ||
            !lenAtLeast(env, base256, 256) || !lenAtLeast(env, pow2, kPowTable)) {
            return JNI_FALSE;
        }
        auto t = std::make_shared<Tables>();
        jint c[Costs::kCount];
        env->GetIntArrayRegion(costs, 0, Costs::kCount, c);
        for (int i = 0; i < Costs::kCount; i++) {
            if (c[i] < 0 || c[i] > 10000000) return JNI_FALSE;
        }
        if (c[16] < 1) return JNI_FALSE;   // nodeBudget
        Costs& k = t->costs;
        k.prox1 = c[0]; k.prox2 = c[1]; k.proxFar = c[2]; k.delFirst = c[3]; k.phon = c[4]; k.vowel = c[5]; k.sub = c[6];
        k.ins = c[7]; k.insDouble = c[8]; k.insH = c[9]; k.insNear = c[10]; k.del = c[11]; k.delDouble = c[12];
        k.trans = c[13]; k.multi = c[14]; k.split = c[15]; k.nodeBudget = c[16];
        t->lower.resize(65536);
        t->upper.resize(65536);
        static_assert(sizeof(jchar) == sizeof(char16_t), "jchar");
        env->GetCharArrayRegion(lower, 0, 65536, reinterpret_cast<jchar*>(t->lower.data()));
        env->GetByteArrayRegion(upper, 0, 65536, reinterpret_cast<jbyte*>(t->upper.data()));
        env->GetCharArrayRegion(base256, 0, 256, reinterpret_cast<jchar*>(t->base256));
        env->GetDoubleArrayRegion(pow2, 0, kPowTable, t->pow2);
        if (env->ExceptionCheck()) return JNI_FALSE;
        std::lock_guard<std::mutex> g(gMutex);
        gTables = t;
        return JNI_TRUE;
    } catch (...) {
        return JNI_FALSE;
    }
}

jboolean nSetRules(JNIEnv* env, jclass, jbyteArray pairs, jcharArray t2, jcharArray d2, jcharArray sil,
                   jshortArray silCost, jshortArray silentStart, jshortArray silentAny, jbooleanArray extra,
                   jbooleanArray oneLetter) {
    try {
        constexpr jsize kMaxRules = 30000;
        if (!lenAtLeast(env, pairs, 65536) || !lenAtLeast(env, silentStart, 256) || !lenAtLeast(env, silentAny, 256) ||
            !lenAtLeast(env, extra, 256) || !lenAtLeast(env, oneLetter, 256) || t2 == nullptr || d2 == nullptr ||
            sil == nullptr || silCost == nullptr) {
            return JNI_FALSE;
        }
        jsize nt2 = env->GetArrayLength(t2), nd2 = env->GetArrayLength(d2), nsil = env->GetArrayLength(sil);
        if (nt2 % 3 != 0 || nd2 % 3 != 0 || nsil % 2 != 0 || nt2 > kMaxRules || nd2 > kMaxRules || nsil > kMaxRules ||
            env->GetArrayLength(silCost) < nsil / 2) {
            return JNI_FALSE;
        }
        auto r = std::make_shared<Rules>();
        env->GetByteArrayRegion(pairs, 0, 65536, reinterpret_cast<jbyte*>(r->pairs.data()));
        std::vector<jchar> buf(static_cast<size_t>(std::max({nt2, nd2, nsil})) + 1);
        env->GetCharArrayRegion(t2, 0, nt2, buf.data());
        for (jsize i = 0; i + 2 < nt2; i += 3) {
            r->t2a.push_back(buf[i]); r->t2b.push_back(buf[i + 1]); r->t2d.push_back(buf[i + 2]);
        }
        env->GetCharArrayRegion(d2, 0, nd2, buf.data());
        for (jsize i = 0; i + 2 < nd2; i += 3) {
            r->d2p.push_back(buf[i]); r->d2c.push_back(buf[i + 1]); r->d2t.push_back(buf[i + 2]);
        }
        env->GetCharArrayRegion(sil, 0, nsil, buf.data());
        std::vector<jshort> costs(static_cast<size_t>(nsil / 2) + 1);
        env->GetShortArrayRegion(silCost, 0, nsil / 2, costs.data());
        for (jsize i = 0; i < nsil / 2; i++) {
            r->silPrev.push_back(buf[2 * i]);
            r->silChar.push_back(buf[2 * i + 1]);
            r->silCost.push_back(costs[i]);
        }
        jshort s256[256];
        env->GetShortArrayRegion(silentStart, 0, 256, s256);
        for (int i = 0; i < 256; i++) r->silentStart[i] = s256[i];
        env->GetShortArrayRegion(silentAny, 0, 256, s256);
        for (int i = 0; i < 256; i++) r->silentAny[i] = s256[i];
        jboolean b256[256];
        env->GetBooleanArrayRegion(extra, 0, 256, b256);
        for (int i = 0; i < 256; i++) r->extra[i] = b256[i] != JNI_FALSE;
        env->GetBooleanArrayRegion(oneLetter, 0, 256, b256);
        for (int i = 0; i < 256; i++) r->oneLetter[i] = b256[i] != JNI_FALSE;
        if (env->ExceptionCheck()) return JNI_FALSE;
        std::lock_guard<std::mutex> g(gMutex);
        gRules = r;
        return JNI_TRUE;
    } catch (...) {
        return JNI_FALSE;
    }
}

// Returns how many results (0..5) or -1 if it could not search (Java then uses its own code).
// outWords: result i starts at i * kResultChars; outInfo: [0] = visited nodes, then (length, cost) of each.
jint nSearch(JNIEnv* env, jclass, jobject dict, jint size, jint n, jcharArray tb, jcharArray near, jintArray nearCount,
             jcharArray outWords, jintArray outInfo, jlongArray outScores) {
    try {
        if (dict == nullptr || size <= 2 || n < 1 || n > kMaxTyped) return -1;
        void* addr = env->GetDirectBufferAddress(dict);
        jlong cap = env->GetDirectBufferCapacity(dict);
        if (addr == nullptr || cap < size) return -1;
        if (!lenAtLeast(env, tb, n) || !lenAtLeast(env, near, n * kNear) || !lenAtLeast(env, nearCount, n) ||
            !lenAtLeast(env, outWords, kMaxResults * kResultChars) || !lenAtLeast(env, outInfo, kInfoSize) ||
            !lenAtLeast(env, outScores, kMaxResults)) {
            return -1;
        }
        char16_t tbuf[kMaxTyped];
        char16_t nbuf[kMaxTyped * kNear];
        jint cnt[kMaxTyped];
        env->GetCharArrayRegion(tb, 0, n, reinterpret_cast<jchar*>(tbuf));
        env->GetCharArrayRegion(near, 0, n * kNear, reinterpret_cast<jchar*>(nbuf));
        env->GetIntArrayRegion(nearCount, 0, n, cnt);
        if (env->ExceptionCheck()) return -1;
        int count = 0;
        {
            std::lock_guard<std::mutex> g(gMutex);
            if (!gTables) return -1;
            std::shared_ptr<const Rules> rules = gRules;
            if (!rules) rules = std::make_shared<Rules>();
            gFuzzy.attach(static_cast<const uint8_t*>(addr), size);
            gFuzzy.search(*gTables, *rules, tbuf, n, nbuf, cnt);
            count = gFuzzy.count();
            jint info[kInfoSize] = {0};
            jlong scores[kMaxResults] = {0};
            info[0] = gFuzzy.visits();
            for (int i = 0; i < count; i++) {
                env->SetCharArrayRegion(outWords, i * kResultChars, gFuzzy.wordLen(i),
                                        reinterpret_cast<const jchar*>(gFuzzy.word(i)));
                info[1 + 2 * i] = gFuzzy.wordLen(i);
                info[2 + 2 * i] = gFuzzy.cost(i);
                scores[i] = gFuzzy.score(i);
            }
            env->SetIntArrayRegion(outInfo, 0, kInfoSize, info);
            env->SetLongArrayRegion(outScores, 0, kMaxResults, scores);
        }
        if (env->ExceptionCheck()) return -1;
        return count;
    } catch (...) {
        return -1;
    }
}

jboolean nTriOpen(JNIEnv* env, jclass, jstring path) {
    try {
        if (path == nullptr) return JNI_FALSE;
        const jchar* chars = env->GetStringChars(path, nullptr);
        if (chars == nullptr) return JNI_FALSE;
        std::string p = toUtf8(reinterpret_cast<const char16_t*>(chars), env->GetStringLength(path));
        env->ReleaseStringChars(path, chars);
        auto store = std::make_shared<TriStore>();
        if (!store->open(p.c_str())) return JNI_FALSE;
        std::lock_guard<std::mutex> g(gTriMutex);
        gTri = store;
        return JNI_TRUE;
    } catch (...) {
        return JNI_FALSE;
    }
}

void nTriClose(JNIEnv*, jclass) {
    std::lock_guard<std::mutex> g(gTriMutex);
    gTri.reset();
}

bool utf8Arg(JNIEnv* env, jstring s, std::string* out) {
    if (s == nullptr) return false;
    const jchar* chars = env->GetStringChars(s, nullptr);
    if (chars == nullptr) return false;
    *out = toUtf8(reinterpret_cast<const char16_t*>(chars), env->GetStringLength(s));
    env->ReleaseStringChars(s, chars);
    return true;
}

jint nTriFind(JNIEnv* env, jclass, jstring a1, jstring a2, jstring b1, jstring b2, jobjectArray outWords,
              jintArray outScores) {
    try {
        std::shared_ptr<const TriStore> store;
        {
            std::lock_guard<std::mutex> g(gTriMutex);
            store = gTri;
        }
        if (!store || outWords == nullptr || outScores == nullptr) return 0;
        int max = std::min<jsize>(env->GetArrayLength(outWords), env->GetArrayLength(outScores));
        if (max <= 0) return 0;
        if (max > 64) max = 64;
        std::string sa1, sa2, sb1, sb2;
        bool ha1 = utf8Arg(env, a1, &sa1), ha2 = utf8Arg(env, a2, &sa2);
        bool hb1 = utf8Arg(env, b1, &sb1), hb2 = utf8Arg(env, b2, &sb2);
        if ((!ha1 && !ha2) || (!hb1 && !hb2)) return 0;
        TriStore::Hit hits[64];
        int n = store->find(ha1 ? &sa1 : nullptr, ha2 ? &sa2 : nullptr, hb1 ? &sb1 : nullptr, hb2 ? &sb2 : nullptr, max,
                            hits);
        jint scores[64];
        int done = 0;
        for (int i = 0; i < n; i++) {
            const uint8_t* p;
            int len;
            if (!store->wordBytes(hits[i].id, &p, &len)) break;
            char16_t w[256];
            int wl = fromUtf8(p, len, w, 256);
            jstring js = env->NewString(reinterpret_cast<const jchar*>(w), wl);
            if (js == nullptr) return done;
            env->SetObjectArrayElement(outWords, done, js);
            env->DeleteLocalRef(js);
            scores[done] = hits[i].score;
            done++;
        }
        if (done > 0) env->SetIntArrayRegion(outScores, 0, done, scores);
        if (env->ExceptionCheck()) return 0;
        return done;
    } catch (...) {
        return 0;
    }
}

// the JDK jni.h declares char* and the NDK one const char*: the cast covers both.
#define MR_METHOD(name, sig, fn) \
    { const_cast<char*>(name), const_cast<char*>(sig), reinterpret_cast<void*>(fn) }

const JNINativeMethod kMethods[] = {
    MR_METHOD("nVersion", "()I", nVersion),
    MR_METHOD("nInit", "([I[C[B[C[D)Z", nInit),
    MR_METHOD("nSetRules", "([B[C[C[C[S[S[S[Z[Z)Z", nSetRules),
    MR_METHOD("nSearch", "(Ljava/nio/ByteBuffer;II[C[C[I[C[I[J)I", nSearch),
    MR_METHOD("nTriOpen", "(Ljava/lang/String;)Z", nTriOpen),
    MR_METHOD("nTriClose", "()V", nTriClose),
    MR_METHOD("nTriFind",
              "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;[I)I",
              nTriFind),
};

}  // namespace

extern "C" __attribute__((visibility("default"))) jint JNI_OnLoad(JavaVM* vm, void*) {
    JNIEnv* env = nullptr;
    if (vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6) != JNI_OK || env == nullptr) return JNI_ERR;
    jclass cls = env->FindClass("com/mrkeyboard/app/MrNative");
    if (cls == nullptr) {
        env->ExceptionClear();
        return JNI_ERR;
    }
    if (env->RegisterNatives(cls, kMethods, static_cast<jint>(sizeof(kMethods) / sizeof(kMethods[0]))) != JNI_OK) {
        env->ExceptionClear();
        return JNI_ERR;
    }
    return JNI_VERSION_1_6;
}
