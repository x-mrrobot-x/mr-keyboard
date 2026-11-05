package com.mrkeyboard.app;

import java.util.Arrays;
import java.util.List;

/** PC test of the recent words (MrRecent, v1.75). Runs through docs/tools/run_java_tests.sh. */
public class RecentTest {
    static int ok = 0, fail = 0;

    static void check(String name, boolean cond) {
        if (cond) { ok++; System.out.println("OK    " + name); }
        else { fail++; System.out.println("FAIL  " + name); }
    }

    static WordComposer typed(String s) {
        WordComposer wc = new WordComposer();
        for (int i = 0; i < s.length(); i++) wc.add(s.charAt(i), new int[] {s.charAt(i)});
        return wc;
    }

    static List<Object[]> complete(Suggest s, String prefix) {
        s.added.clear();
        MrRecent.complete(s, typed(prefix));
        return s.added;
    }

    static String words(List<Object[]> l) {
        StringBuilder b = new StringBuilder();
        for (Object[] o : l) b.append(o[0]).append(' ');
        return b.toString().trim();
    }

    public static void main(String[] a) {
        Suggest s = new Suggest();
        s.valid.addAll(Arrays.asList("casa", "carro", "cachorro", "de", "reunião", "amanhã", "obrigado", "para"));

        // ---------------------------------------------------------------- recording and completing
        MrRecent.clear();
        MrRecent.record(s, "Maria");
        List<Object[]> r = complete(s, "ma");
        check("name outside the dictionary (Maria) completes with 2 letters, like a dictionary word",
                r.size() == 1 && "Maria".equals(r.get(0)[0]) && r.get(0)[2] == Dictionary.DataType.UNIGRAM
                        && (Integer) r.get(0)[1] == (200 << 2));
        check("without accent or case: 'MA' also finds Maria", words(complete(s, "MA")).equals("Maria"));
        check("prefix that does not match returns nothing", complete(s, "jo").isEmpty());
        check("whole word already typed does not come back", complete(s, "maria").isEmpty());
        r = complete(s, "m");
        check("with 1 letter the name comes in as a bigram, priority up to 127", r.size() == 1
                && r.get(0)[2] == Dictionary.DataType.BIGRAM && (Integer) r.get(0)[1] <= 127 && (Integer) r.get(0)[1] > 0);

        MrRecent.record(s, "obrogado");
        check("outside the dictionary and only lowercase (typo) is not recorded", complete(s, "obr").isEmpty());
        MrRecent.record(s, "Casa");
        check("dictionary word is stored in lowercase", words(complete(s, "ca")).equals("casa"));
        check("with 1 letter only a name/term outside the dictionary: 'c' does not offer casa", complete(s, "c").isEmpty());
        MrRecent.record(s, "iPhone");
        check("brand with a capital in the middle is recorded as written", words(complete(s, "ip")).equals("iPhone"));
        MrRecent.record(s, "NASA");
        check("acronym outside the dictionary is recorded", words(complete(s, "na")).equals("NASA"));

        // ---------------------------------------------------------------- filters
        MrRecent.clear();
        for (String w : new String[] {"ab", "abc123", "com certeza", "1234", "--", "", "   "}) MrRecent.record(s, w);
        StringBuilder longWord = new StringBuilder("Z");
        for (int i = 0; i < 31; i++) longWord.append('a');
        MrRecent.record(s, longWord);
        MrRecent.record(s, null);
        check("short, with a digit, with a space, only symbol, empty, too long and null: nothing is recorded",
                complete(s, "ab").isEmpty() && complete(s, "co").isEmpty() && complete(s, "zaa").isEmpty());
        MrRecent.record(null, "Ana");
        check("without the Suggest it still records (as a name)", words(complete(s, "an")).equals("Ana"));

        // ---------------------------------------------------------------- limit, order and age
        MrRecent.clear();
        MrRecent.record(s, "Carlos");
        MrRecent.record(s, "Caetano");
        MrRecent.record(s, "Camila");
        r = complete(s, "ca");
        check("at most 2 per query, the newest first", r.size() == 2 && "Camila".equals(r.get(0)[0]) && "Caetano".equals(r.get(1)[0]));
        MrRecent.record(s, "Carlos");
        check("recording again brings it to the front and does not duplicate", words(complete(s, "ca")).equals("Carlos Camila"));
        MrRecent.clear();
        MrRecent.record(s, "Zacarias");
        for (int i = 0; i < 95; i++) MrRecent.record(s, "Nome" + (char) ('a' + i % 26) + (char) ('a' + i / 26) + "x");
        int newest = (Integer) complete(s, "nom").get(0)[1];
        int oldest = (Integer) complete(s, "zac").get(0)[1];
        check("the score drops with age (200 for the newest, 50 for the oldest of 96)", newest == (200 << 3) && oldest == (50 << 3));
        MrRecent.record(s, "Outro");
        check("went past the limit of 96: the oldest is forgotten", complete(s, "zac").isEmpty() && !complete(s, "out").isEmpty());

        // ---------------------------------------------------------------- prediction: bonus and pairs
        MrRecent.clear();
        check("with nothing recorded the bonus is 0", MrRecent.bonus("casa") == 0);
        MrRecent.record(s, "reunião");
        MrRecent.record(s, "de");
        MrRecent.record(s, "amanhã");
        MrRecent.breakPair();
        for (int i = 0; i < 20; i++) MrRecent.record(s, "Fill" + (char) ('a' + i) + "x");
        check("bonus of the newest is the maximum (40) and drops with age", MrRecent.bonus("Fillt" + "x") == 40
                && MrRecent.bonus("Reunião") > 0 && MrRecent.bonus("reunião") < 40 && MrRecent.bonus("amanhã") >= MrRecent.bonus("reunião") && MrRecent.bonus("amanhã") < 40);
        check("unrecorded word gets no bonus; without accent and without case they match", MrRecent.bonus("outra") == 0 && MrRecent.bonus("AMANHA") > 0);
        // "de" has 2 letters: it does not count as a recent word, but pairs only apply to words that were recorded
        String[] after = MrRecent.nextAfter("reunião", 2);
        check("recent pair: after reunião came amanhã (de is too short and was not recorded, so the pair is reunião -> amanhã)",
                after.length == 1 && "amanhã".equals(after[0]));
        MrRecent.breakPair();
        MrRecent.record(s, "obrigado");
        check("after a break (new sentence) there is no pair with the previous word", MrRecent.nextAfter("amanhã", 2).length == 0);
        MrRecent.record(s, "para");
        MrRecent.record(s, "casa");
        MrRecent.breakPair();
        MrRecent.record(s, "obrigado");
        MrRecent.record(s, "carro");
        String[] two = MrRecent.nextAfter("OBRIGADO", 5);
        check("two pairs with the same 1st word: the newest first", two.length == 2 && "carro".equals(two[0]) && "para".equals(two[1]));
        check("requested maximum is respected", MrRecent.nextAfter("obrigado", 1).length == 1);
        check("word without a pair returns empty (never null)", MrRecent.nextAfter("xyz", 3).length == 0 && MrRecent.nextAfter(null, 3).length == 0);

        // ---------------------------------------------------------------- field
        MrRecent.clear();
        MrRecent.onField("com.app.chat", 7);
        MrRecent.record(s, "Fernanda");
        MrRecent.onField("com.app.chat", 7);
        check("same app and same field (keyboard reopened): keeps", words(complete(s, "fe")).equals("Fernanda"));
        MrRecent.onField("com.app.chat", 8);
        check("another field of the same app: clears", complete(s, "fe").isEmpty());
        MrRecent.record(s, "Fernanda");
        MrRecent.onField("com.outro.app", 8);
        check("another app: clears", complete(s, "fe").isEmpty());
        MrRecent.record(s, "Fernanda");
        MrRecent.onField(null, 8);
        check("unknown app (null): clears for safety", complete(s, "fe").isEmpty());

        // ---------------------------------------------------------------- robustness
        MrRecent.clear();
        MrRecent.complete(null, typed("ma"));
        MrRecent.complete(s, null);
        MrRecent.complete(s, typed(""));
        check("complete with a null Suggest, null or empty composer does not throw", true);
        MrRecent.record(s, "Maria");
        StringBuilder giant = new StringBuilder();
        for (int i = 0; i < 20; i++) giant.append('m');
        check("typed word with more than 12 letters does not query", complete(s, giant.toString()).isEmpty());

        System.out.println(fail == 0 ? "ALL OK (" + ok + " checks)" : fail + " FAILURE(S)");
        if (fail != 0) System.exit(1);
    }
}
