package com.mrkeyboard.app;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import java.util.ArrayList;
import java.util.HashMap;

/** MrAppCache.Store on the phone: mr_apps.db, with the apps (package, name, place of the files) and the signature and the language of the names. */
final class MrAppCacheDb implements MrAppCache.Store {
    private static final String DB = "mr_apps.db";
    private static final String K_SIGNATURE = "signature";
    private static final String K_LOCALE = "locale";

    private final Helper mHelper;

    private static final class Helper extends SQLiteOpenHelper {
        Helper(Context c) {
            super(c, DB, null, 1);
        }

        @Override
        public void onCreate(SQLiteDatabase db) {
            db.execSQL("CREATE TABLE apps (pkg TEXT PRIMARY KEY, label TEXT, src TEXT)");
            db.execSQL("CREATE TABLE meta (k TEXT PRIMARY KEY, v TEXT)");
        }

        @Override
        public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
            // version 1 is the first one; it is only a copy of what the system says, so a change may simply start over
        }
    }

    MrAppCacheDb(Context c) {
        mHelper = new Helper(c);
    }

    /** Closes the database (the helper is made for one pass of the list and not kept). */
    void close() {
        try {
            mHelper.close();
        } catch (RuntimeException e) {
            // nothing to do
        }
    }

    public MrAppCache.Snapshot read() {
        SQLiteDatabase db = mHelper.getWritableDatabase();
        if (db == null) return MrAppCache.Snapshot.empty();
        String signature = null, locale = null;
        Cursor m = db.rawQuery("SELECT k, v FROM meta", null);
        try {
            while (m.moveToNext()) {
                String key = m.getString(0);
                if (K_SIGNATURE.equals(key)) signature = m.getString(1);
                else if (K_LOCALE.equals(key)) locale = m.getString(1);
            }
        } finally {
            m.close();
        }
        ArrayList<MrAppList.Entry> entries = new ArrayList<MrAppList.Entry>();
        HashMap<String, String> sources = new HashMap<String, String>();
        Cursor a = db.rawQuery("SELECT pkg, label, src FROM apps", null);
        try {
            while (a.moveToNext()) {
                String pkg = a.getString(0);
                String label = a.getString(1);
                if (pkg == null || label == null) continue;
                entries.add(new MrAppList.Entry(pkg, label));
                sources.put(pkg, a.isNull(2) ? "" : a.getString(2));
            }
        } finally {
            a.close();
        }
        MrAppList.sort(entries);
        return new MrAppCache.Snapshot(signature, locale, entries, sources);
    }

    public void write(MrAppCache.Snapshot s) {
        SQLiteDatabase db = mHelper.getWritableDatabase();
        if (db == null) return;
        db.beginTransaction();
        try {
            db.execSQL("DELETE FROM apps");
            db.execSQL("DELETE FROM meta");
            for (MrAppList.Entry e : s.entries) {
                String src = s.sources.get(e.pkg);
                db.execSQL("INSERT INTO apps (pkg, label, src) VALUES (?, ?, ?)", new Object[] {e.pkg, e.label, src == null ? "" : src});
            }
            db.execSQL("INSERT INTO meta (k, v) VALUES (?, ?)", new Object[] {K_SIGNATURE, s.signature});
            db.execSQL("INSERT INTO meta (k, v) VALUES (?, ?)", new Object[] {K_LOCALE, s.locale});
            db.setTransactionSuccessful();
        } finally {
            db.endTransaction();
        }
    }
}
