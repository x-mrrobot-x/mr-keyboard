package android.widget;

public abstract class CompoundButton extends TextView {
    public interface OnCheckedChangeListener { void onCheckedChanged(CompoundButton buttonView, boolean isChecked); }
    public CompoundButton(android.content.Context context) { super(context); }
    public void setChecked(boolean checked) { }
    public boolean isChecked() { return false; }
    public void toggle() { }
    public void setOnCheckedChangeListener(OnCheckedChangeListener l) { }
}
