package android.view;

public class View {
    public interface OnClickListener { void onClick(View v); }
    public android.content.Context getContext() { return null; }
    public android.content.res.Resources getResources() { return null; }
    public ViewGroup.LayoutParams getLayoutParams() { return null; }
    public void setLayoutParams(ViewGroup.LayoutParams params) { }
    public void setBackground(android.graphics.drawable.Drawable background) { }
    public void setPadding(int left, int top, int right, int bottom) { }
    public void setOnClickListener(OnClickListener l) { }
}
