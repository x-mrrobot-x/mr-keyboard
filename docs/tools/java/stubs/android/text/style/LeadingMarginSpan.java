package android.text.style;

public interface LeadingMarginSpan {
    class Standard implements LeadingMarginSpan {
        /** The margins as given (first line, the others): read by the PC tests. */
        public final int stubFirst, stubRest;
        public Standard(int first, int rest) { stubFirst = first; stubRest = rest; }
    }
}
