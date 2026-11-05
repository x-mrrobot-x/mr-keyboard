package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.graphics.Typeface;
import android.graphics.drawable.GradientDrawable;
import android.preference.PreferenceManager;
import android.view.Gravity;
import android.view.View;
import android.widget.CompoundButton;
import android.widget.LinearLayout;
import android.widget.Switch;
import android.widget.TextView;

/**
 * Card with the "Voltar à folha principal ao digitar" (return to the main sheet when typing) switch (v1.69), at the top of the
 * keyboard Sheets page. Same look as the main ABC keyboard card. The key is
 * "pref_sheet_return" (default on), read by LatinIME.returnToMainSheet.
 */
public final class MrSheetOpt {
    private MrSheetOpt() { }

    static final String KEY = "pref_sheet_return";

    private static int dp(Context c, float v) {
        return Math.round(v * c.getResources().getDisplayMetrics().density);
    }

    private static int color(Context c, String name) {
        Resources r = c.getResources();
        return r.getColor(r.getIdentifier(name, "color", c.getPackageName()));
    }

    public static View row(final Context c) {
        final SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(c);

        LinearLayout card = new LinearLayout(c);
        card.setOrientation(LinearLayout.HORIZONTAL);
        card.setGravity(Gravity.CENTER_VERTICAL);
        card.setPadding(dp(c, 14), dp(c, 12), dp(c, 14), dp(c, 12));
        GradientDrawable bg = new GradientDrawable();
        bg.setColor(color(c, "mr_ui_sunken"));
        bg.setCornerRadius(dp(c, 16));
        bg.setStroke(Math.max(1, dp(c, 1)), color(c, "mr_ui_stroke"));
        card.setBackground(bg);

        LinearLayout texts = new LinearLayout(c);
        texts.setOrientation(LinearLayout.VERTICAL);
        final TextView title = new TextView(c);
        title.setText(MrPacks.text(c, "title_sheet_return"));
        title.setTextColor(color(c, "mr_ui_text"));
        title.setTextSize(14.5f);
        title.setTypeface(null, Typeface.BOLD);
        final TextView summary = new TextView(c);
        summary.setTextColor(color(c, "mr_ui_text2"));
        summary.setTextSize(12.5f);
        texts.addView(title);
        texts.addView(summary);
        card.addView(texts, new LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f));

        final Switch sw = new Switch(c);
        boolean on = sp.getBoolean(KEY, true);
        sw.setChecked(on);
        summary.setText(MrPacks.text(c, on ? "summary_sheet_return_true" : "summary_sheet_return_false"));
        sw.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            public void onCheckedChanged(CompoundButton button, boolean checked) {
                sp.edit().putBoolean(KEY, checked).apply();
                summary.setText(MrPacks.text(c, checked ? "summary_sheet_return_true" : "summary_sheet_return_false"));
            }
        });
        card.addView(sw);
        card.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                sw.toggle();
            }
        });

        LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        lp.setMargins(0, dp(c, 14), 0, dp(c, 10));
        card.setLayoutParams(lp);
        return card;
    }
}
