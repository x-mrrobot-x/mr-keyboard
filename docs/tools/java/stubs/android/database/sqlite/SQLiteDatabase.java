package android.database.sqlite;

import android.database.Cursor;

/** Compile stub: same signature as the framework class (does not go into the dex). */
public class SQLiteDatabase {
    public static final int OPEN_READWRITE = 0;

    public interface CursorFactory { }

    public static SQLiteDatabase openDatabase(String path, CursorFactory factory, int flags) {
        return null;
    }

    public Cursor rawQuery(String sql, String[] selectionArgs) {
        return null;
    }

    public void execSQL(String sql) { }

    public void execSQL(String sql, Object[] bindArgs) { }

    public void beginTransaction() { }

    public void setTransactionSuccessful() { }

    public void endTransaction() { }

    public void close() { }
}
