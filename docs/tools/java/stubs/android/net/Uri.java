package android.net;

public class Uri implements android.os.Parcelable {
    /** Not in Android: the text it was parsed from (the PC tests read it). */
    public String stubText;
    public static Uri parse(String uriString) { Uri u = new Uri(); u.stubText = uriString; return u; }
    public String toString() { return stubText; }
}
