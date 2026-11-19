package android.graphics.drawable;

public abstract class Drawable {
    /** The state that a copy of a drawable is made from (Android nested class). */
    public abstract static class ConstantState {
        public abstract Drawable newDrawable();
    }
    public ConstantState getConstantState() { return null; }
    public Drawable mutate() { return this; }
    /** A selector answers the face of its state; any other drawable is its own current one. */
    public Drawable getCurrent() { return this; }
    public void setAlpha(int alpha) { }
    private final android.graphics.Rect stubBounds = new android.graphics.Rect();
    public void setBounds(int left, int top, int right, int bottom) { stubBounds.left = left; stubBounds.top = top; stubBounds.right = right; stubBounds.bottom = bottom; }
    public final android.graphics.Rect getBounds() { return stubBounds; }
    public void draw(android.graphics.Canvas canvas) { }
    private boolean stubVisible = true;
    public boolean setVisible(boolean visible, boolean restart) { boolean changed = stubVisible != visible; stubVisible = visible; return changed; }
    public final boolean isVisible() { return stubVisible; }
    /** Not in Android: how often the drawable asked to be drawn again, and the beats it asked for (what View.scheduleDrawable would run later). */
    public int stubInvalidations;
    public final java.util.ArrayList<Runnable> stubScheduled = new java.util.ArrayList<Runnable>();
    public void invalidateSelf() { stubInvalidations++; }
    public void scheduleSelf(Runnable what, long when) { stubScheduled.add(what); }
    public void unscheduleSelf(Runnable what) { stubScheduled.remove(what); }
    public int getOpacity() { return 0; }
    /** The state as last set (the key faces of the keyboard are selectors: the PC tests read which state the preview asked for). */
    public int[] stubState = new int[0];
    public boolean setState(final int[] stateSet) { boolean changed = !java.util.Arrays.equals(stubState, stateSet); stubState = stateSet; return changed; }
    /** Colour filter as last set: read by the PC tests. */
    public android.graphics.ColorFilter stubFilter;
    public void setColorFilter(android.graphics.ColorFilter colorFilter) { stubFilter = colorFilter; }
    /** Level as last set (ClipDrawable uses it to say how much shows): read by the PC tests. */
    public int stubLevel;
    public final boolean setLevel(int level) { boolean changed = stubLevel != level; stubLevel = level; return changed; }
    public final int getLevel() { return stubLevel; }
}
