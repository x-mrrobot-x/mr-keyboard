package android.view.inputmethod;

/** Compile and PC test stub: a keyboard of the list that Android keeps (the tests build them with the second constructor). */
public final class InputMethodInfo {
    private final String stubPackage, stubId;

    public InputMethodInfo(String packageName, String id) {
        stubPackage = packageName;
        stubId = id;
    }

    public String getPackageName() { return stubPackage; }
    public String getId() { return stubId; }
}
