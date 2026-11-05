package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.preference.EditTextPreference;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.preference.PreferenceCategory;
import android.preference.PreferenceManager;
import android.widget.Toast;

import java.util.ArrayList;

/**
 * Settings → AI Editor (v1.80): the OpenAI-API-compatible service that the
 * MrAi dialog uses (ready-made provider or own address/model), the user's API key,
 * a connection test and the list of the user's styles (tapping edits or deletes, on the
 * MrAiStyleActivity screen). The pref_ai_* keys live in the default preferences (res/xml/prefs_ai.xml)
 * and are part of "Restore defaults" (MrReset.KEYS), except the value of the API key: the
 * pref_ai_key row is non-persistent and the value stays in "mr_ai" (MrAi.apiKey), a file that is not part of
 * the backup; Restore erases that value too. The summaries show address and model, but
 * never the key (only "saved"/"not saved").
 */
public class MrAiPrefs extends PreferenceActivity {
    private final Handler mHandler = new Handler(Looper.getMainLooper());
    private Preference mEndpoint;
    private Preference mModel;
    private Preference mKey;
    private Preference mTest;
    private PreferenceCategory mStyles;
    private boolean mTesting;

    private final Runnable mRecreate = new Runnable() {
        public void run() {
            if (!isFinishing() && !isDestroyed()) recreate();
        }
    };

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(UiLocale.wrap(base));
    }

    @Override
    protected void onCreate(Bundle state) {
        super.onCreate(state);
        setTitle(t("mr_ai_title"));
        addPreferencesFromResource(getResources().getIdentifier("prefs_ai", "xml", getPackageName()));
        migratePreviousPresets();
        ListDividerFix.apply(this);

        Preference provider = findPreference(MrAi.KEY_PROVIDER);
        if (provider != null) {
            provider.setOnPreferenceChangeListener(new Preference.OnPreferenceChangeListener() {
                public boolean onPreferenceChange(Preference preference, Object newValue) {
                    applyPreset(String.valueOf(newValue));
                    return true;
                }
            });
        }
        mEndpoint = findPreference(MrAi.KEY_ENDPOINT);
        if (mEndpoint != null) {
            mEndpoint.setOnPreferenceChangeListener(new Preference.OnPreferenceChangeListener() {
                public boolean onPreferenceChange(Preference preference, Object newValue) {
                    preference.setSummary(summaryOr(String.valueOf(newValue)));
                    return true;
                }
            });
        }
        mModel = findPreference(MrAi.KEY_MODEL);
        if (mModel != null) {
            mModel.setOnPreferenceChangeListener(new Preference.OnPreferenceChangeListener() {
                public boolean onPreferenceChange(Preference preference, Object newValue) {
                    preference.setSummary(summaryOr(String.valueOf(newValue)));
                    return true;
                }
            });
        }
        mKey = findPreference(MrAi.KEY_API_KEY);
        if (mKey != null) {
            mKey.setOnPreferenceChangeListener(new Preference.OnPreferenceChangeListener() {
                public boolean onPreferenceChange(Preference preference, Object newValue) {
                    MrAi.setApiKey(MrAiPrefs.this, String.valueOf(newValue)); // outside the backup (see MrAi)
                    preference.setSummary(keySummary(String.valueOf(newValue)));
                    return true;
                }
            });
            ((EditTextPreference) mKey).setText(MrAi.apiKey(this)); // non-persistent row: fill in by hand
        }
        mTest = findPreference("pref_ai_test");
        if (mTest != null) {
            mTest.setOnPreferenceClickListener(new Preference.OnPreferenceClickListener() {
                public boolean onPreferenceClick(Preference preference) {
                    test();
                    return true;
                }
            });
        }
        mStyles = (PreferenceCategory) findPreference("mr_ai_cat_styles");
        refreshSummaries();
        rebuildStyles();
    }

    @Override
    protected void onResume() {
        super.onResume();
        MrAiDialog.setAuxiliaryUiVisible(true);
        refreshSummaries();
        rebuildStyles(); // back from the style screen already with the new list
    }

    @Override
    protected void onPause() {
        mHandler.removeCallbacks(mRecreate);
        MrAiDialog.setAuxiliaryUiVisible(false);
        super.onPause();
    }

    private String t(String name) {
        String s = MrPacks.text(this, name);
        return s != null ? s : name;
    }

    /** Migrates only the models that were old presets; models chosen by the user stay untouched. */
    private void migratePreviousPresets() {
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);
        String provider = prefs.getString(MrAi.KEY_PROVIDER, "openai");
        String model = prefs.getString(MrAi.KEY_MODEL, "");
        String replacement = null;
        if ("openai".equals(provider) && "gpt-4o-mini".equals(model)) replacement = MrAi.MODEL_DEF;
        else if ("groq".equals(provider) && "llama-3.3-70b-versatile".equals(model)) replacement = "openai/gpt-oss-120b";
        else if ("openrouter".equals(provider) && "openai/gpt-4o-mini".equals(model)) replacement = "openai/gpt-6.1-terra";
        else if ("gemini".equals(provider) && ("gemini-2.5-flash".equals(model) || "gemini-3.8-flash".equals(model) || "gemini-4-argon".equals(model))) replacement = "gemini-3.5-flash-lite";
        if (replacement != null) prefs.edit().putString(MrAi.KEY_MODEL, replacement).apply();
    }

    /** Ready-made address and model of the chosen provider ("custom" changes nothing). */
    private void applyPreset(String provider) {
        String endpoint;
        String model;
        if ("groq".equals(provider)) {
            endpoint = "https://api.groq.com/openai/v1/chat/completions";
            model = "openai/gpt-oss-120b";
        } else if ("openrouter".equals(provider)) {
            endpoint = "https://openrouter.ai/api/v1/chat/completions";
            model = "openai/gpt-6.1-terra";
        } else if ("gemini".equals(provider)) {
            endpoint = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions";
            model = "gemini-3.5-flash-lite";
        } else if ("openai".equals(provider)) {
            endpoint = MrAi.ENDPOINT_DEF;
            model = MrAi.MODEL_DEF;
        } else {
            return;
        }
        PreferenceManager.getDefaultSharedPreferences(this).edit()
                .putString(MrAi.KEY_ENDPOINT, endpoint)
                .putString(MrAi.KEY_MODEL, model).apply();
        mHandler.post(mRecreate); // the fields on screen reread the preferences
    }

    private String summaryOr(String v) {
        String s = v == null ? "" : v.trim();
        return s.length() > 0 ? s : "—";
    }

    private String keySummary(String v) {
        return t(v != null && v.trim().length() > 0 ? "mr_ai_key_set" : "mr_ai_key_unset");
    }

    private void refreshSummaries() {
        SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(this);
        if (mEndpoint != null) mEndpoint.setSummary(summaryOr(sp.getString(MrAi.KEY_ENDPOINT, MrAi.ENDPOINT_DEF)));
        if (mModel != null) mModel.setSummary(summaryOr(sp.getString(MrAi.KEY_MODEL, MrAi.MODEL_DEF)));
        if (mKey != null) mKey.setSummary(keySummary(MrAi.apiKey(this)));
    }

    private void rebuildStyles() {
        if (mStyles == null) return;
        mStyles.removeAll();
        ArrayList<String[]> list = MrAi.loadCustom(this);
        for (int i = 0; i < list.size(); i++) {
            String[] st = list.get(i);
            final int index = i;
            Preference pr = new Preference(this);
            pr.setPersistent(false);
            pr.setTitle(st[0] + "  " + st[1]);
            String ins = st[2].replace('\n', ' ');
            pr.setSummary(ins.length() > 120 ? ins.substring(0, 120) + "…" : ins);
            pr.setOnPreferenceClickListener(new Preference.OnPreferenceClickListener() {
                public boolean onPreferenceClick(Preference preference) {
                    MrAi.openStyleEditor(MrAiPrefs.this, index);
                    return true;
                }
            });
            mStyles.addPreference(pr);
        }
        Preference add = new Preference(this);
        add.setPersistent(false);
        add.setTitle(t("mr_ai_add_style"));
        add.setOnPreferenceClickListener(new Preference.OnPreferenceClickListener() {
            public boolean onPreferenceClick(Preference preference) {
                MrAi.openStyleEditor(MrAiPrefs.this, -1);
                return true;
            }
        });
        mStyles.addPreference(add);
    }

    private void test() {
        if (mTesting) return;
        mTesting = true;
        if (mTest != null) mTest.setSummary(t("mr_ai_working"));
        final Context app = getApplicationContext();
        new Thread(new Runnable() {
            public void run() {
                String err = null;
                try {
                    MrAi.rewrite(app, "Reply with only the word OK.", "ping", false, 0.3);
                } catch (MrAi.AiFail f) {
                    err = f.getMessage();
                } catch (RuntimeException e) {
                    err = MrPacks.text(app, "mr_ai_net_fail");
                }
                final String result = err;
                mHandler.post(new Runnable() {
                    public void run() {
                        mTesting = false;
                        if (isFinishing() || isDestroyed()) return;
                        if (mTest != null) mTest.setSummary(t("mr_ai_test_sum"));
                        String msg = result == null ? t("mr_ai_test_ok")
                                : MrPacks.text(MrAiPrefs.this, "mr_ai_test_fail", result);
                        Toast.makeText(MrAiPrefs.this, msg, Toast.LENGTH_LONG).show();
                    }
                });
            }
        }).start();
    }
}
