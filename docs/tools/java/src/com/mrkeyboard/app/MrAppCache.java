package com.mrkeyboard.app;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

final class MrAppCache implements MrAppPicker.Live {
    interface Disk {
        Map<String, String[]> rows();

        String signature();

        void save(Map<String, String[]> rows, String signature);

        void close();
    }

    private final Context mCtx;
    private final Disk mDisk;

    MrAppCache(Context c, Disk disk) {
        mCtx = c;
        mDisk = disk;
    }

    static MrAppCache open(Context c) {
        return new MrAppCache(c, new Sql(c));
    }

    public List<MrAppList.Entry> cached() {
        final ArrayList<MrAppList.Entry> out = new ArrayList<MrAppList.Entry>();
        final Map<String, String[]> rows = mDisk.rows();
        for (Map.Entry<String, String[]> e : rows.entrySet()) out.add(new MrAppList.Entry(e.getKey(), e.getValue()[0]));
        MrAppList.sort(out);
        return out;
    }

    public List<MrAppList.Entry> refresh() {
        final List<MrAppList.Found> found = MrAppList.scan(mCtx);
        final String sig = MrAppList.signature(found);
        if (sig != null && sig.equals(mDisk.signature())) return null;
        final HashMap<String, String[]> now = new HashMap<String, String[]>();
        final List<MrAppList.Entry> out = MrAppList.named(mCtx, found, mDisk.rows(), now);
        mDisk.save(now, sig);
        return out;
    }

    public void close() {
        mDisk.close();
    }

    private static final class Sql implements Disk {
        private static final String DB = "mr_apps.db";

        private final Helper mHelper;

        private static final class Helper extends SQLiteOpenHelper {
            Helper(Context c) {
                super(c, DB, null, 1);
            }

            @Override
            public void onCreate(SQLiteDatabase db) {
                db.execSQL("CREATE TABLE apps (pkg TEXT PRIMARY KEY, label TEXT NOT NULL, stamp TEXT NOT NULL)");
                db.execSQL("CREATE TABLE meta (k TEXT PRIMARY KEY, v TEXT)");
            }

            @Override
            public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
            }
        }

        Sql(Context c) {
            mHelper = new Helper(c.getApplicationContext());
        }

        public Map<String, String[]> rows() {
            final HashMap<String, String[]> out = new HashMap<String, String[]>();
            Cursor c = null;
            try {
                final SQLiteDatabase db = mHelper.getWritableDatabase();
                if (db == null) return out;
                c = db.rawQuery("SELECT pkg, label, stamp FROM apps", null);
                while (c != null && c.moveToNext()) out.put(c.getString(0), new String[] {c.getString(1), c.getString(2)});
            } catch (RuntimeException e) {
                out.clear();
            } finally {
                if (c != null) c.close();
            }
            return out;
        }

        public String signature() {
            Cursor c = null;
            try {
                final SQLiteDatabase db = mHelper.getWritableDatabase();
                if (db == null) return null;
                c = db.rawQuery("SELECT v FROM meta WHERE k='sig'", null);
                return c != null && c.moveToNext() ? c.getString(0) : null;
            } catch (RuntimeException e) {
                return null;
            } finally {
                if (c != null) c.close();
            }
        }

        public void save(Map<String, String[]> rows, String signature) {
            SQLiteDatabase db = null;
            try {
                db = mHelper.getWritableDatabase();
                if (db == null) return;
                db.beginTransaction();
                try {
                    db.execSQL("DELETE FROM apps");
                    for (Map.Entry<String, String[]> e : rows.entrySet()) {
                        db.execSQL("INSERT INTO apps (pkg, label, stamp) VALUES (?, ?, ?)", new Object[] {e.getKey(), e.getValue()[0], e.getValue()[1]});
                    }
                    if (signature == null) db.execSQL("DELETE FROM meta WHERE k='sig'");
                    else db.execSQL("INSERT OR REPLACE INTO meta (k, v) VALUES ('sig', ?)", new Object[] {signature});
                    db.setTransactionSuccessful();
                } finally {
                    db.endTransaction();
                }
            } catch (RuntimeException e) {
            }
        }

        public void close() {
            try {
                mHelper.close();
            } catch (RuntimeException e) {
            }
        }
    }
}
