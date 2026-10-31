package com.mrkeyboard.app;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
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
 * Tela "Sugestões e dicionários" (v1.63, refeita na 1.67). Uma tela só para os idiomas e as
 * sugestões:
 *  - cartões de idioma (pt-BR, en-US e es sempre, mais o que o catálogo trouxer), cada um com o
 *    estado do dicionário; tocar abre os detalhes (baixar, atualizar, remover). Idioma com
 *    dicionário instalado é idioma do teclado (MrPacks.syncLanguages);
 *  - as opções de sugestões (res/xml/prefs_suggestions.xml, nas preferências padrão);
 *  - a nota de privacidade.
 * Só se conecta quando o usuário toca em "Procurar atualizações", em "Baixar"/"Atualizar" ou em
 * um idioma não instalado quando ainda não há catálogo guardado (para mostrar o tamanho antes de
 * baixar). Usa o mesmo visual das outras telas (tema, cabeçalho de SettingsHeader e UiLocale).
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
    /** Idioma tocado enquanto o catálogo era buscado: abre os detalhes quando chegar. */
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
     * "Correções rápidas" usa a tabela de autotexto do Android, que só existe para alguns idiomas:
     * sem ela a opção não faz nada e sai da tela (como era na tela de configurações).
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

    // ------------------------------------------------------------------ lista

    /** Nome do idioma quando o catálogo ainda não foi visto (cartões padrão). */
    private String langName(String id) {
        String key = "mr_lang_" + id.replace('-', '_');
        return getResources().getIdentifier(key, "string", getPackageName()) != 0 ? t(key) : id;
    }

    /** Monta de novo a lista de idiomas (padrão, catálogo e instalados) e põe o teclado em dia. */
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
        hint.setSummary(t("mr_dicts_langs_hint"));
        mLangs.addPreference(hint);
        MrPacks.syncLanguages(this, ids);
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

    /** Cor da paleta do app (mr_colors.xml) pelo nome, ou 0 se não existir. */
    private int color(String name) {
        int id = getResources().getIdentifier(name, "color", getPackageName());
        return id != 0 ? getResources().getColor(id) : 0;
    }

    /** Fim da parte do texto que leva a cor: até " · " ou ":" (o resto, como tamanho e versão, fica cinza). */
    private static int headEnd(String s) {
        int a = s.indexOf(" · "), b = s.indexOf(':');
        if (a < 0) a = s.length();
        if (b < 0) b = s.length();
        return Math.min(a, b);
    }

    /** O começo do texto (o estado) na cor da paleta; o resto no cinza de sempre. */
    private CharSequence paint(String text, String colorName, boolean whole) {
        int c = colorName == null ? 0 : color(colorName);
        if (c == 0 || text.length() == 0) return text;
        SpannableString sp = new SpannableString(text);
        sp.setSpan(new ForegroundColorSpan(c), 0, whole ? text.length() : headEnd(text), Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        return sp;
    }

    /**
     * Estado do cartão, com cor no estado: instalado verde, baixando ou instalando âmbar,
     * atualização azul, falha vermelho; não baixado fica no cinza do resumo.
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

    // ------------------------------------------------------------------ ações

    /** Toque em um idioma: sem catálogo guardado e sem pacote instalado, busca o catálogo antes. */
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
