package android.widget;

public class ProgressBar extends android.view.View {
    private int stubMax = 100, stubProgress;
    public ProgressBar(android.content.Context context) { }
    public void setMax(int max) { stubMax = max; }
    public int getMax() { return stubMax; }
    public void setProgress(int progress) { stubProgress = Math.max(0, Math.min(stubMax, progress)); }
    public int getProgress() { return stubProgress; }
    public void setIndeterminate(boolean indeterminate) { }
}
