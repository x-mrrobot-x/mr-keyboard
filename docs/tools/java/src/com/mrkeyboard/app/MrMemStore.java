package com.mrkeyboard.app;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.TreeSet;

/** MrWordStore in memory (the PC tests, and the fallback when the database cannot be opened). */
final class MrMemStore implements MrWordStore {
    private final ArrayList<Row>[] mRows;
    private final ArrayList<String>[] mLocale;
    private long mNextId = 1;
    private long mNextBatch = 1;

    @SuppressWarnings("unchecked")
    MrMemStore() {
        mRows = new ArrayList[5];
        mLocale = new ArrayList[5];
        for (int i = 0; i < 5; i++) {
            mRows[i] = new ArrayList<Row>();
            mLocale[i] = new ArrayList<String>();
        }
    }

    /** Accent, case and nothing else: "Itaú" and "itau" are the same for searching. */
    static String fold(String s) {
        if (s == null) return "";
        char[] c = new char[s.length()];
        for (int i = 0; i < c.length; i++) c[i] = MrText.base(s.charAt(i));
        return new String(c);
    }

    private static boolean ok(int kind) {
        return kind >= 0 && kind < 5;
    }

    public synchronized int count(int kind, String locale) {
        if (!ok(kind)) return 0;
        int n = 0;
        for (int i = 0; i < mRows[kind].size(); i++) if (mLocale[kind].get(i).equals(locale)) n++;
        return n;
    }

    public synchronized List<Row> list(int kind, String locale, String filter, final int sort, int offset, int limit) {
        ArrayList<Row> out = new ArrayList<Row>();
        if (!ok(kind)) return out;
        String f = filter == null ? "" : fold(filter.trim());
        for (int i = 0; i < mRows[kind].size(); i++) {
            if (!mLocale[kind].get(i).equals(locale)) continue;
            Row r = mRows[kind].get(i);
            if (f.length() > 0 && !fold(r.a).contains(f) && !(r.b != null && fold(r.b).contains(f))) continue;
            out.add(r);
        }
        Collections.sort(out, new Comparator<Row>() {
            public int compare(Row x, Row y) {
                if (sort == SORT_USED && x.freq != y.freq) return x.freq > y.freq ? -1 : 1;
                return x.id == y.id ? 0 : (x.id > y.id ? -1 : 1);
            }
        });
        int from = Math.min(Math.max(0, offset), out.size());
        int to = Math.min(out.size(), from + Math.max(0, limit));
        return new ArrayList<Row>(out.subList(from, to));
    }

    public synchronized List<Row> all(int kind, String locale) {
        ArrayList<Row> out = new ArrayList<Row>();
        if (!ok(kind)) return out;
        for (int i = 0; i < mRows[kind].size(); i++) if (mLocale[kind].get(i).equals(locale)) out.add(mRows[kind].get(i));
        return out;
    }

    public synchronized long add(int kind, String locale, Row row) {
        if (!ok(kind) || row == null || row.a == null) return -1;
        Row r = new Row(kind, row.a, row.b, row.freq, row.batch, row.added);
        r.id = mNextId++;
        mRows[kind].add(r);
        mLocale[kind].add(locale);
        return r.id;
    }

    public synchronized boolean delete(int kind, long id) {
        if (!ok(kind)) return false;
        for (int i = 0; i < mRows[kind].size(); i++) {
            if (mRows[kind].get(i).id == id) {
                mRows[kind].remove(i);
                mLocale[kind].remove(i);
                return true;
            }
        }
        return false;
    }

    public synchronized int deleteAll(int kind, String locale) {
        if (!ok(kind)) return 0;
        int n = 0;
        for (int i = mRows[kind].size() - 1; i >= 0; i--) {
            if (mLocale[kind].get(i).equals(locale)) {
                mRows[kind].remove(i);
                mLocale[kind].remove(i);
                n++;
            }
        }
        return n;
    }

    public synchronized int deleteBatch(String locale, long batch) {
        int n = 0;
        for (int kind = MrWordStore.KIND_IMPORTED_WORD; kind <= MrWordStore.KIND_IMPORTED_PAIR; kind++) {
            for (int i = mRows[kind].size() - 1; i >= 0; i--) {
                if (mLocale[kind].get(i).equals(locale) && mRows[kind].get(i).batch == batch) {
                    mRows[kind].remove(i);
                    mLocale[kind].remove(i);
                    n++;
                }
            }
        }
        return n;
    }

    public synchronized long newBatch() {
        return mNextBatch++;
    }

    public void begin() { }

    public void end() { }

    public synchronized List<String> locales() {
        TreeSet<String> set = new TreeSet<String>();
        for (int k = 0; k < 5; k++) set.addAll(mLocale[k]);
        return new ArrayList<String>(set);
    }
}
