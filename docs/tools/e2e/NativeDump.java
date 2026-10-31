package com.mrkeyboard.app;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.file.*;
import java.util.*;

/**
 * Gera os arquivos de ouro do repositório do motor nativo (mr-engine, pasta testdata/): o que o código JAVA
 * responde para uma lista de consultas, com as tabelas e as regras exatamente como o app as entrega à lib.
 * O teste do mr-engine (test/mr_test.cpp) lê esses arquivos e exige a mesma resposta do C++ sem precisar do app,
 * do Java nem do dicionário completo.
 *
 * Uso: java -cp app.jar:stubs:. com.mrkeyboard.app.NativeDump dicionario.dict erros.tsv pasta_saida idioma [consultas]
 *   escreve  tables.bin (uma vez; igual para todos os idiomas), rules_<idioma>.bin, golden_<idioma>.tsv
 *   rules.txt é lido da pasta do dicionário. O dicionário de teste (pequeno) vem de mr-engine/tools/make_testdict.py.
 *
 * Formatos (little-endian): veja mr-engine/test/mr_test.cpp (loadTables, loadRules) e README.
 */
public class NativeDump {
    static void le32(OutputStream o, int v) throws IOException {
        o.write(v); o.write(v >> 8); o.write(v >> 16); o.write(v >> 24);
    }

    static void le16(OutputStream o, int v) throws IOException {
        o.write(v); o.write(v >> 8);
    }

    static void chars(OutputStream o, char[] a) throws IOException {
        for (char c : a) le16(o, c);
    }

    static void tables(File f) throws IOException {
        OutputStream o = new BufferedOutputStream(new FileOutputStream(f));
        o.write("MRT0".getBytes("US-ASCII"));
        int[] c = MrNative.costs();
        le32(o, c.length);
        for (int v : c) le32(o, v);
        chars(o, MrNative.lowerTable());
        o.write(MrNative.upperTable());
        chars(o, MrNative.baseTable());
        for (double d : MrNative.powTable()) {
            long bits = Double.doubleToLongBits(d);
            le32(o, (int) bits);
            le32(o, (int) (bits >>> 32));
        }
        o.close();
    }

    static void rules(File f, MrRules r) throws IOException {
        OutputStream o = new BufferedOutputStream(new FileOutputStream(f));
        o.write("MRR0".getBytes("US-ASCII"));
        o.write(r.pairs);
        char[] t2 = MrNative.packT2(r), d2 = MrNative.packD2(r), sil = MrNative.packSil(r);
        le32(o, t2.length); chars(o, t2);
        le32(o, d2.length); chars(o, d2);
        le32(o, sil.length); chars(o, sil);
        for (int i = 0; i < sil.length / 2; i++) le16(o, r.silCost[i]);
        for (short v : r.silentStart) le16(o, v);
        for (short v : r.silentAny) le16(o, v);
        for (boolean b : r.extra) o.write(b ? 1 : 0);
        for (boolean b : r.oneLetter) o.write(b ? 1 : 0);
        o.close();
    }

    public static void main(String[] a) throws Exception {
        byte[] bytes = Files.readAllBytes(Paths.get(a[0]));
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
        buf.put(bytes); buf.rewind();
        File outDir = new File(a[2]);
        outDir.mkdirs();
        String lang = a[3];
        int want = a.length > 4 ? Integer.parseInt(a[4]) : 1500;
        File dir = new File(a[0]).getAbsoluteFile().getParentFile();
        MrRules rules = MrRules.parse(new FileInputStream(new File(dir, "rules.txt")));
        MrRules.set(rules);
        String rowsProp = System.getProperty("rows");
        if (rowsProp != null) {
            String[] r = rowsProp.split(",");
            for (int i = 0; i < 3; i++) E2ETest.ROWS[i] = r[i];
        }
        MrNative.sForceJava = true;   // o ouro é sempre o do Java
        tables(new File(outDir, "tables.bin"));
        rules(new File(outDir, "rules_" + lang + ".bin"), rules);

        // consultas: por tipo de erro (passo fixo, sem sorteio), começos de palavra, palavras certas e casos de borda
        Map<String, List<String>> byKind = new TreeMap<String, List<String>>();
        List<String> right = new ArrayList<String>();
        for (String line : Files.readAllLines(Paths.get(a[1]))) {
            String[] p = line.split("\t");
            if (p.length < 3 || p[0].length() < 2) continue;
            List<String> l = byKind.get(p[2]);
            if (l == null) { l = new ArrayList<String>(); byKind.put(p[2], l); }
            l.add(p[0]);
            right.add(p[1]);
        }
        LinkedHashSet<String> q = new LinkedHashSet<String>();
        int perKind = Math.max(20, want * 6 / 10 / Math.max(1, byKind.size()));
        for (List<String> l : byKind.values()) {
            int step = Math.max(1, l.size() / perKind);
            for (int i = 0; i < l.size() && q.size() < want * 7 / 10 + 50; i += step) q.add(l.get(i));
        }
        int step = Math.max(1, right.size() / (want / 5));
        for (int i = 0; i < right.size(); i += step) {
            String w = right.get(i);
            q.add(w);
            for (int k = 2; k <= 5 && k < w.length(); k += 3) q.add(w.substring(0, k));
        }
        String[] edge = {"Casa", "CASA", "ÁGUA", "ação", "ç", "a", "aa", "aaaaaaaaaaaaaaaaaaaa", "bcdfghjklm", "xyzxyzxyzxyz",
            "porisso", "tambem", "naoseiseeuvou", "qwertyuiopasdfghjklz", "hhhhh", "1234", "d'água", "ñandú", "über",
            "alomde", "avontade", "derepente", "emfim", "pormim", "jaque", "tudobem", "eaí"};
        for (String e : edge) q.add(e);

        MrFuzzy f = new MrFuzzy(buf, bytes.length);
        java.lang.reflect.Field fNear = MrFuzzy.class.getDeclaredField("mNear");
        java.lang.reflect.Field fCnt = MrFuzzy.class.getDeclaredField("mNearCount");
        fNear.setAccessible(true); fCnt.setAccessible(true);
        PrintStream out = new PrintStream(new FileOutputStream(new File(outDir, "golden_" + lang + ".tsv")), false, "UTF-8");
        int n = 0, withResult = 0;
        for (String w : q) {
            if (w.length() > MrFuzzy.MAX_TYPED + 4) continue;
            WordComposer wc = E2ETest.compose(w);
            f.search(wc, w);
            char[][] near = (char[][]) fNear.get(f);
            int[] cnt = (int[]) fCnt.get(f);
            int len = Math.min(w.length(), MrFuzzy.MAX_TYPED);
            StringBuilder ns = new StringBuilder();
            for (int j = 0; j < len; j++) {
                if (j > 0) ns.append('|');
                ns.append(near[j], 0, cnt[j]);
            }
            out.println(w + "\t" + ns + "\t" + NativeParity.render(f));
            n++;
            if (f.resultCount() > 0) withResult++;
        }
        out.close();
        System.out.println("golden_" + lang + ".tsv: " + n + " consultas, " + withResult + " com resultado");
    }
}
