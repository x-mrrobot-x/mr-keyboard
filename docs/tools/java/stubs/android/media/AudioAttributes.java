package android.media;

/** Compile stub (API 21): what MrKeySound asks for is recorded so the PC tests can read it back. */
public final class AudioAttributes {
    public static final int USAGE_ASSISTANCE_SONIFICATION = 13;
    public static final int CONTENT_TYPE_SONIFICATION = 4;
    public int stubUsage;
    public int stubContentType;

    public static class Builder {
        private int usage;
        private int contentType;
        public Builder() { }
        public Builder setUsage(int usage) { this.usage = usage; return this; }
        public Builder setContentType(int contentType) { this.contentType = contentType; return this; }
        public AudioAttributes build() {
            AudioAttributes a = new AudioAttributes();
            a.stubUsage = usage;
            a.stubContentType = contentType;
            return a;
        }
    }
}
