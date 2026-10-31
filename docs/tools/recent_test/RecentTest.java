package com.mrkeyboard.app;

import java.util.Arrays;
import java.util.List;

/** Teste de PC das palavras recentes (MrRecent, v1.75). Roda pelo docs/tools/run_java_tests.sh. */
public class RecentTest {
    static int ok = 0, fail = 0;

    static void check(String name, boolean cond) {
        if (cond) { ok++; System.out.println("OK    " + name); }
        else { fail++; System.out.println("FALHA " + name); }
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

        // ---------------------------------------------------------------- anotar e completar
        MrRecent.clear();
        MrRecent.record(s, "Maria");
        List<Object[]> r = complete(s, "ma");
        check("nome fora do dicionário (Maria) completa com 2 letras, como palavra de dicionário",
                r.size() == 1 && "Maria".equals(r.get(0)[0]) && r.get(0)[2] == Dictionary.DataType.UNIGRAM
                        && (Integer) r.get(0)[1] == (200 << 2));
        check("sem acento nem caixa: 'MA' também acha Maria", words(complete(s, "MA")).equals("Maria"));
        check("prefixo que não bate não entrega nada", complete(s, "jo").isEmpty());
        check("palavra inteira já digitada não volta", complete(s, "maria").isEmpty());
        r = complete(s, "m");
        check("com 1 letra o nome entra como bigrama, prioridade até 127", r.size() == 1
                && r.get(0)[2] == Dictionary.DataType.BIGRAM && (Integer) r.get(0)[1] <= 127 && (Integer) r.get(0)[1] > 0);

        MrRecent.record(s, "obrogado");
        check("fora do dicionário e só minúscula (erro de digitação) não é anotado", complete(s, "obr").isEmpty());
        MrRecent.record(s, "Casa");
        check("palavra do dicionário é guardada em minúsculas", words(complete(s, "ca")).equals("casa"));
        check("com 1 letra só nome/termo fora do dicionário: 'c' não oferece casa", complete(s, "c").isEmpty());
        MrRecent.record(s, "iPhone");
        check("marca com maiúscula no meio é anotada como foi escrita", words(complete(s, "ip")).equals("iPhone"));
        MrRecent.record(s, "NASA");
        check("sigla fora do dicionário é anotada", words(complete(s, "na")).equals("NASA"));

        // ---------------------------------------------------------------- filtros
        MrRecent.clear();
        for (String w : new String[] {"ab", "abc123", "com certeza", "1234", "--", "", "   "}) MrRecent.record(s, w);
        StringBuilder longo = new StringBuilder("Z");
        for (int i = 0; i < 31; i++) longo.append('a');
        MrRecent.record(s, longo);
        MrRecent.record(s, null);
        check("curta, com dígito, com espaço, só símbolo, vazia, longa demais e nula: nada é anotado",
                complete(s, "ab").isEmpty() && complete(s, "co").isEmpty() && complete(s, "zaa").isEmpty());
        MrRecent.record(null, "Ana");
        check("sem o Suggest ainda anota (como nome)", words(complete(s, "an")).equals("Ana"));

        // ---------------------------------------------------------------- limite, ordem e idade
        MrRecent.clear();
        MrRecent.record(s, "Carlos");
        MrRecent.record(s, "Caetano");
        MrRecent.record(s, "Camila");
        r = complete(s, "ca");
        check("no máximo 2 por consulta, as mais novas primeiro", r.size() == 2 && "Camila".equals(r.get(0)[0]) && "Caetano".equals(r.get(1)[0]));
        MrRecent.record(s, "Carlos");
        check("anotar de novo traz para a frente e não duplica", words(complete(s, "ca")).equals("Carlos Camila"));
        MrRecent.clear();
        MrRecent.record(s, "Zacarias");
        for (int i = 0; i < 95; i++) MrRecent.record(s, "Nome" + (char) ('a' + i % 26) + (char) ('a' + i / 26) + "x");
        int novo = (Integer) complete(s, "nom").get(0)[1];
        int velho = (Integer) complete(s, "zac").get(0)[1];
        check("a pontuação cai com a idade (200 na mais nova, 50 na mais velha de 96)", novo == (200 << 3) && velho == (50 << 3));
        MrRecent.record(s, "Outro");
        check("passou do limite de 96: a mais velha é esquecida", complete(s, "zac").isEmpty() && !complete(s, "out").isEmpty());

        // ---------------------------------------------------------------- previsão: bônus e pares
        MrRecent.clear();
        check("sem nada anotado o bônus é 0", MrRecent.bonus("casa") == 0);
        MrRecent.record(s, "reunião");
        MrRecent.record(s, "de");
        MrRecent.record(s, "amanhã");
        MrRecent.breakPair();
        for (int i = 0; i < 20; i++) MrRecent.record(s, "Fill" + (char) ('a' + i) + "x");
        check("bônus da mais nova é o máximo (40) e cai com a idade", MrRecent.bonus("Fillt" + "x") == 40
                && MrRecent.bonus("Reunião") > 0 && MrRecent.bonus("reunião") < 40 && MrRecent.bonus("amanhã") >= MrRecent.bonus("reunião") && MrRecent.bonus("amanhã") < 40);
        check("palavra não anotada fica sem bônus; sem acento e sem caixa casam", MrRecent.bonus("outra") == 0 && MrRecent.bonus("AMANHA") > 0);
        // "de" tem 2 letras: não entra como palavra recente, mas os pares valem só para quem foi anotado
        String[] depois = MrRecent.nextAfter("reunião", 2);
        check("par recente: depois de reunião veio amanhã (de é curta demais e não foi anotada, então o par é reunião -> amanhã)",
                depois.length == 1 && "amanhã".equals(depois[0]));
        MrRecent.breakPair();
        MrRecent.record(s, "obrigado");
        check("depois de uma quebra (nova frase) não há par com a palavra anterior", MrRecent.nextAfter("amanhã", 2).length == 0);
        MrRecent.record(s, "para");
        MrRecent.record(s, "casa");
        MrRecent.breakPair();
        MrRecent.record(s, "obrigado");
        MrRecent.record(s, "carro");
        String[] dois = MrRecent.nextAfter("OBRIGADO", 5);
        check("dois pares com a mesma 1ª palavra: o mais novo primeiro", dois.length == 2 && "carro".equals(dois[0]) && "para".equals(dois[1]));
        check("máximo pedido é respeitado", MrRecent.nextAfter("obrigado", 1).length == 1);
        check("palavra sem par volta vazio (nunca nulo)", MrRecent.nextAfter("xyz", 3).length == 0 && MrRecent.nextAfter(null, 3).length == 0);

        // ---------------------------------------------------------------- campo
        MrRecent.clear();
        MrRecent.onField("com.app.chat", 7);
        MrRecent.record(s, "Fernanda");
        MrRecent.onField("com.app.chat", 7);
        check("mesmo app e mesmo campo (teclado reaberto): mantém", words(complete(s, "fe")).equals("Fernanda"));
        MrRecent.onField("com.app.chat", 8);
        check("outro campo do mesmo app: zera", complete(s, "fe").isEmpty());
        MrRecent.record(s, "Fernanda");
        MrRecent.onField("com.outro.app", 8);
        check("outro app: zera", complete(s, "fe").isEmpty());
        MrRecent.record(s, "Fernanda");
        MrRecent.onField(null, 8);
        check("app desconhecido (nulo): zera por segurança", complete(s, "fe").isEmpty());

        // ---------------------------------------------------------------- robustez
        MrRecent.clear();
        MrRecent.complete(null, typed("ma"));
        MrRecent.complete(s, null);
        MrRecent.complete(s, typed(""));
        check("complete com Suggest nulo, composer nulo ou vazio não lança", true);
        MrRecent.record(s, "Maria");
        StringBuilder gigante = new StringBuilder();
        for (int i = 0; i < 20; i++) gigante.append('m');
        check("palavra digitada com mais de 12 letras não consulta", complete(s, gigante.toString()).isEmpty());

        System.out.println(fail == 0 ? "TUDO OK (" + ok + " verificações)" : fail + " FALHA(S)");
        if (fail != 0) System.exit(1);
    }
}
