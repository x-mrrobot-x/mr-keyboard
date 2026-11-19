package com.mrkeyboard.app;

import android.content.Context;
import android.preference.PreferenceManager;

/**
 * The two lines of the card "Keyboard statistics" (Advanced) that were rows of "Suggestions and dictionaries": the suggestion engine in use
 * ("Suggestion engine: Native (C++)", or why it is not) and the recognition time of the gesture typing. MrPerf.summary writes them after the
 * memory of the dictionaries; the screen of the suggestions no longer has them.
 */
final class MrEngineStats {
    private MrEngineStats() { }

    /** The engine line and the recognition lines, one under the other; null when no text could be read. Never throws. */
    static String block(Context c) {
        try {
            String engine = engineLine(c);
            String gesture = gestureLines(c);
            if (engine == null) return gesture;
            return gesture == null ? engine : engine + "\n" + gesture;
        } catch (RuntimeException e) {
            return null;
        }
    }

    /** "Suggestion engine: Native (C++)", or why it is not: with no lib the suggestions by search are gone and this is where one sees it. */
    static String engineLine(Context c) {
        String title = MrPacks.text(c, "mr_engine_title");
        String state = MrPacks.text(c, MrNative.ready() ? "mr_engine_native" : "mr_engine_missing");
        return title == null || state == null ? null : title + ": " + state;
    }

    /**
     * "Recognition time: last gesture ... ms, average ... ms, longest ... ms, gestures ...", then the time of the word shown while the finger slides
     * and the words of the person that the gestures know; or why there is no time yet (typing by gestures off, the file not downloaded, the
     * recognition still opening, no gesture made).
     */
    static String gestureLines(Context c) {
        String title = MrPacks.text(c, "mr_gesture_time_title");
        if (title == null) return null;
        String why = null;
        if (!PreferenceManager.getDefaultSharedPreferences(c).getBoolean(MrGestureInput.PREF_ON, true)) why = "mr_gesture_time_off";
        else if (MrPacks.modelFile(c, MrPacks.MODEL_GESTURE, MrPacks.ENCODER) == null) why = "mr_gesture_time_nopack";
        else if (!MrNative.ready()) why = "mr_engine_missing";
        else if (!MrGesture.ready()) why = "mr_gesture_time_loading";
        long[] st = why != null ? null : MrGestureInput.stats();
        if (st != null && st[0] <= 0) why = "mr_gesture_time_none";
        if (why != null) {
            String text = MrPacks.text(c, why);
            return text == null ? null : title + ": " + text;
        }
        String first = MrPacks.text(c, "mr_gesture_time_stats", MrDiag.msText(st[1]), MrDiag.msText(st[2] / st[0]), MrDiag.msText(st[3]),
                Integer.valueOf((int) Math.min(st[0], Integer.MAX_VALUE)));
        if (first == null) return null;
        StringBuilder b = new StringBuilder(title).append(": ").append(first);
        // the recognitions made while the finger slid (the word on the strip), and how long the copy of the words of the person took
        if (st[4] > 0) {
            String preview = MrPacks.text(c, "mr_gesture_time_preview", MrDiag.msText(st[5] / st[4]), MrDiag.msText(st[6]));
            if (preview != null) b.append('\n').append(preview);
        }
        long[] own = MrGestureWords.stats();            // {words, nanoseconds the last copy took, bytes}
        if (own[0] > 0) {
            String words = MrPacks.text(c, "mr_gesture_time_words", Integer.valueOf((int) Math.min(own[0], Integer.MAX_VALUE)), MrDiag.msText(own[1]));
            if (words != null) b.append('\n').append(words);
        }
        return b.toString();
    }
}
