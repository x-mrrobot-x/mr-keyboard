package android.graphics.drawable;

/** Compile and PC test stub (Android signature): the layers of a key face. Like the real one, a colour filter set on it goes to every layer. */
public class LayerDrawable extends Drawable {
    private final Drawable[] layers;

    public LayerDrawable(Drawable[] layers) { this.layers = layers; }
    public int getNumberOfLayers() { return layers.length; }
    public Drawable getDrawable(int index) { return layers[index]; }

    @Override
    public void setColorFilter(android.graphics.ColorFilter colorFilter) {
        super.setColorFilter(colorFilter);
        for (Drawable d : layers) d.setColorFilter(colorFilter);
    }
}
