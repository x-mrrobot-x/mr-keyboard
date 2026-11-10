package com.mrkeyboard.app;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.preference.CheckBoxPreference;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.preference.PreferenceCategory;
import android.preference.PreferenceGroup;
import android.preference.PreferenceManager;
import android.text.AutoText;
import android.text.SpannableString;
import android.text.SpannableStringBuilder;
import android.text.Spanned;
import android.text.style.ForegroundColorSpan;
import android.widget.Toast;

import java.io.File;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

/**
 * "Sugestões e dicionários" (Suggestions and dictionaries) screen (v1.63, redone in 1.67). A single screen for the languages and the
 * suggestions:
 *  - language cards (pt-BR, en-US and es always, plus whatever the catalog brings), each with the
 *    dictionary state; tapping opens the details (download, update, remove). A language with an
 *    installed dictionary is a keyboard language (MrPacks.syncLanguages);
 *  - the suggestion options (res/xml/prefs_suggestions.xml, in the default preferences);
 *  - the privacy note.
 * It only connects when the user taps "Procurar atualizações" (check for updates), "Baixar"/"Atualizar" (download/update) or
 * a language that is not installed when there is no stored catalog yet (to show the size before
 * downloading). Uses the same look as the other screens (theme, SettingsHeader header and UiLocale).
 */
public class MrPacksActivity extends PreferenceActivity {
    private final Handler mHandler = new Handler(Looper.getMainLooper());
    private final HashMap<String, Preference> mPackPrefs = new HashMap<String, Preference>();
    private PreferenceCategory mLangs;
    private Preference mCheck;
    /** v1.90.0: load times and memory of the dictionary in use (MrDiag). */
    private Preference mMem;
    private MrPacks.Catalog mCat;
    private boolean mChecking;
    private String mCheckError;
    private String mError;
    private String mErrorId;
    /** Language tapped while the catalog was being fetched: opens the details when it arrives. */
    private String mOpenId;

    private final Runnable mPoll = new Runnable() {
        public void run() {
            if (gone()) return;
            update();
            if (MrPacks.sJobId != null) mHandler.postDelayed(this, 400);
        }
    };

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(UiLocale.wrap(base));
    }

    @Override
    protected void onCreate(Bundle state) {
        super.onCreate(state);
        setTitle(t("mr_dicts_title"));
        addPreferencesFromResource(getResources().getIdentifier("prefs_suggestions", "xml", getPackageName()));
        ListDividerFix.apply(this);
        mLangs = (PreferenceCategory) findPreference("mr_cat_langs");
        hideQuickFixesIfUnsupported();
        mCat = MrPacks.cachedCatalog(this);
        rebuild();
    }

    /**
     * "Correções rápidas" (quick fixes) uses Android's autotext table, which only exists for some languages:
     * without it the option does nothing and leaves the screen (as it did on the settings screen).
     */
    private void hideQuickFixesIfUnsupported() {
        if (AutoText.getSize(getListView()) >= 1) return;
        Preference quick = findPreference("quick_fixes");
        Preference group = findPreference("mr_cat_suggestions");
        if (quick != null && group instanceof PreferenceGroup) ((PreferenceGroup) group).removePreference(quick);
    }

    @Override
    protected void onResume() {
        super.onResume();
        rebuild();
        if (MrPacks.sJobId != null) {
            mHandler.removeCallbacks(mPoll);
            mHandler.post(mPoll);
        }
    }

    @Override
    protected void onPause() {
        mHandler.removeCallbacks(mPoll);
        super.onPause();
    }

    // ------------------------------------------------------------------ list

    /** Name of the language when the catalog has not been seen yet (default cards). */
    private String langName(String id) {
        String key = "mr_lang_" + id.replace('-', '_');
        return getResources().getIdentifier(key, "string", getPackageName()) != 0 ? t(key) : id;
    }

    private void plain(Preference p) {
        int id = getResources().getIdentifier("mr_ui_pref_row_static", "layout", getPackageName());
        if (id != 0) p.setLayoutResource(id);
    }

    /** Rebuilds the list of languages (default, catalog and installed) and brings the keyboard up to date. */
    private void rebuild() {
        if (mLangs == null) return;
        mLangs.removeAll();
        mPackPrefs.clear();
        ArrayList<String> catIds = new ArrayList<String>();
        if (mCat != null) for (MrPacks.Pack p : mCat.packs) catIds.add(p.id);
        Locale loc = getResources().getConfiguration().locale;
        ArrayList<String> ids = MrPacks.cardIds(catIds, MrPacks.installedIds(this), loc.getLanguage());
        for (final String id : ids) {
            MrPacks.Pack p = mCat != null ? mCat.find(id) : null;
            Preference pr = new Preference(this);
            pr.setPersistent(false);
            pr.setTitle(p != null ? p.name(loc) : langName(id));
            pr.setOnPreferenceClickListener(new Preference.OnPreferenceClickListener() {
                public boolean onPreferenceClick(Preference preference) {
                    open(id);
                    return true;
                }
            });
            mLangs.addPreference(pr);
            mPackPrefs.put(id, pr);
        }
        mCheck = new Preference(this);
        mCheck.setPersistent(false);
        mCheck.setTitle(t("mr_dicts_check"));
        mCheck.setOnPreferenceClickListener(new Preference.OnPreferenceClickListener() {
            public boolean onPreferenceClick(Preference preference) {
                check();
                return true;
            }
        });
        mLangs.addPreference(mCheck);
        Preference hint = new Preference(this);
        hint.setPersistent(false);
        hint.setSelectable(false);
        plain(hint);
        hint.setSummary(t("mr_dicts_langs_hint"));
        mLangs.addPreference(hint);
        // v1.77: says whether the native engine is in use (since 1.87.0 there is no Java fallback; this way you can check whether the lib was copied)
        Preference engine = new Preference(this);
        engine.setPersistent(false);
        engine.setSelectable(false);
        plain(engine);
        engine.setTitle(t("mr_engine_title"));
        engine.setSummary(t(MrNative.ready() ? "mr_engine_native" : "mr_engine_missing"));
        mLangs.addPreference(engine);
        mMem = new Preference(this);
        mMem.setPersistent(false);
        mMem.setSelectable(false);
        plain(mMem);
        mMem.setTitle(t("mr_mem_title"));
        mMem.setSummary(t("mr_mem_wait"));
        mLangs.addPreference(mMem);
        refreshMem();
        MrPacks.syncLanguages(this, ids);
        update();
    }

    /**
     * Fills the "Dictionary memory" line. Reading the memory map of the process takes a few milliseconds, so it is done in a thread and the
     * text is put on the screen when it is ready (never while the screen is gone).
     */
    private void refreshMem() {
        final Preference target = mMem;
        final File dir = MrPacks.activeDir();
        if (target == null) return;
        if (dir == null) {
            target.setSummary(t("mr_mem_none"));
            return;
        }
        Thread th = new Thread(new Runnable() {
            public void run() {
                final String text = memText(MrDiag.collect(dir));
                mHandler.post(new Runnable() {
                    public void run() {
                        if (!gone() && target == mMem) target.setSummary(text);
                    }
                });
            }
        }, "MrDiag");
        th.setPriority(Thread.MIN_PRIORITY);
        th.start();
    }

    /** The lines of the report: dictionary, trigram file and engine, each with size, memory and time. */
    private String memText(MrDiag.Report r) {
        StringBuilder sb = new StringBuilder();
        sb.append(t("mr_mem_dict", r.id, r.version, MrDiag.bytesText(r.dictBytes), MrDiag.bytesText(r.dictMem), MrDiag.msText(r.dictNs)));
        sb.append('\n');
        if (r.hasTri) {
            sb.append(t("mr_mem_tri", r.triFormat, MrDiag.bytesText(r.triBytes), MrDiag.bytesText(r.triMem), MrDiag.msText(r.triNs)));
        } else {
            sb.append(t("mr_mem_tri_none"));
        }
        sb.append('\n').append(t("mr_mem_engine", MrDiag.msText(r.engineNs), MrDiag.msText(r.rulesNs)));
        if (r.dictMem < 0 && r.triMem < 0) sb.append('\n').append(t("mr_mem_nomem"));
        return sb.toString();
    }

    /** Updates only the texts (during the download). */
    private void update() {
        for (String id : mPackPrefs.keySet()) {
            MrPacks.Pack p = mCat != null ? mCat.find(id) : null;
            mPackPrefs.get(id).setSummary(state(id, p));
        }
        if (mCheck != null) mCheck.setSummary(checkState());
    }

    /** Color from the app palette (mr_colors.xml) by name, or 0 if it does not exist. */
    private int color(String name) {
        int id = getResources().getIdentifier(name, "color", getPackageName());
        return id != 0 ? getResources().getColor(id) : 0;
    }

    /** End of the part of the text that gets the color: up to " · " or ":" (the rest, such as size and version, stays gray). */
    private static int headEnd(String s) {
        int a = s.indexOf(" · "), b = s.indexOf(':');
        if (a < 0) a = s.length();
        if (b < 0) b = s.length();
        return Math.min(a, b);
    }

    /** The start of the text (the state) in the palette color; the rest in the usual gray. */
    private CharSequence paint(String text, String colorName, boolean whole) {
        int c = colorName == null ? 0 : color(colorName);
        if (c == 0 || text.length() == 0) return text;
        SpannableString sp = new SpannableString(text);
        sp.setSpan(new ForegroundColorSpan(c), 0, whole ? text.length() : headEnd(text), Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        return sp;
    }

    /**
     * Card state, with color on the state: installed green, downloading or installing amber,
     * update blue, failure red; not downloaded stays in the summary gray.
     */
    private CharSequence state(String id, MrPacks.Pack p) {
        int inst = MrPacks.installedVersion(this, id);
        if (id.equals(MrPacks.sJobId)) {
            return paint(MrPacks.sJobInstalling ? t("mr_dicts_state_installing")
                    : t("mr_dicts_state_downloading", MrPacks.sJobPercent), "mr_ui_amber", true);
        }
        if (id.equals(mErrorId) && mError != null) return paint(mError, "mr_ui_rose", true);
        boolean newer = p != null && p.version > inst;
        if (newer && MrPacks.appTooOld(this, p)) {
            return paint(inst > 0 ? t("mr_dicts_state_installed", inst, MrPacks.sizeText(dirSize(id, inst)))
                    + " · " + t("mr_dicts_state_needs_app") : t("mr_dicts_state_needs_app"), "mr_ui_rose", true);
        }
        if (inst > 0) {
            if (newer) return paint(t("mr_dicts_state_update", p.version, MrPacks.sizeText(p.size)), "mr_ui_blue", false);
            return paint(t("mr_dicts_state_installed", inst, MrPacks.sizeText(dirSize(id, inst))), "mr_ui_mint", false);
        }
        if (p != null) return t("mr_dicts_state_available", MrPacks.sizeText(p.size));
        return t(mCat != null ? "mr_dicts_state_unavailable" : "mr_dicts_state_notdl");
    }

    private CharSequence checkState() {
        if (mChecking) return t("mr_dicts_checking");
        if (mCheckError != null) return paint(mCheckError, "mr_ui_rose", true);
        long at = MrPacks.checkedAt(this);
        if (at == 0) return t("mr_dicts_check_never");
        String when = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT).format(new Date(at));
        String s = t("mr_dicts_check_last", when);
        if (mCat != null && mCat.packs.isEmpty()) s = s + " · " + t("mr_dicts_empty");
        int n = MrPacks.updatesAvailable(this, mCat);
        if (n == 0) return s;
        SpannableStringBuilder b = new SpannableStringBuilder(s);
        b.append(" · ");
        int from = b.length();
        b.append(t(n == 1 ? "mr_dicts_updates_one" : "mr_dicts_updates_many", n));
        int blue = color("mr_ui_blue");
        if (blue != 0) b.setSpan(new ForegroundColorSpan(blue), from, b.length(), Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        return b;
    }

    private long dirSize(String id, int version) {
        File[] fs = MrPacks.packDir(this, id, version).listFiles();
        long n = 0;
        if (fs != null) for (File f : fs) n += f.length();
        return n;
    }

    // ------------------------------------------------------------------ actions

    /** Tap on a language: with no stored catalog and no installed pack, fetches the catalog first. */
    private void open(String id) {
        if (mCat == null && MrPacks.installedVersion(this, id) == 0) {
            mOpenId = id;
            check();
        } else {
            showPack(id);
        }
    }

    private void check() {
        if (mChecking) return;
        mChecking = true;
        mCheckError = null;
        update();
        final Context app = getApplicationContext();
        new Thread(new Runnable() {
            public void run() {
                MrPacks.Catalog cat = null;
                String err = null;
                try {
                    cat = MrPacks.fetchCatalog(app);
                } catch (MrPacks.PackException e) {
                    err = msg(e);
                } catch (RuntimeException e) {
                    err = t("mr_dicts_err_io", e.getClass().getSimpleName());
                }
                final MrPacks.Catalog fc = cat;
                final String fe = err;
                mHandler.post(new Runnable() {
                    public void run() {
                        mChecking = false;
                        mCheckError = fe;
                        if (fc != null) mCat = fc;
                        String open = mOpenId;
                        mOpenId = null;
                        if (gone()) return;
                        rebuild();
                        if (open != null) {
                            if (fe != null) toast(fe); else showPack(open);
                        }
                    }
                });
            }
        }, "MrPacksCheck").start();
    }

    private void showPack(final String id) {
        final MrPacks.Pack p = mCat != null ? mCat.find(id) : null;
        int inst = MrPacks.installedVersion(this, id);
        boolean job = id.equals(MrPacks.sJobId);
        Locale loc = getResources().getConfiguration().locale;
        final String title = p != null ? p.name(loc) : id;
        StringBuilder m = new StringBuilder();
        if (p != null) {
            String d = p.description(loc);
            if (d.length() > 0) m.append(d).append("\n\n");
            m.append(t("mr_dicts_size_download", MrPacks.sizeText(p.size), MrPacks.sizeText(p.installedSize)));
            if (p.licenses.length() > 0) m.append("\n").append(t("mr_dicts_licenses", p.licenses));
            if (p.credits.length() > 0) m.append("\n\n").append(p.credits);
        }
        if (inst > 0) {
            if (m.length() > 0) m.append("\n\n");
            m.append(t("mr_dicts_state_installed", inst, MrPacks.sizeText(dirSize(id, inst))));
        }
        AlertDialog.Builder b = new AlertDialog.Builder(this);
        b.setTitle(title);
        b.setMessage(m.toString());
        if (job) {
            b.setPositiveButton(t("mr_dicts_cancel"), new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int which) {
                    MrPacks.sCancel = true;
                }
            });
        } else if (p != null && p.version > inst && !MrPacks.appTooOld(this, p) && MrPacks.sJobId == null) {
            b.setPositiveButton(t(inst == 0 ? "mr_dicts_download" : "mr_dicts_update"),
                    new DialogInterface.OnClickListener() {
                        public void onClick(DialogInterface dialog, int which) {
                            download(p);
                        }
                    });
        }
        if (inst > 0 && !job) {
            b.setNeutralButton(t("mr_dicts_remove"), new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int which) {
                    confirmRemove(id, title);
                }
            });
        }
        b.setNegativeButton(t("mr_dicts_close"), null);
        b.show();
    }

    private void download(final MrPacks.Pack p) {
        if (MrPacks.sJobId != null || mCat == null) return;
        mError = null;
        mErrorId = null;
        MrPacks.sJobPercent = 0;
        MrPacks.sJobInstalling = false;
        MrPacks.sJobId = p.id;
        final MrPacks.Catalog cat = mCat;
        final Context app = getApplicationContext();
        new Thread(new Runnable() {
            public void run() {
                String err = null;
                try {
                    MrPacks.install(app, cat, p);
                } catch (MrPacks.PackException e) {
                    err = msg(e);
                } catch (RuntimeException e) {
                    err = t("mr_dicts_err_io", e.getClass().getSimpleName());
                } finally {
                    MrPacks.sJobId = null;
                }
                final String fe = err;
                mHandler.post(new Runnable() {
                    public void run() {
                        if (fe != null) {
                            mError = fe;
                            mErrorId = p.id;
                            toast(fe);
                        } else {
                            Preference show = findPreference("show_suggestions");
                            if (show instanceof CheckBoxPreference) {
                                ((CheckBoxPreference) show).setChecked(true);
                            } else {
                                PreferenceManager.getDefaultSharedPreferences(app).edit()
                                        .putBoolean("show_suggestions", true).apply();
                            }
                            toast(t("mr_dicts_installed_ok"));
                        }
                        if (!gone()) rebuild();
                    }
                });
            }
        }, "MrPacksInstall").start();
        mHandler.removeCallbacks(mPoll);
        mHandler.post(mPoll);
    }

    private void confirmRemove(final String id, String title) {
        AlertDialog.Builder b = new AlertDialog.Builder(this);
        b.setTitle(title);
        b.setMessage(t("mr_dicts_remove_confirm", title));
        b.setPositiveButton(t("mr_dicts_remove"), new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                MrPacks.remove(MrPacksActivity.this, id);
                mError = null;
                mErrorId = null;
                toast(t("mr_dicts_removed_ok"));
                rebuild();
            }
        });
        b.setNegativeButton(t("mr_dicts_close"), null);
        b.show();
    }

    // ------------------------------------------------------------------ texts

    private boolean gone() {
        return isFinishing() || isDestroyed();
    }

    private void toast(String s) {
        if (s != null) Toast.makeText(getApplicationContext(), s, Toast.LENGTH_LONG).show();
    }

    String msg(MrPacks.PackException e) {
        String s = t(e.key, e.args);
        return s != null ? s : e.key;
    }

    String t(String name, Object... args) {
        int id = getResources().getIdentifier(name, "string", getPackageName());
        if (id == 0) return name;
        try {
            return args.length == 0 ? getResources().getString(id) : getResources().getString(id, args);
        } catch (RuntimeException e) {
            return getResources().getString(id);
        }
    }
}
