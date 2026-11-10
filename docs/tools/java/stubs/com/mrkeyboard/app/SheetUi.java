package com.mrkeyboard.app;

import android.content.Context;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import java.util.List;

/** Compile stub (APK class, smali): signatures of the drawn icons, buttons and menus that the sheet screens use. */
public final class SheetUi {
    private SheetUi() { }

    public static final int ICON_MORE_VERT = 0x1;
    public static final int ICON_BACK = 0x2;
    public static final int ICON_KEYBOARD = 0x3;
    public static final int ICON_EDIT_KEYS = 0x4;
    public static final int ICON_RENAME = 0x5;
    public static final int ICON_ARROW_UP = 0x6;
    public static final int ICON_ARROW_DOWN = 0x7;
    public static final int ICON_DUPLICATE = 0x8;
    public static final int ICON_ROWS = 0x9;
    public static final int ICON_EXPORT = 0xa;
    public static final int ICON_IMPORT = 0xb;
    public static final int ICON_RESTORE = 0xc;
    public static final int ICON_DELETE = 0xd;
    public static final int ICON_CLEAR = 0xe;
    public static final int ICON_LOCK = 0xf;
    public static final int TONE_NORMAL = 0x0;
    public static final int TONE_WARNING = 0x1;
    public static final int TONE_DANGER = 0x2;
    public static final android.graphics.Typeface TF_MEDIUM = null;

    public static int dp(Context c, float v) { return 0; }
    public static float dpf(Context c, float v) { return 0f; }
    public static ImageView makeIconButton(Context c, int icon, int color, int sizeDp, String description) { return null; }
    public static EditText makeEditText(Context c, String hint, boolean singleLine) { return null; }
    public static void showPopupMenu(Context c, View anchor, String title, String subtitle, List<MenuEntry> items, OnMenuSelect listener) { }

    public interface OnMenuSelect { void onSelect(int id); }

    public static final class MenuEntry {
        public final int id;
        public final int icon;
        public final String title;
        public final int tone;
        public final boolean dividerBefore;
        public MenuEntry(int id, int icon, String title) { this(id, icon, title, 0, false); }
        public MenuEntry(int id, int icon, String title, int tone, boolean dividerBefore) {
            this.id = id; this.icon = icon; this.title = title; this.tone = tone; this.dividerBefore = dividerBefore;
        }
    }

    public static final class IconDrawable extends android.graphics.drawable.Drawable {
        public IconDrawable(Context c, int kind, int color, int sizePx) { }
    }
}
