package android.widget;

public class SeekBar extends ProgressBar {
    public interface OnSeekBarChangeListener {
        void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser);

        void onStartTrackingTouch(SeekBar seekBar);

        void onStopTrackingTouch(SeekBar seekBar);
    }

    public SeekBar(android.content.Context context) { super(context); }

    /** The listener the screen set: the PC tests move the bar by calling it. */
    public OnSeekBarChangeListener stubListener;
    public void setOnSeekBarChangeListener(OnSeekBarChangeListener listener) { stubListener = listener; }
}
