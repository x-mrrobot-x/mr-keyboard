package com.mrkeyboard.app;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Paint;
import android.os.Bundle;
import android.text.InputType;
import android.preference.PreferenceManager;
import android.provider.Settings;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

/**
 * "Keyboard sound": fifteen tiles in a grid (mute, the system sound that is the default, and the thirteen sounds of the app), the volume
 * and, under them, a field with the keyboard already open to try the sounds by typing. Touching a tile chooses it and plays it. The state is in the preferences that the keyboard reads: sound_on (the mute tile is sound_on
 * off, any other tile turns it on) and pref_sound_style (MrKeySound.KEY); the volume is pref_click_volume. Nothing is kept here, so the screen
 * can be created again at any time. The volume is for the sounds of the app: the default one follows the volume of the system, which the
 * screen says (the slider is disabled then, and when the sound is off).
 */
public class MrSoundActivity extends Activity {
    static final String MUTE = "mute";
    static final String SOUND_ON = "sound_on";
    static final int COLUMNS = 5;
    /**
     * The tiles in the order of the grid (rows of COLUMNS): the ids of MrKeySound plus MUTE and DEFAULT. Mute and the default sound come first, then the
     * sounds from the most discreet to the most eye-catching.
     */
    static final String[] TILES = {
            MUTE, MrKeySound.DEFAULT, "keyboard", "drop", "bubble",
            "bubble2", "bell", "duck", "mouse", "cat",
            "frog", "fox", "wand", "pistol", "rocket"};
    /** What a tile shows: the first glyph that the font of the phone has (the newest emojis come first), then the last one whatever happens. */
    private static final String[][] GLYPHS = {
            {MUTE, "🔇"},
            {"bubble", "🫧", "🔵"},
            {"bubble2", "🫧", "🔵"},
            {"bell", "🔔"},
            {"duck", "🦆", "🐥"},
            {"keyboard", "⌨️"},
            {"fox", "🦊", "🐺"},
            {"pistol", "🔫"},
            {"wand", "🪄", "✨"},
            {"frog", "🐸"},
            {"cat", "🐱"},
            {"drop", "💧"},
            {"rocket", "🚀"},
            {"mouse", "🖱️", "🐭"}};

    MrKit k;
    SharedPreferences mPrefs;
    final List<LinearLayout> mTiles = new ArrayList<LinearLayout>();
    SeekBar mSeek;
    TextView mPercent;
    TextView mNote;
    /** The field to try the sounds in, and the line that says the keyboard in use is not this one. */
    EditText mTry;
    TextView mOtherIme;

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(UiLocale.wrap(base));
    }

    @Override
    protected void onSaveInstanceState(Bundle out) {
        super.onSaveInstanceState(out);
        MrScreenIme.save(out, mTry, null);
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (mOtherIme != null) mOtherIme.setVisibility(keyboardInUse(this) ? View.GONE : View.VISIBLE);
    }

    @Override
    protected void onCreate(Bundle state) {
        super.onCreate(state);
        k = new MrKit(this);
        mPrefs = PreferenceManager.getDefaultSharedPreferences(this);

        ScrollView scroll = new ScrollView(this);
        scroll.setBackground(k.round(k.bg, 0, 0, false));
        LinearLayout col = k.column();
        col.setPadding(k.dp(20), k.dp(16), k.dp(20), k.dp(24));
        scroll.addView(col, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        // the keyboard stays open below the tiles: the room for it, and the scroll only goes down as far as the field needs
        MrScreenIme.keepVisible(scroll, col, k.dp(20), k.dp(16), k.dp(20), k.dp(24), k.dp(12));

        col.addView(k.backHeader(k.t("mr_sound_title"), new View.OnClickListener() {
            public void onClick(View v) {
                finish();
            }
        }), k.wide(0));
        col.addView(k.label(k.t("mr_sound_styles"), 16f, k.text2, true), k.wide(18));

        LinearLayout grid = k.column();
        col.addView(grid, k.wide(8));
        Paint probe = new Paint(Paint.ANTI_ALIAS_FLAG);
        LinearLayout row = null;
        for (int i = 0; i < TILES.length; i++) {
            if (i % COLUMNS == 0) {
                row = k.row();
                grid.addView(row, k.wide(i == 0 ? 0 : 8));
            }
            LinearLayout tile = tile(TILES[i], probe);
            mTiles.add(tile);
            LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(0, k.dp(64), 1f);
            p.setMargins(i % COLUMNS == 0 ? 0 : k.dp(4), 0, i % COLUMNS == COLUMNS - 1 ? 0 : k.dp(4), 0);
            row.addView(tile, p);
        }

        LinearLayout volume = k.panel();
        col.addView(volume, k.wide(20));
        LinearLayout line = k.row();
        volume.addView(line, k.wide(0));
        line.addView(k.label(k.t("mr_sound_volume"), 16f, k.text, true), new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        mPercent = k.label("", 16f, k.text2, false);
        line.addView(mPercent, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        mSeek = new SeekBar(this);
        mSeek.setMax(100);
        mSeek.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar bar, int progress, boolean fromUser) {
                if (fromUser) volumeChanged(progress);
            }

            public void onStartTrackingTouch(SeekBar bar) {
            }

            public void onStopTrackingTouch(SeekBar bar) {
                volumeLetGo();
            }
        });
        volume.addView(mSeek, k.wide(8));
        mNote = k.label("", 13f, k.text2, false);
        volume.addView(mNote, k.wide(6));

        // the field to try the keys in: the keyboard opens with the screen, under the tiles, so a sound is chosen and heard typing at once
        mTry = k.field(k.t("mr_sound_try"), InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_FLAG_MULTI_LINE | InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS);
        mTry.setMinLines(2);
        mTry.setGravity(Gravity.TOP);
        col.addView(mTry, k.wide(16));
        mOtherIme = k.label(k.t("mr_sound_other_ime"), 13f, k.text2, false);
        mOtherIme.setVisibility(keyboardInUse(this) ? View.GONE : View.VISIBLE);
        col.addView(mOtherIme, k.wide(8));

        setContentView(scroll);
        refresh();
        if (state == null) MrScreenIme.show(mTry);
        else MrScreenIme.restore(state, mTry, null);
    }

    /** One tile: the glyph (and a small caption for the two bubbles and for the default one). */
    private LinearLayout tile(final String id, Paint probe) {
        LinearLayout t = k.column();
        t.setGravity(Gravity.CENTER);
        t.setClickable(true);
        t.setContentDescription(k.t(id.equals(MrKeySound.DEFAULT) ? "mr_sound_default" : "mr_sound_name_" + id));
        t.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                choose(id);
            }
        });
        if (id.equals(MrKeySound.DEFAULT)) {
            t.addView(k.label(k.t("mr_sound_default"), 13f, k.text2, false), new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        } else {
            t.addView(k.label(glyph(id, probe), 26f, k.text, false), new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
            if (id.equals("bubble") || id.equals("bubble2")) {
                t.addView(k.label(id.equals("bubble") ? "1" : "2", 11f, k.text2, false), new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
            }
        }
        return t;
    }

    /** Is Mr Keyboard the keyboard in use ("default_input_method" is "package/class")? When Android cannot say, yes: the note is only for a certain no. */
    static boolean keyboardInUse(Context c) {
        try {
            String id = Settings.Secure.getString(c.getContentResolver(), Settings.Secure.DEFAULT_INPUT_METHOD);
            String pkg = c.getPackageName();
            return id == null || pkg == null || id.startsWith(pkg + "/");
        } catch (RuntimeException e) {
            return true;
        }
    }

    /** The first glyph of the tile that the font of the phone can draw (the last one when none can). */
    static String glyph(String id, Paint probe) {
        for (String[] g : GLYPHS) {
            if (!g[0].equals(id)) continue;
            for (int i = 1; i < g.length - 1; i++) if (probe.hasGlyph(g[i])) return g[i];
            return g[g.length - 1];
        }
        return "";
    }

    /** The tile that is chosen now: mute when the sound is off, else the style (DEFAULT when none was chosen). */
    String current() {
        if (!mPrefs.getBoolean(SOUND_ON, true)) return MUTE;
        return MrKeySound.style(mPrefs);
    }

    /** A tile was touched: it is chosen, drawn as chosen and heard. */
    void choose(String id) {
        SharedPreferences.Editor e = mPrefs.edit();
        if (MUTE.equals(id)) {
            e.putBoolean(SOUND_ON, false);
        } else {
            e.putBoolean(SOUND_ON, true);
            e.putString(MrKeySound.KEY, id);
        }
        e.apply();
        refresh();
        if (!MUTE.equals(id)) {
            MrKeySound.preload(this, id);
            MrKeySound.preview(this, id);
        }
    }

    void volumeChanged(int percent) {
        int p = Math.max(0, Math.min(100, percent));
        mPrefs.edit().putString(MrKeySound.VOLUME_KEY, Float.toString(p / 100f)).apply();
        mPercent.setText(p + "%");
    }

    void volumeLetGo() {
        String now = current();
        if (!MUTE.equals(now)) MrKeySound.preview(this, now);
    }

    /** Draws the chosen tile, the volume and the note under it. */
    void refresh() {
        String now = current();
        for (int i = 0; i < mTiles.size(); i++) {
            boolean on = TILES[i].equals(now);
            mTiles.get(i).setBackground(k.round(on ? k.soft : k.card, on ? k.accent : k.stroke, 14f, false));
        }
        int percent = Math.round(MrKeySound.volume(mPrefs) * 100f);
        mSeek.setProgress(percent);
        mPercent.setText(percent + "%");
        boolean own = !MUTE.equals(now) && !MrKeySound.DEFAULT.equals(now);
        mSeek.setEnabled(own);
        mSeek.setAlpha(own ? 1f : 0.4f);
        mNote.setText(MUTE.equals(now) ? k.t("mr_sound_muted") : MrKeySound.DEFAULT.equals(now) ? k.t("mr_sound_default_note") : "");
        mNote.setVisibility(own ? View.GONE : View.VISIBLE);
    }
}
