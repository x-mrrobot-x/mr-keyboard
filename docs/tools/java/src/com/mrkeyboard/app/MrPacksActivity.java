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
import android.preference.PreferenceManager;
import android.preference.PreferenceScreen;
import android.widget.Toast;

import java.io.File;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

/**
 * Tela "Dicionários" (v1.63): lista os pacotes do catálogo e os instalados, com baixar, atualizar e
 * remover. Só se conecta quando o usuário toca em "Procurar atualizações" ou "Baixar"/"Atualizar"
 * (ou ao abrir, se ele ligou essa opção). Montada em código, com o mesmo visual das outras telas
 * de configurações (tema, cabeçalho de SettingsHeader e idioma de UiLocale).
 */
public class MrPacksActivity extends PreferenceActivity {
    private final Handler mHandler = new Handler(Looper.getMainLooper());
    private final HashMap<String, Preference> mPackPrefs = new HashMap<String, Preference>();
    private PreferenceCategory mLangs;
    private Preference mCheck;
    private MrPacks.Catalog mCat;
    private boolean mChecking;
    private String mCheckError;
    private String mError;
    private String mErrorId;

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
        PreferenceManager pm = getPreferenceManager();
        pm.setSharedPreferencesName(MrPacks.PREFS);
        PreferenceScreen root = pm.createPreferenceScreen(this);

        mLangs = category(root, "mr_dicts_cat_langs", "mr_ui_ic_globe_mint");

        PreferenceCategory opts = category(root, "mr_dicts_cat_options", "mr_ui_ic_gear_slate");
        CheckBoxPreference wifi = new CheckBoxPreference(this);
        wifi.setKey(MrPacks.KEY_WIFI);
        wifi.setTitle(t("mr_dicts_wifi"));
        wifi.setSummary(t("mr_dicts_wifi_sum"));
        wifi.setDefaultValue(Boolean.TRUE);
        wifi.setPersistent(true);
        opts.addPreference(wifi);
        CheckBoxPreference auto = new CheckBoxPreference(this);
        auto.setKey(MrPacks.KEY_AUTO);
        auto.setTitle(t("mr_dicts_auto"));
        auto.setSummary(t("mr_dicts_auto_sum"));
        auto.setDefaultValue(Boolean.FALSE);
        auto.setPersistent(true);
        opts.addPreference(auto);

        PreferenceCategory priv = category(root, "mr_dicts_cat_privacy", "mr_ui_ic_info_slate");
        Preference text = new Preference(this);
        text.setTitle(t("mr_dicts_privacy_title"));
        text.setSummary(t("mr_dicts_privacy_text"));
        text.setSelectable(false);
        text.setPersistent(false);
        priv.addPreference(text);

        setPreferenceScreen(root);
        ListDividerFix.apply(this);

        mCat = MrPacks.cachedCatalog(this);
        rebuild();
        if (MrPacks.autoCheck(this)) check();
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

    // ------------------------------------------------------------------ lista

    private PreferenceCategory category(PreferenceScreen root, String title, String icon) {
        PreferenceCategory c = new PreferenceCategory(this);
        c.setTitle(t(title));
        int id = getResources().getIdentifier(icon, "drawable", getPackageName());
        if (id != 0) c.setIcon(id);
        root.addPreference(c);
        return c;
    }

    /** Monta de novo a lista de idiomas (pacotes do catálogo e instalados). */
    private void rebuild() {
        if (mLangs == null) return;
        mLangs.removeAll();
        mPackPrefs.clear();
        ArrayList<String> ids = new ArrayList<String>();
        if (mCat != null) for (MrPacks.Pack p : mCat.packs) ids.add(p.id);
        for (String id : MrPacks.installedIds(this)) if (!ids.contains(id)) ids.add(id);
        Locale loc = getResources().getConfiguration().locale;
        for (final String id : ids) {
            MrPacks.Pack p = mCat != null ? mCat.find(id) : null;
            Preference pr = new Preference(this);
            pr.setPersistent(false);
            pr.setTitle(p != null ? p.name(loc) : id);
            pr.setOnPreferenceClickListener(new Preference.OnPreferenceClickListener() {
                public boolean onPreferenceClick(Preference preference) {
                    showPack(id);
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
        update();
    }

    /** Atualiza só os textos (durante o download). */
    private void update() {
        for (String id : mPackPrefs.keySet()) {
            MrPacks.Pack p = mCat != null ? mCat.find(id) : null;
            mPackPrefs.get(id).setSummary(state(id, p));
        }
        if (mCheck != null) mCheck.setSummary(checkState());
    }

    private String state(String id, MrPacks.Pack p) {
        int inst = MrPacks.installedVersion(this, id);
        if (id.equals(MrPacks.sJobId)) {
            return MrPacks.sJobInstalling ? t("mr_dicts_state_installing")
                    : t("mr_dicts_state_downloading", MrPacks.sJobPercent);
        }
        if (id.equals(mErrorId) && mError != null) return mError;
        boolean newer = p != null && p.version > inst;
        if (newer && MrPacks.appTooOld(this, p)) {
            return inst > 0 ? t("mr_dicts_state_installed", inst, MrPacks.sizeText(dirSize(id, inst)))
                    + " · " + t("mr_dicts_state_needs_app") : t("mr_dicts_state_needs_app");
        }
        if (inst > 0) {
            if (newer) return t("mr_dicts_state_update", p.version, MrPacks.sizeText(p.size));
            return t("mr_dicts_state_installed", inst, MrPacks.sizeText(dirSize(id, inst)));
        }
        if (p != null) return t("mr_dicts_state_available", MrPacks.sizeText(p.size));
        return "";
    }

    private String checkState() {
        if (mChecking) return t("mr_dicts_checking");
        if (mCheckError != null) return mCheckError;
        long at = MrPacks.checkedAt(this);
        if (at == 0) return t("mr_dicts_check_never");
        String when = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT).format(new Date(at));
        String s = t("mr_dicts_check_last", when);
        if (mCat != null && mCat.packs.isEmpty()) s = s + " · " + t("mr_dicts_empty");
        return s;
    }

    private long dirSize(String id, int version) {
        File[] fs = MrPacks.packDir(this, id, version).listFiles();
        long n = 0;
        if (fs != null) for (File f : fs) n += f.length();
        return n;
    }

    // ------------------------------------------------------------------ ações

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
                        if (!gone()) rebuild();
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
                        } else if (!PreferenceManager.getDefaultSharedPreferences(app)
                                .getBoolean("show_suggestions", false)) {
                            toast(t("mr_dicts_installed_turn_on"));
                        } else {
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

    // ------------------------------------------------------------------ textos

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
