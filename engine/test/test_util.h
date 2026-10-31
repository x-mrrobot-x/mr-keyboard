// Funções comuns aos programas de teste e de medição (mr_test, mr_bench).
//
// Estes testes de C++ NÃO provam que o resultado é igual ao do Java: para isso as tabelas e as regras teriam que vir do
// Java do app. Quem prova é docs/tools/e2e/NativeParity.java (Java x C++ ao vivo, pela JNI, com os dicionários de dicts/),
// que roda no CI do app. Aqui as tabelas de letras e as regras são APROXIMADAS (ASCII + Latin-1) e servem para exercitar a
// busca, os arquivos estragados, a leitura dos trigramas e as bordas, com ASan/UBSan.
#pragma once

#include <algorithm>
#include <cmath>
#include <cstdint>
#include <cstring>
#include <fstream>
#include <iterator>
#include <string>
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

// Custos de MrFuzzy.java (1.77). Os do app chegam pela JNI; aqui são só para o teste.
inline void approxCosts(Costs& k) {
    k.prox1 = 25; k.prox2 = 30; k.proxFar = 35; k.delFirst = 30; k.phon = 25; k.vowel = 45; k.sub = 75;
    k.ins = 60; k.insDouble = 30; k.insH = 40; k.insNear = 45; k.del = 40; k.delDouble = 30;
    k.trans = 40; k.multi = 35; k.split = 35; k.nodeBudget = 12000;
}

// Tabelas de letras aproximadas: maiúsculas ASCII e Latin-1 (o dicionário não tem letras acima de U+00FF).
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

// Regras de idioma de mentira, mas com todos os tipos (par fonético, vogal, grupos nos dois sentidos, letra muda no
// começo, depois de outra e depois de qualquer uma, letra que sobra, palavra de uma letra), para a busca passar por todos
// os ramos.
inline void approxRules(Rules& r) {
    auto pair = [&](char a, char b, uint8_t kind) { r.pairs[(a << 8) | b] = kind; r.pairs[(b << 8) | a] = kind; };
    pair('s', 'z', 1); pair('c', 's', 1); pair('x', 'z', 1); pair('g', 'j', 1); pair('k', 'c', 1); pair('q', 'k', 1);
    pair('e', 'i', 2); pair('o', 'u', 2); pair('a', 'e', 2);
    r.t2a = {u'c', u's'};  r.t2b = {u'h', u's'};  r.t2d = {u'x', u'c'};   // "ch" digitado = x no dicionário; "ss" = c
    r.d2p = {u's', u'x'};  r.d2c = {u's', u'c'};  r.d2t = {u'c', u'x'};   // "ss" no dicionário = c digitado; "xc" = x
    r.silPrev = {u'n', u'r'};  r.silChar = {u'h', u'h'};  r.silCost = {35, 35};
    r.silentStart[static_cast<int>('h')] = 30;
    r.silentAny[static_cast<int>('u')] = 45;
    r.extra[static_cast<int>('h')] = true;
    r.oneLetter[static_cast<int>('a')] = true;
    r.oneLetter[static_cast<int>('e')] = true;
    r.oneLetter[static_cast<int>('o')] = true;
}

// Entrada da busca como MrFuzzy.search a prepara: tb = letras sem acento; near = teclas vizinhas de cada toque.
struct Query {
    int n = 0;
    char16_t tb[kMaxTyped] = {0};
    char16_t near[kMaxTyped * kNear] = {0};
    int cnt[kMaxTyped] = {0};
};

// Vizinhas num teclado QWERTY (esquerda, direita, cima, cima-direita, baixo-esquerda, baixo), como E2ETest.codesFor.
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

}  // namespace mrtest
