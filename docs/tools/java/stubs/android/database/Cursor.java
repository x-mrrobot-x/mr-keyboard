package android.database;

/** Compile stub: same signature as the framework class (does not go into the dex). */
public interface Cursor {
    boolean moveToNext();
    int getInt(int columnIndex);
    long getLong(int columnIndex);
    String getString(int columnIndex);
    boolean isNull(int columnIndex);
    void close();
}
