package com.mrkeyboard.app;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.TreeSet;

/**
 * MrWordStore on the phone (v1.85). Three databases:
 *  - mr_words.db (ours, created here): the imported words, the imported pairs and the blocked words;
 *  - auto_dict.db and userbigram_dict.db (the learned words and pairs, made by the original keyboard code): opened on demand and only read, deleted from and
 *    added to when a row is edited. Their schema is not changed. They have no date, so "newest" is the highest _id.
 * The keyboard process and the settings screens share the files; SQLite serialises the writes.
 */
final class MrSqlStore implements MrWordStore {
    private static final String DB = "mr_words.db";
    private static final String AUTO = "auto_dict.db";
    private static final String BIGRAM = "userbigram_dict.db";

    private final Context mCtx;
    private final Helper mHelper;
    private SQLiteDatabase mTx;
    private static long sLastBatch;

    private static final class Helper extends SQLiteOpenHelper {
        Helper(Context c) {
            super(c, DB, null, 1);
        }

        @Override
        public void onCreate(SQLiteDatabase db) {
            db.execSQL("CREATE TABLE words (_id INTEGER PRIMARY KEY, word TEXT, locale TEXT, weight INTEGER, batch INTEGER, added INTEGER)");
            db.execSQL("CREATE INDEX words_locale ON words (locale)");
            db.execSQL("CREATE TABLE pairs (_id INTEGER PRIMARY KEY, w1 TEXT, w2 TEXT, locale TEXT, weight INTEGER, batch INTEGER, added INTEGER)");
            db.execSQL("CREATE INDEX pairs_locale ON pairs (locale)");
            db.execSQL("CREATE TABLE blocked (_id INTEGER PRIMARY KEY, word TEXT, locale TEXT, added INTEGER)");
            db.execSQL("CREATE INDEX blocked_locale ON blocked (locale)");
        }

        @Override
        public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
            // version 1 is the first one; a later version adds columns here without dropping what the user imported
        }
    }

    MrSqlStore(Context c) {
        mCtx = c;
        mHelper = new Helper(c);
        mHelper.getWritableDatabase();   // creates the file now, so a failure shows up when the store is opened
    }

    private SQLiteDatabase own() {
        if (mTx != null) return mTx;
        return mHelper.getWritableDatabase();
    }

    /** The database of the original keyboard code, or null if the keyboard has not created it yet. */
    private SQLiteDatabase learned(String name) {
        try {
            File f = mCtx.getDatabasePath(name);
            if (f == null || !f.isFile()) return null;
            return SQLiteDatabase.openDatabase(f.getPath(), null, SQLiteDatabase.OPEN_READWRITE);
        } catch (RuntimeException e) {
            return null;
        }
    }

    private static void closeQuietly(SQLiteDatabase db) {
        try {
            if (db != null) db.close();
        } catch (RuntimeException e) {
            // nothing to do
        }
    }

    // ------------------------------------------------------------------ queries

    /** Opens the database of the kind; {@code own} tells if it is ours (not to be closed after every call). */
    private SQLiteDatabase open(int kind) {
        switch (kind) {
            case KIND_LEARNED_WORD: return learned(AUTO);
            case KIND_LEARNED_PAIR: return learned(BIGRAM);
            default: return own();
        }
    }

    private void done(int kind, SQLiteDatabase db) {
        if (kind == KIND_LEARNED_WORD || kind == KIND_LEARNED_PAIR) closeQuietly(db);
    }

    private static String selectSql(int kind) {
        switch (kind) {
            case KIND_LEARNED_WORD: return "SELECT _id, word, '', freq, 0, 0 FROM words WHERE locale=?";
            case KIND_LEARNED_PAIR:
                return "SELECT main._id, word1, word2, IFNULL(frequency.freq, 0), 0, 0 FROM main LEFT JOIN frequency ON frequency.pair_id = main._id WHERE locale=?";
            case KIND_IMPORTED_WORD: return "SELECT _id, word, '', weight, batch, added FROM words WHERE locale=?";
            case KIND_IMPORTED_PAIR: return "SELECT _id, w1, w2, weight, batch, added FROM pairs WHERE locale=?";
            default: return "SELECT _id, word, '', 0, 0, added FROM blocked WHERE locale=?";
        }
    }

    private static String idColumn(int kind) {
        return kind == KIND_LEARNED_PAIR ? "main._id" : "_id";
    }

    private static String freqColumn(int kind) {
        switch (kind) {
            case KIND_LEARNED_WORD: return "freq";
            case KIND_LEARNED_PAIR: return "IFNULL(frequency.freq, 0)";
            case KIND_IMPORTED_WORD:
            case KIND_IMPORTED_PAIR: return "weight";
            default: return "0";
        }
    }

    private static Row readRow(int kind, Cursor c) {
        Row r = new Row();
        r.kind = kind;
        r.id = c.getLong(0);
        r.a = c.getString(1);
        String b = c.getString(2);
        r.b = (kind == KIND_LEARNED_PAIR || kind == KIND_IMPORTED_PAIR) ? b : null;
        r.freq = c.getInt(3);
        r.batch = c.getLong(4);
        r.added = c.getLong(5);
        return r;
    }

    public int count(int kind, String locale) {
        SQLiteDatabase db = open(kind);
        if (db == null) return 0;
        Cursor c = null;
        try {
            String table = kind == KIND_LEARNED_WORD ? "words" : kind == KIND_LEARNED_PAIR ? "main"
                    : kind == KIND_IMPORTED_WORD ? "words" : kind == KIND_IMPORTED_PAIR ? "pairs" : "blocked";
            c = db.rawQuery("SELECT COUNT(*) FROM " + table + " WHERE locale=?", new String[] {locale});
            return c.moveToNext() ? c.getInt(0) : 0;
        } catch (RuntimeException e) {
            return 0;
        } finally {
            if (c != null) c.close();
            done(kind, db);
        }
    }

    public List<Row> list(int kind, String locale, String filter, int sort, int offset, int limit) {
        boolean filtered = filter != null && filter.trim().length() > 0;
        String order = sort == SORT_USED ? " ORDER BY " + freqColumn(kind) + " DESC, " + idColumn(kind) + " DESC"
                : " ORDER BY " + idColumn(kind) + " DESC";
        ArrayList<Row> out = new ArrayList<Row>();
        SQLiteDatabase db = open(kind);
        if (db == null) return out;
        Cursor c = null;
        try {
            if (!filtered) {
                c = db.rawQuery(selectSql(kind) + order + " LIMIT " + Math.max(0, limit) + " OFFSET " + Math.max(0, offset), new String[] {locale});
                while (c.moveToNext()) out.add(readRow(kind, c));
                return out;
            }
            // accents are not folded by SQLite: the filter runs here, over the whole language (at most some tens of thousands of rows)
            String f = MrMemStore.fold(filter.trim());
            c = db.rawQuery(selectSql(kind) + order, new String[] {locale});
            int skipped = 0;
            while (c.moveToNext() && out.size() < limit) {
                Row r = readRow(kind, c);
                if (!MrMemStore.fold(r.a).contains(f) && !(r.b != null && MrMemStore.fold(r.b).contains(f))) continue;
                if (skipped < offset) {
                    skipped++;
                    continue;
                }
                out.add(r);
            }
            return out;
        } catch (RuntimeException e) {
            return out;
        } finally {
            if (c != null) c.close();
            done(kind, db);
        }
    }

    public List<Row> all(int kind, String locale) {
        ArrayList<Row> out = new ArrayList<Row>();
        SQLiteDatabase db = open(kind);
        if (db == null) return out;
        Cursor c = null;
        try {
            c = db.rawQuery(selectSql(kind) + " ORDER BY " + idColumn(kind), new String[] {locale});
            while (c.moveToNext()) out.add(readRow(kind, c));
        } catch (RuntimeException e) {
            // an empty list: the screen shows nothing for this kind
        } finally {
            if (c != null) c.close();
            done(kind, db);
        }
        return out;
    }

    // ------------------------------------------------------------------ changes

    public long add(int kind, String locale, Row row) {
        if (row == null || row.a == null) return -1;
        SQLiteDatabase db = open(kind);
        if (db == null) return -1;
        Cursor c = null;
        try {
            switch (kind) {
                case KIND_LEARNED_WORD:
                    db.execSQL("INSERT INTO words (word, freq, locale) VALUES (?, ?, ?)", new Object[] {row.a, Integer.valueOf(row.freq), locale});
                    break;
                case KIND_LEARNED_PAIR:
                    db.execSQL("INSERT INTO main (word1, word2, locale) VALUES (?, ?, ?)", new Object[] {row.a, row.b, locale});
                    c = db.rawQuery("SELECT last_insert_rowid()", null);
                    if (c.moveToNext()) {
                        long id = c.getLong(0);
                        db.execSQL("INSERT INTO frequency (pair_id, freq) VALUES (?, ?)", new Object[] {Long.valueOf(id), Integer.valueOf(row.freq)});
                        return id;
                    }
                    return -1;
                case KIND_IMPORTED_WORD:
                    db.execSQL("INSERT INTO words (word, locale, weight, batch, added) VALUES (?, ?, ?, ?, ?)",
                            new Object[] {row.a, locale, Integer.valueOf(row.freq), Long.valueOf(row.batch), Long.valueOf(row.added)});
                    break;
                case KIND_IMPORTED_PAIR:
                    db.execSQL("INSERT INTO pairs (w1, w2, locale, weight, batch, added) VALUES (?, ?, ?, ?, ?, ?)",
                            new Object[] {row.a, row.b, locale, Integer.valueOf(row.freq), Long.valueOf(row.batch), Long.valueOf(row.added)});
                    break;
                default:
                    db.execSQL("INSERT INTO blocked (word, locale, added) VALUES (?, ?, ?)", new Object[] {row.a, locale, Long.valueOf(row.added)});
                    break;
            }
            c = db.rawQuery("SELECT last_insert_rowid()", null);
            return c.moveToNext() ? c.getLong(0) : -1;
        } catch (RuntimeException e) {
            return -1;
        } finally {
            if (c != null) c.close();
            done(kind, db);
        }
    }

    public boolean delete(int kind, long id) {
        SQLiteDatabase db = open(kind);
        if (db == null) return false;
        try {
            Object[] a = new Object[] {Long.valueOf(id)};
            switch (kind) {
                case KIND_LEARNED_WORD: db.execSQL("DELETE FROM words WHERE _id=?", a); break;
                case KIND_LEARNED_PAIR:
                    db.execSQL("DELETE FROM frequency WHERE pair_id=?", a);
                    db.execSQL("DELETE FROM main WHERE _id=?", a);
                    break;
                case KIND_IMPORTED_WORD: db.execSQL("DELETE FROM words WHERE _id=?", a); break;
                case KIND_IMPORTED_PAIR: db.execSQL("DELETE FROM pairs WHERE _id=?", a); break;
                default: db.execSQL("DELETE FROM blocked WHERE _id=?", a); break;
            }
            return true;
        } catch (RuntimeException e) {
            return false;
        } finally {
            done(kind, db);
        }
    }

    public int deleteAll(int kind, String locale) {
        int n = count(kind, locale);
        SQLiteDatabase db = open(kind);
        if (db == null) return 0;
        try {
            Object[] a = new Object[] {locale};
            switch (kind) {
                case KIND_LEARNED_WORD: db.execSQL("DELETE FROM words WHERE locale=?", a); break;
                case KIND_LEARNED_PAIR:
                    db.execSQL("DELETE FROM frequency WHERE pair_id IN (SELECT _id FROM main WHERE locale=?)", a);
                    db.execSQL("DELETE FROM main WHERE locale=?", a);
                    break;
                case KIND_IMPORTED_WORD: db.execSQL("DELETE FROM words WHERE locale=?", a); break;
                case KIND_IMPORTED_PAIR: db.execSQL("DELETE FROM pairs WHERE locale=?", a); break;
                default: db.execSQL("DELETE FROM blocked WHERE locale=?", a); break;
            }
            return n;
        } catch (RuntimeException e) {
            return 0;
        } finally {
            done(kind, db);
        }
    }

    public int deleteBatch(String locale, long batch) {
        int n = 0;
        SQLiteDatabase db = own();
        try {
            for (int kind = KIND_IMPORTED_WORD; kind <= KIND_IMPORTED_PAIR; kind++) {
                String table = kind == KIND_IMPORTED_WORD ? "words" : "pairs";
                Cursor c = db.rawQuery("SELECT COUNT(*) FROM " + table + " WHERE locale=? AND batch=?", new String[] {locale, String.valueOf(batch)});
                try {
                    if (c.moveToNext()) n += c.getInt(0);
                } finally {
                    c.close();
                }
                db.execSQL("DELETE FROM " + table + " WHERE locale=? AND batch=?", new Object[] {locale, Long.valueOf(batch)});
            }
        } catch (RuntimeException e) {
            return n;
        }
        return n;
    }

    public synchronized long newBatch() {
        sLastBatch = Math.max(System.currentTimeMillis(), sLastBatch + 1);
        return sLastBatch;
    }

    public List<String> locales() {
        TreeSet<String> set = new TreeSet<String>();
        String[][] src = {{AUTO, "SELECT DISTINCT locale FROM words"}, {BIGRAM, "SELECT DISTINCT locale FROM main"}};
        for (String[] s : src) {
            SQLiteDatabase db = learned(s[0]);
            if (db == null) continue;
            collect(db, s[1], set);
            closeQuietly(db);
        }
        SQLiteDatabase mine = own();
        collect(mine, "SELECT DISTINCT locale FROM words", set);
        collect(mine, "SELECT DISTINCT locale FROM pairs", set);
        collect(mine, "SELECT DISTINCT locale FROM blocked", set);
        ArrayList<String> out = new ArrayList<String>(set);
        Collections.sort(out, new Comparator<String>() {
            public int compare(String x, String y) {
                return x.compareTo(y);
            }
        });
        return out;
    }

    private static void collect(SQLiteDatabase db, String sql, TreeSet<String> into) {
        Cursor c = null;
        try {
            c = db.rawQuery(sql, null);
            while (c.moveToNext()) {
                String l = c.getString(0);
                if (l != null && l.length() > 0) into.add(l);
            }
        } catch (RuntimeException e) {
            // the table is not there yet
        } finally {
            if (c != null) c.close();
        }
    }

    // ------------------------------------------------------------------ transactions

    public synchronized void begin() {
        if (mTx != null) return;
        mTx = mHelper.getWritableDatabase();
        mTx.beginTransaction();
    }

    public synchronized void end() {
        if (mTx == null) return;
        try {
            mTx.setTransactionSuccessful();
        } finally {
            mTx.endTransaction();
            mTx = null;
        }
    }
}
