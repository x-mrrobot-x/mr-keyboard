// Mr Keyboard - motor nativo, etapa 1.
//
// Porta para C++ de duas partes do app que hoje rodam em Java e são as mais pesadas:
//   - Fuzzy:    a busca de correção (MrFuzzy.java: distância de edição com pesos sobre o trie do .dict,
//               passadas, divisão de palavras coladas);
//   - TriStore: a consulta de trigramas (MrTrigram.java: arquivo trigrams.bin, formato MRT1).
// Os arquivos são os mesmos de hoje (main.dict, trigrams.bin); nenhum formato novo.
//
// Regras deste código (leia antes de mexer):
//   1. A fonte da verdade dos custos, das regras e das tabelas de letras é o Java do app. O Java entrega
//      tudo na inicialização (nInit/nSetRules); aqui não há constante de ajuste escondida.
//   2. Nunca confiar nos arquivos. Toda leitura é conferida contra o tamanho; arquivo estragado dá menos
//      resultados ou erro, nunca queda do teclado.
//   3. Nenhuma exceção atravessa o JNI.
//   4. Só tipos de tamanho fixo. O resultado não pode depender de char ter ou não sinal (x86 x ARM).
//   5. O resultado tem de ser idêntico ao do Java, bit a bit (palavras, pontuação, custo, ordem). A prova
//      é o teste de paridade (test/ e docs/tools/e2e/NativeParity.java no app).
#pragma once

#include <cstddef>
#include <cstdint>
#include <memory>
#include <string>
#include <vector>

namespace mr {

// Versão do contrato Java <-> nativo. Sobe quando muda a assinatura de qualquer função nativa, a ordem
// dos custos ou o significado de qualquer tabela. O app confere no carregamento e, se não bater, usa o Java.
constexpr int kEngineVersion = 1;

constexpr int kMaxTyped = 20;         // MrFuzzy.MAX_TYPED
constexpr int kMaxExtraDepth = 3;     // MrFuzzy.MAX_EXTRA_DEPTH
constexpr int kMaxResults = 5;        // MrFuzzy.MAX_RESULTS
constexpr int kMaxWord = 48;          // MrFuzzy.MAX_WORD
constexpr int kInf = 1 << 20;         // MrFuzzy.INF
constexpr int kNear = 16;             // vizinhos guardados por toque
constexpr int kResultChars = kMaxWord * 2 + 2;  // tamanho do buffer de cada resultado (palavra + espaço + palavra)
constexpr int kPowTable = 256;        // custos 0..255 têm 2^(-c/25) vindo do Java

// Custos (x100) e limites. A ordem é a de MrNative.COSTS no Java; mude as duas juntas.
struct Costs {
    int prox1, prox2, proxFar, delFirst, phon, vowel, sub;
    int ins, insDouble, insH, insNear, del, delDouble;
    int trans, multi, split, nodeBudget;
    static constexpr int kCount = 17;
};

// Tabelas que não dependem do idioma. Vêm do Java (Character/MrText) para valer o mesmo que lá em
// qualquer versão do Android.
struct Tables {
    Costs costs{};
    std::vector<char16_t> lower;    // 65536: Character.toLowerCase
    std::vector<uint8_t> upper;     // 65536: Character.isUpperCase (0/1)
    char16_t base256[256] = {0};    // MrText.base para 0..255
    double pow2[kPowTable] = {0};   // Math.pow(2.0, -c / 25.0), calculado pelo Java

    char16_t baseOf(int c) const { return c < 256 ? base256[c] : lower[c & 0xFFFF]; }
    char16_t lowerOf(int c) const { return lower[c & 0xFFFF]; }
    bool isUpper(int c) const { return upper[c & 0xFFFF] != 0; }
};

// Regras do idioma (as tabelas de MrRules.java).
struct Rules {
    std::vector<uint8_t> pairs = std::vector<uint8_t>(65536, 0);  // [(a << 8) | b]: 1 fonética, 2 vogal
    std::vector<char16_t> t2a, t2b, t2d;   // grupos: digitado (2 letras) -> dicionário (1)
    std::vector<char16_t> d2p, d2c, d2t;   // grupos: dicionário (2 letras) -> digitado (1)
    std::vector<char16_t> silPrev, silChar;
    std::vector<int16_t> silCost;
    int16_t silentStart[256] = {0};
    int16_t silentAny[256] = {0};
    bool extra[256] = {false};
    bool oneLetter[256] = {false};

    int pair(int a, int b) const {
        if (a >= 256 || b >= 256) return 0;
        return pairs[(a << 8) | b];
    }
};

// Busca aproximada no trie do .dict (mesmo formato de dictionary.cpp). Uma instância por vez: o Java já
// serializa as consultas (synchronized) e a JNI trava um mutex.
class Fuzzy {
public:
    // dict: bytes do .dict (somente leitura, vivo durante a chamada). size: tamanho em bytes.
    void attach(const uint8_t* dict, int size);

    // tb: letras digitadas sem acento/caixa (n entre 1 e kMaxTyped); near: n x kNear letras vizinhas de cada
    // toque; nearCount: quantas há em cada. Não lança.
    void search(const Tables& t, const Rules& r, const char16_t* tb, int n, const char16_t* near, const int* nearCount);

    int count() const { return resCount_; }
    int wordLen(int i) const { return resLen_[i]; }
    const char16_t* word(int i) const { return resWord_[i]; }
    int64_t score(int i) const { return resScore_[i]; }
    int cost(int i) const { return resCost_[i]; }
    int visits() const { return visits_; }

private:
    void walk(int pos, int depth, int pcb, int parentRaw);
    void walkRoot();
    bool isPrefix() const;
    bool prefixRec(int pos, int j) const;
    int skipBigrams(int pos) const;
    void firstLetters();
    int sub(int j, int cb);
    int subCost(int cb, int j) const;
    int insCost(int j) const;
    int delCost(int cb, int pcb, int depth) const;
    int nearRank(int j, int cb) const;
    bool isNear(int j, int cb) const;
    int64_t scoreFor(int freq, int cost) const;
    void offer(const char16_t* word, int len, int freq, int cost);
    void insert(const char16_t* word, int len, int64_t score, int cost);
    void removeAt(int i);
    void setMaxCost(int max);
    void split();
    int lookup(int from, int to);
    void lookupRec(int pos, int j, int to, int depth);

    int dat(int pos) const { return dict_[pos]; }

    const uint8_t* dict_ = nullptr;
    int size_ = 0;
    bool latest_ = false;
    int root_ = 0;
    const Tables* t_ = nullptr;
    const Rules* r_ = nullptr;

    int n_ = 0;
    char16_t tb_[kMaxTyped] = {0};
    char16_t near_[kMaxTyped][kNear] = {{0}};
    int nearCount_[kMaxTyped] = {0};
    int16_t sub_[kMaxTyped][256];
    int ins_[kMaxTyped] = {0};
    bool first_[256] = {false};
    char16_t twoD1_[kMaxTyped + 1] = {0};
    char16_t twoD2_[kMaxTyped + 1] = {0};
    int rows_[kMaxTyped + kMaxExtraDepth + 2][kMaxTyped + 1] = {{0}};
    int rowsLen_ = kMaxTyped + kMaxExtraDepth + 2;
    char16_t path_[kMaxWord + 2] = {0};
    int maxCost_ = 0;
    int band_ = 0;
    int visits_ = 0;
    int onlyTyped_ = 0;   // na raiz: 1 = só a inicial digitada, 2 = só as outras aceitas, 3 = só a que faltou, 0 = todas

    int resCount_ = 0;
    char16_t resWord_[kMaxResults][kResultChars] = {{0}};
    int resLen_[kMaxResults] = {0};
    int64_t resScore_[kMaxResults] = {0};
    int resCost_[kMaxResults] = {0};

    char16_t splitBuf_[kResultChars] = {0};
    char16_t leftBuf_[kMaxWord + 1] = {0};
    char16_t lookBuf_[kMaxWord + 1] = {0};
    char16_t lookPath_[kMaxWord + 1] = {0};
    int lookFreq_ = 0;
    int lookLen_ = 0;
    // Teto de nós das buscas recursivas que não passam pelo walk (isPrefix e o lookup do split). Num dicionário de verdade
    // elas visitam no máximo algumas centenas de nós (medido: 41 e 379 em 43 mil consultas); num arquivo estragado, com
    // ponteiros em ciclo e letras repetidas, cresceriam exponencialmente e travariam o teclado.
    mutable int guard_ = 0;
};

// trigrams.bin (formato MRT1, big-endian; docs/tools/make_trigrams.py no app). O arquivo é lido inteiro para a
// memória (3 MB) e só os índices (4 bytes por palavra e por contexto) ficam à parte. Não usa mmap de propósito:
// se um pacote novo trocasse o arquivo no lugar, a leitura de uma página mapeada derrubaria o app (SIGBUS).
class TriStore {
public:
    // false se o arquivo não existe, não é MRT1, está truncado, fora de ordem ou com ids inválidos.
    bool open(const char* path);
    // O mesmo de open() para bytes já em memória (testes). Copia.
    bool openBytes(const uint8_t* data, size_t size);
    bool isOpen() const { return !data_.empty(); }

    struct Hit {
        uint32_t id;
        int score;
    };
    // Continuações de (w1, w2). a1/a2 são as grafias de w1 (como veio e em minúscula), b1/b2 as de w2, em UTF-8
    // (nulas ou repetidas são aceitas). Tenta (a1,b1) (a1,b2) (a2,b1) (a2,b2) e devolve o 1º contexto achado
    // (como MrTrigram.find). Devolve quantas (até max).
    int find(const std::string* a1, const std::string* a2, const std::string* b1, const std::string* b2,
             int max, Hit* out) const;
    // Bytes UTF-8 da palavra id (sem terminador). false se id inválido.
    bool wordBytes(uint32_t id, const uint8_t** p, int* len) const;

    size_t contexts() const { return ctx_.size(); }
    size_t vocabulary() const { return word_.size(); }
    size_t indexBytes() const { return (ctx_.size() + word_.size()) * sizeof(uint32_t); }

private:
    bool parse();
    int wordId(const std::string& w) const;
    uint32_t be24(size_t p) const { return (uint32_t(data_[p]) << 16) | (uint32_t(data_[p + 1]) << 8) | data_[p + 2]; }

    std::vector<uint8_t> data_;
    std::vector<uint32_t> word_;   // posição do byte de tamanho de cada palavra
    std::vector<uint32_t> ctx_;    // posição de cada contexto
};

// Conversões UTF-16 <-> UTF-8 (a JNI usa UTF-8 modificado, que não serve para emoji).
std::string toUtf8(const char16_t* s, int len);
int fromUtf8(const uint8_t* s, int len, char16_t* out, int maxOut);

}  // namespace mr
