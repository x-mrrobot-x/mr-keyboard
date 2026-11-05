package android.content;

public class ClipData {
    public static class Item {
        public CharSequence coerceToText(Context context) { return null; }
    }
    public static ClipData newPlainText(CharSequence label, CharSequence text) { return null; }
    public int getItemCount() { return 0; }
    public Item getItemAt(int index) { return null; }
}
