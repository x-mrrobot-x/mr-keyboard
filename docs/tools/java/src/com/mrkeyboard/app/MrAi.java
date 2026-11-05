package com.mrkeyboard.app;

import android.content.ClipData;
import android.content.ClipboardManager;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Handler;
import android.os.Looper;
import android.graphics.drawable.GradientDrawable;
import android.preference.PreferenceManager;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Locale;

/**
 * AI Editor (v1.80): toolbar dialog that rewrites, with an AI service
 * configured by the user, the text selected in the app (or what is before the cursor).
 *
 * The dialog is attached to the IME window (MrAiDialog), above the keyboard and in the same fixed theme
 * as the settings. It is not inserted in the keyboard layout and does not follow the keyboard
 * visual themes.
 * A single row of ready-made styles (Formal, Short, Fix, Expand, Friendly,
 * Professional and Punctuation), plus Create/user styles, emojify and result;
 * Copy and Apply (replaces the text in the app, first checking that it has not changed).
 *
 * Network: only when the user taps a style (or redo), only to the
 * address configured in Settings → AI Editor (MrAiPrefs, pref_ai_* keys in the
 * default preferences), in the OpenAI-compatible chat completions format. The key only goes
 * in the Authorization header of that request; it is not logged. Only https:// addresses and
 * always with a key. In a password field the dialog does not capture text
 * nor fire any request. The dialog only opens from the toolbar.
 *
 * The user styles live in SharedPreferences "mr_ai" (key "styles", JSON), together with the
 * "emojify" option and the API key ("api_key"). That file is left out of the backup rules
 * (res/xml/backup_rules.xml and data_extraction_rules.xml only include the default preferences and
 * sheets.json), so the key never leaves the device through backup. The rest of the service
 * configuration stays in the default preferences (pref_ai_*), so the settings screen and
 * "Restore defaults" (MrReset) handle it like the others; Restore also erases the key.
 */
public final class MrAi implements View.OnClickListener, View.OnLongClickListener, Runnable {
    static final String PREFS = "mr_ai";
    static final String KEY_STYLES = "styles";
    static final String KEY_EMOJIFY = "emojify";
    private static final String KEY_EMOJI_DEFAULT_OFF_SET = "emojify_default_off_set";
    static final String KEY_PROVIDER = "pref_ai_provider";
    static final String KEY_ENDPOINT = "pref_ai_endpoint";
    static final String KEY_MODEL = "pref_ai_model";
    static final String KEY_API_KEY = "pref_ai_key"; // only the key of the row on the screen; the value goes in PREFS/KEY_SECRET
    static final String KEY_SECRET = "api_key";
    static final String EXTRA_STYLE = "mr_ai_style_index";
    static final String ENDPOINT_DEF = "https://api.openai.com/v1/chat/completions";
    static final String MODEL_DEF = "gpt-6.1-terra";
    static final int MAX_CHARS = 4000;
    static final int MAX_STYLES = 50;

    // internal click codes (C_CHIP + position in the row for the styles)
    private static final int C_BACK = 1;
    private static final int C_GEAR = 2;
    private static final int C_EMOJI = 5;
    private static final int C_COPY = 6;
    private static final int C_APPLY = 7;
    private static final int C_REDO = 8;
    private static final int C_CHIP = 100;
    private static final int R_BG = 1000;
    private static final int R_UI = 1001;

    private static final String[] BUILTIN_EMOJI = {"🤝", "🎯", "✅", "📝", "😊", "💼", "✍️"};
    private static final String[] BUILTIN_NAME = {
            "mr_ai_style_formal", "mr_ai_style_short", "mr_ai_style_fix", "mr_ai_style_expand",
            "mr_ai_style_friendly", "mr_ai_style_pro", "mr_ai_style_punct"};
    private static final String[] BUILTIN_INSTR = {
            "Rewrite the text in a formal, polite and well-structured tone, fixing grammar and spelling. Keep the meaning.",
            "Rewrite the text much shorter and more direct, keeping only the essential meaning. Remove filler words.",
            "Correct only spelling, missing accents, grammar, punctuation and capitalization. Keep the words, the tone and the word order as they are whenever possible.",
            "Expand the text with a bit more detail, clarity and completeness, keeping the same tone and meaning.",
            "Rewrite the text in a warm, friendly and casual tone, like talking to a friend. Keep the meaning.",
            "Rewrite the text in a professional, clear and objective business tone, suitable for work messages and email. Keep the meaning.",
            "Fix only punctuation, capitalization, spacing and missing accents. Do not change any word."};
    private static final int BUILTIN_FIX = 2;
    private static final String SYSTEM =
            "You are a text-rewriting assistant inside a keyboard. Rewrite the text that comes after "
            + "the separator, following the instruction. Keep the original language of the text unless "
            + "the instruction clearly asks otherwise. Reply with ONLY the rewritten text: no quotes, "
            + "no explanations, no preamble, no markdown fences.";
    private static final String EMOJI_YES =
            " Sprinkle a few relevant emojis through the text where they fit naturally; do not overdo it.";
    private static final String EMOJI_NO = " Do not add emojis that are not in the original text.";

    /** Error already with the message ready to show (localized here, at the point of failure). */
    static final class AiFail extends Exception {
        AiFail(String msg) { super(msg); }
    }

    // ------------------------------------------------------------------ dialog state
    private static View sRoot;
    private static ViewGroup sStrip;
    private static TextView sStatus;
    private static TextView sResult;
    private static View sBtnEmoji;
    private static TextView sEmojiCheck;
    private static TextView sEmojiLabel;
    private static TextView sBtnApply;
    private static Handler sHandler;
    private static boolean sOpen;
    private static boolean sBlocked;
    private static boolean sBusy;
    private static boolean sEmojify;
    private static String sSource;
    private static boolean sIsSel;
    private static String sResultText;
    private static int sSel = -1; // 0..6 ready-made, 100+i user, -1 none
    private static boolean sFired;
    private static int sSeq;
    private static ArrayList<String[]> sCustom = new ArrayList<String[]>();

    private final int mCode;
    private String mText;
    private String mError;
    private int mSeq;
    private double mTemp;
    private String mSource;
    private boolean mEmojify;
    private Context mContext;

    private MrAi(int code) {
        mCode = code;
    }

    private MrAi(int code, String instruction, int seq, double temp) {
        mCode = code;
        mText = instruction;
        mSeq = seq;
        mTemp = temp;
    }

    private static String t(String name) {
        Context c = sRoot != null ? sRoot.getContext() : MrTools.sApp;
        String s = c != null ? MrPacks.text(c, name) : null;
        return s != null ? s : name;
    }

    private static String t(String name, Object arg) {
        Context c = sRoot != null ? sRoot.getContext() : MrTools.sApp;
        String s = c != null ? MrPacks.text(c, name, arg) : null;
        return s != null ? s : name;
    }

    private static int dp(float v) {
        return Math.round(v * sRoot.getContext().getResources().getDisplayMetrics().density);
    }

    private static SharedPreferences prefsAi() {
        return sRoot.getContext().getSharedPreferences(PREFS, Context.MODE_PRIVATE);
    }

    // ------------------------------------------------------------------ dialog assembly

    /** Binds the Views of the dialog; called by MrAiDialog on every opening. */
    static void setup(View root) {
        if (root == null) return;
        sRoot = root;
        sHandler = new Handler(Looper.getMainLooper());
        sStrip = (ViewGroup) root.findViewWithTag("ai_strip");
        btn("ai_back", C_BACK);
        btn("ai_gear", C_GEAR);
        sBtnEmoji = btn("ai_emoji", C_EMOJI);
        sEmojiCheck = (TextView) root.findViewWithTag("ai_emoji_check");
        sEmojiLabel = (TextView) root.findViewWithTag("ai_emoji_label");
        btn("ai_copy", C_COPY);
        btn("ai_redo", C_REDO);
        sBtnApply = (TextView) btn("ai_apply", C_APPLY);

        TextView title = (TextView) root.findViewWithTag("ai_title");
        if (title != null) title.setTextColor(uiColor("mr_ui_text"));
        TextView hdr = (TextView) root.findViewWithTag("ai_hdr_result");
        if (hdr != null) hdr.setTextColor(uiColor("mr_ui_text"));
        sStatus = (TextView) root.findViewWithTag("ai_status");
        if (sStatus != null) sStatus.setTextColor(uiColor("mr_ui_text2"));
        sResult = (TextView) root.findViewWithTag("ai_result");
        if (sResult != null) {
            sResult.setTextColor(uiColor("mr_ui_text"));
            sResult.setBackground(fieldBackground());
        }
        if (sBtnApply != null) {
            sBtnApply.setTextColor(uiColor("mr_text_on_accent"));
        }

        SharedPreferences aiPrefs = prefsAi();
        if (!aiPrefs.getBoolean(KEY_EMOJI_DEFAULT_OFF_SET, false)) {
            aiPrefs.edit().putBoolean(KEY_EMOJIFY, false)
                    .putBoolean(KEY_EMOJI_DEFAULT_OFF_SET, true).apply();
            sEmojify = false;
        } else {
            sEmojify = aiPrefs.getBoolean(KEY_EMOJIFY, false);
        }
        sOpen = true;
        refreshEmojiBtn();
        updateApply();
        onOpen();
    }

    private static View btn(String tag, int code) {
        View button = sRoot.findViewWithTag(tag);
        if (button == null) return null;
        if (button instanceof TextView) {
            ((TextView) button).setTextColor(uiColor("mr_ui_text2"));
        }
        button.setOnClickListener(new MrAi(code));
        return button;
    }

    private static int uiColor(String name) {
        Context context = sRoot.getContext();
        int id = context.getResources().getIdentifier(name, "color", context.getPackageName());
        return context.getResources().getColor(id);
    }

    private static GradientDrawable rounded(int fill, int stroke, float radiusDp) {
        GradientDrawable drawable = new GradientDrawable();
        drawable.setShape(GradientDrawable.RECTANGLE);
        drawable.setColor(fill);
        drawable.setStroke(Math.max(1, dp(1)), stroke);
        drawable.setCornerRadius(dp(radiusDp));
        return drawable;
    }

    private static GradientDrawable chipBackground(boolean selected) {
        if (selected) {
            return rounded(uiColor("mr_ui_cyan_soft"),
                    uiColor("mr_ui_cyan_line"), 18f);
        }
        return rounded(uiColor("mr_ui_card"),
                uiColor("mr_ui_stroke"), 18f);
    }

    private static GradientDrawable styleChipBackground(boolean selected) {
        if (selected) {
            return rounded(uiColor("mr_ui_cyan_soft"),
                    uiColor("mr_ui_cyan_line"), 12f);
        }
        return rounded(uiColor("mr_ui_card"),
                uiColor("mr_ui_stroke"), 12f);
    }

    private static GradientDrawable emojiCheckBackground(boolean checked) {
        int fill = uiColor(checked ? "mr_ui_cyan_soft" : "mr_ui_sunken");
        int stroke = uiColor(checked ? "mr_ui_cyan" : "mr_ui_stroke_strong");
        return rounded(fill, stroke, 5f);
    }

    private static GradientDrawable fieldBackground() {
        return rounded(uiColor("mr_ui_sunken"),
                uiColor("mr_ui_stroke_strong"), 16f);
    }

    /** Invalidates old jobs and releases all the Views when the dialog closes. */
    static void dialogClosed() {
        sSeq++;
        sOpen = false;
        sBusy = false;
        sRoot = null;
        sStrip = null;
        sStatus = null;
        sResult = null;
        sBtnEmoji = null;
        sEmojiCheck = null;
        sEmojiLabel = null;
        sBtnApply = null;
        sHandler = null;
        sSource = null;
        sResultText = null;
    }

    /** Called by MrTools.release when the keyboard is rebuilt or destroyed. */
    public static void release() {
        MrAiDialog.dismiss();
    }

    private static void onOpen() {
        sSeq++;
        sBusy = false;
        sResultText = null;
        sSel = -1;
        sFired = false;
        if (sResult != null) sResult.setText("");
        Context ctx = sRoot.getContext();
        MrNotice.aiEditor(ctx);
        loadCustomHere();
        rebuildStrip();
        refreshChips();
        captureSource();
        updateApply();
        if (sStatus != null) {
            if (sBlocked) sStatus.setText(t("mr_ai_password"));
            else if (sSource == null || sSource.trim().length() == 0) sStatus.setText(t("mr_ai_no_text"));
            else if (!configured(ctx)) sStatus.setText(t("mr_ai_no_key"));
            else sStatus.setText(t("mr_ai_tap_style"));
        }
    }

    private static boolean isPasswordField() {
        try {
            LatinIME ime = MrTools.sIme;
            if (ime == null) return false;
            EditorInfo ei = ime.getCurrentInputEditorInfo();
            if (ei == null) return false;
            int cls = ei.inputType & 0x0000000f;
            int var = ei.inputType & 0x00000ff0;
            if (cls == 1) return var == 0x80 || var == 0x90 || var == 0xe0;
            if (cls == 2) return var == 0x10;
            return false;
        } catch (RuntimeException e) {
            return false;
        }
    }

    /** Text to rewrite: the app selection, or what is before the cursor (up to MAX_CHARS). */
    private static void captureSource() {
        sSource = null;
        sIsSel = false;
        sBlocked = isPasswordField();
        if (sBlocked) return;
        try {
            LatinIME ime = MrTools.sIme;
            if (ime == null) return;
            ime.mrCommit(); // ends the composition before reading (like enterTranslate)
            InputConnection ic = ime.getAppInputConnection();
            if (ic == null) return;
            CharSequence sel = ic.getSelectedText(0);
            if (sel != null && sel.length() > 0) {
                sSource = sel.toString();
                sIsSel = true;
                return;
            }
            CharSequence before = ic.getTextBeforeCursor(MAX_CHARS, 0);
            if (before != null) sSource = before.toString();
        } catch (RuntimeException e) {
            sSource = null;
        }
    }

    // ------------------------------------------------------------------ user styles

    /** List of user styles: each item is {emoji, name, instructions}. */
    static ArrayList<String[]> loadCustom(Context c) {
        ArrayList<String[]> out = new ArrayList<String[]>();
        try {
            String raw = c.getSharedPreferences(PREFS, Context.MODE_PRIVATE).getString(KEY_STYLES, null);
            if (raw == null) return out;
            JSONArray arr = new JSONArray(raw);
            for (int i = 0; i < arr.length() && out.size() < MAX_STYLES; i++) {
                JSONObject o = arr.optJSONObject(i);
                if (o == null) continue;
                String n = o.optString("n");
                String ins = o.optString("i");
                if (n.length() == 0 || ins.length() == 0) continue;
                String e = o.optString("e");
                out.add(new String[]{e.length() > 0 ? e : "✨", n, ins});
            }
        } catch (RuntimeException e) {
            // unreadable list: stays empty (the ready-made styles keep working)
        } catch (JSONException e) {
            // same
        }
        return out;
    }

    static void saveCustom(Context c, ArrayList<String[]> list) {
        try {
            JSONArray arr = new JSONArray();
            for (String[] st : list) {
                JSONObject o = new JSONObject();
                o.put("e", st[0]);
                o.put("n", st[1]);
                o.put("i", st[2]);
                arr.put(o);
            }
            c.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
                    .edit().putString(KEY_STYLES, arr.toString()).apply();
        } catch (JSONException e) {
            // not saved this time; the screen reports it through the result of the list
        }
    }

    private static void loadCustomHere() {
        sCustom = loadCustom(sRoot.getContext());
    }

    private static void rebuildStrip() {
        if (sStrip == null) return;
        sStrip.removeAllViews();
        addChip(0, null, t("mr_ai_create"));
        for (int i = 0; i < BUILTIN_NAME.length; i++) addChip(i + 1, BUILTIN_EMOJI[i], t(BUILTIN_NAME[i]));
        for (int i = 0; i < sCustom.size(); i++) {
            String[] st = sCustom.get(i);
            addChip(BUILTIN_NAME.length + 1 + i, st[0], st[1]);
        }
        refreshChips();
    }

    private static void addChip(int pos, String emoji, String name) {
        Context ctx = sRoot.getContext();
        int textColor = uiColor("mr_ui_text2");
        LinearLayout chip = new LinearLayout(ctx);
        chip.setOrientation(LinearLayout.VERTICAL);
        chip.setGravity(Gravity.CENTER);
        // Same inset on all four sides; wrap-content width keeps every translated label visible.
        chip.setPadding(dp(10), dp(10), dp(10), dp(10));
        chip.setBackground(styleChipBackground(false));

        LinearLayout.LayoutParams iconLp;
        if (pos == 0) {
            ImageView icon = new ImageView(ctx);
            int iconId = ctx.getResources().getIdentifier(
                    "ic_mr_ai_add_edit", "drawable", ctx.getPackageName());
            if (iconId != 0) icon.setImageResource(iconId);
            icon.setColorFilter(textColor);
            iconLp = new LinearLayout.LayoutParams(dp(20), dp(20));
            iconLp.setMargins(0, 0, 0, dp(2));
            icon.setLayoutParams(iconLp);
            chip.addView(icon);
        } else {
            TextView icon = new TextView(ctx);
            icon.setText(emoji);
            icon.setTextColor(textColor);
            icon.setTextSize(18f);
            icon.setGravity(Gravity.CENTER);
            icon.setSingleLine(true);
            iconLp = new LinearLayout.LayoutParams(
                    ViewGroup.LayoutParams.WRAP_CONTENT, dp(22));
            iconLp.setMargins(0, 0, 0, dp(2));
            icon.setLayoutParams(iconLp);
            chip.addView(icon);
        }

        TextView label = new TextView(ctx);
        label.setText(name);
        label.setTextColor(textColor);
        label.setTextSize(11f);
        label.setGravity(Gravity.CENTER);
        label.setSingleLine(true);
        // In a vertical LinearLayout the default child width is MATCH_PARENT;
        // set WRAP_CONTENT explicitly so long labels expand the chip instead of clipping.
        label.setLayoutParams(new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        chip.addView(label);

        LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.MATCH_PARENT);
        lp.setMargins(dp(3), dp(3), dp(3), dp(3));
        chip.setLayoutParams(lp);
        MrAi listener = new MrAi(C_CHIP + pos);
        chip.setOnClickListener(listener);
        chip.setOnLongClickListener(listener);
        sStrip.addView(chip);
    }

    /** Position in the row → style id (0..6 ready-made, 100+i user); -2 = Create button. */
    private static int styleAt(int pos) {
        if (pos == 0) return -2;
        if (pos <= BUILTIN_NAME.length) return pos - 1;
        return 100 + (pos - BUILTIN_NAME.length - 1);
    }

    private static void refreshChips() {
        if (sStrip == null) return;
        for (int i = 0; i < sStrip.getChildCount(); i++) {
            View view = sStrip.getChildAt(i);
            if (!(view instanceof LinearLayout)) continue;
            LinearLayout chip = (LinearLayout) view;
            boolean selected = styleAt(i) == sSel;
            int color = uiColor(selected ? "mr_ui_cyan" : "mr_ui_text2");
            chip.setAlpha(1f);
            chip.setBackground(styleChipBackground(selected));
            View icon = chip.getChildAt(0);
            if (icon instanceof TextView) ((TextView) icon).setTextColor(color);
            else if (icon instanceof ImageView) ((ImageView) icon).setColorFilter(color);
            View label = chip.getChildAt(1);
            if (label instanceof TextView) ((TextView) label).setTextColor(color);
        }
    }

    private static void refreshEmojiBtn() {
        if (sBtnEmoji == null) return;
        sBtnEmoji.setBackground(chipBackground(sEmojify));
        if (sEmojiCheck != null) {
            sEmojiCheck.setText(sEmojify ? "✓" : "");
            sEmojiCheck.setTextColor(uiColor(sEmojify ? "mr_ui_cyan" : "mr_ui_text2"));
            sEmojiCheck.setBackground(emojiCheckBackground(sEmojify));
        }
        if (sEmojiLabel != null) {
            sEmojiLabel.setText(t("mr_ai_emojify"));
            sEmojiLabel.setTextColor(uiColor(sEmojify ? "mr_ui_cyan" : "mr_ui_text2"));
        }
    }

    private static void updateApply() {
        if (sBtnApply != null) sBtnApply.setAlpha(sResultText == null || sResultText.length() == 0 ? 0.45f : 1f);
    }

    private static String preview(String src) {
        String one = src.replace('\n', ' ').trim();
        if (one.length() > 90) one = one.substring(0, 90) + "…";
        return one;
    }

    // ------------------------------------------------------------------ service configuration

    /** API key, read from "mr_ai" (outside the backup), never from the default preferences. */
    static String apiKey(Context c) {
        String v = c.getSharedPreferences(PREFS, Context.MODE_PRIVATE).getString(KEY_SECRET, "");
        return v == null ? "" : v.trim();
    }

    static void setApiKey(Context c, String key) {
        c.getSharedPreferences(PREFS, Context.MODE_PRIVATE).edit()
                .putString(KEY_SECRET, key == null ? "" : key.trim()).apply();
    }

    private static String cfg(Context c, String key, String def) {
        String v = PreferenceManager.getDefaultSharedPreferences(c).getString(key, def);
        return v == null ? def : v.trim();
    }

    private static boolean configured(Context c) {
        String ep = cfg(c, KEY_ENDPOINT, ENDPOINT_DEF);
        String model = cfg(c, KEY_MODEL, MODEL_DEF);
        if (ep.length() == 0 || model.length() == 0) return false;
        return apiKey(c).length() > 0;
    }

    // ------------------------------------------------------------------ trigger and response

    private static String instructionFor(int styleId) {
        if (styleId >= 0 && styleId < BUILTIN_INSTR.length) return BUILTIN_INSTR[styleId];
        int i = styleId - 100;
        if (i >= 0 && i < sCustom.size()) return sCustom.get(i)[2];
        return null;
    }

    private static void fire() {
        if (!sOpen || sRoot == null) return;
        if (sBlocked) {
            setStatus(t("mr_ai_password"));
            return;
        }
        if (sSource == null || sSource.trim().length() == 0) {
            setStatus(t("mr_ai_no_text"));
            return;
        }
        String instruction = instructionFor(sSel);
        if (instruction == null) {
            setStatus(t("mr_ai_tap_style"));
            return;
        }
        Context ctx = sRoot.getContext();
        if (!configured(ctx)) {
            setStatus(t("mr_ai_no_key"));
            MrTools.toast(t("mr_ai_no_key"));
            return;
        }
        if (sSource.length() > MAX_CHARS) {
            MrTools.toast(t("mr_tr_long"));
            return;
        }
        double temp = (sSel == BUILTIN_FIX || sSel == BUILTIN_INSTR.length - 1) ? 0.3 : 0.7;
        sSeq++;
        sBusy = true;
        sFired = true;
        sResultText = null;
        updateApply();
        setStatus(t("mr_ai_working"));
        MrAi job = new MrAi(R_BG, instruction, sSeq, temp);
        job.mSource = sSource; // copy from the moment of the tap: the dialog may close in the middle
        job.mEmojify = sEmojify;
        job.mContext = ctx.getApplicationContext();
        new Thread(job).start();
    }

    private static void setStatus(String s) {
        if (sStatus != null) sStatus.setText(s);
    }

    public void run() {
        if (mCode == R_BG) {
            String out = null;
            String err = null;
            try {
                Context ctx = mContext != null ? mContext : MrTools.sApp;
                if (ctx == null && sRoot != null) ctx = sRoot.getContext();
                if (ctx == null) throw new AiFail("mr_ai_net_fail");
                out = rewrite(ctx, mText, mSource, mEmojify, mTemp);
            } catch (AiFail f) {
                err = f.getMessage();
            } catch (RuntimeException e) {
                err = t("mr_ai_net_fail");
            }
            MrAi ui = new MrAi(R_UI, out, mSeq, 0);
            ui.mError = err;
            if (sHandler != null) sHandler.post(ui);
            return;
        }
        // R_UI: back on the main thread
        if (!sOpen || mSeq != sSeq || sResult == null) return;
        sBusy = false;
        if (mError != null) {
            setStatus(mError);
            return;
        }
        sResultText = mText;
        sResult.setText(mText);
        setStatus(t("mr_ai_original", preview(sSource)));
        updateApply();
    }

    /**
     * One rewrite request (blocking; call off the main thread). Returns only the rewritten
     * text or throws AiFail with the ready message. Also used by the MrAiPrefs test.
     */
    static String rewrite(Context c, String instruction, String text, boolean emojify, double temp)
            throws AiFail {
        String endpoint = cfg(c, KEY_ENDPOINT, ENDPOINT_DEF);
        String model = cfg(c, KEY_MODEL, MODEL_DEF);
        String key = apiKey(c);
        if (!endpoint.startsWith("https://")) {
            throw new AiFail(MrPacks.text(c, "mr_ai_bad_url"));
        }
        if (key.length() == 0) {
            throw new AiFail(MrPacks.text(c, "mr_ai_no_key"));
        }
        HttpURLConnection conn = null;
        try {
            JSONObject sys = new JSONObject();
            sys.put("role", "system");
            sys.put("content", SYSTEM + (emojify ? EMOJI_YES : EMOJI_NO));
            JSONObject usr = new JSONObject();
            usr.put("role", "user");
            usr.put("content", instruction + "\n\n---\n" + text);
            JSONArray msgs = new JSONArray();
            msgs.put(sys);
            msgs.put(usr);
            JSONObject body = new JSONObject();
            body.put("model", model);
            // GPT-6 reasoning defaults reject custom sampling temperature; omit it for those IDs.
            if (!model.toLowerCase(Locale.US).contains("gpt-6")) body.put("temperature", temp);
            body.put("messages", msgs);

            conn = (HttpURLConnection) new URL(endpoint).openConnection();
            conn.setConnectTimeout(15000);
            conn.setReadTimeout(60000);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=utf-8");
            conn.setRequestProperty("User-Agent", "MrKeyboard");
            if (key.length() > 0) conn.setRequestProperty("Authorization", "Bearer " + key);
            conn.setDoOutput(true);
            OutputStream os = conn.getOutputStream();
            os.write(body.toString().getBytes("UTF-8"));
            os.close();

            int code = conn.getResponseCode();
            InputStream in = code >= 200 && code < 300 ? conn.getInputStream() : conn.getErrorStream();
            String resp = readAll(in);
            if (code < 200 || code >= 300) {
                String detail = "";
                try {
                    JSONObject e = new JSONObject(resp).optJSONObject("error");
                    if (e != null) detail = e.optString("message");
                } catch (JSONException ignore) {
                    detail = resp.trim();
                }
                if (detail.length() > 180) detail = detail.substring(0, 180) + "…";
                String head = MrPacks.text(c, "mr_ai_http", Integer.valueOf(code));
                throw new AiFail(detail.length() > 0 ? head + ": " + detail : head);
            }
            String out = extract(resp);
            if (out == null || out.trim().length() == 0) throw new AiFail(MrPacks.text(c, "mr_ai_empty"));
            return clean(out, text);
        } catch (AiFail f) {
            throw f;
        } catch (JSONException e) {
            throw new AiFail(MrPacks.text(c, "mr_ai_empty"));
        } catch (Exception e) {
            throw new AiFail(MrPacks.text(c, "mr_ai_net_fail"));
        } finally {
            if (conn != null) conn.disconnect();
        }
    }

    private static String readAll(InputStream in) throws Exception {
        if (in == null) return "";
        BufferedReader r = new BufferedReader(new InputStreamReader(in, "UTF-8"));
        StringBuilder b = new StringBuilder();
        char[] buf = new char[4096];
        int n;
        while ((n = r.read(buf)) != -1) {
            b.append(buf, 0, n);
            if (b.length() > 262144) break;
        }
        r.close();
        return b.toString();
    }

    /** choices[0].message.content (text or parts), with choices[0].text as a fallback. */
    private static String extract(String resp) throws JSONException {
        JSONObject root = new JSONObject(resp);
        JSONArray choices = root.optJSONArray("choices");
        if (choices == null || choices.length() == 0) return null;
        JSONObject first = choices.optJSONObject(0);
        if (first == null) return null;
        JSONObject msg = first.optJSONObject("message");
        if (msg != null) {
            Object content = msg.opt("content");
            if (content instanceof String) return (String) content;
            if (content instanceof JSONArray) {
                JSONArray parts = (JSONArray) content;
                StringBuilder b = new StringBuilder();
                for (int i = 0; i < parts.length(); i++) {
                    JSONObject part = parts.optJSONObject(i);
                    if (part != null) b.append(part.optString("text"));
                    else b.append(parts.optString(i));
                }
                return b.toString();
            }
        }
        String legacy = first.optString("text");
        return legacy.length() > 0 ? legacy : null;
    }

    /** Trims the spaces at the ends and a pair of quotes that the model sometimes puts around everything. */
    private static String clean(String out, String original) {
        String s = out.trim();
        if (s.length() > 2 && s.startsWith("\"") && s.endsWith("\"")
                && !original.trim().startsWith("\"")) {
            s = s.substring(1, s.length() - 1).trim();
        }
        return s;
    }

    // ------------------------------------------------------------------ apply / copy

    private static void applyResult() {
        if (sResultText == null || sResultText.length() == 0 || sSource == null) return;
        try {
            LatinIME ime = MrTools.sIme;
            if (ime == null) return;
            InputConnection ic = ime.getAppInputConnection();
            if (ic == null) return;
            ic.beginBatchEdit();
            boolean ok = false;
            try {
                if (sIsSel) {
                    CharSequence now = ic.getSelectedText(0);
                    if (now != null && sSource.equals(now.toString())) {
                        ic.finishComposingText();
                        ok = ic.commitText(sResultText, 1);
                    }
                } else {
                    CharSequence now = ic.getTextBeforeCursor(sSource.length(), 0);
                    if (now != null && sSource.equals(now.toString())) {
                        ic.finishComposingText();
                        ic.deleteSurroundingText(sSource.length(), 0);
                        ok = ic.commitText(sResultText, 1);
                    }
                }
            } finally {
                ic.endBatchEdit();
            }
            if (ok) {
                MrAiDialog.dismiss();
            } else {
                setStatus(t("mr_ai_changed"));
                MrTools.toast(t("mr_ai_changed"));
            }
        } catch (RuntimeException e) {
            setStatus(t("mr_ai_changed"));
        }
    }

    private static void copyResult() {
        if (sResultText == null || sResultText.length() == 0) return;
        try {
            ClipboardManager cm = (ClipboardManager) sRoot.getContext().getSystemService("clipboard");
            if (cm != null) {
                cm.setPrimaryClip(ClipData.newPlainText("mr_ai", sResultText));
                MrTools.toast(t("mr_ai_copied"));
            }
        } catch (RuntimeException e) {
            // without a clipboard: it just does not copy
        }
    }

    // ------------------------------------------------------------------ screens (settings / style)

    static void openPrefs(Context from) {
        MrAiDialog.requestReopenOnReturn();
        MrAiDialog.dismiss();
        try {
            Intent i = new Intent(from, MrAiPrefs.class);
            i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            from.startActivity(i);
        } catch (RuntimeException e) {
            MrAiDialog.cancelReopenOnReturn();
            // without the screen: the user stays in the app
        }
    }

    static void openStyleEditor(Context from, int index) {
        // When the style editor starts from the Preferences screen, it stays underneath;
        // reopening the AI Editor is only needed if the origin was the dialog itself.
        boolean reopenAi = !(from instanceof MrAiPrefs);
        if (reopenAi) MrAiDialog.requestReopenOnReturn();
        MrAiDialog.dismiss();
        try {
            Intent i = new Intent(from, MrAiStyleActivity.class);
            i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            i.putExtra(EXTRA_STYLE, index);
            from.startActivity(i);
        } catch (RuntimeException e) {
            if (reopenAi) MrAiDialog.cancelReopenOnReturn();
            // same
        }
    }

    // ------------------------------------------------------------------ clicks

    public void onClick(View v) {
        switch (mCode) {
            case C_BACK:
                MrAiDialog.dismiss();
                return;
            case C_GEAR:
                if (MrTools.sIme != null) openPrefs(MrTools.sIme);
                return;
            case C_EMOJI:
                sEmojify = !sEmojify;
                prefsAi().edit().putBoolean(KEY_EMOJIFY, sEmojify).apply();
                refreshEmojiBtn();
                if (sFired && !sBusy) fire();
                return;
            case C_COPY:
                copyResult();
                return;
            case C_APPLY:
                applyResult();
                return;
            case C_REDO:
                fire();
                return;
            default:
                break;
        }
        if (mCode >= C_CHIP) {
            int styleId = styleAt(mCode - C_CHIP);
            if (styleId == -2) {
                if (MrTools.sIme != null) openStyleEditor(MrTools.sIme, -1);
                return;
            }
            sSel = styleId;
            refreshChips();
            fire();
        }
    }

    public boolean onLongClick(View v) {
        if (mCode < C_CHIP) return false;
        int styleId = styleAt(mCode - C_CHIP);
        if (styleId < 100) return false; // ready-made ones (and Create) are not edited by holding
        int index = styleId - 100;
        if (index >= sCustom.size()) return false;
        if (MrTools.sIme != null) openStyleEditor(MrTools.sIme, index);
        return true;
    }
}
