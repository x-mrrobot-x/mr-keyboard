package com.mrkeyboard.app;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.os.Build;
import android.preference.PreferenceManager;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.security.MessageDigest;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

/**
 * Downloadable dictionary packs (v1.63).
 *
 * Privacy: it only connects when the user asks (check for updates, download, update), only
 * over HTTPS and only to download files; it does not send anything that was typed, nor the device model
 * (fixed User-Agent).
 *
 * Security: the catalog comes signed with the APK key and is only accepted if the signature matches
 * the certificate this app was installed with; the catalog series cannot go back. The pack zip
 * and each file inside it must have the size and SHA-256 from the catalog; only the listed names
 * are extracted. The new pack only replaces the previous one after being checked.
 *
 * Files: files/dicts/&lt;id&gt;/&lt;version&gt;/ (main.dict, trigrams.bin, rules.txt, NOTICE.txt, pack.json).
 * State in SharedPreferences "mr_packs". The keyboard reloads when "mr_dicts_updated_at" changes in the
 * default preferences (LatinIME.onSharedPreferenceChanged).
 */
public final class MrPacks {
    private MrPacks() { }

    static final String CATALOG_URL =
            "https://github.com/x-mrrobot-x/mr-keyboard/releases/latest/download/catalog.json"; // v1.73: in the APK release
    /** Zip address = RELEASES_URL + the pack's "release" (tag) + "/" + its zip name; the catalog has no address of its own. */
    static final String RELEASES_URL = "https://github.com/x-mrrobot-x/mr-keyboard/releases/download/";
    static final String SIG_PREFIX = "mr-keyboard/catalog/v1\n";
    static final int CATALOG_FORMAT = 1;
    static final int PACK_FORMAT = 1;
    static final String PREFS = "mr_packs";
    static final String SIGNAL_KEY = "mr_dicts_updated_at";
    static final String KEY_SERIAL = "serial";
    static final String KEY_CATALOG = "catalog";
    static final String KEY_CHECKED = "checked_at";
    static final String KEY_INSTALLED = "installed.";
    static final String MAIN = "main.dict";
    static final String TRIGRAMS = "trigrams.bin";
    static final String RULES = "rules.txt";
    static final String NOTICE = "NOTICE.txt";
    static final String MANIFEST = "pack.json";
    static final int MAX_CATALOG = 1 << 20;
    static final long MAX_PACK = 64L << 20;
    static final int DICT_TYPE = 1;

    // ------------------------------------------------------------------ errors

    /** Error to show to the user: name of the text in res/values (mr_dicts_err_*) and arguments. */
    static final class PackException extends Exception {
        final String key;
        final Object[] args;

        PackException(String key, Object... args) {
            super(key);
            this.key = key;
            this.args = args;
        }
    }

    // ------------------------------------------------------------------ catalog

    static final class Pack {
        String id, lang, region, release, url, sha256, licenses, credits, manifestSha;
        Map<String, Object> name, description;
        int version, format;
        long minApp, size, installedSize;
        String[] fileNames;
        long[] fileSizes;
        String[] fileSha;

        String name(Locale l) {
            return localized(name, l, id);
        }

        String description(Locale l) {
            return localized(description, l, "");
        }
    }

    static final class Catalog {
        long serial;
        String generated, data;
        final ArrayList<Pack> packs = new ArrayList<Pack>();

        Pack find(String id) {
            for (Pack p : packs) if (p.id.equals(id)) return p;
            return null;
        }
    }

    static String localized(Map<String, Object> m, Locale l, String def) {
        if (m == null) return def;
        Object o = l != null ? m.get(l.getLanguage()) : null;
        if (!(o instanceof String)) o = m.get("en");
        if (!(o instanceof String)) {
            for (Object v : m.values()) if (v instanceof String) return (String) v;
            return def;
        }
        return (String) o;
    }

    /**
     * Checks and reads the catalog (JSON envelope with the signature). certs: this app's certificates.
     * minSerial: the highest series already seen (the catalog cannot be older).
     */
    static Catalog parseCatalog(byte[] envelope, X509Certificate[] certs, long minSerial) throws PackException {
        Map<String, Object> env;
        String data;
        byte[] sig;
        String alg;
        try {
            env = MrJson.obj(MrJson.parse(new String(envelope, "UTF-8")));
            if (MrJson.num(env, "format") != CATALOG_FORMAT) throw new PackException("mr_dicts_err_new_format");
            alg = MrJson.str(env, "algorithm");
            data = MrJson.str(env, "data");
            sig = Base64.getDecoder().decode(MrJson.str(env, "signature"));
        } catch (PackException e) {
            throw e;
        } catch (Exception e) {
            throw new PackException("mr_dicts_err_corrupt", "catalog.json");
        }
        if (!alg.equals("SHA256withRSA") && !alg.equals("SHA256withECDSA") && !alg.equals("SHA256withDSA")) {
            throw new PackException("mr_dicts_err_signature");
        }
        byte[] msg;
        try {
            byte[] p = SIG_PREFIX.getBytes("UTF-8");
            byte[] d = data.getBytes("UTF-8");
            msg = new byte[p.length + d.length];
            System.arraycopy(p, 0, msg, 0, p.length);
            System.arraycopy(d, 0, msg, p.length, d.length);
        } catch (IOException e) {
            throw new PackException("mr_dicts_err_signature");
        }
        boolean ok = false;
        if (certs != null) {
            for (X509Certificate c : certs) {
                try {
                    java.security.Signature v = java.security.Signature.getInstance(alg);
                    v.initVerify(c.getPublicKey());
                    v.update(msg);
                    if (v.verify(sig)) {
                        ok = true;
                        break;
                    }
                } catch (Exception ignored) {
                    // key of another type: try the next certificate
                }
            }
        }
        if (!ok) {
            String signer = MrJson.optStr(env, "signer", null);
            if (signer != null && certs != null && certs.length > 0 && !signer.equalsIgnoreCase(certSha(certs[0]))) {
                throw new PackException("mr_dicts_err_other_key");
            }
            throw new PackException("mr_dicts_err_signature");
        }
        Catalog cat = readData(data);
        if (cat.serial < minSerial) throw new PackException("mr_dicts_err_old_catalog");
        return cat;
    }

    /** Reads the catalog data (already checked). */
    static Catalog readData(String data) throws PackException {
        try {
            Map<String, Object> d = MrJson.obj(MrJson.parse(data));
            if (MrJson.num(d, "format") != CATALOG_FORMAT) throw new PackException("mr_dicts_err_new_format");
            Catalog cat = new Catalog();
            cat.data = data;
            cat.serial = MrJson.num(d, "serial");
            cat.generated = MrJson.optStr(d, "generated", "");
            HashSet<String> ids = new HashSet<String>();
            for (Object o : MrJson.list(d.get("packs"))) {
                Pack p = readPack(MrJson.obj(o));
                if (ids.add(p.id)) cat.packs.add(p);
            }
            return cat;
        } catch (PackException e) {
            throw e;
        } catch (RuntimeException e) {
            throw new PackException("mr_dicts_err_corrupt", "catalog.json");
        }
    }

    @SuppressWarnings("unchecked")
    private static Pack readPack(Map<String, Object> m) {
        Pack p = new Pack();
        p.id = MrJson.str(m, "id");
        if (!validId(p.id)) throw new IllegalArgumentException("id");
        p.lang = MrJson.str(m, "lang").toLowerCase(Locale.ROOT);
        p.region = MrJson.optStr(m, "region", "").toUpperCase(Locale.ROOT);
        Object nm = m.get("name");
        p.name = nm instanceof Map ? (Map<String, Object>) nm : null;
        Object ds = m.get("description");
        p.description = ds instanceof Map ? (Map<String, Object>) ds : null;
        p.version = (int) MrJson.num(m, "version");
        p.format = (int) MrJson.num(m, "format");
        p.minApp = MrJson.num(m, "minApp");
        p.release = MrJson.str(m, "release");
        if (!validTag(p.release)) throw new IllegalArgumentException("release");
        p.url = MrJson.str(m, "url");
        if (!safeName(p.url) || !p.url.endsWith(".zip")) throw new IllegalArgumentException("url");
        p.size = MrJson.num(m, "size");
        p.installedSize = MrJson.num(m, "installedSize");
        if (p.version < 1 || p.size <= 0 || p.size > MAX_PACK || p.installedSize <= 0 || p.installedSize > MAX_PACK) {
            throw new IllegalArgumentException("size");
        }
        p.sha256 = hexField(m, "sha256");
        p.manifestSha = hexField(m, "manifestSha256");
        List<Object> files = MrJson.list(m.get("files"));
        int n = files.size();
        if (n == 0 || n > 32) throw new IllegalArgumentException("files");
        p.fileNames = new String[n];
        p.fileSizes = new long[n];
        p.fileSha = new String[n];
        boolean main = false;
        HashSet<String> seen = new HashSet<String>();
        for (int i = 0; i < n; i++) {
            Map<String, Object> f = MrJson.obj(files.get(i));
            String fn = MrJson.str(f, "name");
            if (!safeName(fn) || fn.equals(MANIFEST) || !seen.add(fn)) throw new IllegalArgumentException("name");
            p.fileNames[i] = fn;
            p.fileSizes[i] = MrJson.num(f, "size");
            if (p.fileSizes[i] <= 0 || p.fileSizes[i] > MAX_PACK) throw new IllegalArgumentException("size");
            p.fileSha[i] = hexField(f, "sha256");
            if (fn.equals(MAIN)) main = true;
        }
        if (!main) throw new IllegalArgumentException("no main.dict");
        Object lic = m.get("licenses");
        StringBuilder b = new StringBuilder();
        if (lic instanceof List) {
            for (Object o : (List<Object>) lic) {
                if (o instanceof String) {
                    if (b.length() > 0) b.append(", ");
                    b.append((String) o);
                }
            }
        }
        p.licenses = b.toString();
        p.credits = MrJson.optStr(m, "credits", "");
        return p;
    }

    private static String hexField(Map<String, Object> m, String k) {
        String s = MrJson.str(m, k).toLowerCase(Locale.ROOT);
        if (s.length() != 64) throw new IllegalArgumentException(k);
        for (int i = 0; i < 64; i++) {
            char c = s.charAt(i);
            if (!((c >= '0' && c <= '9') || (c >= 'a' && c <= 'f'))) throw new IllegalArgumentException(k);
        }
        return s;
    }

    static boolean validId(String id) {
        // pt, pt-BR, en-US
        if (id == null) return false;
        int n = id.length();
        if (n == 2 || n == 3) return lowerLetters(id, 0, n);
        if (n == 5 || n == 6) {
            int dash = n - 3;
            if (id.charAt(dash) != '-') return false;
            return lowerLetters(id, 0, dash) && Character.isUpperCase(id.charAt(dash + 1))
                    && Character.isUpperCase(id.charAt(dash + 2))
                    && id.charAt(dash + 1) <= 'Z' && id.charAt(dash + 2) <= 'Z';
        }
        return false;
    }

    private static boolean lowerLetters(String s, int from, int to) {
        if (to - from < 2) return false;
        for (int i = from; i < to; i++) {
            char c = s.charAt(i);
            if (c < 'a' || c > 'z') return false;
        }
        return true;
    }

    /** Release tag like v1.82.0 (v and three numbers separated by dots): it goes into the download address. */
    static boolean validTag(String s) {
        if (s == null || s.length() < 6 || s.length() > 16 || s.charAt(0) != 'v') return false;
        int dots = 0, digits = 0;
        for (int i = 1; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c >= '0' && c <= '9') {
                digits++;
            } else if (c == '.' && digits > 0) {
                dots++;
                digits = 0;
            } else {
                return false;
            }
        }
        return dots == 2 && digits > 0;
    }

    /** Where the pack's zip is: the release that made it (the catalog says which one), not necessarily the latest. */
    static String zipUrl(Pack p) {
        return RELEASES_URL + p.release + "/" + p.url;
    }

    /** File name without a folder: letters, digits, . _ - (does not start with a dot). */
    static boolean safeName(String s) {
        if (s == null || s.length() == 0 || s.length() > 64) return false;
        char c0 = s.charAt(0);
        if (!((c0 >= 'a' && c0 <= 'z') || (c0 >= 'A' && c0 <= 'Z') || (c0 >= '0' && c0 <= '9'))) return false;
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            boolean ok = (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9')
                    || c == '.' || c == '_' || c == '-';
            if (!ok) return false;
        }
        return !s.contains("..");
    }

    // ------------------------------------------------------------------ network

    /** Opens a URL for reading; replaceable in tests. */
    interface Net {
        InputStream open(String url, long[] length) throws IOException;
    }

    static Net sNet = new Net() {
        public InputStream open(String url, long[] length) throws IOException {
            URL u = new URL(url);
            if (!"https".equals(u.getProtocol())) throw new IOException("https");
            HttpURLConnection c = (HttpURLConnection) u.openConnection();
            c.setConnectTimeout(15000);
            c.setReadTimeout(30000);
            c.setInstanceFollowRedirects(true);
            c.setUseCaches(false);
            // fixed, so as not to send the device model (the Android default does)
            c.setRequestProperty("User-Agent", "MrKeyboard");
            c.setRequestProperty("Accept-Encoding", "identity");
            int code = c.getResponseCode();
            if (code != 200) {
                c.disconnect();
                throw new HttpError(code);
            }
            if (!"https".equals(c.getURL().getProtocol())) {
                c.disconnect();
                throw new IOException("https");
            }
            length[0] = c.getContentLength();
            return c.getInputStream();
        }
    };

    static final class HttpError extends IOException {
        final int code;

        HttpError(int code) {
            super("HTTP " + code);
            this.code = code;
        }
    }

    static String sCatalogUrl = CATALOG_URL;
    /** Certificates to check the catalog in tests (on the device: the app's own). */
    static X509Certificate[] sTestCerts;

    static byte[] fetchBytes(String url, int max) throws PackException {
        InputStream in = null;
        try {
            long[] len = new long[1];
            in = sNet.open(url, len);
            ByteArrayOutputStream out = new ByteArrayOutputStream(len[0] > 0 && len[0] <= max ? (int) len[0] : 8192);
            byte[] buf = new byte[8192];
            int r;
            while ((r = in.read(buf)) > 0) {
                out.write(buf, 0, r);
                if (out.size() > max) throw new PackException("mr_dicts_err_corrupt", "catalog.json");
            }
            return out.toByteArray();
        } catch (HttpError e) {
            throw new PackException("mr_dicts_err_http", e.code);
        } catch (IOException e) {
            throw new PackException("mr_dicts_err_network");
        } finally {
            closeQuietly(in);
        }
    }

    // ------------------------------------------------------------------ saved state

    static SharedPreferences prefs(Context c) {
        return c.getSharedPreferences(PREFS, Context.MODE_PRIVATE);
    }

    private static String sCachedData;
    private static Catalog sCached;

    /** Last catalog checked (no network), or null. */
    static synchronized Catalog cachedCatalog(Context c) {
        String data = prefs(c).getString(KEY_CATALOG, null);
        if (data == null) return null;
        if (data.equals(sCachedData)) return sCached;
        try {
            sCached = readData(data);
        } catch (PackException e) {
            sCached = null;
        }
        sCachedData = data;
        return sCached;
    }

    static long checkedAt(Context c) {
        return prefs(c).getLong(KEY_CHECKED, 0);
    }

    /** Downloads and checks the catalog; stores the series and the data. Run off the main thread. */
    static Catalog fetchCatalog(Context c) throws PackException {
        byte[] env = fetchBytes(sCatalogUrl, MAX_CATALOG);
        SharedPreferences p = prefs(c);
        Catalog cat = parseCatalog(env, certs(c), p.getLong(KEY_SERIAL, 0));
        p.edit().putLong(KEY_SERIAL, cat.serial).putString(KEY_CATALOG, cat.data)
                .putLong(KEY_CHECKED, System.currentTimeMillis()).commit();
        return cat;
    }

    static int installedVersion(Context c, String id) {
        return prefs(c).getInt(KEY_INSTALLED + id, 0);
    }

    /** Ids of the installed packs. */
    static ArrayList<String> installedIds(Context c) {
        ArrayList<String> out = new ArrayList<String>();
        for (String k : prefs(c).getAll().keySet()) {
            if (k.startsWith(KEY_INSTALLED)) {
                String id = k.substring(KEY_INSTALLED.length());
                if (validId(id)) out.add(id);
            }
        }
        java.util.Collections.sort(out);
        return out;
    }

    /** How many installed packs have a newer version in the catalog and can be updated by this app. */
    static int updatesAvailable(Context c, Catalog cat) {
        if (cat == null) return 0;
        int n = 0;
        for (Pack p : cat.packs) {
            int inst = installedVersion(c, p.id);
            if (inst > 0 && p.version > inst && !appTooOld(c, p)) n++;
        }
        return n;
    }

    // ------------------------------------------------------------------ keyboard languages

    /** Key in the default preferences with the keyboard languages, read by LanguageSwitcher. */
    static final String LANGS_KEY = "selected_languages";

    /** Languages that always appear as cards on the screen, even without a catalog (and offline). */
    static final String[] DEFAULT_IDS = {"pt-BR", "en-US", "es"};

    /**
     * Order of the cards: the app language first, then the default ones, those from the catalog and, last,
     * the installed ones that the catalog does not list (no repeats). Only those of the same language move up; the order
     * among the others does not change.
     */
    static ArrayList<String> cardIds(List<String> catalogIds, List<String> installed, String uiLanguage) {
        ArrayList<String> all = new ArrayList<String>();
        for (String id : DEFAULT_IDS) all.add(id);
        if (catalogIds != null) for (String id : catalogIds) if (validId(id) && !all.contains(id)) all.add(id);
        if (installed != null) for (String id : installed) if (!all.contains(id)) all.add(id);
        ArrayList<String> out = new ArrayList<String>();
        String lang = uiLanguage == null ? "" : uiLanguage.toLowerCase(Locale.ROOT);
        for (String id : all) if (splitLocale(id)[0].equals(lang)) out.add(id);
        for (String id : all) if (!out.contains(id)) out.add(id);
        return out;
    }

    /**
     * Value of "selected_languages" for the installed packs, in the order of the cards
     * ("pt_BR,en_US,"), or null if there are none (the keyboard goes back to using the device language).
     */
    static String languageKeys(List<String> order, List<String> installed) {
        StringBuilder sb = new StringBuilder();
        for (String id : order) if (installed.contains(id)) sb.append(id.replace('-', '_')).append(',');
        return sb.length() == 0 ? null : sb.toString();
    }

    /**
     * Makes the keyboard languages equal to the installed packs: downloaded the dictionary, the language enters
     * the keyboard (the space bar switches between them); removed, it leaves. Only writes if it changed.
     */
    static void syncLanguages(Context c, List<String> order) {
        String keys = languageKeys(order, installedIds(c));
        SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(c);
        String now = sp.getString(LANGS_KEY, null);
        if (keys == null ? now == null : keys.equals(now)) return;
        SharedPreferences.Editor e = sp.edit();
        if (keys == null) e.remove(LANGS_KEY); else e.putString(LANGS_KEY, keys);
        e.apply();
    }

    static File root(Context c) {
        return new File(c.getFilesDir(), "dicts");
    }

    static File packDir(Context c, String id, int version) {
        return new File(new File(root(c), id), String.valueOf(version));
    }

    // ------------------------------------------------------------------ download and install

    /** Download in progress (one at a time), read by the screen. */
    static volatile String sJobId;
    static volatile int sJobPercent;
    static volatile boolean sJobInstalling;
    static volatile boolean sCancel;

    static long appVersion(Context c) {
        try {
            return c.getPackageManager().getPackageInfo(c.getPackageName(), 0).versionCode;
        } catch (Exception e) {
            return 0;
        }
    }

    static boolean appTooOld(Context c, Pack p) {
        return p.format != PACK_FORMAT || p.minApp > appVersion(c);
    }

    /**
     * Downloads, checks and installs the pack (replaces the previous version only at the end). Run off the
     * main thread.
     */
    static void install(Context c, Catalog cat, Pack p) throws PackException {
        sCancel = false;
        sJobPercent = 0;
        sJobInstalling = false;
        sJobId = p.id;
        File base = root(c);
        File part = new File(c.getCacheDir(), p.id + "-" + p.version + ".zip.part");
        File tmp = new File(new File(base, p.id), p.version + ".tmp");
        try {
            if (appTooOld(c, p)) throw new PackException("mr_dicts_err_app_old");
            long need = p.size + p.installedSize + (2L << 20);
            if (!base.exists()) base.mkdirs();
            if (base.getUsableSpace() < need) throw new PackException("mr_dicts_err_space", sizeText(need));
            download(zipUrl(p), part, p);
            sJobInstalling = true;
            deleteTree(tmp);
            extract(part, tmp, p);
            checkFiles(tmp);
            File dir = packDir(c, p.id, p.version);
            deleteTree(dir);
            if (!tmp.renameTo(dir)) throw new PackException("mr_dicts_err_io", "rename");
            prefs(c).edit().putInt(KEY_INSTALLED + p.id, p.version).commit();
            File[] old = new File(base, p.id).listFiles();
            if (old != null) {
                for (File f : old) {
                    if (!f.getName().equals(String.valueOf(p.version))) deleteTree(f);
                }
            }
            signal(c);
        } finally {
            part.delete();
            deleteTree(tmp);
            sJobId = null;
            sJobInstalling = false;
        }
    }

    private static void download(String url, File part, Pack p) throws PackException {
        InputStream in = null;
        OutputStream out = null;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            long[] len = new long[1];
            in = sNet.open(url, len);
            if (len[0] > 0 && len[0] != p.size) throw new PackException("mr_dicts_err_corrupt", "size");
            out = new FileOutputStream(part);
            byte[] buf = new byte[65536];
            long total = 0;
            int r;
            while ((r = in.read(buf)) > 0) {
                if (sCancel) throw new PackException("mr_dicts_err_cancel");
                total += r;
                if (total > p.size) throw new PackException("mr_dicts_err_corrupt", "size");
                md.update(buf, 0, r);
                out.write(buf, 0, r);
                sJobPercent = (int) (total * 100 / p.size);
            }
            out.close();
            out = null;
            if (total != p.size) throw new PackException("mr_dicts_err_corrupt", "size");
            if (!hex(md.digest()).equals(p.sha256)) throw new PackException("mr_dicts_err_corrupt", "sha256");
        } catch (PackException e) {
            throw e;
        } catch (HttpError e) {
            throw new PackException("mr_dicts_err_http", e.code);
        } catch (IOException e) {
            if (sCancel) throw new PackException("mr_dicts_err_cancel");
            throw new PackException("mr_dicts_err_network");
        } catch (Exception e) {
            throw new PackException("mr_dicts_err_io", e.getClass().getSimpleName());
        } finally {
            closeQuietly(in);
            closeQuietly(out);
        }
    }

    /** Extracts only the files in the catalog, checking the size and SHA-256 of each. */
    private static void extract(File zip, File dir, Pack p) throws PackException {
        if (!dir.mkdirs() && !dir.isDirectory()) throw new PackException("mr_dicts_err_io", "mkdir");
        HashSet<String> seen = new HashSet<String>();
        ZipInputStream zin = null;
        try {
            zin = new ZipInputStream(new FileInputStream(zip));
            byte[] buf = new byte[65536];
            ZipEntry e;
            while ((e = zin.getNextEntry()) != null) {
                String name = e.getName();
                long size;
                String sha;
                if (name.equals(MANIFEST)) {
                    size = 1 << 16;
                    sha = p.manifestSha;
                } else {
                    int i = indexOf(p.fileNames, name);
                    if (i < 0) throw new PackException("mr_dicts_err_corrupt", name);
                    size = p.fileSizes[i];
                    sha = p.fileSha[i];
                }
                if (e.isDirectory() || !seen.add(name)) throw new PackException("mr_dicts_err_corrupt", name);
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                OutputStream out = new FileOutputStream(new File(dir, name));
                long total = 0;
                try {
                    int r;
                    while ((r = zin.read(buf)) > 0) {
                        if (sCancel) throw new PackException("mr_dicts_err_cancel");
                        total += r;
                        if (total > size) throw new PackException("mr_dicts_err_corrupt", name);
                        md.update(buf, 0, r);
                        out.write(buf, 0, r);
                    }
                } finally {
                    out.close();
                }
                if (!name.equals(MANIFEST) && total != size) throw new PackException("mr_dicts_err_corrupt", name);
                if (!hex(md.digest()).equals(sha)) throw new PackException("mr_dicts_err_corrupt", name);
            }
        } catch (PackException ex) {
            throw ex;
        } catch (Exception ex) {
            throw new PackException("mr_dicts_err_corrupt", "zip");
        } finally {
            closeQuietly(zin);
        }
        for (String n : p.fileNames) {
            if (!seen.contains(n)) throw new PackException("mr_dicts_err_corrupt", n);
        }
    }

    /** Checks the content before using it: dictionary header, the two words and the rules. */
    static void checkFiles(File dir) throws PackException {
        File main = new File(dir, MAIN);
        if (!dictHeaderOk(main)) throw new PackException("mr_dicts_err_corrupt", MAIN);
        File tri = new File(dir, TRIGRAMS);
        if (tri.exists()) {
            byte[] h = head(tri, 4);
            if (h == null || h[0] != 'M' || h[1] != 'R' || h[2] != 'T' || h[3] != '1') {
                throw new PackException("mr_dicts_err_corrupt", TRIGRAMS);
            }
        }
        File rules = new File(dir, RULES);
        if (rules.exists()) {
            InputStream in = null;
            try {
                in = new FileInputStream(rules);
                MrRules.parse(in);
            } catch (IOException e) {
                throw new PackException("mr_dicts_err_corrupt", RULES);
            } finally {
                closeQuietly(in);
            }
        }
    }

    static boolean dictHeaderOk(File f) {
        long n = f.length();
        if (n < 1024 || n > 4194304) return false;
        byte[] h = head(f, 2);
        return h != null && (h[0] & 0xFF) == 200 && h[1] == 1;
    }

    private static byte[] head(File f, int n) {
        InputStream in = null;
        try {
            in = new FileInputStream(f);
            byte[] b = new byte[n];
            int got = 0;
            while (got < n) {
                int r = in.read(b, got, n - got);
                if (r <= 0) return null;
                got += r;
            }
            return b;
        } catch (IOException e) {
            return null;
        } finally {
            closeQuietly(in);
        }
    }

    /** Removes the pack. The words learned by the keyboard do not change. */
    static void remove(Context c, String id) {
        prefs(c).edit().remove(KEY_INSTALLED + id).commit();
        deleteTree(new File(root(c), id));
        signal(c);
    }

    /** Tells the keyboard (LatinIME.onSharedPreferenceChanged) to reload the dictionary. */
    static void signal(Context c) {
        PreferenceManager.getDefaultSharedPreferences(c).edit()
                .putLong(SIGNAL_KEY, System.currentTimeMillis()).apply();
    }

    // ------------------------------------------------------------------ use by the keyboard

    /** Language (lowercase) and region (uppercase) of "pt_BR", "pt-br", "pt". */
    static String[] splitLocale(String locale) {
        if (locale == null) return new String[] {"", ""};
        String s = locale.trim();
        int cut = s.indexOf('_');
        if (cut < 0) cut = s.indexOf('-');
        String lang = (cut < 0 ? s : s.substring(0, cut)).toLowerCase(Locale.ROOT);
        String region = cut < 0 ? "" : s.substring(cut + 1).toUpperCase(Locale.ROOT);
        int cut2 = region.indexOf('_');
        if (cut2 < 0) cut2 = region.indexOf('-');
        if (cut2 >= 0) region = region.substring(0, cut2);
        return new String[] {lang, region};
    }

    /** Folder of the pack installed for the language (the same region first), or null. */
    static File installedFor(Context c, String locale) {
        String[] lr = splitLocale(locale);
        if (lr[0].length() == 0) return null;
        String best = null;
        for (String id : installedIds(c)) {
            String[] p = splitLocale(id);
            if (!p[0].equals(lr[0])) continue;
            if (best == null || (p[1].equals(lr[1]) && !splitLocale(best)[1].equals(lr[1]))) best = id;
        }
        if (best == null) return null;
        File dir = packDir(c, best, installedVersion(c, best));
        return new File(dir, MAIN).isFile() ? dir : null;
    }

    /** Dictionary of the pack, mapped from the file (the system only loads what is read), or null. */
    static BinaryDictionary openDictionary(Context c, String locale) {
        try {
            if (c == null) return null;
            File dir = installedFor(c, locale);
            return dir != null ? open(c, new File(dir, MAIN)) : null;
        } catch (Throwable e) {
            return null;
        }
    }

    static BinaryDictionary open(Context c, File main) throws IOException {
        if (!dictHeaderOk(main)) return null;
        RandomAccessFile raf = new RandomAccessFile(main, "r");
        try {
            FileChannel ch = raf.getChannel();
            MappedByteBuffer buf = ch.map(FileChannel.MapMode.READ_ONLY, 0, ch.size());
            BinaryDictionary d = new BinaryDictionary(c, buf, DICT_TYPE);
            if (d.getSize() <= 2) {
                d.close();
                return null;
            }
            return d;
        } finally {
            raf.close();
        }
    }

    private static String sActiveDir;
    private static volatile String sLastLang;

    /**
     * Main dictionary of the language, called by Suggest when there is no built-in dictionary.
     * Enables the rules and the two words of the same pack. Without a pack, it falls back to the dictionaries of
     * external apps (PluginManager), as before.
     */
    public static BinaryDictionary mainDictionary(Context c, String locale) {
        sLastLang = splitLocale(locale)[0];
        BinaryDictionary d = null;
        File dir = null;
        try {
            dir = installedFor(c, locale);
            if (dir != null) d = open(c, new File(dir, MAIN));
        } catch (Throwable e) {
            d = null;
        }
        activate(d != null ? dir : null);
        if (d != null) return d;
        return PluginManager.getDictionary(c, locale);
    }

    static synchronized void activate(File dir) {
        String path = dir != null ? dir.getPath() : null;
        if (path == null) {
            MrRules.set(null);
            MrTrigram.use(null);
            sActiveDir = null;
            return;
        }
        if (!path.equals(sActiveDir)) {
            MrRules r = null;
            InputStream in = null;
            try {
                File f = new File(dir, RULES);
                if (f.isFile()) {
                    in = new FileInputStream(f);
                    r = MrRules.parse(in);
                }
            } catch (IOException e) {
                r = null;
            } finally {
                closeQuietly(in);
            }
            MrRules.set(r);
            sActiveDir = path;
        }
        File tri = new File(dir, TRIGRAMS);
        MrTrigram.use(tri.isFile() ? tri : null);
    }

    // ------------------------------------------------------------------ "Download dictionary" item

    private static String sOffer;
    private static String sOfferLabel;
    private static long sOfferAt;

    /**
     * Single item of the strip when the language dictionary is missing (MrPredict.list), or null if the
     * catalog already seen has no pack for that language.
     */
    static List<CharSequence> offerList(Context c) {
        try {
            String lang = sLastLang;
            if (c == null || lang == null || lang.length() == 0) return null;
            Catalog cat = cachedCatalog(c);
            if (cat != null) {
                boolean has = false;
                for (Pack p : cat.packs) if (p.lang.equals(lang)) has = true;
                if (!has) return null;
            }
            long now = System.currentTimeMillis();
            String label = sOfferLabel;
            if (label == null || now - sOfferAt > 30000) {
                label = text(c, "mr_dicts_offer");
                sOfferAt = now;
            }
            if (label == null) return null;
            if (sOffer == null || !label.equals(sOfferLabel)) {
                sOfferLabel = label;
                sOffer = new String(label.toCharArray());
            }
            ArrayList<CharSequence> out = new ArrayList<CharSequence>(1);
            out.add(sOffer);
            return out;
        } catch (RuntimeException e) {
            return null;
        }
    }

    /** Called at the start of LatinIME.pickSuggestionManually: true if it was the item (opens the screen). */
    public static boolean onPick(Context c, CharSequence picked) {
        if (picked == null || picked != sOffer) return false;
        try {
            Intent i = new Intent(c, MrPacksActivity.class);
            i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            c.startActivity(i);
        } catch (RuntimeException e) {
            // without the screen, it just does not type the item text
        }
        return true;
    }

    static String text(Context c, String name, Object... args) {
        try {
            Context ui = UiLocale.wrap(c);
            int id = ui.getResources().getIdentifier(name, "string", c.getPackageName());
            if (id == 0) return null;
            return args.length == 0 ? ui.getResources().getString(id) : ui.getResources().getString(id, args);
        } catch (RuntimeException e) {
            return null;
        }
    }

    // ------------------------------------------------------------------ app certificates

    static X509Certificate[] certs(Context c) throws PackException {
        if (sTestCerts != null) return sTestCerts;
        try {
            Signature[] sigs;
            if (Build.VERSION.SDK_INT >= 28) {
                sigs = Api28.signers(c);
            } else {
                PackageInfo pi = c.getPackageManager().getPackageInfo(c.getPackageName(), PackageManager.GET_SIGNATURES);
                sigs = pi.signatures;
            }
            if (sigs == null || sigs.length == 0) throw new PackException("mr_dicts_err_signature");
            CertificateFactory cf = CertificateFactory.getInstance("X.509");
            X509Certificate[] out = new X509Certificate[sigs.length];
            for (int i = 0; i < sigs.length; i++) {
                out[i] = (X509Certificate) cf.generateCertificate(new ByteArrayInputStream(sigs[i].toByteArray()));
            }
            return out;
        } catch (PackException e) {
            throw e;
        } catch (Exception e) {
            throw new PackException("mr_dicts_err_signature");
        }
    }

    /** Separate so that Android 8 never loads SigningInfo (API 28). */
    static final class Api28 {
        private Api28() { }

        static Signature[] signers(Context c) throws PackageManager.NameNotFoundException {
            PackageInfo pi = c.getPackageManager().getPackageInfo(c.getPackageName(),
                    PackageManager.GET_SIGNING_CERTIFICATES);
            return pi.signingInfo != null ? pi.signingInfo.getApkContentsSigners() : null;
        }
    }

    static String certSha(X509Certificate c) {
        try {
            return hex(MessageDigest.getInstance("SHA-256").digest(c.getEncoded()));
        } catch (Exception e) {
            return "";
        }
    }

    // ------------------------------------------------------------------ utilities

    static String sizeText(long bytes) {
        double mb = bytes / 1000000.0;
        if (mb < 0.1) mb = 0.1;
        return String.format(Locale.getDefault(), "%.1f MB", mb);
    }

    static String hex(byte[] d) {
        char[] out = new char[d.length * 2];
        final char[] h = "0123456789abcdef".toCharArray();
        for (int i = 0; i < d.length; i++) {
            out[2 * i] = h[(d[i] >> 4) & 15];
            out[2 * i + 1] = h[d[i] & 15];
        }
        return new String(out);
    }

    private static int indexOf(String[] a, String s) {
        for (int i = 0; i < a.length; i++) if (a[i].equals(s)) return i;
        return -1;
    }

    static void deleteTree(File f) {
        if (f == null || !f.exists()) return;
        File[] kids = f.listFiles();
        if (kids != null) for (File k : kids) deleteTree(k);
        f.delete();
    }

    static void closeQuietly(java.io.Closeable c) {
        if (c == null) return;
        try {
            c.close();
        } catch (IOException ignored) {
            // nothing to do
        }
    }
}
