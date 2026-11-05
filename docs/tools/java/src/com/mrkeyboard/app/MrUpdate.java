package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;

import java.security.cert.X509Certificate;
import java.util.Locale;
import java.util.Map;

/**
 * Notice of a new version (v1.82.0): reads update.json from the latest release, checks it and says whether there is
 * a version newer than the installed one. Nothing here downloads or installs the APK.
 *
 * The file is signed with the APK key, with its own prefix (SIG_PREFIX), and is only accepted if the signature
 * matches the certificate this app was installed with (MrPacks.verifySigned, the same code as for the catalog).
 * What it says is then checked again: tag like v1.82.0, versionCode that follows from the tag, APK named
 * mr-keyboard-&lt;tag&gt;.apk with a size and a SHA-256, notes in English (and Portuguese). The file carries no
 * address: the APK link is RELEASES_URL + tag + name, built here from constants of the app.
 *
 * Privacy: one HTTPS GET to github.com, with the fixed User-Agent of MrPacks and nothing from the user or the device;
 * the comparison of versions is made on the device.
 *
 * Security: a versionCode lower than the highest already seen is refused (an old signed file cannot be played back),
 * and only a versionCode higher than the installed one is offered.
 *
 * State in SharedPreferences "mr_update": the time of the last good check and of the last try, the highest
 * versionCode seen and the last verified notice (to show it without the network).
 *
 * One check serves everybody: the opening of the app (checkIfOlder with WINDOW), the "Check for updates" line
 * (check) and the morning job (checkIfOlder with JOB_REUSE). Run them off the main thread.
 */
public final class MrUpdate {
    private MrUpdate() { }

    static final String UPDATE_URL = "https://github.com/x-mrrobot-x/mr-keyboard/releases/latest/download/update.json";
    /** The page of the latest release ("View on GitHub"): full notes, hashes and the source zip. */
    static final String RELEASE_PAGE = "https://github.com/x-mrrobot-x/mr-keyboard/releases/latest";
    static final String SIG_PREFIX = "mr-keyboard/update/v1\n";
    static final int FORMAT = 1;
    static final String PREFS = "mr_update";
    static final String KEY_CHECKED = "checked_at";
    static final String KEY_TRIED = "tried_at";
    static final String KEY_SEEN = "seen_code";
    static final String KEY_NOTICE = "notice";
    static final String KEY_AUTO = "auto";
    static final String KEY_SNOOZE_CODE = "snooze_code";
    static final String KEY_SNOOZE_AT = "snooze_at";
    static final int MAX_NOTICE = 32 << 10;
    static final int MAX_NOTES = 8000;
    static final long MAX_APK = 100L << 20;
    /** On opening the app: at most one check per day. */
    static final long WINDOW = 24L * 3600 * 1000;
    /** In the morning job: the result of a check less than 6 hours old is reused. */
    static final long JOB_REUSE = 6L * 3600 * 1000;
    /** After a try that failed (or found nothing to read), the automatic checks wait this long before trying again. */
    static final long RETRY = 3600L * 1000;

    // ------------------------------------------------------------------ result

    static final int UNKNOWN = 0;      // nothing known yet (never checked, or a check was skipped)
    static final int UP_TO_DATE = 1;
    static final int AVAILABLE = 2;    // Result.notice is the newer version
    static final int FAILED = 3;       // Result.error says why

    static final int ERR_NONE = 0;
    static final int ERR_NETWORK = 1;
    static final int ERR_HTTP = 2;     // Result.httpCode (e.g. 404: the release has no update.json)
    static final int ERR_FILE = 3;     // not a valid update.json (format, content, size)
    static final int ERR_SIGNATURE = 4; // not signed by this app's key
    static final int ERR_OLD = 5;      // older than a notice already seen

    /** What the notice says (already checked). */
    static final class Notice {
        long versionCode, apkSize;
        String versionName, generated, apkName, apkSha256, notesPt, notesEn, data;

        /** The notes in the language of the phone: Portuguese for pt, English for the rest (Spanish included); plain text. */
        String notes(Locale l) {
            String md = l != null && "pt".equals(l.getLanguage()) && notesPt != null ? notesPt : notesEn;
            return plain(md);
        }

        /** Where the APK is: the exact tag of the signed notice (never "latest", which may change before the download). */
        String apkUrl() {
            return MrPacks.RELEASES_URL + versionName + "/" + apkName;
        }
    }

    static final class Result {
        int status = UNKNOWN;
        Notice notice;
        int error = ERR_NONE;
        int httpCode;
        /** True when no network was used (the answer comes from the last good check). */
        boolean fromCache;
    }

    // ------------------------------------------------------------------ the notice

    /** versionCode of a tag like v1.82.0: major * 1000000 + minor * 1000 + patch (the same rule as apktool.yml). */
    static long codeOf(String tag) {
        String[] p = tag.substring(1).split("\\.");
        return Long.parseLong(p[0]) * 1000000L + Long.parseLong(p[1]) * 1000L + Long.parseLong(p[2]);
    }

    /** Reads the notice data (already checked for signature) and validates every field. */
    static Notice readData(String data) throws MrPacks.PackException {
        try {
            Map<String, Object> d = MrJson.obj(MrJson.parse(data));
            if (MrJson.num(d, "format") != FORMAT) throw new MrPacks.PackException("mr_dicts_err_new_format");
            Notice n = new Notice();
            n.data = data;
            n.versionName = MrJson.str(d, "versionName");
            if (!MrPacks.validTag(n.versionName)) throw new IllegalArgumentException("versionName");
            n.versionCode = MrJson.num(d, "versionCode");
            if (n.versionCode != codeOf(n.versionName)) throw new IllegalArgumentException("versionCode");
            n.generated = MrJson.optStr(d, "generated", "");
            Map<String, Object> apk = MrJson.obj(d.get("apk"));
            n.apkName = MrJson.str(apk, "name");
            if (!n.apkName.equals("mr-keyboard-" + n.versionName + ".apk")) throw new IllegalArgumentException("apk.name");
            n.apkSize = MrJson.num(apk, "size");
            if (n.apkSize <= 0 || n.apkSize > MAX_APK) throw new IllegalArgumentException("apk.size");
            n.apkSha256 = MrPacks.hexField(apk, "sha256");
            Map<String, Object> notes = MrJson.obj(d.get("notes"));
            n.notesEn = MrJson.str(notes, "en");
            n.notesPt = MrJson.optStr(notes, "pt-BR", null);
            if (n.notesEn.trim().length() == 0 || n.notesEn.length() > MAX_NOTES
                    || (n.notesPt != null && n.notesPt.length() > MAX_NOTES)) {
                throw new IllegalArgumentException("notes");
            }
            return n;
        } catch (MrPacks.PackException e) {
            throw e;
        } catch (RuntimeException e) {
            throw new MrPacks.PackException("mr_dicts_err_corrupt", "update.json");
        }
    }

    /**
     * The notes are written in simple Markdown ("- " items, **bold**, `code`); on the screen they are plain text:
     * items start with a bullet and the marks are dropped.
     */
    static String plain(String md) {
        if (md == null) return "";
        String[] lines = md.replace("\r\n", "\n").split("\n", -1);
        StringBuilder out = new StringBuilder(md.length());
        int blank = 0;
        for (String line : lines) {
            String t = line.replace("**", "").replace("`", "");
            int end = t.length();
            while (end > 0 && (t.charAt(end - 1) == ' ' || t.charAt(end - 1) == '\t')) end--;
            t = t.substring(0, end);
            if (t.startsWith("- ") || t.startsWith("* ")) t = "• " + t.substring(2);
            if (t.length() == 0) {
                if (++blank > 1) continue;
            } else {
                blank = 0;
            }
            if (out.length() > 0) out.append('\n');
            out.append(t);
        }
        return out.toString().trim();
    }

    // ------------------------------------------------------------------ state

    /** Address of update.json; replaceable in tests. */
    static String sUrl = UPDATE_URL;
    /** The time in milliseconds, fixed in tests (0 = the real one). */
    static long sTestNow;

    static long now() {
        return sTestNow != 0 ? sTestNow : System.currentTimeMillis();
    }

    static SharedPreferences prefs(Context c) {
        return c.getSharedPreferences(PREFS, Context.MODE_PRIVATE);
    }

    /** The last verified notice if it is newer than the installed version, else null. No network. */
    static Notice pending(Context c) {
        String data = prefs(c).getString(KEY_NOTICE, null);
        if (data == null) return null;
        try {
            Notice n = readData(data);
            return n.versionCode > MrPacks.appVersion(c) ? n : null;
        } catch (MrPacks.PackException e) {
            return null;
        }
    }

    // ------------------------------------------------------------------ settings and "Not now"

    /** "Check when the app opens" (Settings, About). On by default; off means no automatic check and no pop-up. */
    static boolean auto(Context c) {
        return prefs(c).getBoolean(KEY_AUTO, true);
    }

    static void setAuto(Context c, boolean on) {
        prefs(c).edit().putBoolean(KEY_AUTO, on).commit();
    }

    /**
     * "Not now" (and View on GitHub, and closing the dialog): the pop-up for this version does not come back on opening
     * the app for WINDOW. A newer version has another versionCode and shows at once. The Settings line still shows it.
     */
    static void snooze(Context c, Notice n) {
        prefs(c).edit().putLong(KEY_SNOOZE_CODE, n.versionCode).putLong(KEY_SNOOZE_AT, now()).commit();
    }

    /** True while the pop-up for this notice is snoozed. A clock that went back counts as "not snoozed". */
    static boolean snoozed(Context c, Notice n) {
        SharedPreferences p = prefs(c);
        long at = p.getLong(KEY_SNOOZE_AT, 0), now = now();
        return p.getLong(KEY_SNOOZE_CODE, 0) == n.versionCode && at > 0 && now >= at && now - at < WINDOW;
    }

    /** What to pop up on opening: the stored newer version if it is not snoozed, else null. No network. */
    static Notice toShow(Context c) {
        Notice n = pending(c);
        return n != null && !snoozed(c, n) ? n : null;
    }

    /** The version name of the installed app (e.g. v1.82.0), or "" if it cannot be read. */
    static String appName(Context c) {
        try {
            String v = c.getPackageManager().getPackageInfo(c.getPackageName(), 0).versionName;
            return v != null ? v : "";
        } catch (Exception e) {
            return "";
        }
    }

    // ------------------------------------------------------------------ texts

    /** Name (in the strings) of the reason a check failed. */
    static String errorKey(int error) {
        switch (error) {
            case ERR_NETWORK: return "mr_update_err_network";
            case ERR_HTTP: return "mr_update_err_http";
            case ERR_SIGNATURE: return "mr_update_err_signature";
            case ERR_OLD: return "mr_update_err_old";
            default: return "mr_update_err_file";
        }
    }

    /** "1.2 MB" (decimal comma in the languages that use it); under 1 MB in KB. */
    static String sizeText(long bytes, Locale l) {
        if (bytes < 1000000L) return String.format(l, "%d KB", Math.max(1L, (bytes + 500L) / 1000L));
        return String.format(l, "%.1f MB", bytes / 1000000.0);
    }

    /** The answer from what is stored, without the network. */
    static Result cached(Context c) {
        Result r = new Result();
        r.fromCache = true;
        r.notice = pending(c);
        r.status = r.notice != null ? AVAILABLE : (prefs(c).getString(KEY_NOTICE, null) != null ? UP_TO_DATE : UNKNOWN);
        return r;
    }

    // ------------------------------------------------------------------ checking

    /**
     * Reads update.json now. Never throws: the answer says what happened. Run off the main thread.
     * A notice that fails any check is thrown away and nothing stored changes, except the time of the try.
     */
    static synchronized Result check(Context c) {
        SharedPreferences p = prefs(c);
        long now = now();
        p.edit().putLong(KEY_TRIED, now).commit();
        try {
            byte[] env = MrPacks.fetchBytes(sUrl, MAX_NOTICE, "update.json");
            X509Certificate[] certs = MrPacks.certs(c);
            Notice n = readData(MrPacks.verifySigned(env, FORMAT, SIG_PREFIX, "update.json", certs));
            long seen = p.getLong(KEY_SEEN, 0);
            if (n.versionCode < seen) return failed(ERR_OLD, 0);
            p.edit().putLong(KEY_SEEN, Math.max(seen, n.versionCode)).putString(KEY_NOTICE, n.data)
                    .putLong(KEY_CHECKED, now).commit();
            Result r = new Result();
            r.notice = pending(c);
            r.status = r.notice != null ? AVAILABLE : UP_TO_DATE;
            return r;
        } catch (MrPacks.PackException e) {
            return failure(e);
        }
    }

    /**
     * Like check, but only if the last good check is older than maxAge and the last try was not in the last hour;
     * otherwise it answers from what is stored (fromCache). A clock that went back counts as "old".
     */
    static synchronized Result checkIfOlder(Context c, long maxAge) {
        SharedPreferences p = prefs(c);
        long now = now();
        long checked = p.getLong(KEY_CHECKED, 0), tried = p.getLong(KEY_TRIED, 0);
        boolean fresh = checked > 0 && now >= checked && now - checked < maxAge;
        boolean waiting = tried > 0 && now >= tried && now - tried < RETRY;
        if (fresh || waiting) return cached(c);
        return check(c);
    }

    private static Result failed(int error, int httpCode) {
        Result r = new Result();
        r.status = FAILED;
        r.error = error;
        r.httpCode = httpCode;
        return r;
    }

    private static Result failure(MrPacks.PackException e) {
        String k = e.key;
        if (k.equals("mr_dicts_err_network")) return failed(ERR_NETWORK, 0);
        if (k.equals("mr_dicts_err_http")) return failed(ERR_HTTP, e.args.length > 0 && e.args[0] instanceof Integer ? (Integer) e.args[0] : 0);
        if (k.equals("mr_dicts_err_signature") || k.equals("mr_dicts_err_other_key")) return failed(ERR_SIGNATURE, 0);
        return failed(ERR_FILE, 0);
    }
}
