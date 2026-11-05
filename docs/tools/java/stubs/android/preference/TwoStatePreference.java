package android.preference;

public abstract class TwoStatePreference extends Preference {
    public TwoStatePreference(android.content.Context context) { super(context); }
    public void setChecked(boolean checked) { }
    public boolean isChecked() { return false; }
}
