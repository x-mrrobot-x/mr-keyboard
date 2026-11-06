package com.mrkeyboard.app;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

/**
 * PC test of the rules behind the screens "What the keyboard learned" and "Add words and texts" (MrLearned on a MrMemStore, v1.85): saving an import
 * with its caps, undo, block, forget, edit, the export that is also the backup, and what the keyboard loads. The SQLite store (MrSqlStore) needs
 * Android and is checked on the device (checklist in docs/suggestion-features.md). Runs through docs/tools/run_java_tests.sh.
 */
public class LearnedStoreTest {
    static int ok = 0, fail = 0;
    static final String L = "pt_BR";

    static void check(String name, boolean cond) {
        if (cond) { ok++; System.out.println("OK    " + name); }
        else { fail++; System.out.println("FAIL  " + name); }
    }

    static MrWordStore.Row row(int kind, String a, String b, int freq) {
        return new MrWordStore.Row(kind, a, b, freq, 0, 0);
    }

    static final class Rec implements MrLearned.Sink {
        final int kind;
        final List<String> got = new ArrayList<String>();

        Rec(int kind) {
            this.kind = kind;
        }

        public int kind() {
            return kind;
        }

        public void word(String w, int f) {
            got.add(w + ":" + f);
        }

        public void pair(String a, String b, int f) {
            got.add(a + " " + b + ":" + f);
        }
    }

    static MrImport.Known known(String... words) {
        final HashSet<String> set = new HashSet<String>(Arrays.asList(words));
        return new MrImport.Known() {
            public boolean knows(String w) {
                return set.contains(w);
            }
        };
    }

    static List<CharSequence> strip(String... s) {
        return new ArrayList<CharSequence>(Arrays.asList((CharSequence[]) s));
    }

    public static void main(String[] a) {
        MrImport.Known pt = known("vou", "ver", "a", "o", "bom", "dia", "de", "reunião", "hoje", "usar");

        // ---------------------------------------------------------------- saving an import
        MrMemStore st = new MrMemStore();
        MrLearned.useStore(st);
        MrImport.Plan plan = MrImport.parse("vou usar o zap hoje. vou ver o zap hoje. Marina e Clara. Vou ver a Marina hoje.", pt);
        long now = 1000;
        MrLearned.Result r = MrLearned.apply(st, plan, L, now);
        check("an import saves the words and the pairs of the plan", r.words == plan.words.size() && r.pairs == plan.pairs.size() && r.words >= 2 && r.pairs >= 1);
        check("... with one batch number and the date", r.batch > 0 && st.all(MrWordStore.KIND_IMPORTED_WORD, L).get(0).batch == r.batch
                && st.all(MrWordStore.KIND_IMPORTED_WORD, L).get(0).added == now);
        check("counts per kind", MrLearned.counts(st, L)[MrWordStore.KIND_IMPORTED_WORD] == r.words && MrLearned.counts(st, L)[MrWordStore.KIND_IMPORTED_PAIR] == r.pairs
                && MrLearned.counts(st, L)[MrWordStore.KIND_LEARNED_WORD] == 0);
        check("nothing is saved for another language", st.count(MrWordStore.KIND_IMPORTED_WORD, "en_US") == 0);
        MrLearned.Result again = MrLearned.apply(st, plan, L, now + 1);
        check("importing the same material again adds nothing (counted as already there)", again.total() == 0 && again.dupWords == r.words && again.dupPairs == r.pairs && again.batch == 0);

        // unticked words and their pairs
        MrMemStore st2 = new MrMemStore();
        MrImport.Plan p2 = MrImport.parse("[phrases]\nMaria Clara\nClara Souza\n", pt);
        for (MrImport.NewWord w : p2.words) if (w.word.equals("Clara")) w.checked = false;
        MrLearned.Result r2 = MrLearned.apply(st2, p2, L, now);
        check("an unticked word is not saved, and no pair that has it", r2.words == 2 && r2.pairs == 0 && st2.count(MrWordStore.KIND_IMPORTED_PAIR, L) == 0);

        // undo
        MrMemStore st3 = new MrMemStore();
        st3.add(MrWordStore.KIND_LEARNED_WORD, L, row(MrWordStore.KIND_LEARNED_WORD, "learned", null, 250));
        MrLearned.Result first = MrLearned.apply(st3, MrImport.parse("[words]\nalfa\nbeta\n[phrases]\nalfa beta\n", pt), L, now);
        MrLearned.Result second = MrLearned.apply(st3, MrImport.parse("[words]\ngama\n", pt), L, now + 5);
        check("two imports have two batches", first.batch > 0 && second.batch > first.batch);
        int undone = MrLearned.undo(st3, L, second.batch);
        check("undo takes back only that import (1 word)", undone == 1 && st3.count(MrWordStore.KIND_IMPORTED_WORD, L) == 2);
        check("... and never touches what was learned", st3.count(MrWordStore.KIND_LEARNED_WORD, L) == 1);
        check("undo of a batch that is not there does nothing", MrLearned.undo(st3, L, 12345) == 0 && MrLearned.undo(st3, L, 0) == 0);

        // caps
        MrMemStore full = new MrMemStore();
        for (int i = 0; i < MrLearned.IMPORT_MAX_WORDS - 2; i++) full.add(MrWordStore.KIND_IMPORTED_WORD, L, row(MrWordStore.KIND_IMPORTED_WORD, "w" + i, null, 50));
        for (int i = 0; i < MrLearned.IMPORT_MAX_PAIRS - 1; i++) full.add(MrWordStore.KIND_IMPORTED_PAIR, L, row(MrWordStore.KIND_IMPORTED_PAIR, "p" + i, "q" + i, 50));
        for (int i = 0; i < 10000; i++) full.add(MrWordStore.KIND_LEARNED_PAIR, L, row(MrWordStore.KIND_LEARNED_PAIR, "x" + i, "y" + i, 3));
        MrLearned.Result cap = MrLearned.apply(full, MrImport.parse("[words]\nnewa\nnewb\nnewc\n[phrases]\nnewa newb newc\n", pt), L, now);
        check("the cap of imported words stops the import (2 saved, 1 left out)", cap.words == 2 && cap.cappedWords == 1);
        check("the cap of imported pairs stops the import (1 saved, 1 left out)", cap.pairs == 1 && cap.cappedPairs == 1);
        check("an import never evicts what was learned (10,000 pairs stay)", full.count(MrWordStore.KIND_LEARNED_PAIR, L) == 10000);
        check("the caps are 20,000 words and 30,000 pairs", MrLearned.IMPORT_MAX_WORDS == 20000 && MrLearned.IMPORT_MAX_PAIRS == 30000);

        // ---------------------------------------------------------------- block, forget, edit
        MrMemStore b = new MrMemStore();
        b.add(MrWordStore.KIND_LEARNED_WORD, L, row(MrWordStore.KIND_LEARNED_WORD, "Spoilerx", null, 100));
        b.add(MrWordStore.KIND_LEARNED_WORD, L, row(MrWordStore.KIND_LEARNED_WORD, "outro", null, 100));
        b.add(MrWordStore.KIND_LEARNED_PAIR, L, row(MrWordStore.KIND_LEARNED_PAIR, "bom", "spoilerx", 30));
        b.add(MrWordStore.KIND_LEARNED_PAIR, L, row(MrWordStore.KIND_LEARNED_PAIR, "bom", "dia", 30));
        b.add(MrWordStore.KIND_IMPORTED_WORD, L, row(MrWordStore.KIND_IMPORTED_WORD, "spoilerx", null, 50));
        b.add(MrWordStore.KIND_IMPORTED_PAIR, L, row(MrWordStore.KIND_IMPORTED_PAIR, "spoilerx", "dia", 50));
        int removed = MrLearned.block(b, L, "spoilerx", now);
        check("block deletes the word from what was learned and imported, and its pairs (4 rows)", removed == 4 && b.count(MrWordStore.KIND_LEARNED_WORD, L) == 1
                && b.count(MrWordStore.KIND_LEARNED_PAIR, L) == 1 && b.count(MrWordStore.KIND_IMPORTED_WORD, L) == 0 && b.count(MrWordStore.KIND_IMPORTED_PAIR, L) == 0);
        check("... and puts it on the block list once, even if blocked again with another case", b.count(MrWordStore.KIND_BLOCKED, L) == 1
                && MrLearned.block(b, L, "SPOILERX", now) == 0 && b.count(MrWordStore.KIND_BLOCKED, L) == 1);
        check("block refuses what is not a word", MrLearned.block(b, L, "two words", now) == -1 && MrLearned.block(b, L, "x1", now) == -1);
        MrLearned.refreshBlocked(b, L);
        check("a blocked word is recognised, any case", MrLearned.isBlocked("spoilerx") && MrLearned.isBlocked("Spoilerx") && !MrLearned.isBlocked("outro"));
        List<CharSequence> list = strip("spoilerx", "Spoilerx", "outro", "dia");
        boolean firstGone = MrLearned.filter(list);
        check("the strip loses the blocked words but keeps the typed one in front", list.size() == 3 && "spoilerx".equals(list.get(0).toString())
                && "outro".equals(list.get(1).toString()) && firstGone);
        list = strip("zz", "outro", "dia");
        check("nothing blocked in the list: it stays as it is", !MrLearned.filter(list) && list.size() == 3);
        MrLearned.Result blocked = MrLearned.apply(b, MrImport.parse("[words]\nSpoilerx\nnovo\n", pt), L, now);
        check("an import skips a blocked word", blocked.words == 1 && blocked.blockedSkipped == 1);
        check("unblock", MrLearned.unblock(b, b.all(MrWordStore.KIND_BLOCKED, L).get(0).id) && b.count(MrWordStore.KIND_BLOCKED, L) == 0);
        MrLearned.refreshBlocked(b, L);
        check("... and the word is no longer blocked", !MrLearned.isBlocked("spoilerx"));
        MrMemStore b2 = new MrMemStore();
        MrLearned.apply(b2, MrImport.parse("[blocked]\nlixo\nsujeira\n", pt), L, now);
        check("a [blocked] section of an import blocks the words", b2.count(MrWordStore.KIND_BLOCKED, L) == 2);

        MrMemStore e = new MrMemStore();
        long id = e.add(MrWordStore.KIND_LEARNED_WORD, L, row(MrWordStore.KIND_LEARNED_WORD, "Nubamk", null, 77));
        MrWordStore.Row rw = e.all(MrWordStore.KIND_LEARNED_WORD, L).get(0);
        check("edit fixes a typo and keeps the use", MrLearned.edit(e, L, rw, "Nubank") == 0 && e.count(MrWordStore.KIND_LEARNED_WORD, L) == 1
                && e.all(MrWordStore.KIND_LEARNED_WORD, L).get(0).a.equals("Nubank") && e.all(MrWordStore.KIND_LEARNED_WORD, L).get(0).freq == 77);
        rw = e.all(MrWordStore.KIND_LEARNED_WORD, L).get(0);
        check("edit refuses a text that is not a word, and changes nothing", MrLearned.edit(e, L, rw, "two words") == MrImport.R_SPACE && MrLearned.edit(e, L, rw, "n1") == MrImport.R_NUMBER
                && e.all(MrWordStore.KIND_LEARNED_WORD, L).get(0).a.equals("Nubank"));
        e.add(MrWordStore.KIND_IMPORTED_PAIR, L, new MrWordStore.Row(MrWordStore.KIND_IMPORTED_PAIR, "Maria", "Clraa", 60, 7, 99));
        MrWordStore.Row pr = e.all(MrWordStore.KIND_IMPORTED_PAIR, L).get(0);
        check("edit of a pair takes 'first second' and keeps weight and import", MrLearned.edit(e, L, pr, "Maria Clara") == 0
                && e.all(MrWordStore.KIND_IMPORTED_PAIR, L).get(0).b.equals("Clara") && e.all(MrWordStore.KIND_IMPORTED_PAIR, L).get(0).batch == 7
                && e.all(MrWordStore.KIND_IMPORTED_PAIR, L).get(0).freq == 60);
        pr = e.all(MrWordStore.KIND_IMPORTED_PAIR, L).get(0);
        check("edit of a pair needs exactly two words", MrLearned.edit(e, L, pr, "Maria") == MrImport.R_CHARS && MrLearned.edit(e, L, pr, "a b c") == MrImport.R_CHARS);
        check("forget deletes one row", MrLearned.forget(e, MrWordStore.KIND_LEARNED_WORD, e.all(MrWordStore.KIND_LEARNED_WORD, L).get(0).id) && e.count(MrWordStore.KIND_LEARNED_WORD, L) == 0);
        check("delete all learned and all imported", MrLearned.deleteAllImported(e, L) == 1 && MrLearned.deleteAllLearned(e, L) == 0);

        // ---------------------------------------------------------------- listing
        MrMemStore ls = new MrMemStore();
        String[] names = {"Itaú", "casa", "Nubank", "zap", "carro"};
        int[] uses = {10, 90, 40, 90, 5};
        for (int i = 0; i < names.length; i++) ls.add(MrWordStore.KIND_LEARNED_WORD, L, row(MrWordStore.KIND_LEARNED_WORD, names[i], null, uses[i]));
        ls.add(MrWordStore.KIND_LEARNED_WORD, "en_US", row(MrWordStore.KIND_LEARNED_WORD, "other", null, 1));
        List<MrWordStore.Row> byUse = ls.list(MrWordStore.KIND_LEARNED_WORD, L, null, MrWordStore.SORT_USED, 0, 10);
        check("most used first, a tie goes to the newest (zap before casa)", byUse.size() == 5 && byUse.get(0).a.equals("zap") && byUse.get(1).a.equals("casa") && byUse.get(4).a.equals("carro"));
        List<MrWordStore.Row> byNew = ls.list(MrWordStore.KIND_LEARNED_WORD, L, null, MrWordStore.SORT_NEW, 0, 10);
        check("newest first", byNew.get(0).a.equals("carro") && byNew.get(4).a.equals("Itaú"));
        check("pages: offset and limit", ls.list(MrWordStore.KIND_LEARNED_WORD, L, null, MrWordStore.SORT_NEW, 1, 2).size() == 2
                && ls.list(MrWordStore.KIND_LEARNED_WORD, L, null, MrWordStore.SORT_NEW, 1, 2).get(0).a.equals("zap")
                && ls.list(MrWordStore.KIND_LEARNED_WORD, L, null, MrWordStore.SORT_NEW, 9, 2).isEmpty());
        check("search ignores accent and case ('itau' finds Itaú, 'CAR' finds carro and casa? no, only carro)", ls.list(MrWordStore.KIND_LEARNED_WORD, L, "itau", 0, 0, 10).size() == 1
                && ls.list(MrWordStore.KIND_LEARNED_WORD, L, "CAR", 0, 0, 10).size() == 1);
        check("rows of another language are not listed", ls.list(MrWordStore.KIND_LEARNED_WORD, L, "other", 0, 0, 10).isEmpty() && ls.locales().size() == 2);

        // ---------------------------------------------------------------- the export is the backup
        MrMemStore src = new MrMemStore();
        src.add(MrWordStore.KIND_LEARNED_WORD, L, row(MrWordStore.KIND_LEARNED_WORD, "Zeca", null, 250));
        src.add(MrWordStore.KIND_LEARNED_WORD, L, row(MrWordStore.KIND_LEARNED_WORD, "pouco", null, 2));
        src.add(MrWordStore.KIND_IMPORTED_WORD, L, row(MrWordStore.KIND_IMPORTED_WORD, "Nubank", null, 50));
        src.add(MrWordStore.KIND_IMPORTED_WORD, L, row(MrWordStore.KIND_IMPORTED_WORD, "Itaú", null, 70));
        src.add(MrWordStore.KIND_IMPORTED_WORD, L, row(MrWordStore.KIND_IMPORTED_WORD, "raro", null, 1));
        src.add(MrWordStore.KIND_LEARNED_PAIR, L, row(MrWordStore.KIND_LEARNED_PAIR, "bom", "dia", 40));
        src.add(MrWordStore.KIND_LEARNED_PAIR, L, row(MrWordStore.KIND_LEARNED_PAIR, "bom", "tarde", 3));
        src.add(MrWordStore.KIND_IMPORTED_PAIR, L, row(MrWordStore.KIND_IMPORTED_PAIR, "vou", "ver", 50));
        src.add(MrWordStore.KIND_BLOCKED, L, row(MrWordStore.KIND_BLOCKED, "lixo", null, 0));
        String t1 = MrLearned.export(src, L);
        check("export header and sections", t1.startsWith("# mr-words 1\n# language: pt-BR\n[words]\n") && t1.contains("[phrases]\n") && t1.contains("[blocked]\nlixo\n"));
        check("export: weights (default left out), learned words with enough use only", t1.contains("\nNubank\n") && t1.contains("\nItaú\t70\n") && t1.contains("\nraro\t1\n")
                && t1.contains("\nZeca\t100\n") && !t1.contains("pouco"));
        check("export: pairs as phrases, only the ones used enough", t1.contains("\nbom dia\n") && t1.contains("\nvou ver\n") && !t1.contains("bom tarde"));
        MrImport.Known all = known("bom", "dia", "vou", "ver");
        MrMemStore dst = new MrMemStore();
        MrImport.Plan back = MrImport.parse(t1, all);
        check("the export is a standard list that imports without a line left out", back.standard && back.ignoredCount == 0 && "pt-BR".equals(back.languageHint));
        MrLearned.apply(dst, back, L, now);
        String t2 = MrLearned.export(dst, L);
        check("export -> import -> export gives the same text (the backup is exact)", t1.equals(t2));
        MrMemStore dst2 = new MrMemStore();
        MrLearned.apply(dst2, MrImport.parse(t2, known()), L, now);
        String t3 = MrLearned.export(dst2, L);
        check("... and the second round is stable even when the dictionary knows none of the words", MrLearned.export(dst2, L).equals(MrLearned.export(
                dst2, L)) && t3.contains("\nbom dia\n"));
        check("language tags", MrLearned.tag("pt_BR").equals("pt-BR") && MrLearned.localeOf("en-US").equals("en_US") && MrLearned.localeOf("es").equals("es"));

        // ---------------------------------------------------------------- what the keyboard loads
        MrMemStore kb = new MrMemStore();
        kb.add(MrWordStore.KIND_IMPORTED_WORD, L, row(MrWordStore.KIND_IMPORTED_WORD, "Nubank", null, 50));
        kb.add(MrWordStore.KIND_IMPORTED_WORD, L, row(MrWordStore.KIND_IMPORTED_WORD, "Itaú", null, 100));
        kb.add(MrWordStore.KIND_IMPORTED_WORD, L, row(MrWordStore.KIND_IMPORTED_WORD, "raro", null, 1));
        kb.add(MrWordStore.KIND_IMPORTED_WORD, L, row(MrWordStore.KIND_IMPORTED_WORD, "lixo", null, 50));
        kb.add(MrWordStore.KIND_IMPORTED_PAIR, L, row(MrWordStore.KIND_IMPORTED_PAIR, "Maria", "Clara", 50));
        kb.add(MrWordStore.KIND_IMPORTED_PAIR, L, row(MrWordStore.KIND_IMPORTED_PAIR, "lixo", "dia", 50));
        kb.add(MrWordStore.KIND_BLOCKED, L, row(MrWordStore.KIND_BLOCKED, "lixo", null, 0));
        kb.add(MrWordStore.KIND_IMPORTED_WORD, "en_US", row(MrWordStore.KIND_IMPORTED_WORD, "other", null, 50));
        Rec words = new Rec(0), pairs = new Rec(1);
        MrLearned.useStore(kb);
        MrLearned.loadFrom(kb, words, L);
        MrLearned.loadFrom(kb, pairs, L);
        check("the dictionary of words gets the imported words of its language, scaled (weight 50 = 130, 100 = 250, 1 = 6, the minimum that is valid)",
                words.got.equals(Arrays.asList("Nubank:130", "Itaú:250", "raro:6")));
        check("the blocked word is not loaded, and not its pairs", !words.got.toString().contains("lixo") && pairs.got.equals(Arrays.asList("Maria Clara:6")));
        check("the pair frequency stays inside the measured 4-9 of the user pairs", MrLearned.pairFreq(1) == 4 && MrLearned.pairFreq(50) == 6
                && MrLearned.pairFreq(100) == 9 && MrLearned.pairFreq(1000) == 9 && MrLearned.pairFreq(0) == 4);
        final int[] seen = {0, 0};
        Dictionary.WordCallback gate = MrLearned.gate(new Dictionary.WordCallback() {
            public boolean addWord(char[] word, int wordOffset, int wordLength, int frequency, int dicTypeId, Dictionary.DataType dataType) {
                seen[0]++;
                seen[1] = frequency;
                return false;
            }
        });
        boolean keepOn = gate.addWord("ana".toCharArray(), 0, 3, 5, 3, Dictionary.DataType.UNIGRAM);
        check("the gate keeps a word typed once or twice (frequency 5) out of the strip and the search goes on", keepOn && seen[0] == 0);
        gate.addWord("ana".toCharArray(), 0, 3, 6, 3, Dictionary.DataType.UNIGRAM);
        check("the gate lets an accepted word (frequency 6) through, with its frequency", seen[0] == 1 && seen[1] == 6);
        check("the word frequency grows with the weight and stays inside 6-250", MrLearned.wordFreq(50) == 130 && MrLearned.wordFreq(100) == 250
                && MrLearned.wordFreq(1) == 6 && MrLearned.wordFreq(1000) == 250 && MrLearned.wordFreq(20) < MrLearned.wordFreq(50));
        MrLearned.load(null, words, L);
        MrLearned.load(null, null, L);
        check("load without a store or a sink does not throw", true);

        System.out.println(fail == 0 ? "ALL OK (" + ok + " checks)" : fail + " FAILURE(S)");
        if (fail != 0) System.exit(1);
    }
}
