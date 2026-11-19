package com.mrkeyboard.app;

/** Compile stub (APK class, hand-written smali): the emoji panel, used by the emoji search. */
public class MrEmotes {
    /** Recent emojis, newest first (null until the panel loaded them). */
    static java.util.ArrayList<String> sRecent;

    /** The emojis of category c (0 to 7), separated by | . */
    static String data(int c) { return ""; }

    /** Puts the emoji at the top of the recents. */
    static void addRecent(String emoji) { }

    /** The category tabs: recent and the eight categories (null until the panel is made). */
    static android.widget.TextView[] sTabs;

    /** Builds the list again (the rows come from MrSymbols while the symbols are on) and goes back to the top. */
    static void refresh() { stubRefreshes++; }

    /** Not in the app: how many times the panel was built again (the PC tests read it). */
    static int stubRefreshes;
}
