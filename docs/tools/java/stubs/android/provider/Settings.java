package android.provider;

/** Compile and PC test stub: the action of the keyboard settings and the value of the default keyboard (a field the tests set). */
public final class Settings {
    public static final String ACTION_INPUT_METHOD_SETTINGS = "android.settings.INPUT_METHOD_SETTINGS";

    public static final class Secure {
        public static final String DEFAULT_INPUT_METHOD = "default_input_method";
        /** Tests only: the values that getString answers, by name. */
        public static final java.util.Map<String, String> stubValues = new java.util.HashMap<String, String>();

        public static String getString(android.content.ContentResolver resolver, String name) {
            return stubValues.get(name);
        }

        /** The integer of a setting (Android signature); tests put it in stubValues. */
        public static int getInt(android.content.ContentResolver resolver, String name, int def) {
            String v = stubValues.get(name);
            return v == null ? def : Integer.parseInt(v);
        }
    }

    public static final class Global {
        /** Tests only: the values that getInt answers, by name. */
        public static final java.util.Map<String, String> stubValues = new java.util.HashMap<String, String>();

        public static int getInt(android.content.ContentResolver resolver, String name, int def) {
            String v = stubValues.get(name);
            return v == null ? def : Integer.parseInt(v);
        }
    }
}
