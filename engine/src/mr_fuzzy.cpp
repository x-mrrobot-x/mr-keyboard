// Porta de MrFuzzy.java (busca). Cada função diz de qual método vem. Mantenha a MESMA ordem de operações:
// a paridade com o Java é bit a bit, inclusive nos arquivos estragados (onde o Java "retorna" no meio da
// leitura e a busca segue com o que já achou).
#include "mr_engine.h"

#include <algorithm>
#include <cmath>
#include <cstring>

namespace mr {

namespace {
// MrFuzzy.java: setMaxCost usa "max / 30" (custo mínimo de mudar o tamanho). Não é um custo ajustável.
constexpr int kBandDivisor = 30;
}  // namespace

void Fuzzy::attach(const uint8_t* dict, int size) {
    dict_ = dict;
    size_ = size;
    bool latest = false;
    if (dict != nullptr && size > 2) {
        int v = dict[0];
        int b = dict[1];
        latest = v >= 200 && (b == 0 || b == 1);
    }
    latest_ = latest;
    root_ = latest ? 2 : 0;
}

// ---------------------------------------------------------------------------------------------- busca

void Fuzzy::search(const Tables& t, const Rules& r, const char16_t* tb, int n, const char16_t* near,
                   const int* nearCount) {
    t_ = &t;
    r_ = &r;
    resCount_ = 0;
    visits_ = 0;
    if (dict_ == nullptr || size_ <= 2 || n < 1) return;
    if (n > kMaxTyped) n = kMaxTyped;
    n_ = n;
    for (int j = 0; j < n; j++) {
        tb_[j] = tb[j];
        int cnt = nearCount[j];
        if (cnt < 0) cnt = 0;
        if (cnt > kNear) cnt = kNear;
        for (int k = 0; k < cnt; k++) near_[j][k] = near[j * kNear + k];
        nearCount_[j] = cnt;
        std::fill(sub_[j], sub_[j] + 256, int16_t(-1));
    }
    for (int j = 0; j < n; j++) ins_[j] = insCost(j);
    for (int j = 2; j <= n; j++) {
        char16_t a = tb_[j - 2], b = tb_[j - 1];
        char16_t d1 = 0, d2 = 0;
        for (size_t k = 0; k < r.t2a.size(); k++) {
            if (r.t2a[k] == a && r.t2b[k] == b) {
                if (d1 == 0) d1 = r.t2d[k];
                else if (d2 == 0) d2 = r.t2d[k];
            }
        }
        twoD1_[j] = d1;
        twoD2_[j] = d2;
    }
    firstLetters();
    int* row0 = rows_[0];
    row0[0] = 0;
    for (int j = 1; j <= n; j++) row0[j] = std::min(kInf, row0[j - 1] + ins_[j - 1]);

    const Costs& c = t.costs;
    // 1ª passada: um erro (custo de 1 letra a mais/a menos ou troca). Ver os comentários em MrFuzzy.search.
    bool prefix = isPrefix();
    if (!prefix || n >= 4) {
        setMaxCost(prefix && n == 4 ? 40 : n <= 3 ? 45 : n == 4 ? 60 : 75);
        walkRoot();
        if (!prefix && visits_ <= c.nodeBudget) {
            // a 1ª letra ficou de fora; só a letra que faltou e, em palavra longa, mais um erro barato
            setMaxCost(c.delFirst + (n >= 6 ? 30 : 0));
            onlyTyped_ = 3;
            walk(root_, 0, 0, 0);
            onlyTyped_ = 0;
        }
        if (resCount_ == 0 && !prefix && n >= 6) {
            // 2ª passada: até dois erros, para palavras mais longas
            setMaxCost(n <= 7 ? 100 : 120);
            walkRoot();
        }
    }
    if (n >= 4) split();
}

void Fuzzy::setMaxCost(int max) {
    maxCost_ = max;
    band_ = max / kBandDivisor;
}

void Fuzzy::walkRoot() {
    onlyTyped_ = 1;
    walk(root_, 0, 0, 0);
    if (visits_ > t_->costs.nodeBudget) return;
    onlyTyped_ = 2;
    walk(root_, 0, 0, 0);
    onlyTyped_ = 0;
}

bool Fuzzy::isPrefix() const {
    guard_ = 0;
    return prefixRec(root_, 0);
}

bool Fuzzy::prefixRec(int pos, int j) const {
    if (pos < 0 || pos >= size_) return false;
    if (++guard_ > t_->costs.nodeBudget) return false;   // só estoura em arquivo estragado (veja guard_)
    int count = dat(pos);
    pos++;
    int want = tb_[j];
    for (int i = 0; i < count; i++) {
        if (pos >= size_) return false;
        int c = dat(pos++);
        if (c == 0xFF) {
            if (pos + 1 >= size_) return false;
            c = (dat(pos) << 8) | dat(pos + 1);
            pos += 2;
        }
        // O Java lança IndexOutOfBounds aqui quando o arquivo termina logo depois da letra (o MrFuzzy.afterWords
        // engole a exceção e some com os resultados); em C++ ler fora do arquivo é comportamento indefinido, então
        // este grupo simplesmente termina. Só acontece em dicionário estragado.
        if (pos >= size_) return false;
        int flags = dat(pos);
        int child = 0;
        if ((flags & 0x40) != 0) {
            if (pos + 2 >= size_) return false;
            child = ((flags & 0x3F) << 16) | (dat(pos + 1) << 8) | dat(pos + 2);
            pos += 3;
        } else {
            pos += 1;
        }
        if ((flags & 0x80) != 0) {
            if (pos >= size_) return false;
            pos++;
            if (latest_) pos = skipBigrams(pos);
        }
        int cb = t_->baseOf(c);
        if (cb != want) continue;
        if (j + 1 == n_) {
            if (child != 0) return true;
        } else if (child != 0 && prefixRec(child, j + 1)) {
            return true;
        }
    }
    return false;
}

int Fuzzy::skipBigrams(int pos) const {
    if (pos >= size_) return pos;
    if ((dat(pos) & 0x80) != 0) {
        int guard = 0;
        while (pos + 3 < size_ && guard++ < 10000) {
            pos += 3;
            int more = dat(pos++) & 0x80;
            if (more == 0) break;
        }
        return pos;
    }
    return pos + 1;
}

// MrFuzzy.firstLetters
void Fuzzy::firstLetters() {
    std::fill(first_, first_ + 256, false);
    int t = tb_[0];
    first_[t & 0xFF] = t < 256;
    for (int k = 0; k < nearCount_[0]; k++) {
        int c = near_[0][k];
        if (c < 256) first_[c] = true;
    }
    const Rules& r = *r_;
    for (int c = 0; c < 256; c++) {
        // letras parecidas e vogais trocadas; letras mudas no começo ("omem" -> homem)
        if (r.pair(c, t) != 0 || r.silentStart[c] > 0) first_[c] = true;
    }
    // grupos: "ch" digitado pode ser "x" no dicionário; "x" digitado pode ser "ch"
    if (n_ > 1) {
        for (size_t k = 0; k < r.t2a.size(); k++) {
            if (r.t2a[k] == t && r.t2b[k] == tb_[1]) {
                int d = t_->baseOf(r.t2d[k]);
                if (d < 256) first_[d] = true;
            }
        }
    }
    for (size_t k = 0; k < r.d2t.size(); k++) {
        if (r.d2t[k] == t) {
            int d = t_->baseOf(r.d2p[k]);
            if (d < 256) first_[d] = true;
        }
    }
    if (n_ > 1 && tb_[1] < 256) first_[tb_[1]] = true;
}

int Fuzzy::sub(int j, int cb) {
    if (cb >= 256) return cb == tb_[j] ? 0 : t_->costs.sub;
    int s = sub_[j][cb];
    if (s < 0) {
        s = subCost(cb, j);
        sub_[j][cb] = static_cast<int16_t>(s);
    }
    return s;
}

// MrFuzzy.walk
void Fuzzy::walk(int pos, int depth, int pcb, int parentRaw) {
    if (pos < 0 || pos >= size_) return;
    const Costs& cs = t_->costs;
    const Rules& R = *r_;
    int count = dat(pos);
    pos++;
    int* prev = rows_[depth];
    int* prev2 = depth > 0 ? rows_[depth - 1] : nullptr;
    const int n = n_;
    for (int i = 0; i < count; i++) {
        if (pos >= size_) return;
        int c = dat(pos++);
        if (c == 0xFF) {
            if (pos + 1 >= size_) return;
            c = (dat(pos) << 8) | dat(pos + 1);
            pos += 2;
        }
        // O Java lança IndexOutOfBounds aqui quando o arquivo termina logo depois da letra (o MrFuzzy.afterWords
        // engole a exceção e some com os resultados); em C++ ler fora do arquivo é comportamento indefinido, então
        // este grupo simplesmente termina. Só acontece em dicionário estragado.
        if (pos >= size_) return;
        int flags = dat(pos);
        bool terminal = (flags & 0x80) != 0;
        int child = 0;
        if ((flags & 0x40) != 0) {
            if (pos + 2 >= size_) return;
            child = ((flags & 0x3F) << 16) | (dat(pos + 1) << 8) | dat(pos + 2);
            pos += 3;
        } else {
            pos += 1;
        }
        int freq = 0;
        if (terminal) {
            if (pos >= size_) return;
            freq = dat(pos++);
            if (latest_) pos = skipBigrams(pos);
        }
        if (++visits_ > cs.nodeBudget) return;
        int cb = t_->baseOf(c);
        if (depth == 0) {
            if (cb >= 256) continue;
            if (onlyTyped_ == 3) {
                if (first_[cb]) continue;
            } else {
                if (!first_[cb]) continue;
                if (onlyTyped_ == 1 && cb != tb_[0]) continue;
                if (onlyTyped_ == 2 && cb == tb_[0]) continue;
            }
        }
        const int raw = c;
        const int rl = t_->lowerOf(c);
        int del = delCost(cb, pcb, depth);
        // o dicionário tem 2 letras (pai + esta) para 1 digitada? (grupos: x = ch, c = sc...)
        int d1 = -1, d2 = -1;
        if (prev2 != nullptr && !R.d2p.empty()) {
            int p = t_->lowerOf(parentRaw);
            for (size_t k = 0; k < R.d2p.size(); k++) {
                if (R.d2p[k] == p && R.d2c[k] == rl) {
                    if (d1 < 0) d1 = R.d2t[k];
                    else if (d2 < 0) d2 = R.d2t[k];
                }
            }
        }
        int* cur = rows_[depth + 1];
        int r = depth + 1;
        int lo = r - band_;
        int hi = r + band_;
        if (hi > n) hi = n;
        int rowMin = kInf;
        if (lo <= 0) {
            int best0 = prev[0] + del;
            if (best0 > kInf) best0 = kInf;
            cur[0] = best0;
            rowMin = best0;
            lo = 1;
        } else {
            cur[lo - 1] = kInf;
        }
        if (hi + 1 <= n) cur[hi + 1] = kInf;
        if (hi + 2 <= n) cur[hi + 2] = kInf;
        const bool onlyDel = depth == 0 && onlyTyped_ == 3;
        for (int j = lo; j <= hi; j++) {
            int tj1 = tb_[j - 1];
            // na passada da 1ª letra que faltou, a raiz só pode ser letra que falta
            int best = onlyDel ? kInf : prev[j - 1] + sub(j - 1, cb);
            int v = cur[j - 1] + ins_[j - 1];
            if (v < best) best = v;
            v = prev[j] + del;
            if (v < best) best = v;
            if (j >= 2) {
                if (prev2 != nullptr && cb == tb_[j - 2] && pcb == tj1 && cb != pcb) {
                    v = prev2[j - 2] + cs.trans;
                    if (v < best) best = v;
                }
                if ((twoD1_[j] != 0 && rl == twoD1_[j]) || (twoD2_[j] != 0 && rl == twoD2_[j])) {
                    v = prev[j - 2] + cs.multi;
                    if (v < best) best = v;
                }
            }
            if (d1 >= 0 && (tj1 == d1 || tj1 == d2)) {
                v = prev2[j - 1] + cs.multi;
                if (v < best) best = v;
            }
            if (best > kInf) best = kInf;
            cur[j] = best;
            if (best < rowMin) rowMin = best;
        }
        if (depth < kMaxWord) path_[depth] = static_cast<char16_t>(raw);
        if (terminal && hi == n && cur[n] <= maxCost_ && depth + 1 <= kMaxWord && freq > 0) {
            offer(path_, depth + 1, freq, cur[n]);
        }
        if (child != 0 && rowMin <= maxCost_ && depth + 1 < n + band_ && depth + 2 < rowsLen_ &&
            depth + 1 < kMaxWord) {
            walk(child, depth + 1, cb, raw);
            if (visits_ > cs.nodeBudget) return;
            // a recursão sobrescreveu rows_[depth + 2..]; rows_[depth + 1] é desta entrada
            prev = rows_[depth];
            prev2 = depth > 0 ? rows_[depth - 1] : nullptr;
        }
    }
}

bool Fuzzy::isNear(int j, int cb) const {
    for (int k = nearCount_[j] - 1; k >= 0; k--) {
        if (near_[j][k] == cb) return true;
    }
    return false;
}

// Posição de cb entre os vizinhos do toque j (0 = o mais perto), ou -1.
int Fuzzy::nearRank(int j, int cb) const {
    int cnt = nearCount_[j];
    for (int k = 0; k < cnt; k++) {
        if (near_[j][k] == cb) return k;
    }
    return -1;
}

int Fuzzy::subCost(int cb, int j) const {
    const Costs& c = t_->costs;
    int t = tb_[j];
    if (cb == t) return 0;
    int near = nearRank(j, cb);
    if (near >= 0) return near == 0 ? c.prox1 : near == 1 ? c.prox2 : c.proxFar;
    int kind = r_->pair(cb, t);
    if (kind == 1) return c.phon;
    if (kind == 2) return c.vowel;
    return c.sub;
}

// Letra digitada a mais na posição j.
int Fuzzy::insCost(int j) const {
    const Costs& c = t_->costs;
    int t = tb_[j];
    if (j > 0 && tb_[j - 1] == t) return c.insDouble;
    if (t < 256 && r_->extra[t]) return c.insH;
    if (j > 0 && isNear(j - 1, t)) return c.insNear;
    if (j + 1 < n_ && isNear(j + 1, t)) return c.insNear;
    return c.ins;
}

// Letra do dicionário que não foi digitada.
int Fuzzy::delCost(int cb, int pcb, int depth) const {
    const Costs& c = t_->costs;
    const Rules& r = *r_;
    if (depth == 0 && onlyTyped_ == 3) {
        int s0 = cb < 256 ? r.silentStart[cb] : 0;
        return s0 > 0 && s0 < c.delFirst ? s0 : c.delFirst;
    }
    if (depth == 0 && cb < 256 && r.silentStart[cb] > 0) return r.silentStart[cb];
    if (depth > 0 && cb == pcb) return c.delDouble;
    for (size_t k = 0; k < r.silPrev.size(); k++) {
        if (r.silChar[k] == cb && r.silPrev[k] == pcb) return r.silCost[k];
    }
    if (depth > 0 && cb < 256 && r.silentAny[cb] > 0) return r.silentAny[cb];
    return c.del;
}

int64_t Fuzzy::scoreFor(int freq, int cost) const {
    int n = std::min(n_, 24);
    double base = static_cast<double>(freq) * static_cast<double>(int64_t(1) << (n + 1));
    // O Java usa Math.pow(2.0, -cost / 25.0); a tabela vem calculada por ele, então o arredondamento é o mesmo.
    double p = (cost >= 0 && cost < kPowTable) ? t_->pow2[cost] : std::pow(2.0, -cost / 25.0);
    double s = base * p;
    if (s > 2147483647 / 8) s = 2147483647 / 8;
    return static_cast<int64_t>(s);
}

void Fuzzy::offer(const char16_t* word, int len, int freq, int cost) {
    int64_t score = scoreFor(freq, cost);
    if (score <= 0) return;
    insert(word, len, score, cost);
}

void Fuzzy::insert(const char16_t* word, int len, int64_t score, int cost) {
    if (len < 0 || len > kResultChars) return;
    // repetida? fica a de maior pontuação
    for (int i = 0; i < resCount_; i++) {
        if (resLen_[i] == len && std::memcmp(resWord_[i], word, sizeof(char16_t) * len) == 0) {
            if (score <= resScore_[i]) return;
            removeAt(i);
            break;
        }
    }
    int at = resCount_;
    while (at > 0 && resScore_[at - 1] < score) at--;
    if (at >= kMaxResults) return;
    int last = std::min(resCount_, kMaxResults - 1);
    for (int i = last; i > at; i--) {
        std::memcpy(resWord_[i], resWord_[i - 1], sizeof(resWord_[i]));
        resLen_[i] = resLen_[i - 1];
        resScore_[i] = resScore_[i - 1];
        resCost_[i] = resCost_[i - 1];
    }
    std::memcpy(resWord_[at], word, sizeof(char16_t) * len);
    resLen_[at] = len;
    resScore_[at] = score;
    resCost_[at] = cost;
    if (resCount_ < kMaxResults) resCount_++;
}

void Fuzzy::removeAt(int i) {
    for (int k = i; k < resCount_ - 1; k++) {
        std::memcpy(resWord_[k], resWord_[k + 1], sizeof(resWord_[k]));
        resLen_[k] = resLen_[k + 1];
        resScore_[k] = resScore_[k + 1];
        resCost_[k] = resCost_[k + 1];
    }
    resCount_--;
}

// ------------------------------------------------------------------------------------ espaço faltando

// MrFuzzy.split
void Fuzzy::split() {
    const int n = n_;
    guard_ = 0;
    int64_t bestScore = 0;
    int bestLen = 0;
    for (int k = 1; k <= n - 2; k++) {
        if (k == 1) {
            int b = tb_[0];
            if (!(b < 256 && r_->oneLetter[b])) continue;
        }
        int fl = lookup(0, k);
        if (fl <= 0) continue;
        int leftLen = lookLen_;
        std::memcpy(leftBuf_, lookBuf_, sizeof(char16_t) * leftLen);
        int fr = lookup(k, n);
        if (fr <= 0) continue;
        int64_t score = scoreFor(std::min(fl, fr), t_->costs.split);
        if (score > bestScore) {
            bestScore = score;
            std::memcpy(splitBuf_, leftBuf_, sizeof(char16_t) * leftLen);
            splitBuf_[leftLen] = u' ';
            std::memcpy(splitBuf_ + leftLen + 1, lookBuf_, sizeof(char16_t) * lookLen_);
            bestLen = leftLen + 1 + lookLen_;
        }
    }
    if (bestLen > 0) insert(splitBuf_, bestLen, bestScore, t_->costs.split);
}

// Procura tb_[from..to) no trie sem considerar acento; guarda em lookBuf_ a grafia mais frequente.
int Fuzzy::lookup(int from, int to) {
    lookFreq_ = 0;
    lookLen_ = 0;
    if (to - from > kMaxWord) return 0;
    // lookRec usa j como índice de tb_ e depth como índice do caminho
    lookupRec(root_, from, to, 0);
    return lookFreq_;
}

void Fuzzy::lookupRec(int pos, int j, int to, int depth) {
    if (pos < 0 || pos >= size_) return;
    if (++guard_ > t_->costs.nodeBudget) return;   // só estoura em arquivo estragado (veja guard_)
    int count = dat(pos);
    pos++;
    int want = tb_[j];
    for (int i = 0; i < count; i++) {
        if (pos >= size_) return;
        int c = dat(pos++);
        if (c == 0xFF) {
            if (pos + 1 >= size_) return;
            c = (dat(pos) << 8) | dat(pos + 1);
            pos += 2;
        }
        // O Java lança IndexOutOfBounds aqui quando o arquivo termina logo depois da letra (o MrFuzzy.afterWords
        // engole a exceção e some com os resultados); em C++ ler fora do arquivo é comportamento indefinido, então
        // este grupo simplesmente termina. Só acontece em dicionário estragado.
        if (pos >= size_) return;
        int flags = dat(pos);
        bool terminal = (flags & 0x80) != 0;
        int child = 0;
        if ((flags & 0x40) != 0) {
            if (pos + 2 >= size_) return;
            child = ((flags & 0x3F) << 16) | (dat(pos + 1) << 8) | dat(pos + 2);
            pos += 3;
        } else {
            pos += 1;
        }
        int freq = 0;
        if (terminal) {
            if (pos >= size_) return;
            freq = dat(pos++);
            if (latest_) pos = skipBigrams(pos);
        }
        int cb = t_->baseOf(c);
        if (cb != want) continue;
        lookPath_[depth] = static_cast<char16_t>(c);
        if (j + 1 == to) {
            if (terminal && freq > lookFreq_ && !t_->isUpper(lookPath_[0])) {
                lookFreq_ = freq;
                lookLen_ = depth + 1;
                std::memcpy(lookBuf_, lookPath_, sizeof(char16_t) * (depth + 1));
            }
        } else if (child != 0) {
            lookupRec(child, j + 1, to, depth + 1);
        }
    }
}

}  // namespace mr
