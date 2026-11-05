// Speed of the C++ search with the test queries and the real dictionaries (dicts/). Usage: mr_bench dicts_dir [rounds]
// The comparison with Java (same queries, through the JNI) is in docs/tools/e2e/NativeParity.java.
#include <chrono>
#include <cstdio>
#include <cstdlib>
#include <string>
#include <vector>

#include "test_util.h"

using namespace mr;
using namespace mrtest;

int main(int argc, char** argv) {
    if (argc < 2) {
        std::printf("usage: mr_bench dicts_dir [rounds]\n");
        return 2;
    }
    std::string dicts = argv[1];
    int rounds = argc > 2 ? std::atoi(argv[2]) : 20;
    Tables tables;
    approxTables(tables);
    Rules rules;
    approxRules(rules);
    struct L { const char* id; std::vector<std::string> words; };
    std::vector<L> langs = {
        {"pt-BR", {"obrigdo", "sepre", "durate", "vda", "agoa", "prte", "trabakho", "pesquiza", "hospitl", "conciencia", "qeu", "omem", "jente",
                   "excessao", "obrigaod", "alomde", "porisso", "tambem", "naoseiseeuvou", "xyzxyzxyzxyz"}},
        {"en-US", {"recieve", "wich", "definately", "seperate", "becuase", "teh", "adn", "tommorow", "occured", "untill", "thier", "freind",
                   "writting", "alot", "goverment", "arguement", "comming", "xyzxyzxyzxyz"}},
        {"es", {"ecuela", "tambien", "porfavor", "hablr", "trabjo", "ahcer", "mañna", "nesesito", "kiero", "aver", "ablar", "grasias", "undia",
                "deacuerdo", "xyzxyzxyzxyz"}},
    };
    for (const L& l : langs) {
        auto dict = readFile(dicts + "/" + l.id + "/main.dict");
        if (dict.empty()) { std::printf("%s: no dictionary\n", l.id); continue; }
        auto rows = keyRows(l.id);
        std::vector<Query> qs;
        for (const auto& w : l.words) {
            Query q;
            if (makeQuery(tables, w, rows, &q)) qs.push_back(q);
        }
        Fuzzy f;
        f.attach(dict.data(), static_cast<int>(dict.size()));
        long visits = 0;
        double best = 1e18;
        for (int r = 0; r < rounds; r++) {
            auto t0 = std::chrono::steady_clock::now();
            long v = 0;
            for (const Query& q : qs) {
                f.search(tables, rules, q.tb, q.n, q.near, q.cnt);
                v += f.visits();
            }
            double us = std::chrono::duration<double, std::micro>(std::chrono::steady_clock::now() - t0).count();
            best = std::min(best, us);
            visits = v;
        }
        std::printf("%-6s %zu queries, best round %.1f us per query, %.0f nodes visited per query\n", l.id, qs.size(),
                    best / qs.size(), static_cast<double>(visits) / qs.size());
        std::string tpath = dicts + "/" + l.id + "/trigrams.bin";
        TriStore st;
        auto t0 = std::chrono::steady_clock::now();
        bool ok = st.open(tpath.c_str());
        double ms = std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now() - t0).count();
        std::printf("%-6s trigrams.bin: %s in %.1f ms; file %zu bytes + index %zu bytes\n", l.id, ok ? "open" : "REJECTED", ms,
                    readFile(tpath).size(), st.indexBytes());
    }
    return 0;
}
