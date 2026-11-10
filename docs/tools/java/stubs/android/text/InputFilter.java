package android.text;

/** Compile stub of the framework class (only the signatures that the Java layer uses). */
public interface InputFilter {
    CharSequence filter(CharSequence source, int start, int end, Spanned dest, int dstart, int dend);

    class LengthFilter implements InputFilter {
        public LengthFilter(int max) { }
        public CharSequence filter(CharSequence source, int start, int end, Spanned dest, int dstart, int dend) { return null; }
    }
}
