// Testes do motor nativo no PC (sem Java, sem Android). Uso: mr_test pasta_dicts [rodadas_de_estrago]
//   pasta_dicts: a pasta dicts/ do projeto (pt-BR/, en-US/, es/ com main.dict, trigrams.bin)
//
// O que este programa prova:
//   1. a busca sobre o dicionário de verdade acha correções óbvias (confere "contém", não o resultado exato);
//   2. a consulta não depende do que veio antes (estado antigo da programação dinâmica não vaza);
//   3. dicionário e trigrams.bin estragados (cortados, bytes trocados, lixo): nada pode cair, ler fora do arquivo ou travar;
//   4. caractere de 2 bytes (0xFF + 2) no dicionário, UTF-8, limites, arquivos de trigramas inválidos.
// O que NÃO prova: resultado igual ao do Java. Isso é do docs/tools/e2e/NativeParity.java (ao vivo, com as tabelas do Java).
// Com -DMR_SANITIZE=ON os acessos fora do limite e o comportamento indefinido viram erro.
#include <algorithm>
#include <chrono>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

#include "mr_engine.h"
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
            std::printf("FALHA %s:%d: ", __FILE__, __LINE__); \
            std::printf(__VA_ARGS__);                         \
            std::printf("\n");                                \
        }                                                     \
    } while (0)

struct Lang {
    const char* id;
    // digitado -> palavra que tem de aparecer entre os (até 5) resultados
    std::vector<std::pair<std::string, std::string>> cases;
    std::vector<std::string> extra;   // consultas só para o estrago e para a independência de ordem
    std::vector<std::pair<std::string, std::string>> pairs;   // pares de trigramas comuns (ao menos um tem continuação)
};

std::vector<Lang> languages() {
    return {
        {"pt-BR",
         {{"obrigdo", "obrigado"}, {"sepre", "sempre"}, {"durate", "durante"}, {"vda", "vida"}, {"porisso", "por isso"}},
         {"agoa", "prte", "trabakho", "pesquiza", "hospitl", "conciencia", "qeu", "naoseiseeuvou", "ç", "Fernanda", "ÁGUA",
          "aaaaaaaaaaaaaaaaaaaa", "xyzxyzxyzxyz", "omem", "jente", "excessao", "cançado", "obrigaod", "dis", "alomde"},
         {{"de", "acordo"}, {"por", "causa"}, {"no", "entanto"}, {"em", "relação"}, {"o", "que"}, {"não", "é"}}},
        {"en-US",
         {{"recieve", "receive"}, {"wich", "which"}, {"definately", "definitely"}, {"seperate", "separate"}, {"becuase", "because"}},
         {"teh", "adn", "tommorow", "occured", "untill", "thier", "freind", "writting", "Monday", "I", "xyzxyzxyzxyz",
          "aaaaaaaaaaaaaaaaaaaa", "alot", "cantbe", "wouldnt", "goverment", "arguement", "comming"},
         {{"of", "the"}, {"in", "the"}, {"it", "is"}, {"to", "be"}, {"going", "to"}, {"i", "am"}}},
        {"es",
         {{"ecuela", "escuela"}, {"tambien", "también"}, {"porfavor", "por favor"}, {"hablr", "hablar"}, {"trabjo", "trabajo"}},
         {"ahcer", "mañna", "nesesito", "kiero", "aver", "ablar", "grasias", "Madrid", "ñandú", "xyzxyzxyzxyz",
          "aaaaaaaaaaaaaaaaaaaa", "pais", "estoy", "undia", "deacuerdo", "ademas"},
         {{"de", "la"}, {"en", "el"}, {"que", "se"}, {"es", "un"}, {"a", "la"}, {"por", "favor"}}},
    };
}

bool contains(const Fuzzy& f, const std::string& want) {
    for (int i = 0; i < f.count(); i++) {
        if (toUtf8(f.word(i), f.wordLen(i)) == want) return true;
    }
    return false;
}

void realDictionary(const std::string& dicts, const Lang& lang, const Tables& tables, const Rules& rules) {
    std::string dir = dicts + "/" + lang.id;
    auto dict = readFile(dir + "/main.dict");
    CHECK(!dict.empty(), "sem %s/main.dict", dir.c_str());
    if (dict.empty()) return;
    auto rows = keyRows(lang.id);
    Fuzzy f;
    f.attach(dict.data(), static_cast<int>(dict.size()));

    // 1) correções óbvias
    int found = 0;
    for (const auto& c : lang.cases) {
        Query q;
        CHECK(makeQuery(tables, c.first, rows, &q), "consulta");
        f.search(tables, rules, q.tb, q.n, q.near, q.cnt);
        bool ok = contains(f, c.second);
        found += ok ? 1 : 0;
        if (!ok) std::printf("  (aviso) %s: %s não trouxe %s: %s\n", lang.id, c.first.c_str(), c.second.c_str(), render(f).c_str());
        // lista bem formada: no máximo 5, pontuação em ordem decrescente, sem repetida
        CHECK(f.count() <= kMaxResults, "mais de %d resultados", kMaxResults);
        for (int i = 1; i < f.count(); i++) CHECK(f.score(i - 1) >= f.score(i), "pontuação fora de ordem em %s", c.first.c_str());
        for (int i = 0; i < f.count(); i++)
            for (int j = i + 1; j < f.count(); j++)
                CHECK(!(f.wordLen(i) == f.wordLen(j) && std::memcmp(f.word(i), f.word(j), sizeof(char16_t) * f.wordLen(i)) == 0),
                      "resultado repetido em %s", c.first.c_str());
    }
    // as tabelas e regras daqui são aproximadas: tolera 1 caso a menos, mas a busca tem de funcionar
    CHECK(found >= static_cast<int>(lang.cases.size()) - 1, "%s: só %d de %zu correções óbvias", lang.id, found, lang.cases.size());

    // 2) independência de ordem: o resultado de uma consulta é o mesmo numa instância limpa e numa que já fez outras
    std::vector<std::string> words;
    for (const auto& c : lang.cases) words.push_back(c.first);
    for (const auto& w : lang.extra) words.push_back(w);
    std::vector<std::string> alone;
    for (const auto& w : words) {
        Fuzzy fresh;
        fresh.attach(dict.data(), static_cast<int>(dict.size()));
        Query q;
        if (!makeQuery(tables, w, rows, &q)) { alone.push_back(""); continue; }
        fresh.search(tables, rules, q.tb, q.n, q.near, q.cnt);
        alone.push_back(render(fresh));
    }
    Fuzzy busy;
    busy.attach(dict.data(), static_cast<int>(dict.size()));
    int bad = 0;
    for (int pass = 0; pass < 2; pass++) {
        for (size_t k = 0; k < words.size(); k++) {
            size_t i = pass == 0 ? k : words.size() - 1 - k;   // 2ª volta em ordem inversa
            Query q;
            if (!makeQuery(tables, words[i], rows, &q)) continue;
            busy.search(tables, rules, q.tb, q.n, q.near, q.cnt);
            if (render(busy) != alone[i]) {
                bad++;
                if (bad <= 3) std::printf("  DIFERENÇA de ordem %s \"%s\"\n    limpa: %s\n    usada: %s\n", lang.id, words[i].c_str(), alone[i].c_str(), render(busy).c_str());
            }
        }
    }
    CHECK(bad == 0, "%s: %d consultas deram resultado diferente numa instância usada", lang.id, bad);
    std::printf("%-6s dicionário de verdade: %zu correções óbvias (%d achadas), %zu consultas sem dependência de ordem\n", lang.id,
                lang.cases.size(), found, words.size());
}

void realTrigrams(const std::string& dicts, const Lang& lang) {
    TriStore st;
    std::string path = dicts + "/" + lang.id + "/trigrams.bin";
    CHECK(st.open(path.c_str()), "abrir %s", path.c_str());
    CHECK(st.contexts() > 1000 && st.vocabulary() > 1000, "%s: poucos contextos (%zu) ou palavras (%zu)", lang.id, st.contexts(), st.vocabulary());
    int withNext = 0;
    for (const auto& p : lang.pairs) {
        std::string a = p.first, b = p.second;
        TriStore::Hit hits[8];
        int n = st.find(&a, &a, &b, &b, 8, hits);
        CHECK(n >= 0 && n <= 8, "contagem fora do limite");
        for (int i = 0; i < n; i++) {
            const uint8_t* w;
            int len;
            CHECK(st.wordBytes(hits[i].id, &w, &len) && len > 0, "id de continuação inválido");
            CHECK(hits[i].score >= 0 && hits[i].score <= 255, "pontuação fora de 0..255");
        }
        if (n > 0) withNext++;
    }
    CHECK(withNext >= 1, "%s: nenhum dos pares comuns tem continuação (formato mudou?)", lang.id);
    std::printf("%-6s trigramas de verdade: %zu palavras, %zu contextos, %zu bytes de índice, %d de %zu pares comuns com continuação\n", lang.id,
                st.vocabulary(), st.contexts(), st.indexBytes(), withNext, lang.pairs.size());
}

// ------------------------------------------------------------------------------------ dados estragados

struct Lcg {
    uint64_t s;
    explicit Lcg(uint64_t seed) : s(seed) {}
    uint32_t next() { s = s * 6364136223846793005ULL + 1442695040888963407ULL; return static_cast<uint32_t>(s >> 33); }
};

void corruptDict(const std::string& dicts, const Lang& lang, const Tables& tables, const Rules& rules, int rounds) {
    auto dict = readFile(dicts + "/" + lang.id + "/main.dict");
    if (dict.empty()) return;
    auto rows = keyRows(lang.id);
    std::vector<Query> qs;
    std::vector<std::string> words;
    for (const auto& c : lang.cases) words.push_back(c.first);
    for (const auto& w : lang.extra) words.push_back(w);
    for (const auto& w : words) {
        Query q;
        if (makeQuery(tables, w, rows, &q)) qs.push_back(q);
    }
    Lcg rnd(0xC0FFEE + std::strlen(lang.id));
    Fuzzy f;
    long searches = 0;
    auto t0 = std::chrono::steady_clock::now();
    for (int r = 0; r < rounds; r++) {
        std::vector<uint8_t> d = dict;
        int mode = static_cast<int>(rnd.next() % 4);
        if (mode == 0) {                       // cortado em qualquer ponto
            d.resize(rnd.next() % (d.size() + 1));
        } else if (mode == 1) {                // alguns bytes trocados
            int k = 1 + static_cast<int>(rnd.next() % 20);
            for (int i = 0; i < k; i++) d[rnd.next() % d.size()] = static_cast<uint8_t>(rnd.next());
        } else if (mode == 2) {                // muitos bytes trocados no começo (raiz e primeiros grupos)
            for (int i = 0; i < 200; i++) d[rnd.next() % std::min<size_t>(d.size(), 4096)] = static_cast<uint8_t>(rnd.next());
        } else {                               // lixo puro
            for (auto& b : d) b = static_cast<uint8_t>(rnd.next());
        }
        if (d.size() <= 2) d.resize(3, 0);
        f.attach(d.data(), static_cast<int>(d.size()));
        for (const Query& q : qs) {
            f.search(tables, rules, q.tb, q.n, q.near, q.cnt);
            searches++;
            CHECK(f.count() >= 0 && f.count() <= kMaxResults, "contagem fora do limite: %d", f.count());
            // o teto é conferido a cada nó, mas cada passada que recomeça conta mais um antes de perceber (igual ao Java)
            CHECK(f.visits() <= tables.costs.nodeBudget + 8, "nós visitados acima do teto: %d", f.visits());
            for (int i = 0; i < f.count(); i++) {
                CHECK(f.wordLen(i) >= 1 && f.wordLen(i) <= kResultChars, "tamanho de palavra inválido: %d", f.wordLen(i));
            }
        }
    }
    double ms = std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now() - t0).count();
    std::printf("%-6s dicionário estragado: %d arquivos, %ld buscas, sem queda; %.2f ms por busca em média\n", lang.id, rounds, searches,
                ms / static_cast<double>(std::max<long>(1, searches)));
}

void corruptTri(const std::string& dicts, const Lang& lang, int rounds) {
    auto tri = readFile(dicts + "/" + lang.id + "/trigrams.bin");
    if (tri.empty()) return;
    Lcg rnd(0xBEEF + std::strlen(lang.id));
    int opened = 0;
    std::string a = "de", b = "casa", c = "Casa";
    for (int r = 0; r < rounds; r++) {
        std::vector<uint8_t> d = tri;
        int mode = static_cast<int>(rnd.next() % 4);
        if (mode == 0) d.resize(rnd.next() % (d.size() + 1));
        else if (mode == 1) { int k = 1 + static_cast<int>(rnd.next() % 8); for (int i = 0; i < k; i++) d[rnd.next() % d.size()] = static_cast<uint8_t>(rnd.next()); }
        else if (mode == 2) { for (int i = 0; i < 12; i++) d[rnd.next() % std::min<size_t>(d.size(), 64)] = static_cast<uint8_t>(rnd.next()); }
        else { for (auto& x : d) x = static_cast<uint8_t>(rnd.next()); }
        TriStore st;
        if (st.openBytes(d.data(), d.size())) {
            opened++;
            // aberto = tudo conferido: qualquer consulta tem de funcionar
            TriStore::Hit hits[8];
            int n = st.find(&a, &b, &b, &c, 8, hits);
            CHECK(n >= 0 && n <= 8, "contagem de trigramas fora do limite");
            for (int i = 0; i < n; i++) {
                const uint8_t* p;
                int len;
                CHECK(st.wordBytes(hits[i].id, &p, &len), "id de continuação inválido depois de aberto");
            }
        }
    }
    std::printf("%-6s trigrams.bin estragado: %d arquivos (%d ainda válidos), sem queda\n", lang.id, rounds, opened);
}

// ----------------------------------------------------------------------------------------- casos de borda

void edgeCases(const Tables& tables) {
    // Dicionário feito à mão no formato "latest": cabeçalho 200,1; raiz em 2.
    //   2: [1] 'a' (filhos em 7)          grupo raiz
    //   7: [2] 'b' term f=100 sem bigramas | 0xFF 0x01 0x51 (ő, U+0151) term f=90 sem bigramas
    const uint8_t d[] = {200, 1,
                         1, 'a', 0x40, 0x00, 0x07,
                         2, 'b', 0x80, 100, 0x00, 0xFF, 0x01, 0x51, 0x80, 90, 0x00};
    Rules rules;
    Fuzzy f;
    f.attach(d, static_cast<int>(sizeof(d)));
    auto rows = keyRows("en-US");
    Query q;
    CHECK(makeQuery(tables, "ab", rows, &q), "consulta");
    f.search(tables, rules, q.tb, q.n, q.near, q.cnt);
    CHECK(f.count() == 1 && toUtf8(f.word(0), f.wordLen(0)) == "ab", "ab: esperava ab, veio %s", render(f).c_str());
    CHECK(makeQuery(tables, "a\xC5\x91", rows, &q), "consulta");
    f.search(tables, rules, q.tb, q.n, q.near, q.cnt);
    CHECK(f.count() == 1 && toUtf8(f.word(0), f.wordLen(0)) == "a\xC5\x91", "aő: esperava aő (caractere de 2 bytes), veio %s", render(f).c_str());

    // tamanhos mínimos e nulos não podem cair
    Fuzzy g;
    g.search(tables, rules, q.tb, q.n, q.near, q.cnt);   // sem attach
    CHECK(g.count() == 0, "sem dicionário deve dar 0 resultados");
    const uint8_t tiny[] = {200, 1};
    g.attach(tiny, 2);
    g.search(tables, rules, q.tb, q.n, q.near, q.cnt);
    CHECK(g.count() == 0, "dicionário de 2 bytes deve dar 0 resultados");

    // UTF-8: ida e volta, par substituto, sequências inválidas
    const char16_t emoji[] = {0xD83D, 0xDE00, u'a', 0x00E7, 0x20AC};
    std::string u8 = toUtf8(emoji, 5);
    CHECK(u8 == "\xF0\x9F\x98\x80" "a" "\xC3\xA7" "\xE2\x82\xAC", "toUtf8 com par substituto");
    char16_t back[16];
    int n = fromUtf8(reinterpret_cast<const uint8_t*>(u8.data()), static_cast<int>(u8.size()), back, 16);
    CHECK(n == 5 && std::memcmp(back, emoji, sizeof(emoji)) == 0, "fromUtf8 de volta");
    const uint8_t bad1[] = {0xE2, 0x82};            // cortado
    CHECK(fromUtf8(bad1, 2, back, 16) >= 1, "UTF-8 cortado dá algo, sem ler fora");
    const uint8_t bad2[] = {0xC0, 0x80, 0xFF, 0xED, 0xA0, 0x80};   // sobrelongo, inválido, substituto
    n = fromUtf8(bad2, 6, back, 16);
    bool allRepl = true;
    for (int i = 0; i < n; i++) if (back[i] != 0xFFFD) allRepl = false;
    CHECK(n >= 1 && allRepl, "UTF-8 inválido vira U+FFFD");
    char16_t tiny16[2];
    CHECK(fromUtf8(reinterpret_cast<const uint8_t*>(u8.data()), static_cast<int>(u8.size()), tiny16, 2) <= 2, "saída pequena não estoura");

    // trigramas: arquivos que não são MRT1
    TriStore st;
    CHECK(!st.open("/nao/existe.bin"), "arquivo inexistente");
    CHECK(!st.openBytes(reinterpret_cast<const uint8_t*>("MRT2aaaaaaaa"), 12), "magic errado");
    const uint8_t zero[12] = {'M', 'R', 'T', '1', 0, 0, 0, 0, 0, 0, 0, 0};
    CHECK(st.openBytes(zero, 12) && st.contexts() == 0 && st.vocabulary() == 0, "arquivo vazio válido");
    const uint8_t outOfOrder[] = {'M', 'R', 'T', '1', 0, 0, 0, 2, 1, 'b', 1, 'a', 0, 0, 0, 0};
    CHECK(!st.openBytes(outOfOrder, sizeof(outOfOrder)), "palavras fora de ordem");
    std::printf("casos de borda ok\n");
}

}  // namespace

int main(int argc, char** argv) {
    if (argc < 2) {
        std::printf("uso: mr_test pasta_dicts [rodadas_de_estrago]\n");
        return 2;
    }
    std::string dicts = argv[1];
    int rounds = argc > 2 ? std::atoi(argv[2]) : 100;
    Tables tables;
    approxTables(tables);
    Rules rules;
    approxRules(rules);
    std::printf("contrato do motor: versão %d, %d custos, teto de nós %d (tabelas e regras aproximadas: a paridade com o Java é do NativeParity)\n",
                kEngineVersion, Costs::kCount, tables.costs.nodeBudget);
    edgeCases(tables);
    std::vector<Lang> langs = languages();
    for (const Lang& l : langs) realDictionary(dicts, l, tables, rules);
    for (const Lang& l : langs) realTrigrams(dicts, l);
    for (const Lang& l : langs) corruptDict(dicts, l, tables, rules, rounds);
    for (const Lang& l : langs) corruptTri(dicts, l, rounds * 4);
    std::printf("%s: %d verificações, %d falhas\n", gFails == 0 ? "OK" : "FALHOU", gChecks, gFails);
    return gFails == 0 ? 0 : 1;
}
