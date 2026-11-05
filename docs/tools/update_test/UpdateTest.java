package com.mrkeyboard.app;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.job.JobInfo;
import android.app.job.JobParameters;
import android.app.job.JobScheduler;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.preference.Preference;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.MessageDigest;
import java.security.Principal;
import java.security.PublicKey;
import java.security.Signature;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.TimeZone;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

/**
 * PC test of MrUpdate (the notice of a new version, update.json) with a fake Android: preferences in memory, the
 * network read from memory, a clock set by the test and certificates made here. It covers what the app accepts
 * (signature, kind of file, content of every field), the versions (newer, same, older, replay), the checking windows
 * (24 h on opening, 6 h in the morning job, 1 h after a failed try) and the text of the notes.
 *
 * With a folder as argument (made by update_test/make_fixtures.sh) it also reads the files made by the real tools
 * (make_update.py + SignCatalog.java with a keystore): the notice signed for the update is accepted, the same data
 * signed with the catalog prefix is not.
 *
 * Run by docs/tools/run_java_tests.sh.
 */
public class UpdateTest {
    static int ok, fails;

    static void check(String name, boolean cond) {
        check(name, cond, "");
    }

    static void check(String name, boolean cond, String extra) {
        if (cond) {
            ok++;
            System.out.println("OK    " + name);
        } else {
            fails++;
            System.out.println("FAIL  " + name + (extra.length() > 0 ? " | " + extra : ""));
        }
    }

    // ------------------------------------------------------------------ fake Android

    static final class Prefs implements SharedPreferences {
        final Map<String, Object> m = new HashMap<String, Object>();

        public Map<String, ?> getAll() { return m; }
        public String getString(String k, String d) { return m.containsKey(k) ? (String) m.get(k) : d; }
        public int getInt(String k, int d) { return m.containsKey(k) ? (Integer) m.get(k) : d; }
        public long getLong(String k, long d) { return m.containsKey(k) ? (Long) m.get(k) : d; }
        public boolean getBoolean(String k, boolean d) { return m.containsKey(k) ? (Boolean) m.get(k) : d; }
        public void registerOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
        public void unregisterOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }

        public Editor edit() {
            return new Editor() {
                public Editor putString(String k, String v) { m.put(k, v); return this; }
                public Editor putInt(String k, int v) { m.put(k, v); return this; }
                public Editor putLong(String k, long v) { m.put(k, v); return this; }
                public Editor putBoolean(String k, boolean v) { m.put(k, v); return this; }
                public Editor remove(String k) { m.remove(k); return this; }
                public boolean commit() { return true; }
                public void apply() { }
            };
        }
    }

    static final class Ctx extends Context {
        final Map<String, Prefs> prefs = new HashMap<String, Prefs>();
        int versionCode;
        String versionName = "v1.81.0";

        Ctx(int installed) {
            versionCode = installed;
        }

        public android.content.res.AssetManager getAssets() { return null; }
        public Context getApplicationContext() { return this; }
        android.content.res.Resources res;
        final Map<String, Object> systems = new HashMap<String, Object>();
        public android.content.res.Resources getResources() { return res; }
        public Object getSystemService(String name) { return systems.get(name); }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public File getFilesDir() { return null; }
        public File getCacheDir() { return null; }
        public void startActivity(android.content.Intent i) { }

        public PackageManager getPackageManager() {
            return new PackageManager() {
                public PackageInfo getPackageInfo(String name, int flags) {
                    PackageInfo pi = new PackageInfo();
                    pi.versionCode = versionCode;
                    pi.versionName = versionName;
                    return pi;
                }
            };
        }

        public SharedPreferences getSharedPreferences(String name, int mode) {
            Prefs p = prefs.get(name);
            if (p == null) {
                p = new Prefs();
                prefs.put(name, p);
            }
            return p;
        }

        Prefs state() { return (Prefs) getSharedPreferences(MrUpdate.PREFS, 0); }
    }

    /** A certificate that only knows its public key (enough for checking a signature and for the signer's SHA-256). */
    static final class FakeCert extends X509Certificate {
        final PublicKey key;

        FakeCert(PublicKey key) { this.key = key; }

        public PublicKey getPublicKey() { return key; }
        public byte[] getEncoded() { return key.getEncoded(); }
        public void verify(PublicKey k) { }
        public void verify(PublicKey k, String provider) { }
        public String toString() { return "FakeCert"; }
        public void checkValidity() { }
        public void checkValidity(Date d) { }
        public int getVersion() { return 3; }
        public BigInteger getSerialNumber() { return BigInteger.ONE; }
        public Principal getIssuerDN() { return null; }
        public Principal getSubjectDN() { return null; }
        public Date getNotBefore() { return null; }
        public Date getNotAfter() { return null; }
        public byte[] getTBSCertificate() { return null; }
        public byte[] getSignature() { return null; }
        public String getSigAlgName() { return null; }
        public String getSigAlgOID() { return null; }
        public byte[] getSigAlgParams() { return null; }
        public boolean[] getIssuerUniqueID() { return null; }
        public boolean[] getSubjectUniqueID() { return null; }
        public boolean[] getKeyUsage() { return null; }
        public int getBasicConstraints() { return -1; }
        public boolean hasUnsupportedCriticalExtension() { return false; }
        public Set<String> getCriticalExtensionOIDs() { return null; }
        public Set<String> getNonCriticalExtensionOIDs() { return null; }
        public byte[] getExtensionValue(String oid) { return null; }
    }

    // ------------------------------------------------------------------ network and clock

    static int requests;
    static String lastUrl;
    static byte[] body = new byte[0];
    static int httpCode;
    static boolean netDown;

    static void installNet() {
        MrPacks.sNet = new MrPacks.Net() {
            public InputStream open(String url, long[] length) throws IOException {
                requests++;
                lastUrl = url;
                if (netDown) throw new IOException("no network");
                if (httpCode != 0) throw new MrPacks.HttpError(httpCode);
                length[0] = body.length;
                return new ByteArrayInputStream(body);
            }
        };
    }

    // ------------------------------------------------------------------ files like the ones the release has

    static final String SHA = "0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef";

    /** The data of an update.json; every field is the text that goes in the JSON, so a test can break one. */
    static final class N {
        String format = "1", code = "1082000", name = "\"v1.82.0\"", apkName = "\"mr-keyboard-v1.82.0.apk\"",
                size = "1234567", sha = "\"" + SHA + "\"", apkExtra = "", extra = "",
                notes = "{\"pt-BR\":\"- Novidade **boa** em `Ajustes`.\\n- Outra.\",\"en\":\"- Good **news** in `Settings`.\\n- Another.\"}";

        N code(long c, String tag) {
            code = String.valueOf(c);
            name = "\"" + tag + "\"";
            apkName = "\"mr-keyboard-" + tag + ".apk\"";
            return this;
        }

        String json() {
            return "{\"format\":" + format + ",\"versionCode\":" + code + ",\"versionName\":" + name
                    + ",\"generated\":\"2026-11-05T03:00:00+00:00\",\"apk\":{\"name\":" + apkName + ",\"size\":" + size
                    + ",\"sha256\":" + sha + apkExtra + "},\"notes\":" + notes + extra + "}";
        }
    }

    static String q(String s) {
        StringBuilder b = new StringBuilder("\"");
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '"') b.append("\\\"");
            else if (c == '\\') b.append("\\\\");
            else if (c == '\n') b.append("\\n");
            else if (c < 0x20) b.append(String.format("\\u%04x", (int) c));
            else b.append(c);
        }
        return b.append('"').toString();
    }

    static String hex(byte[] d) {
        StringBuilder b = new StringBuilder();
        for (byte x : d) b.append(String.format("%02x", x & 0xff));
        return b.toString();
    }

    static String signerOf(KeyPair kp) throws Exception {
        return hex(MessageDigest.getInstance("SHA-256").digest(kp.getPublic().getEncoded()));
    }

    /** The envelope as SignCatalog.java makes it: signature over prefix + data. */
    static byte[] sign(String data, String prefix, KeyPair kp, String alg, int format) throws Exception {
        Signature s = Signature.getInstance(alg);
        s.initSign(kp.getPrivate());
        s.update((prefix + data).getBytes(StandardCharsets.UTF_8));
        String sig = Base64.getEncoder().encodeToString(s.sign());
        return ("{\"format\":" + format + ",\"algorithm\":" + q(alg) + ",\"signer\":" + q(signerOf(kp))
                + ",\"signature\":" + q(sig) + ",\"data\":" + q(data) + "}").getBytes(StandardCharsets.UTF_8);
    }

    static KeyPair rsa, rsa2, ec;

    static byte[] good(N n) throws Exception {
        return sign(n.json(), MrUpdate.SIG_PREFIX, rsa, "SHA256withRSA", 1);
    }

    /** One check() with that file as the answer of the server, with the app signed by rsa. */
    static MrUpdate.Result run(Ctx c, byte[] file) {
        body = file;
        httpCode = 0;
        netDown = false;
        MrPacks.sTestCerts = new X509Certificate[] {new FakeCert(rsa.getPublic())};
        return MrUpdate.check(c);
    }

    static MrUpdate.Result run(Ctx c, N n) throws Exception {
        return run(c, good(n));
    }

    static void at(long t) {
        MrUpdate.sTestNow = t;
    }

    static final long H = 3600L * 1000;
    static final long T0 = 1_800_000_000_000L;

    // ------------------------------------------------------------------ tests

    public static void main(String[] args) throws Exception {
        KeyPairGenerator g = KeyPairGenerator.getInstance("RSA");
        g.initialize(2048);
        rsa = g.generateKeyPair();
        rsa2 = g.generateKeyPair();
        KeyPairGenerator ge = KeyPairGenerator.getInstance("EC");
        ge.initialize(256);
        ec = ge.generateKeyPair();
        installNet();
        at(T0);

        constants();
        content();
        signatures();
        versions();
        windows();
        screens();
        glue();
        install();
        morning();
        notesText();
        if (args.length > 0) realFiles(new File(args[0]));

        MrUpdate.sTestNow = 0;
        if (fails == 0) {
            System.out.println("ALL OK (" + ok + " checks)");
        } else {
            System.out.println(fails + " FAILURE(S) out of " + (ok + fails) + " checks");
            System.exit(1);
        }
    }

    static void constants() {
        check("address: update.json of the latest release, on github.com over HTTPS",
                MrUpdate.UPDATE_URL.equals("https://github.com/x-mrrobot-x/mr-keyboard/releases/latest/download/update.json")
                        && MrUpdate.sUrl.equals(MrUpdate.UPDATE_URL));
        check("prefix of the signature is the one of the 'update' domain of SignCatalog.java",
                MrUpdate.SIG_PREFIX.equals("mr-keyboard/update/v1\n") && !MrUpdate.SIG_PREFIX.equals(MrPacks.SIG_PREFIX));
        check("windows: 24 h on opening, 6 h in the job, 1 h after a failed try",
                MrUpdate.WINDOW == 24 * H && MrUpdate.JOB_REUSE == 6 * H && MrUpdate.RETRY == H);
    }

    static void content() throws Exception {
        Ctx c = new Ctx(1081000);
        MrUpdate.Result r = run(c, new N());
        MrUpdate.Notice n = r.notice;
        check("valid notice: available, from the address of the app", r.status == MrUpdate.AVAILABLE && !r.fromCache
                && MrUpdate.UPDATE_URL.equals(lastUrl), "status " + r.status + " error " + r.error);
        check("valid notice: version, code, size and SHA-256", n != null && n.versionName.equals("v1.82.0")
                && n.versionCode == 1082000 && n.apkSize == 1234567 && n.apkSha256.equals(SHA) && n.apkName.equals("mr-keyboard-v1.82.0.apk"));
        check("valid notice: the APK address is built from the app's constants and the tag",
                n != null && n.apkUrl().equals("https://github.com/x-mrrobot-x/mr-keyboard/releases/download/v1.82.0/mr-keyboard-v1.82.0.apk"));

        N withUrl = new N();
        withUrl.apkExtra = ",\"url\":\"https://evil.example/x.apk\"";
        withUrl.extra = ",\"url\":\"https://evil.example/y\",\"future\":[1,2,3]";
        r = run(new Ctx(1081000), withUrl);
        check("a link or an unknown field in the file is ignored: the APK address does not change",
                r.status == MrUpdate.AVAILABLE && r.notice.apkUrl().startsWith(MrPacks.RELEASES_URL + "v1.82.0/") && !r.notice.apkUrl().contains("evil"));

        String[][] bad = {
            {"format 2 inside the data", "format", "2"},
            {"versionName without v", "name", "\"1.82.0\""},
            {"versionName with 2 numbers", "name", "\"v1.82\""},
            {"versionName with 4 numbers", "name", "\"v1.82.0.1\""},
            {"versionName with a path", "name", "\"v1.82.0/../x\""},
            {"versionName that is not text", "name", "182"},
            {"versionCode that does not follow the tag", "code", "1082001"},
            {"versionCode that is not a number", "code", "\"1082000\""},
            {"APK with another name", "apkName", "\"evil.apk\""},
            {"APK of another version", "apkName", "\"mr-keyboard-v1.82.1.apk\""},
            {"APK name with a path", "apkName", "\"../mr-keyboard-v1.82.0.apk\""},
            {"APK size zero", "size", "0"},
            {"APK size negative", "size", "-5"},
            {"APK size over the limit", "size", String.valueOf(MrUpdate.MAX_APK + 1)},
            {"APK size that is not an integer", "size", "1.5"},
            {"SHA-256 too short", "sha", "\"abcd\""},
            {"SHA-256 that is not hex", "sha", "\"" + SHA.replace('0', 'z') + "\""},
            {"notes without English", "notes", "{\"pt-BR\":\"- So pt\"}"},
            {"English notes empty", "notes", "{\"en\":\"   \"}"},
            {"notes that are not an object", "notes", "\"text\""},
            {"English notes over the limit", "notes", "{\"en\":\"" + "x".repeat(MrUpdate.MAX_NOTES + 1) + "\"}"},
        };
        for (String[] b : bad) {
            N x = new N();
            switch (b[1]) {
                case "format": x.format = b[2]; break;
                case "name": x.name = b[2]; break;
                case "code": x.code = b[2]; break;
                case "apkName": x.apkName = b[2]; break;
                case "size": x.size = b[2]; break;
                case "sha": x.sha = b[2]; break;
                default: x.notes = b[2];
            }
            Ctx cc = new Ctx(1081000);
            r = run(cc, x);
            check("rejected (" + b[0] + "): bad file, nothing stored", r.status == MrUpdate.FAILED && r.error == MrUpdate.ERR_FILE
                    && cc.state().getString(MrUpdate.KEY_NOTICE, null) == null && cc.state().getLong(MrUpdate.KEY_SEEN, 0) == 0,
                    "status " + r.status + " error " + r.error);
        }
        N noPt = new N();
        noPt.notes = "{\"en\":\"- Only English.\"}";
        r = run(new Ctx(1081000), noPt);
        check("notes only in English are accepted (Portuguese falls back to English)", r.status == MrUpdate.AVAILABLE
                && r.notice.notes(new Locale("pt", "BR")).equals("• Only English."));
        N upper = new N();
        upper.sha = "\"" + SHA.toUpperCase(Locale.ROOT) + "\"";
        r = run(new Ctx(1081000), upper);
        check("SHA-256 in capitals is accepted and kept in lower case", r.status == MrUpdate.AVAILABLE && r.notice.apkSha256.equals(SHA));
        r = run(new Ctx(1081000), "not json".getBytes(StandardCharsets.UTF_8));
        check("something that is not JSON: bad file", r.status == MrUpdate.FAILED && r.error == MrUpdate.ERR_FILE);
        r = run(new Ctx(1081000), new byte[0]);
        check("empty answer: bad file", r.status == MrUpdate.FAILED && r.error == MrUpdate.ERR_FILE);
    }

    static void signatures() throws Exception {
        N n = new N();
        Ctx c = new Ctx(1081000);
        MrUpdate.Result r = run(c, good(n));
        check("signed with the app's RSA key: accepted", r.status == MrUpdate.AVAILABLE);

        c = new Ctx(1081000);
        body = sign(n.json(), MrUpdate.SIG_PREFIX, ec, "SHA256withECDSA", 1);
        httpCode = 0;
        MrPacks.sTestCerts = new X509Certificate[] {new FakeCert(ec.getPublic())};
        r = MrUpdate.check(c);
        check("signed with an EC key (SHA256withECDSA) and the app has that key: accepted", r.status == MrUpdate.AVAILABLE);

        r = run(new Ctx(1081000), sign(n.json(), MrUpdate.SIG_PREFIX, rsa2, "SHA256withRSA", 1));
        check("signed with another key: signature error", r.status == MrUpdate.FAILED && r.error == MrUpdate.ERR_SIGNATURE);

        r = run(new Ctx(1081000), sign(n.json(), MrUpdate.SIG_PREFIX, ec, "SHA256withECDSA", 1));
        check("signed with an EC key the app does not have: signature error", r.error == MrUpdate.ERR_SIGNATURE);

        byte[] forged = sign(n.json(), MrUpdate.SIG_PREFIX, rsa2, "SHA256withRSA", 1);
        String f = new String(forged, StandardCharsets.UTF_8).replace(signerOf(rsa2), signerOf(rsa));
        r = run(new Ctx(1081000), f.getBytes(StandardCharsets.UTF_8));
        check("other key that claims to be the app's (signer changed by hand): still a signature error",
                r.status == MrUpdate.FAILED && r.error == MrUpdate.ERR_SIGNATURE);

        byte[] ok = good(n);
        N other = new N().code(1083000, "v1.83.0");
        String tampered = new String(ok, StandardCharsets.UTF_8);
        String origData = q(n.json()), newData = q(other.json());
        check("(test setup) the tampering text is in the file", tampered.contains(origData));
        r = run(new Ctx(1081000), tampered.replace(origData, newData).getBytes(StandardCharsets.UTF_8));
        check("data changed after signing: signature error", r.status == MrUpdate.FAILED && r.error == MrUpdate.ERR_SIGNATURE);

        byte[] asCatalog = sign(n.json(), MrPacks.SIG_PREFIX, rsa, "SHA256withRSA", 1);
        r = run(new Ctx(1081000), asCatalog);
        check("signed with the key of the app but for the catalog (catalog prefix): not accepted as an update notice",
                r.status == MrUpdate.FAILED && r.error == MrUpdate.ERR_SIGNATURE);
        boolean refused = false;
        try {
            MrPacks.verifySigned(good(n), 1, MrPacks.SIG_PREFIX, "catalog.json", new X509Certificate[] {new FakeCert(rsa.getPublic())});
        } catch (MrPacks.PackException e) {
            refused = e.key.equals("mr_dicts_err_signature");
        }
        check("and the other way round: an update notice does not pass as a catalog", refused);

        r = run(new Ctx(1081000), sign(n.json(), MrUpdate.SIG_PREFIX, rsa, "SHA256withRSA", 2));
        check("envelope with format 2: bad file (new format)", r.status == MrUpdate.FAILED && r.error == MrUpdate.ERR_FILE);
        String md5 = new String(good(n), StandardCharsets.UTF_8).replace("SHA256withRSA", "MD5withRSA");
        r = run(new Ctx(1081000), md5.getBytes(StandardCharsets.UTF_8));
        check("algorithm that is not SHA-256: signature error", r.status == MrUpdate.FAILED && r.error == MrUpdate.ERR_SIGNATURE);
        r = run(new Ctx(1081000), new String(good(n), StandardCharsets.UTF_8).replaceAll("\"signature\":\"[^\"]*\"", "\"signature\":\"@@@@\"").getBytes(StandardCharsets.UTF_8));
        check("signature that is not base64: bad file", r.status == MrUpdate.FAILED && r.error == MrUpdate.ERR_FILE);
        r = run(new Ctx(1081000), new byte[MrUpdate.MAX_NOTICE + 1]);
        check("answer bigger than the limit: bad file", r.status == MrUpdate.FAILED && r.error == MrUpdate.ERR_FILE);

        Ctx cn = new Ctx(1081000);
        body = good(n);
        MrPacks.sTestCerts = new X509Certificate[] {new FakeCert(rsa.getPublic())};
        httpCode = 404;
        r = MrUpdate.check(cn);
        check("HTTP 404 (the release has no update.json): error with the code", r.status == MrUpdate.FAILED && r.error == MrUpdate.ERR_HTTP && r.httpCode == 404);
        httpCode = 0;
        netDown = true;
        r = MrUpdate.check(cn);
        check("no network: network error", r.status == MrUpdate.FAILED && r.error == MrUpdate.ERR_NETWORK);
        netDown = false;
        check("a failed try stores the time of the try and nothing else", cn.state().getLong(MrUpdate.KEY_TRIED, 0) == T0
                && cn.state().getLong(MrUpdate.KEY_CHECKED, 0) == 0 && cn.state().getString(MrUpdate.KEY_NOTICE, null) == null);
    }

    static void versions() throws Exception {
        MrUpdate.Result r = run(new Ctx(1082000), new N());
        check("same version as the installed one: up to date, nothing offered", r.status == MrUpdate.UP_TO_DATE && r.notice == null);
        r = run(new Ctx(1090000), new N());
        check("installed version newer than the notice: up to date", r.status == MrUpdate.UP_TO_DATE && r.notice == null);
        r = run(new Ctx(1081999), new N());
        check("installed version one below: available", r.status == MrUpdate.AVAILABLE && r.notice.versionCode == 1082000);

        Ctx c = new Ctx(1082000);
        r = run(c, new N().code(1083000, "v1.83.0"));
        check("newer notice: available and stored (series seen = 1083000)", r.status == MrUpdate.AVAILABLE
                && c.state().getLong(MrUpdate.KEY_SEEN, 0) == 1083000 && MrUpdate.pending(c) != null && MrUpdate.pending(c).versionName.equals("v1.83.0"));
        r = run(c, new N());
        check("an older signed notice (replay) is refused and changes nothing", r.status == MrUpdate.FAILED && r.error == MrUpdate.ERR_OLD
                && c.state().getLong(MrUpdate.KEY_SEEN, 0) == 1083000 && MrUpdate.pending(c).versionName.equals("v1.83.0"));
        r = run(c, new N().code(1083000, "v1.83.0"));
        check("the same notice again is accepted (refreshes the time)", r.status == MrUpdate.AVAILABLE);
        r = run(c, new N().code(1084000, "v1.84.0"));
        check("a still newer one replaces it", r.status == MrUpdate.AVAILABLE && MrUpdate.pending(c).versionName.equals("v1.84.0")
                && c.state().getLong(MrUpdate.KEY_SEEN, 0) == 1084000);
        c.versionCode = 1084000;
        check("after the app is updated to that version nothing is pending", MrUpdate.pending(c) == null
                && MrUpdate.cached(c).status == MrUpdate.UP_TO_DATE);
    }

    static void windows() throws Exception {
        N n = new N();
        Ctx c = new Ctx(1081000);
        requests = 0;
        at(T0);
        body = good(n);
        httpCode = 0;
        netDown = false;
        MrPacks.sTestCerts = new X509Certificate[] {new FakeCert(rsa.getPublic())};

        MrUpdate.Result r = MrUpdate.checkIfOlder(c, MrUpdate.WINDOW);
        check("opening, never checked: goes to the network", requests == 1 && r.status == MrUpdate.AVAILABLE && !r.fromCache);
        at(T0 + 23 * H + 59 * 60 * 1000);
        r = MrUpdate.checkIfOlder(c, MrUpdate.WINDOW);
        check("opening within 24 h: no network, answer from what is stored", requests == 1 && r.fromCache && r.status == MrUpdate.AVAILABLE
                && r.notice.versionName.equals("v1.82.0"));
        at(T0 + 24 * H);
        r = MrUpdate.checkIfOlder(c, MrUpdate.WINDOW);
        check("opening at exactly 24 h: goes to the network again", requests == 2 && !r.fromCache);
        at(T0 + 24 * H + 10 * 60 * 1000);
        r = MrUpdate.checkIfOlder(c, MrUpdate.JOB_REUSE);
        check("the morning job 10 minutes after an opening check reuses it (one request for both)", requests == 2 && r.fromCache);
        at(T0 + 24 * H + 5 * H + 59 * 60 * 1000);
        r = MrUpdate.checkIfOlder(c, MrUpdate.JOB_REUSE);
        check("job within 6 h of the last check: reuses it", requests == 2 && r.fromCache);
        at(T0 + 24 * H + 6 * H);
        r = MrUpdate.checkIfOlder(c, MrUpdate.JOB_REUSE);
        check("job at 6 h: checks again", requests == 3 && !r.fromCache);

        // the manual line ignores every window
        int before = requests;
        r = MrUpdate.check(c);
        check("the manual check always goes to the network", requests == before + 1 && !r.fromCache);

        // a failed try: the automatic checks wait 1 h; the manual one does not
        Ctx d = new Ctx(1081000);
        requests = 0;
        at(T0);
        netDown = true;
        r = MrUpdate.checkIfOlder(d, MrUpdate.WINDOW);
        check("opening with no network: error, no notice, no stored check time", requests == 1 && r.status == MrUpdate.FAILED
                && r.error == MrUpdate.ERR_NETWORK && d.state().getLong(MrUpdate.KEY_CHECKED, 0) == 0);
        at(T0 + 59 * 60 * 1000);
        netDown = false;
        r = MrUpdate.checkIfOlder(d, MrUpdate.WINDOW);
        check("opening again within 1 h of a failed try: no network (nothing known yet)", requests == 1 && r.fromCache && r.status == MrUpdate.UNKNOWN);
        at(T0 + H);
        r = MrUpdate.checkIfOlder(d, MrUpdate.WINDOW);
        check("after 1 h the automatic check tries again", requests == 2 && r.status == MrUpdate.AVAILABLE);
        Ctx e = new Ctx(1081000);
        requests = 0;
        at(T0);
        netDown = true;
        MrUpdate.checkIfOlder(e, MrUpdate.WINDOW);
        at(T0 + 60 * 1000);
        netDown = false;
        r = MrUpdate.check(e);
        check("the manual check right after a failed try works", requests == 2 && r.status == MrUpdate.AVAILABLE);

        // a clock that went back must not block the checks for days
        Ctx f = new Ctx(1081000);
        requests = 0;
        at(T0 + 10 * 24 * H);
        MrUpdate.checkIfOlder(f, MrUpdate.WINDOW);
        at(T0);
        r = MrUpdate.checkIfOlder(f, MrUpdate.WINDOW);
        check("clock set back: the automatic check goes to the network instead of waiting for days", requests == 2 && !r.fromCache);

        // cached() with a stored notice and a state that was never written
        Ctx g = new Ctx(1081000);
        check("nothing stored: unknown, no notice", MrUpdate.cached(g).status == MrUpdate.UNKNOWN && MrUpdate.pending(g) == null);
        at(T0);
    }

    /** What the screens rely on: the switch, "Not now", what to pop up, the texts of the errors and of the size. */
    static void screens() throws Exception {
        Ctx c = new Ctx(1081000);
        check("switch 'Check when the app opens' is on by default", MrUpdate.auto(c));
        MrUpdate.setAuto(c, false);
        check("switch off is kept", !MrUpdate.auto(c) && !c.state().getBoolean(MrUpdate.KEY_AUTO, true));
        MrUpdate.setAuto(c, true);
        check("switch on again", MrUpdate.auto(c));
        check("the switch lives in 'mr_update', not in the default preferences (outside the backup and Restore defaults)",
                c.prefs.size() == 1 && c.prefs.containsKey(MrUpdate.PREFS));

        // what to pop up on opening
        N n = new N();
        at(T0);
        run(c, n);
        MrUpdate.Notice known = MrUpdate.pending(c);
        check("a newer version is known after the check", known != null && known.versionName.equals("v1.82.0"));
        check("not snoozed: the pop-up shows", !MrUpdate.snoozed(c, known) && MrUpdate.toShow(c) != null);
        MrUpdate.snooze(c, known);
        check("'Not now': no pop-up", MrUpdate.snoozed(c, known) && MrUpdate.toShow(c) == null);
        check("'Not now' does not hide the version from the Settings line", MrUpdate.pending(c) != null);
        at(T0 + 23 * H + 59 * 60 * 1000);
        check("within 24 h still snoozed", MrUpdate.toShow(c) == null);
        at(T0 + 24 * H);
        check("after 24 h the pop-up comes back", MrUpdate.toShow(c) != null);
        at(T0 + 1000);
        MrUpdate.snooze(c, known);
        run(c, new N().code(1083000, "v1.83.0"));
        check("a newer version than the snoozed one pops up at once", MrUpdate.pending(c).versionName.equals("v1.83.0")
                && MrUpdate.toShow(c) != null);
        at(T0 - H);
        MrUpdate.snooze(c, MrUpdate.pending(c));
        at(T0 - 2 * H);
        check("clock set back: not snoozed (it must not hide the notice for days)", MrUpdate.toShow(c) != null);
        at(T0);
        Ctx up = new Ctx(1083000);
        run(up, new N().code(1083000, "v1.83.0"));
        check("the installed version is the newest: nothing to pop up", MrUpdate.toShow(up) == null && MrUpdate.pending(up) == null);

        // texts
        check("app name comes from the package", MrUpdate.appName(c).equals("v1.81.0"));
        c.versionName = null;
        check("app name with no versionName is empty, not null", MrUpdate.appName(c).equals(""));
        check("each error has its own text key", MrUpdate.errorKey(MrUpdate.ERR_NETWORK).equals("mr_update_err_network")
                && MrUpdate.errorKey(MrUpdate.ERR_HTTP).equals("mr_update_err_http")
                && MrUpdate.errorKey(MrUpdate.ERR_SIGNATURE).equals("mr_update_err_signature")
                && MrUpdate.errorKey(MrUpdate.ERR_OLD).equals("mr_update_err_old")
                && MrUpdate.errorKey(MrUpdate.ERR_FILE).equals("mr_update_err_file")
                && MrUpdate.errorKey(MrUpdate.ERR_NONE).equals("mr_update_err_file"));
        check("size: 1.2 MB in English, 1,2 MB in Portuguese and Spanish",
                MrUpdate.sizeText(1234567, Locale.ENGLISH).equals("1.2 MB")
                        && MrUpdate.sizeText(1234567, new Locale("pt", "BR")).equals("1,2 MB")
                        && MrUpdate.sizeText(1234567, new Locale("es")).equals("1,2 MB"));
        check("size: under 1 MB is in KB, never 0", MrUpdate.sizeText(512345, Locale.ENGLISH).equals("512 KB")
                && MrUpdate.sizeText(1, Locale.ENGLISH).equals("1 KB"));
        check("size: 10.5 MB", MrUpdate.sizeText(10500000, Locale.ENGLISH).equals("10.5 MB"));
        at(T0);
    }

    // ------------------------------------------------------------------ the glue of the screens (MrUpdateUi)

    static final class FakeRow extends android.preference.Preference {
        CharSequence summary;
        Preference.OnPreferenceClickListener click;

        FakeRow(Context c) { super(c); }
        @Override public void setSummary(CharSequence s) { summary = s; }
        @Override public void setOnPreferenceClickListener(Preference.OnPreferenceClickListener l) { click = l; }
    }

    static final class FakeSwitch extends android.preference.CheckBoxPreference {
        boolean checked;
        Preference.OnPreferenceChangeListener change;

        FakeSwitch(Context c) { super(c); }
        @Override public void setChecked(boolean b) { checked = b; }
        @Override public boolean isChecked() { return checked; }
        @Override public void setOnPreferenceChangeListener(Preference.OnPreferenceChangeListener l) { change = l; }
    }

    static final class FakeActivity extends android.preference.PreferenceActivity {
        final Ctx ctx;
        final Map<String, Preference> prefs = new HashMap<String, Preference>();
        android.content.Intent intent;
        boolean finishing;
        final List<String[]> requested = new ArrayList<String[]>();
        final List<android.content.Intent> started = new ArrayList<android.content.Intent>();

        FakeActivity(Ctx c) { ctx = c; }
        @Override public Object getSystemService(String n) { return ctx.getSystemService(n); }
        @Override public void requestPermissions(String[] p, int code) { requested.add(p); }
        @Override public void startActivity(android.content.Intent i) { started.add(i); }
        @Override public Context getApplicationContext() { return ctx; }
        @Override public SharedPreferences getSharedPreferences(String n, int m) { return ctx.getSharedPreferences(n, m); }
        @Override public String getPackageName() { return ctx.getPackageName(); }
        @Override public PackageManager getPackageManager() { return ctx.getPackageManager(); }
        @Override public void runOnUiThread(Runnable r) { r.run(); }
        @Override public boolean isFinishing() { return finishing; }
        @Override public Preference findPreference(CharSequence k) { return prefs.get(k.toString()); }
        @Override public android.content.Intent getIntent() { return intent; }
    }

    interface Cond { boolean ok(); }

    static boolean waitFor(Cond c) throws Exception {
        for (int i = 0; i < 250; i++) {
            if (c.ok()) return true;
            Thread.sleep(20);
        }
        return c.ok();
    }

    static void settle() throws Exception {
        Thread.sleep(250);
    }

    /** Opening the screens, the line and the switch of Settings, with a fake screen and the fake network. */
    static void glue() throws Exception {
        MrPacks.sTestCerts = new X509Certificate[] {new FakeCert(rsa.getPublic())};
        netDown = false;
        httpCode = 0;
        body = good(new N());

        // switch off: no network, no pop-up
        Ctx c = new Ctx(1081000);
        MrUpdate.setAuto(c, false);
        FakeActivity a = new FakeActivity(c);
        requests = 0;
        MrUpdateDialog.sAsked = null;
        MrUpdateUi.onOpen(a);
        settle();
        check("opening with the switch off: no request and no pop-up", requests == 0 && MrUpdateDialog.sAsked == null);

        // switch on, new version: one request, pop-up
        MrUpdate.setAuto(c, true);
        at(T0);
        MrUpdateUi.onOpen(a);
        check("opening with the switch on: asks GitHub once and pops up the new version", waitFor(() -> MrUpdateDialog.sAsked != null)
                && requests == 1 && MrUpdateDialog.sAsked.versionName.equals("v1.82.0"));
        int asked = MrUpdateDialog.sAskedCount;
        at(T0 + 2 * H);
        MrUpdateUi.onOpen(a);
        check("opening again within 24 h: no new request, the pop-up comes back until the user answers",
                waitFor(() -> MrUpdateDialog.sAskedCount == asked + 1) && requests == 1);
        MrUpdate.snooze(c, MrUpdate.pending(c));
        MrUpdateUi.onOpen(a);
        settle();
        check("after 'Not now' opening does not pop up again", MrUpdateDialog.sAskedCount == asked + 1 && requests == 1);

        // the notification opens the dialog even with it snoozed and the switch off
        MrUpdate.setAuto(c, false);
        final boolean[] removed = {false};
        a.intent = new android.content.Intent((String) null, (android.net.Uri) null) {
            @Override public boolean getBooleanExtra(String n, boolean d) { return n.equals(MrUpdateUi.EXTRA_SHOW); }
            @Override public void removeExtra(String n) { removed[0] = n.equals(MrUpdateUi.EXTRA_SHOW); }
        };
        MrUpdateUi.onOpen(a);
        check("started from the notification: opens the dialog at once, even snoozed, and drops the extra",
                MrUpdateDialog.sAskedCount == asked + 2 && removed[0] && requests == 1);
        a.intent = null;

        // offline: a notice already known still shows; nothing known, nothing shown and no error
        MrUpdate.setAuto(c, true);
        at(T0 + 3 * 24 * H);
        netDown = true;
        requests = 0;
        MrUpdateUi.onOpen(a);
        check("offline with a known version: the stored notice pops up (no snooze left after 24 h)",
                waitFor(() -> MrUpdateDialog.sAskedCount == asked + 3));
        Ctx fresh = new Ctx(1081000);
        FakeActivity b = new FakeActivity(fresh);
        MrUpdateUi.onOpen(b);
        settle();
        check("offline and nothing known: no pop-up and no exception", MrUpdateDialog.sAskedCount == asked + 3);
        netDown = false;

        // a screen that is closing gets nothing
        Ctx d = new Ctx(1081000);
        FakeActivity gone = new FakeActivity(d);
        gone.finishing = true;
        int before = MrUpdateDialog.sAskedCount;
        at(T0);
        MrUpdateUi.onOpen(gone);
        settle();
        check("screen finishing: no pop-up", MrUpdateDialog.sAskedCount == before);
        MrUpdateUi.release(gone);

        // Settings: the rows
        Ctx e = new Ctx(1081000);
        FakeActivity s = new FakeActivity(e);
        FakeRow row = new FakeRow(e);
        FakeSwitch sw = new FakeSwitch(e);
        s.prefs.put("mr_update", row);
        s.prefs.put("mr_update_auto", sw);
        MrUpdate.setAuto(e, false);
        requests = 0;
        MrUpdateUi.bind(s);
        check("Settings: the switch shows the stored state and the line shows the installed version",
                !sw.checked && "mr_update_check_sum".equals(String.valueOf(row.summary)) && row.click != null && sw.change != null);
        settle();
        check("Settings with the switch off: opening did not touch the network", requests == 0);
        sw.change.onPreferenceChange(sw, Boolean.TRUE);
        check("flipping the switch is stored in 'mr_update'", MrUpdate.auto(e));
        sw.change.onPreferenceChange(sw, Boolean.FALSE);
        check("flipping it off is stored too", !MrUpdate.auto(e));

        // manual tap: up to date
        requests = 0;
        at(T0);
        body = good(new N().code(1081000, "v1.81.0"));
        row.click.onPreferenceClick(row);
        check("tap, same version: the line ends saying it is up to date", waitFor(() -> "mr_update_sum_uptodate".equals(String.valueOf(row.summary)))
                && requests == 1);
        // tap: offline
        netDown = true;
        row.click.onPreferenceClick(row);
        check("tap, offline: the line says why it could not check", waitFor(() -> "mr_update_sum_error".equals(String.valueOf(row.summary))));
        netDown = false;
        // tap: new version
        body = good(new N());
        int k = MrUpdateDialog.sAskedCount;
        row.click.onPreferenceClick(row);
        check("tap, newer version: the line says so and the dialog opens", waitFor(() -> MrUpdateDialog.sAskedCount == k + 1)
                && "mr_update_sum_available".equals(String.valueOf(row.summary)));
        int reqs = requests;
        row.click.onPreferenceClick(row);
        check("tap with a version already known opens the dialog without going to the network", requests == reqs
                && MrUpdateDialog.sAskedCount == k + 2);
        // an old signed file: replay
        Ctx f = new Ctx(1081000);
        FakeActivity fa = new FakeActivity(f);
        FakeRow fr = new FakeRow(f);
        fa.prefs.put("mr_update", fr);
        body = good(new N().code(1083000, "v1.83.0"));
        MrUpdate.check(f);
        body = good(new N());
        MrUpdate.setAuto(f, false);
        MrUpdateUi.bind(fa);
        check("Settings with a known version: the line already says it is available", "mr_update_sum_available".equals(String.valueOf(fr.summary)));
        at(T0);
    }

    // ------------------------------------------------------------------ download and install (MrUpdateInstall)

    static final class FakeTarget implements MrUpdateInstall.Target {
        final java.io.ByteArrayOutputStream data = new java.io.ByteArrayOutputStream();
        boolean synced, committed, abandoned, closed;
        String failWrite;      // message of the IOException that the write throws once 'failAfter' bytes are in
        int failAfter = Integer.MAX_VALUE;
        boolean failOpen, failCommit;
        Runnable onSync;

        public java.io.OutputStream openWrite() throws IOException {
            if (failOpen) throw new IOException("open");
            return new java.io.OutputStream() {
                public void write(int b) throws IOException {
                    write(new byte[] {(byte) b}, 0, 1);
                }

                public void write(byte[] b, int off, int len) throws IOException {
                    if (failWrite != null && data.size() + len > failAfter) throw new IOException(failWrite);
                    data.write(b, off, len);
                }
            };
        }

        public void sync(java.io.OutputStream out) {
            synced = true;
            if (onSync != null) onSync.run();
        }

        public void commit() {
            if (failCommit) throw new SecurityException("commit");
            committed = true;
        }

        public void abandon() { abandoned = true; closed = true; }
        public void close() { closed = true; }
    }

    static final class Events implements MrUpdateInstall.Listener {
        final java.util.List<String> log = Collections.synchronizedList(new ArrayList<String>());
        volatile MrUpdateInstall.Failure failure;
        volatile boolean aborted;

        public void state(int state, int percent) { log.add(state + ":" + percent); }
        public void failed(MrUpdateInstall.Failure f) { failure = f; log.add("failed"); }
        public void aborted() { aborted = true; log.add("aborted"); }
        String key() { return failure == null ? null : failure.key; }
    }

    static final class TSink implements MrUpdateInstall.Sink {
        volatile boolean cancel;
        boolean began;
        final java.util.List<Integer> percents = new ArrayList<Integer>();

        public void percent(int p) { percents.add(p); }
        public boolean cancelled() { return cancel; }
        public boolean beginCommit() { if (cancel) return false; began = true; return true; }
    }

    static byte[] fakeApk(int n) {
        byte[] b = new byte[n];
        for (int i = 0; i < n; i++) b[i] = (byte) (i * 31 + (i >> 8));
        return b;
    }

    /** The notice of a signed update.json for exactly this APK. */
    static MrUpdate.Notice noticeFor(byte[] apk) throws Exception {
        N n = new N();
        n.size = String.valueOf(apk.length);
        n.sha = q(hex(MessageDigest.getInstance("SHA-256").digest(apk)));
        MrUpdate.Result r = run(new Ctx(1081000), n);
        if (r.notice == null) throw new IllegalStateException("notice: " + r.status + "/" + r.error);
        return r.notice;
    }

    static void netWith(final byte[] bytes, final long declared) {
        MrPacks.sNet = new MrPacks.Net() {
            public InputStream open(String url, long[] length) {
                requests++;
                lastUrl = url;
                length[0] = declared;
                return new ByteArrayInputStream(bytes);
            }
        };
    }

    static void install() throws Exception {
        final byte[] apk = fakeApk(200000); // 4 blocks of 64 KB
        final MrUpdate.Notice n = noticeFor(apk);
        installNet();

        // the usual way: everything written, checked, committed
        body = apk;
        FakeTarget t = new FakeTarget();
        Events ev = new Events();
        TSink sink = new TSink();
        MrUpdateInstall.flow(n, t, ev, sink);
        check("install: the APK reaches the session whole, byte by byte", Arrays.equals(t.data.toByteArray(), apk));
        check("install: synced, committed once, session closed and not abandoned", t.synced && t.committed && t.closed && !t.abandoned);
        check("install: states go Downloading 0%, Verifying, Installing", ev.log.get(0).equals("1:0") && ev.log.contains("2:100")
                && ev.log.get(ev.log.size() - 1).equals("3:100") && ev.failure == null);
        check("install: progress grows to 100% and never goes back", sink.percents.get(sink.percents.size() - 1) == 100
                && increasing(sink.percents));
        check("install: it is the APK of the exact tag of the notice that is read (not 'latest')",
                lastUrl.equals("https://github.com/x-mrrobot-x/mr-keyboard/releases/download/v1.82.0/mr-keyboard-v1.82.0.apk"));

        // an APK that is not the signed one is never committed
        byte[] flipped = apk.clone();
        flipped[100000] ^= 1;
        body = flipped;
        t = new FakeTarget();
        ev = new Events();
        MrUpdateInstall.flow(n, t, ev, new TSink());
        check("install: same size, one bit changed: 'the file doesn't match', abandoned, not committed",
                "mr_update_err_mismatch".equals(ev.key()) && t.abandoned && !t.committed);

        byte[] shorter = Arrays.copyOf(apk, apk.length - 1);
        body = shorter;
        t = new FakeTarget();
        ev = new Events();
        MrUpdateInstall.flow(n, t, ev, new TSink());
        check("install: shorter than the signed size is refused", "mr_update_err_mismatch".equals(ev.key()) && t.abandoned && !t.committed);

        byte[] longer = Arrays.copyOf(apk, apk.length + 70000);
        body = longer;
        t = new FakeTarget();
        ev = new Events();
        MrUpdateInstall.flow(n, t, ev, new TSink());
        check("install: server says a different size than the signed one: refused before writing anything",
                "mr_update_err_mismatch".equals(ev.key()) && t.data.size() == 0 && t.abandoned && !t.committed);

        netWith(longer, -1); // size unknown (chunked answer): the count stops it
        t = new FakeTarget();
        ev = new Events();
        MrUpdateInstall.flow(n, t, ev, new TSink());
        check("install: size unknown and the file keeps coming: stops past the signed size, abandoned",
                "mr_update_err_mismatch".equals(ev.key()) && t.data.size() <= apk.length && t.abandoned && !t.committed);
        installNet();

        // network
        body = apk;
        httpCode = 404;
        t = new FakeTarget();
        ev = new Events();
        MrUpdateInstall.flow(n, t, ev, new TSink());
        check("install: HTTP 404 (asset missing): 'couldn't download: GitHub answered 404'",
                ev.failure != null && "mr_update_err_download".equals(ev.key()) && "mr_update_err_http".equals(ev.failure.reasonKey)
                        && ev.failure.arg == 404 && t.abandoned && !t.committed);
        httpCode = 0;
        netDown = true;
        t = new FakeTarget();
        ev = new Events();
        MrUpdateInstall.flow(n, t, ev, new TSink());
        check("install: no connection: 'couldn't download: no connection'",
                ev.failure != null && "mr_update_err_network".equals(ev.failure.reasonKey) && t.abandoned && !t.committed);
        netDown = false;

        // the device
        t = new FakeTarget();
        t.failWrite = "write failed: ENOSPC (No space left on device)";
        t.failAfter = 70000;
        ev = new Events();
        MrUpdateInstall.flow(n, t, ev, new TSink());
        check("install: no space on the device while writing", "mr_update_err_storage".equals(ev.key()) && t.abandoned && !t.committed);
        t = new FakeTarget();
        t.failWrite = "broken pipe";
        t.failAfter = 70000;
        ev = new Events();
        MrUpdateInstall.flow(n, t, ev, new TSink());
        check("install: another write error is 'Android refused'", "mr_update_err_install".equals(ev.key()) && t.abandoned);
        t = new FakeTarget();
        t.failOpen = true;
        ev = new Events();
        MrUpdateInstall.flow(n, t, ev, new TSink());
        check("install: the session cannot be opened for writing", "mr_update_err_install".equals(ev.key()) && t.abandoned && !t.committed);
        t = new FakeTarget();
        t.failCommit = true;
        ev = new Events();
        MrUpdateInstall.flow(n, t, ev, new TSink());
        check("install: the system refuses the commit (SecurityException): shown as 'Android refused', session abandoned",
                "mr_update_err_install".equals(ev.key()) && t.abandoned && !t.committed);

        // cancelling
        t = new FakeTarget();
        ev = new Events();
        final TSink cancelling = new TSink();
        MrPacks.sNet = new MrPacks.Net() {
            public InputStream open(String url, long[] length) {
                length[0] = apk.length;
                return new InputStream() {
                    int pos;

                    public int read() { return pos < apk.length ? apk[pos++] & 0xff : -1; }

                    public int read(byte[] b, int off, int len) {
                        if (pos >= apk.length) return -1;
                        if (pos > 70000) cancelling.cancel = true; // the user taps Cancel after the second block
                        int r = Math.min(Math.min(len, 65536), apk.length - pos);
                        System.arraycopy(apk, pos, b, off, r);
                        pos += r;
                        return r;
                    }
                };
            }
        };
        MrUpdateInstall.flow(n, t, ev, cancelling);
        check("install: Cancel while downloading: stops, abandons, says nothing", t.abandoned && !t.committed && ev.failure == null && !ev.aborted
                && t.data.size() < apk.length);
        installNet();
        body = apk;
        t = new FakeTarget();
        ev = new Events();
        final TSink late = new TSink();
        t.onSync = new Runnable() { public void run() { late.cancel = true; } };
        MrUpdateInstall.flow(n, t, ev, late);
        check("install: Cancel at the last moment (before the commit): nothing is installed", t.abandoned && !t.committed && ev.failure == null);

        // statuses of the system
        check("status: installed, waiting for the user and 'No' are not failures", MrUpdateInstall.statusKey(0) == null
                && MrUpdateInstall.statusKey(-1) == null && MrUpdateInstall.statusKey(3) == null);
        check("status: no storage has its own text", "mr_update_err_storage".equals(MrUpdateInstall.statusKey(6)));
        check("status: blocked, invalid, conflict, incompatible (another signature) and unknown are 'Android refused'",
                "mr_update_err_install".equals(MrUpdateInstall.statusKey(1)) && "mr_update_err_install".equals(MrUpdateInstall.statusKey(2))
                        && "mr_update_err_install".equals(MrUpdateInstall.statusKey(4)) && "mr_update_err_install".equals(MrUpdateInstall.statusKey(5))
                        && "mr_update_err_install".equals(MrUpdateInstall.statusKey(7)) && "mr_update_err_install".equals(MrUpdateInstall.statusKey(99)));
        check("percent: edges", MrUpdateInstall.percent(0, 10) == 0 && MrUpdateInstall.percent(5, 10) == 50
                && MrUpdateInstall.percent(10, 10) == 100 && MrUpdateInstall.percent(11, 10) == 100 && MrUpdateInstall.percent(5, 0) == 0);

        // the job and the answer of the system (a thread, a fake session)
        final FakeTarget t1 = new FakeTarget();
        final Events e1 = new Events();
        check("job: starts", MrUpdateInstall.startWith(n, t1, e1));
        check("job: committed and waiting for the system", waitFor(() -> e1.log.contains("3:100")) && t1.committed && !MrUpdateInstall.busy());
        MrUpdateInstall.cancel();
        MrUpdateInstall.onResult(3);
        check("job: Cancel after the commit does nothing; the 'No' of the confirm screen comes back as 'aborted', not as an error",
                e1.aborted && e1.failure == null);
        MrUpdateInstall.onResult(6);
        check("job: an answer when nothing is in progress is ignored", e1.failure == null);
        final FakeTarget t2 = new FakeTarget();
        final Events e2 = new Events();
        MrUpdateInstall.startWith(n, t2, e2);
        waitFor(() -> e2.log.contains("3:100"));
        MrUpdateInstall.onResult(6);
        check("job: 'no space' from the system is shown as such", e2.failure != null && "mr_update_err_storage".equals(e2.key()));
        final FakeTarget t3 = new FakeTarget();
        final Events e3 = new Events();
        MrUpdateInstall.startWith(n, t3, e3);
        waitFor(() -> e3.log.contains("3:100"));
        MrUpdateInstall.onResult(0);
        check("job: success is left to the new app (nothing is shown)", e3.failure == null && !e3.aborted);

        // cancel with a download that is stuck
        final java.util.concurrent.CountDownLatch gate = new java.util.concurrent.CountDownLatch(1);
        MrPacks.sNet = new MrPacks.Net() {
            public InputStream open(String url, long[] length) {
                length[0] = apk.length;
                return new InputStream() {
                    boolean first = true;

                    public int read() { return -1; }

                    public int read(byte[] b, int off, int len) throws IOException {
                        if (first) {
                            first = false;
                            try {
                                gate.await();
                            } catch (InterruptedException e) {
                                throw new IOException("interrupted");
                            }
                        }
                        return -1;
                    }
                };
            }
        };
        final FakeTarget t4 = new FakeTarget();
        final Events e4 = new Events();
        MrUpdateInstall.startWith(n, t4, e4);
        waitFor(() -> MrUpdateInstall.busy());
        check("job: busy while downloading, and a second start is refused", MrUpdateInstall.busy()
                && !MrUpdateInstall.startWith(n, new FakeTarget(), new Events()));
        MrUpdateInstall.onResult(1);
        check("job: a stale answer of the system does not touch a download in progress", MrUpdateInstall.busy() && e4.failure == null);
        MrUpdateInstall.cancel();
        check("job: Cancel frees the screen at once, even with the network stuck", !MrUpdateInstall.busy());
        gate.countDown();
        check("job: when the stuck read returns, the session is abandoned and nothing is shown",
                waitFor(() -> t4.abandoned) && e4.failure == null && !e4.aborted && !t4.committed);
        installNet();

        // the session is not left behind by the screen
        check("settings screen of the permission is the one of this app", MrUpdateInstall.ACTION_UNKNOWN_SOURCES
                .equals("android.settings.MANAGE_UNKNOWN_APP_SOURCES"));
        at(T0);
    }

    static boolean increasing(java.util.List<Integer> l) {
        for (int i = 1; i < l.size(); i++) if (l.get(i) < l.get(i - 1)) return false;
        return true;
    }

    // ------------------------------------------------------------------ the morning check (MrUpdateSchedule, MrUpdateNotify, MrUpdateJob)

    static final class FakeJobs extends JobScheduler {
        final Map<Integer, JobInfo> pending = new HashMap<Integer, JobInfo>();
        int scheduled, cancelled;
        RuntimeException refuse;

        public int schedule(JobInfo job) {
            if (refuse != null) throw refuse;
            scheduled++;
            pending.put(job.getId(), job);
            return RESULT_SUCCESS;
        }

        public void cancel(int id) {
            cancelled++;
            pending.remove(id);
        }

        public JobInfo getPendingJob(int id) { return pending.get(id); }
    }

    static final class FakeNm extends NotificationManager {
        boolean enabled = true;
        NotificationChannel channel;
        final Map<Integer, Notification> shown = new HashMap<Integer, Notification>();
        int posted, removed;
        RuntimeException refuse;

        @Override public void createNotificationChannel(NotificationChannel c) { if (channel == null) channel = c; }
        @Override public NotificationChannel getNotificationChannel(String id) { return channel; }
        @Override public void notify(int id, Notification n) {
            if (refuse != null) throw refuse;
            posted++;
            shown.put(id, n);
        }
        @Override public void cancel(int id) {
            removed++;
            shown.remove(id);
        }
        @Override public boolean areNotificationsEnabled() { return enabled; }
    }

    /** Resources that answer the name of the string (and its arguments), so that a test can read what was asked. */
    static final class FakeRes extends android.content.res.Resources {
        final List<String> names = new ArrayList<String>();

        @Override public int getIdentifier(String name, String type, String pkg) {
            if (type.equals("drawable")) return 77;
            if (!names.contains(name)) names.add(name);
            return 1000 + names.indexOf(name);
        }
        @Override public String getString(int id) { return names.get(id - 1000); }
        @Override public String getString(int id, Object... a) { return names.get(id - 1000) + Arrays.toString(a); }
    }

    static final class FakeGroup extends android.preference.PreferenceGroup {
        final List<Preference> items = new ArrayList<Preference>();
        int added, removed;

        FakeGroup(Context c) { super(c); }
        @Override public boolean addPreference(Preference p) { added++; items.add(p); return true; }
        @Override public boolean removePreference(Preference p) { removed++; return items.remove(p); }
    }

    static FakeJobs jobsOf(Ctx c) {
        FakeJobs j = new FakeJobs();
        c.systems.put(Context.JOB_SCHEDULER_SERVICE, j);
        return j;
    }

    static FakeNm nmOf(Ctx c) {
        FakeNm n = new FakeNm();
        c.systems.put(Context.NOTIFICATION_SERVICE, n);
        c.res = new FakeRes();
        return n;
    }

    static final TimeZone UTC = TimeZone.getTimeZone("UTC");
    static final TimeZone SP = TimeZone.getTimeZone("America/Sao_Paulo");
    static final TimeZone NY = TimeZone.getTimeZone("America/New_York");

    /** The instant of that wall-clock time (month 1 to 12) in that zone. */
    static long wall(TimeZone tz, int y, int mo, int d, int h, int mi) {
        Calendar c = Calendar.getInstance(tz);
        c.clear();
        c.set(y, mo - 1, d, h, mi, 0);
        return c.getTimeInMillis();
    }

    static void morning() throws Exception {
        TimeZone saved = TimeZone.getDefault();
        TimeZone.setDefault(SP);
        MrPacks.sTestCerts = new X509Certificate[] {new FakeCert(rsa.getPublic())};
        try {
            schedule();
            jobState();
            notifications();
            rounds();
            service();
            settings();
        } finally {
            TimeZone.setDefault(saved);
            android.os.Build.VERSION.SDK_INT = 0;
            MrUpdateSchedule.sTestMinutes = -1;
            installNet();
            netDown = false;
            httpCode = 0;
            at(T0);
        }
    }

    static void schedule() {
        TimeZone sp = SP, ny = NY;
        check("morning: before the time, it is today", MrUpdateSchedule.next(wall(sp, 2026, 11, 5, 7, 0), sp, 20) == wall(sp, 2026, 11, 5, 8, 20));
        check("morning: one millisecond before the time, still today", MrUpdateSchedule.next(wall(sp, 2026, 11, 5, 8, 20) - 1, sp, 20) == wall(sp, 2026, 11, 5, 8, 20));
        check("morning: exactly at the time, it is tomorrow", MrUpdateSchedule.next(wall(sp, 2026, 11, 5, 8, 20), sp, 20) == wall(sp, 2026, 11, 6, 8, 20));
        check("morning: after the time, it is tomorrow", MrUpdateSchedule.next(wall(sp, 2026, 11, 5, 23, 59), sp, 20) == wall(sp, 2026, 11, 6, 8, 20));
        check("morning: end of the month", MrUpdateSchedule.next(wall(sp, 2026, 11, 30, 9, 0), sp, 0) == wall(sp, 2026, 12, 1, 8, 0));
        check("morning: end of the year", MrUpdateSchedule.next(wall(sp, 2026, 12, 31, 23, 59), sp, 7) == wall(sp, 2027, 1, 1, 8, 7));
        check("morning: 28 Feb of a common year goes to 1 March", MrUpdateSchedule.next(wall(sp, 2027, 2, 28, 9, 0), sp, 0) == wall(sp, 2027, 3, 1, 8, 0));
        check("morning: 28 Feb of a leap year goes to 29 Feb", MrUpdateSchedule.next(wall(sp, 2028, 2, 28, 9, 0), sp, 0) == wall(sp, 2028, 2, 29, 8, 0));
        check("morning: minutes below 0 and above 59 are held to 0 and 59",
                MrUpdateSchedule.next(wall(sp, 2026, 11, 5, 7, 0), sp, -5) == wall(sp, 2026, 11, 5, 8, 0)
                        && MrUpdateSchedule.next(wall(sp, 2026, 11, 5, 7, 0), sp, 99) == wall(sp, 2026, 11, 5, 8, 59));

        long now = wall(UTC, 2026, 11, 5, 10, 0);
        check("morning: the same instant is another local day in each zone",
                MrUpdateSchedule.next(now, sp, 0) == wall(UTC, 2026, 11, 5, 11, 0)
                        && MrUpdateSchedule.next(now, TimeZone.getTimeZone("Asia/Tokyo"), 0) == wall(UTC, 2026, 11, 5, 23, 0)
                        && MrUpdateSchedule.next(now, TimeZone.getTimeZone("America/Los_Angeles"), 0) == wall(UTC, 2026, 11, 5, 16, 0));
        check("morning: a zone with half an hour (India) at 8:00 exactly goes to tomorrow",
                MrUpdateSchedule.next(wall(UTC, 2026, 11, 5, 2, 30), TimeZone.getTimeZone("Asia/Kolkata"), 0) == wall(UTC, 2026, 11, 6, 2, 30));

        // daylight saving time: the wall clock stays at 8:xx, the wait grows or shrinks by one hour
        long fall = MrUpdateSchedule.delay(wall(ny, 2026, 10, 31, 20, 0), ny, 0);
        check("morning: New York, the clocks go back: from 20:00 to 8:00 takes 13 hours, not 12", fall == 13 * H);
        check("morning: New York, the clocks go back: it is 8:00 of the new time", MrUpdateSchedule.next(wall(ny, 2026, 10, 31, 20, 0), ny, 0) == wall(UTC, 2026, 11, 1, 13, 0));
        check("morning: New York, the clocks go forward: from 20:00 to 8:00 takes 11 hours", MrUpdateSchedule.delay(wall(ny, 2026, 3, 7, 20, 0), ny, 0) == 11 * H
                && MrUpdateSchedule.next(wall(ny, 2026, 3, 7, 20, 0), ny, 0) == wall(UTC, 2026, 3, 8, 12, 0));
        TimeZone sy = TimeZone.getTimeZone("Australia/Sydney");
        check("morning: Sydney (southern summer time starts in October): 11 hours", MrUpdateSchedule.delay(wall(sy, 2026, 10, 3, 20, 0), sy, 0) == 11 * H);
        check("morning: the delay is never zero or negative", MrUpdateSchedule.delay(wall(sp, 2026, 11, 5, 8, 20), sp, 20) == 24 * H);

        // any moment, any zone: after now, within a day (25 h on the day the clocks go back), at 8:mm, and the first such moment
        String[] zones = {"America/Sao_Paulo", "America/New_York", "Europe/London", "Europe/Lisbon", "Asia/Kolkata", "Asia/Tokyo",
                "Australia/Sydney", "Pacific/Auckland", "UTC", "America/St_Johns", "Africa/Cairo", "Pacific/Chatham"};
        Random rnd = new Random(1820);
        int bad = 0;
        for (int i = 0; i < 6000; i++) {
            TimeZone tz = TimeZone.getTimeZone(zones[i % zones.length]);
            long t = wall(UTC, 2026, 1, 1, 0, 0) + (long) (rnd.nextDouble() * 3 * 365 * 24 * H);
            int m = rnd.nextInt(60);
            long n = MrUpdateSchedule.next(t, tz, m);
            Calendar c = Calendar.getInstance(tz);
            c.setTimeInMillis(n);
            Calendar before = (Calendar) c.clone();
            before.add(Calendar.DAY_OF_MONTH, -1);
            before.set(Calendar.HOUR_OF_DAY, 8);
            before.set(Calendar.MINUTE, m);
            if (n <= t || n - t > 25 * H || c.get(Calendar.HOUR_OF_DAY) != 8 || c.get(Calendar.MINUTE) != m
                    || c.get(Calendar.SECOND) != 0 || before.getTimeInMillis() > t) bad++;
        }
        check("morning: 6000 moments in 12 zones over 3 years, all right", bad == 0, bad + " wrong");
    }

    static void jobState() {
        Ctx c = new Ctx(1081000);
        check("job state: the morning check is on by default", MrUpdateSchedule.morning(c));
        MrUpdateSchedule.setMorning(c, false);
        check("job state: the switch is stored", !MrUpdateSchedule.morning(c));
        MrUpdateSchedule.setMorning(c, true);
        check("job state: nothing notified and the permission not asked at the start", MrUpdateSchedule.notified(c) == 0 && !MrUpdateSchedule.asked(c));
        MrUpdateSchedule.setNotified(c, 1082000);
        MrUpdateSchedule.setAsked(c);
        check("job state: the notified version and the question are stored", MrUpdateSchedule.notified(c) == 1082000 && MrUpdateSchedule.asked(c));

        MrUpdateSchedule.sTestMinutes = -1;
        Set<Integer> seen = new java.util.HashSet<Integer>();
        boolean inRange = true, kept = true;
        for (int i = 0; i < 60; i++) {
            Ctx x = new Ctx(1081000);
            int m = MrUpdateSchedule.minutes(x);
            inRange &= m >= 0 && m <= 59;
            kept &= MrUpdateSchedule.minutes(x) == m && MrUpdateSchedule.minutes(x) == m;
            seen.add(m);
        }
        check("job state: the minutes are drawn between 0 and 59, once, and kept", inRange && kept);
        check("job state: the draw is not always the same", seen.size() > 5, "values " + seen.size());
        Ctx bad = new Ctx(1081000);
        bad.state().m.put(MrUpdateSchedule.KEY_MINUTES, 700);
        check("job state: a stored value out of range is drawn again", MrUpdateSchedule.minutes(bad) <= 59);

        // the job in the system
        at(T0);                       // 05:00 in Sao Paulo
        MrUpdateSchedule.sTestMinutes = 20;
        Ctx d = new Ctx(1081000);
        FakeJobs js = jobsOf(d);
        MrUpdateSchedule.arm(d);
        JobInfo job = js.pending.get(MrUpdateSchedule.JOB_ID);
        check("job: armed with the id of the job, the service of the update, any network and persisted",
                job != null && job.getService().getClassName().equals("com.mrkeyboard.app.MrUpdateJob")
                        && job.getService().getPackageName().equals("com.mrkeyboard.app")
                        && job.getNetworkType() == JobInfo.NETWORK_TYPE_ANY && job.isPersisted());
        check("job: it waits until 8:20 of the phone (3 h 20 min after 5:00)", job != null && job.getMinLatencyMillis() == 3 * H + 20 * 60000L);
        at(T0 + 10 * H);              // 15:00
        MrUpdateSchedule.arm(d);
        check("job: armed again replaces the job and now waits for tomorrow (17 h 20 min)",
                js.pending.size() == 1 && js.pending.get(MrUpdateSchedule.JOB_ID).getMinLatencyMillis() == 17 * H + 20 * 60000L);
        int sch = js.scheduled;
        MrUpdateSchedule.ensure(d);
        check("job: ensure leaves a waiting job alone", js.scheduled == sch && MrUpdateSchedule.armed(d));
        js.pending.clear();
        check("job: with no job waiting, armed says no and ensure schedules one", !MrUpdateSchedule.armed(d)
                && fire(() -> MrUpdateSchedule.ensure(d)) && MrUpdateSchedule.armed(d));
        MrUpdateSchedule.setMorning(d, false);
        MrUpdateSchedule.ensure(d);
        check("job: with the switch off, ensure cancels what was left", !MrUpdateSchedule.armed(d) && js.cancelled > 0);
        js.pending.put(MrUpdateSchedule.JOB_ID, job);
        MrUpdateSchedule.arm(d);
        check("job: with the switch off, arm cancels and schedules nothing", js.pending.isEmpty());
        MrUpdateSchedule.setMorning(d, true);

        js.refuse = new IllegalArgumentException("persisted jobs need RECEIVE_BOOT_COMPLETED");
        boolean threw = false;
        try {
            MrUpdateSchedule.arm(d);
            MrUpdateSchedule.ensure(d);
        } catch (RuntimeException e) {
            threw = true;
        }
        check("job: if the system refuses the job, nothing is thrown", !threw);
        Ctx none = new Ctx(1081000);
        try {
            MrUpdateSchedule.arm(none);
            MrUpdateSchedule.ensure(none);
            MrUpdateSchedule.sync(none);
        } catch (RuntimeException e) {
            threw = true;
        }
        check("job: with no job service on the phone, nothing is thrown and armed is false", !threw && !MrUpdateSchedule.armed(none));
        at(T0);
    }

    interface Action { void run(); }

    static boolean fire(Action a) {
        a.run();
        return true;
    }

    static MrUpdate.Notice notice(N n) throws Exception {
        return MrUpdate.readData(n.json());
    }

    static void notifications() throws Exception {
        Ctx c = new Ctx(1081000);
        FakeNm nm = nmOf(c);
        check("notification: allowed when the app's notifications are on and the channel does not exist yet", MrUpdateNotify.enabled(c));
        nm.enabled = false;
        check("notification: blocked when the app's notifications are off", !MrUpdateNotify.enabled(c));
        nm.enabled = true;
        MrUpdateNotify.ensureChannel(c);
        check("notification: the channel 'mr_update' has low importance and its own name",
                nm.channel != null && nm.channel.getId().equals("mr_update") && nm.channel.getImportance() == NotificationManager.IMPORTANCE_LOW
                        && "mr_update_notif_channel".equals(String.valueOf(nm.channel.getName())));
        nm.channel.setImportance(NotificationManager.IMPORTANCE_NONE);
        check("notification: blocked when the user turned the channel off", !MrUpdateNotify.enabled(c));
        nm.channel.setImportance(NotificationManager.IMPORTANCE_LOW);
        check("notification: allowed again with the channel on", MrUpdateNotify.enabled(c));
        check("notification: with no notification service the answer is 'blocked'", !MrUpdateNotify.enabled(new Ctx(1081000)));

        MrUpdate.Notice n = notice(new N());
        check("notification: show posts it", MrUpdateNotify.show(c, n) && nm.posted == 1 && nm.shown.containsKey(MrUpdateNotify.ID));
        Notification p = nm.shown.get(MrUpdateNotify.ID);
        check("notification: channel, icon, title with the version, text and removal on tap",
                p != null && p.channelId.equals("mr_update") && p.smallIcon == 77
                        && "mr_update_notif_title[v1.82.0]".equals(String.valueOf(p.contentTitle))
                        && "mr_update_notif_text".equals(String.valueOf(p.contentText)) && p.autoCancel);
        android.app.PendingIntent tap = p == null ? null : p.contentIntent;
        check("notification: the tap is an activity PendingIntent that cannot be changed by others",
                tap != null && tap.activity && tap.flags == (android.app.PendingIntent.FLAG_IMMUTABLE | android.app.PendingIntent.FLAG_UPDATE_CURRENT));
        android.content.Intent i = tap == null ? null : tap.intent;
        check("notification: it opens the Settings of the app in a clean task, asking for the dialog",
                i != null && "com.mrkeyboard.app".equals(i.packageName) && "com.mrkeyboard.app.LatinIMESettings".equals(i.className)
                        && Boolean.TRUE.equals(i.extras.get(MrUpdateUi.EXTRA_SHOW))
                        && i.flags == (android.content.Intent.FLAG_ACTIVITY_NEW_TASK | android.content.Intent.FLAG_ACTIVITY_CLEAR_TASK));
        android.content.Intent s = MrUpdateNotify.settingsIntent(c);
        check("notification: the line 'Allow notifications' opens the notification settings of this app",
                "android.settings.APP_NOTIFICATION_SETTINGS".equals(s.action) && "com.mrkeyboard.app".equals(s.extras.get("android.provider.extra.APP_PACKAGE")));

        nm.refuse = new IllegalStateException("no channel");
        check("notification: if the system refuses it, show says false and throws nothing", !MrUpdateNotify.show(c, n));
        nm.refuse = null;
        check("notification: with no notification service, show says false", !MrUpdateNotify.show(new Ctx(1081000), n));

        // it goes away when the installed app already is that version
        Ctx d = new Ctx(1081000);
        FakeNm nm2 = nmOf(d);
        run(d, new N());
        MrUpdateNotify.show(d, MrUpdate.pending(d));
        MrUpdateNotify.dropIfInstalled(d);
        check("notification: stays while the new version is not installed", nm2.removed == 0 && nm2.shown.size() == 1);
        d.versionCode = 1082000;
        MrUpdateNotify.dropIfInstalled(d);
        check("notification: removed when the installed app is that version", nm2.removed == 1 && nm2.shown.isEmpty());
        d.versionCode = 1090000;
        MrUpdateNotify.show(d, notice(new N()));
        MrUpdateNotify.dropIfInstalled(d);
        check("notification: removed when the installed app is newer too", nm2.shown.isEmpty());
    }

    static void rounds() throws Exception {
        MrUpdateSchedule.sTestMinutes = 20;
        Ctx c = new Ctx(1081000);
        FakeNm nm = nmOf(c);
        jobsOf(c);
        netDown = false;
        httpCode = 0;
        body = good(new N());
        requests = 0;
        at(T0);

        MrUpdateSchedule.setMorning(c, false);
        check("round: switch off - nothing happens and no request", MrUpdateJob.run(c) == MrUpdateJob.OFF && requests == 0 && nm.posted == 0);
        MrUpdateSchedule.setMorning(c, true);
        nm.enabled = false;
        check("round: notifications blocked - no request at all", MrUpdateJob.run(c) == MrUpdateJob.BLOCKED && requests == 0 && nm.posted == 0);
        nm.channel = new NotificationChannel("mr_update", "x", NotificationManager.IMPORTANCE_NONE);
        nm.enabled = true;
        check("round: channel turned off - no request either", MrUpdateJob.run(c) == MrUpdateJob.BLOCKED && requests == 0);
        nm.channel = null;

        check("round: a new version - one request and one notification", MrUpdateJob.run(c) == MrUpdateJob.NOTIFIED && requests == 1 && nm.posted == 1);
        check("round: the version is marked as notified", MrUpdateSchedule.notified(c) == 1082000);
        at(T0 + 1 * H);
        check("round: again an hour later - the result of the check is reused, nothing posted again",
                MrUpdateJob.run(c) == MrUpdateJob.REPEATED && requests == 1 && nm.posted == 1);
        at(T0 + 24 * H);
        check("round: next morning, same version - asks again (more than 6 h) but does not repeat the notification",
                MrUpdateJob.run(c) == MrUpdateJob.REPEATED && requests == 2 && nm.posted == 1);
        nm.shown.clear();
        at(T0 + 48 * H);
        check("round: a notification that the user dismissed does not come back for the same version",
                MrUpdateJob.run(c) == MrUpdateJob.REPEATED && nm.posted == 1 && nm.shown.isEmpty());

        body = good(new N().code(1083000, "v1.83.0"));
        at(T0 + 72 * H);
        check("round: an even newer version gets its own notification", MrUpdateJob.run(c) == MrUpdateJob.NOTIFIED && nm.posted == 2
                && MrUpdateSchedule.notified(c) == 1083000
                && "mr_update_notif_title[v1.83.0]".equals(String.valueOf(nm.shown.get(MrUpdateNotify.ID).contentTitle)));
        int req = requests;
        at(T0 + 72 * H + 5 * H);
        MrUpdateJob.run(c);
        check("round: 5 hours later the stored result is used (window of 6 h)", requests == req);
        at(T0 + 72 * H + 7 * H);
        MrUpdateJob.run(c);
        check("round: 7 hours later it asks again", requests == req + 1);

        // opening the app a few minutes before the job: one request for both
        Ctx e = new Ctx(1081000);
        FakeNm nme = nmOf(e);
        body = good(new N());
        requests = 0;
        at(T0);
        MrUpdate.checkIfOlder(e, MrUpdate.WINDOW);          // what opening the app does
        at(T0 + 10 * 60000L);
        check("round: the job right after opening the app makes no second request and still notifies",
                MrUpdateJob.run(e) == MrUpdateJob.NOTIFIED && requests == 1 && nme.posted == 1);

        // "Check when the app opens" is another switch: it does not stop the morning check
        Ctx f = new Ctx(1081000);
        FakeNm nmf = nmOf(f);
        MrUpdate.setAuto(f, false);
        requests = 0;
        at(T0);
        check("round: with 'check when the app opens' off the morning check still works", MrUpdateJob.run(f) == MrUpdateJob.NOTIFIED && requests == 1);

        // offline
        Ctx g = new Ctx(1081000);
        FakeNm nmg = nmOf(g);
        netDown = true;
        requests = 0;
        check("round: offline and nothing known - fails quietly, nothing marked as notified",
                MrUpdateJob.run(g) == MrUpdateJob.FAILED && requests == 1 && nmg.posted == 0 && MrUpdateSchedule.notified(g) == 0);
        MrUpdateJob.run(g);
        check("round: after a failed try the next round within the hour does not insist", requests == 1);
        netDown = false;
        at(T0 + 2 * H);
        check("round: online again, it works", MrUpdateJob.run(g) == MrUpdateJob.NOTIFIED && nmg.posted == 1);

        Ctx h = new Ctx(1081000);
        FakeNm nmh = nmOf(h);
        at(T0);
        run(h, new N());                                    // known from an earlier check, not notified
        at(T0 + 30 * H);
        netDown = true;
        check("round: offline with a version already known and not notified - it is notified from what is stored",
                MrUpdateJob.run(h) == MrUpdateJob.NOTIFIED && nmh.posted == 1);
        netDown = false;

        // already up to date
        Ctx k = new Ctx(1082000);
        FakeNm nmk = nmOf(k);
        at(T0);
        check("round: the installed app is the latest - nothing, and an old notification is taken away",
                MrUpdateJob.run(k) == MrUpdateJob.NONE && nmk.posted == 0 && nmk.removed == 1);

        // errors
        Ctx m = new Ctx(1081000);
        FakeNm nmm = nmOf(m);
        body = "not json".getBytes(StandardCharsets.UTF_8);
        check("round: an invalid update.json - nothing posted", MrUpdateJob.run(m) == MrUpdateJob.FAILED && nmm.posted == 0);
        body = good(new N());
        nmm.refuse = new IllegalStateException();
        at(T0 + 5 * H);
        check("round: a notification the system refuses is not marked as notified",
                MrUpdateJob.run(m) == MrUpdateJob.FAILED && MrUpdateSchedule.notified(m) == 0);
        nmm.refuse = null;
        check("round: the next round posts it", MrUpdateJob.run(m) == MrUpdateJob.NOTIFIED && nmm.posted == 1);
        check("round: with no services at all it throws nothing", MrUpdateJob.run(new Ctx(1081000)) == MrUpdateJob.BLOCKED);
        at(T0);
    }

    static void service() throws Exception {
        MrUpdateSchedule.sTestMinutes = 20;
        body = good(new N());
        netDown = false;
        httpCode = 0;
        requests = 0;
        at(T0);
        Ctx c = new Ctx(1081000);
        FakeNm nm = nmOf(c);
        FakeJobs js = jobsOf(c);
        MrUpdateJob job = new MrUpdateJob();
        job.stubAttach(c);
        JobParameters p = new JobParameters(MrUpdateSchedule.JOB_ID);
        check("service: onStartJob says that work goes on in the background", job.onStartJob(p));
        check("service: the job ends", waitFor(() -> job.finishedCount == 1));
        check("service: the round was made (one notification)", nm.posted == 1 && requests == 1);
        JobInfo next = js.pending.get(MrUpdateSchedule.JOB_ID);
        check("service: the next morning is scheduled (8:20 of the phone, 3 h 20 min after 5:00)",
                next != null && next.getMinLatencyMillis() == 3 * H + 20 * 60000L && next.isPersisted());
        check("service: it does not ask the system to run it again", !job.lastWantsReschedule);
        check("service: stopped after the work ended (the new job replaced it) - nothing is rescheduled", !job.onStopJob(p));

        // stopped by the system while the work is going on
        final CountDownLatch entered = new CountDownLatch(1), gate = new CountDownLatch(1);
        MrPacks.sNet = new MrPacks.Net() {
            public InputStream open(String url, long[] length) throws IOException {
                entered.countDown();
                try {
                    gate.await(10, TimeUnit.SECONDS);
                } catch (InterruptedException e) {
                    throw new IOException("interrupted");
                }
                length[0] = body.length;
                return new ByteArrayInputStream(body);
            }
        };
        Ctx d = new Ctx(1081000);
        nmOf(d);
        FakeJobs js2 = jobsOf(d);
        MrUpdateJob job2 = new MrUpdateJob();
        job2.stubAttach(d);
        job2.onStartJob(p);
        check("service: the work is waiting for the network", entered.await(5, TimeUnit.SECONDS));
        check("service: stopped by the system in the middle - asks to be tried again", job2.onStopJob(p) && job2.finishedCount == 0);
        gate.countDown();
        check("service: when the work ends it still schedules the next morning", waitFor(() -> job2.finishedCount == 1) && js2.pending.containsKey(MrUpdateSchedule.JOB_ID));
        installNet();

        // switch turned off after the job was scheduled: the round does nothing and the job is not scheduled again
        Ctx e = new Ctx(1081000);
        FakeNm nme = nmOf(e);
        FakeJobs js3 = jobsOf(e);
        MrUpdateSchedule.setMorning(e, false);
        requests = 0;
        MrUpdateJob job3 = new MrUpdateJob();
        job3.stubAttach(e);
        job3.onStartJob(p);
        check("service: with the switch off the job ends without a request and without a new job",
                waitFor(() -> job3.finishedCount == 1) && requests == 0 && nme.posted == 0 && js3.pending.isEmpty());

        // a receiver that survives an update of the app
        Ctx f = new Ctx(1081000);
        FakeNm nmf = nmOf(f);
        FakeJobs js4 = jobsOf(f);
        run(f, new N());
        MrUpdateNotify.show(f, MrUpdate.pending(f));
        f.versionCode = 1082000;                              // the update was installed
        MrUpdateRearm r = new MrUpdateRearm();
        r.onReceive(f, new android.content.Intent(android.content.Intent.ACTION_MY_PACKAGE_REPLACED));
        check("rearm: after the update of the app the morning job exists again", js4.pending.containsKey(MrUpdateSchedule.JOB_ID));
        check("rearm: and the notification of the installed version is gone", nmf.shown.isEmpty());
        js4.pending.clear();
        r.onReceive(f, new android.content.Intent("android.intent.action.BOOT_COMPLETED"));
        r.onReceive(f, null);
        check("rearm: other broadcasts and null do nothing", js4.pending.isEmpty());
        MrUpdateSchedule.setMorning(f, false);
        r.onReceive(f, new android.content.Intent(android.content.Intent.ACTION_MY_PACKAGE_REPLACED));
        check("rearm: with the switch off nothing is scheduled", js4.pending.isEmpty());
        at(T0);
    }

    static void settings() throws Exception {
        MrPacks.sTestCerts = new X509Certificate[] {new FakeCert(rsa.getPublic())};
        netDown = false;
        httpCode = 0;
        body = good(new N());
        MrUpdateSchedule.sTestMinutes = 20;
        at(T0);
        String perm = "android.permission.POST_NOTIFICATIONS";

        // Android 13+, blocked: the system dialog on the first opening, the line stays in the screen
        android.os.Build.VERSION.SDK_INT = 33;
        Ctx c = new Ctx(1081000);
        FakeNm nm = nmOf(c);
        FakeJobs js = jobsOf(c);
        nm.enabled = false;
        MrUpdate.setAuto(c, false);
        FakeActivity a = new FakeActivity(c);
        FakeGroup grp = new FakeGroup(c);
        FakeSwitch morning = new FakeSwitch(c);
        FakeRow allow = new FakeRow(c);
        a.prefs.put("debugging", grp);
        a.prefs.put("mr_update_morning", morning);
        a.prefs.put("mr_update_notif", allow);
        MrUpdateUi.bind(a);
        check("settings: the morning switch shows 'on' (the default) and is connected", morning.checked && morning.change != null && allow.click != null);
        check("settings 13+: first opening with notifications blocked asks the permission once",
                a.requested.size() == 1 && a.requested.get(0).length == 1 && a.requested.get(0)[0].equals(perm) && MrUpdateSchedule.asked(c));
        check("settings: blocked - the line 'Allow notifications' stays in the screen", grp.removed == 0 && grp.added == 0);
        check("settings: opening makes sure the job exists (background)", waitFor(() -> js.pending.containsKey(MrUpdateSchedule.JOB_ID)) && nm.channel != null);
        MrUpdateUi.onOpen(a);
        settle();
        check("settings 13+: the next opening does not ask again", a.requested.size() == 1);

        nm.enabled = true;
        MrUpdateUi.resume(a);
        check("settings: after the user allows them, coming back takes the line away", grp.removed == 1 && grp.items.isEmpty());
        MrUpdateUi.resume(a);
        check("settings: coming back again changes nothing", grp.removed == 1 && grp.added == 0);
        nm.enabled = false;
        MrUpdateUi.resume(a);
        check("settings: if the permission is taken away the line comes back", grp.added == 1 && grp.items.size() == 1 && grp.items.get(0) == allow);
        allow.click.onPreferenceClick(allow);
        check("settings: tapping the line opens the notification settings of the app", a.started.size() == 1
                && "android.settings.APP_NOTIFICATION_SETTINGS".equals(a.started.get(0).action)
                && "com.mrkeyboard.app".equals(a.started.get(0).extras.get("android.provider.extra.APP_PACKAGE")));

        morning.change.onPreferenceChange(morning, Boolean.FALSE);
        check("settings: turning the switch off is stored, cancels the job and takes the line away",
                !MrUpdateSchedule.morning(c) && js.pending.isEmpty() && grp.removed == 2 && a.requested.size() == 1);
        morning.change.onPreferenceChange(morning, Boolean.TRUE);
        check("settings: turning it on schedules the job, asks for the permission again and shows the line",
                MrUpdateSchedule.morning(c) && js.pending.containsKey(MrUpdateSchedule.JOB_ID) && a.requested.size() == 2 && grp.added == 2);
        nm.enabled = true;
        morning.change.onPreferenceChange(morning, Boolean.TRUE);
        check("settings: with the notifications allowed turning it on does not ask", a.requested.size() == 2);

        // another screen closing does not take the line away from Settings
        FakeActivity main = new FakeActivity(c);
        MrUpdateUi.release(main);
        nm.enabled = false;
        MrUpdateUi.resume(a);
        check("settings: another screen going away leaves the line working", grp.added == 3);
        int removedBefore = grp.removed, addedBefore = grp.added;
        MrUpdateUi.release(a);
        nm.enabled = true;
        MrUpdateUi.resume(a);
        nm.enabled = false;
        MrUpdateUi.resume(a);
        check("settings: after Settings goes away nothing more is touched", grp.removed == removedBefore && grp.added == addedBefore);

        // Android 12 and older: no permission to ask, but a blocked app still shows the line
        android.os.Build.VERSION.SDK_INT = 32;
        Ctx d = new Ctx(1081000);
        FakeNm nmd = nmOf(d);
        nmd.enabled = false;
        MrUpdate.setAuto(d, false);
        FakeActivity b = new FakeActivity(d);
        FakeGroup grpb = new FakeGroup(d);
        b.prefs.put("debugging", grpb);
        b.prefs.put("mr_update_morning", new FakeSwitch(d));
        b.prefs.put("mr_update_notif", new FakeRow(d));
        MrUpdateUi.bind(b);
        settle();
        check("settings 12-: no permission is asked and the line stays while the notifications are blocked", b.requested.isEmpty() && grpb.removed == 0);
        MrUpdateUi.release(b);

        // everything allowed from the start: the line is taken out, no question
        android.os.Build.VERSION.SDK_INT = 33;
        Ctx e = new Ctx(1081000);
        nmOf(e);
        MrUpdate.setAuto(e, false);
        FakeActivity g = new FakeActivity(e);
        FakeGroup grpg = new FakeGroup(e);
        g.prefs.put("debugging", grpg);
        g.prefs.put("mr_update_morning", new FakeSwitch(e));
        g.prefs.put("mr_update_notif", new FakeRow(e));
        MrUpdateUi.bind(g);
        settle();
        check("settings: notifications allowed - the line is taken out and nothing is asked", grpg.removed == 1 && g.requested.isEmpty());
        MrUpdateUi.release(g);

        // switch off from the start: no question and no line
        Ctx h = new Ctx(1081000);
        FakeNm nmh = nmOf(h);
        nmh.enabled = false;
        MrUpdate.setAuto(h, false);
        MrUpdateSchedule.setMorning(h, false);
        FakeActivity k = new FakeActivity(h);
        FakeGroup grph = new FakeGroup(h);
        FakeSwitch swh = new FakeSwitch(h);
        k.prefs.put("debugging", grph);
        k.prefs.put("mr_update_morning", swh);
        k.prefs.put("mr_update_notif", new FakeRow(h));
        MrUpdateUi.bind(k);
        settle();
        check("settings: switch off - the switch shows 'off', no question and no line", !swh.checked && k.requested.isEmpty() && grph.removed == 1);
        MrUpdateUi.release(k);

        // the system dialog and ours do not come together
        Ctx m = new Ctx(1081000);
        FakeNm nmm = nmOf(m);
        jobsOf(m);
        nmm.enabled = false;
        run(m, new N());                                   // a version is known
        FakeActivity q = new FakeActivity(m);
        int shown = MrUpdateDialog.sAskedCount;
        MrUpdateUi.onOpen(q);
        settle();
        check("opening: while the permission dialog is asked, the update dialog waits", q.requested.size() == 1 && MrUpdateDialog.sAskedCount == shown);
        MrUpdateUi.onOpen(q);
        check("opening: next time the update dialog comes", waitFor(() -> MrUpdateDialog.sAskedCount == shown + 1) && q.requested.size() == 1);

        // started by the notification: the dialog, and the job is still made sure of
        Ctx n = new Ctx(1081000);
        nmOf(n);
        FakeJobs jsn = jobsOf(n);
        run(n, new N());
        FakeActivity r = new FakeActivity(n);
        r.intent = new android.content.Intent().putExtra(MrUpdateUi.EXTRA_SHOW, true);
        int shown2 = MrUpdateDialog.sAskedCount;
        MrUpdateUi.onOpen(r);
        check("opening from the notification: the dialog opens at once, the extra is used up and no permission is asked",
                MrUpdateDialog.sAskedCount == shown2 + 1 && !r.intent.getBooleanExtra(MrUpdateUi.EXTRA_SHOW, false) && r.requested.isEmpty());
        check("opening from the notification: the morning job is made sure of", waitFor(() -> jsn.pending.containsKey(MrUpdateSchedule.JOB_ID)));

        android.os.Build.VERSION.SDK_INT = 0;
        at(T0);
    }

    static void notesText() throws Exception {
        check("plain text: bullets, bold and code marks removed", MrUpdate.plain("- One **bold** and `code`.\n- Two.")
                .equals("• One bold and code.\n• Two."));
        check("plain text: CRLF, trailing spaces and runs of blank lines", MrUpdate.plain("Line  \r\n\r\n\r\n\r\n- Item \r\n").equals("Line\n\n• Item"));
        check("plain text: a line without marks stays as it is, null gives empty", MrUpdate.plain("Just text, 2 * 3 = 6.").equals("Just text, 2 * 3 = 6.")
                && MrUpdate.plain(null).equals(""));
        check("plain text: a star bullet works too and an accent stays", MrUpdate.plain("* Correção").equals("• Correção"));

        MrUpdate.Notice n = run(new Ctx(1081000), new N()).notice;
        check("notes by language: Portuguese for pt", n.notes(new Locale("pt", "BR")).startsWith("• Novidade boa em Ajustes."));
        check("notes by language: Portuguese for pt-PT too", n.notes(new Locale("pt", "PT")).startsWith("• Novidade"));
        check("notes by language: English for en", n.notes(Locale.US).startsWith("• Good news in Settings."));
        check("notes by language: Spanish, French and no language get English", n.notes(new Locale("es")).startsWith("• Good news")
                && n.notes(Locale.FRANCE).startsWith("• Good news") && n.notes(null).startsWith("• Good news"));
    }

    // ------------------------------------------------------------------ files made by the real tools

    static void realFiles(File dir) throws Exception {
        File certFile = new File(dir, "cert.pem");
        if (!certFile.exists()) {
            check("real files: folder given but without cert.pem", false, dir.getPath());
            return;
        }
        X509Certificate cert;
        try (InputStream in = new FileInputStream(certFile)) {
            cert = (X509Certificate) CertificateFactory.getInstance("X.509").generateCertificate(in);
        }
        String shaApk = new String(Files.readAllBytes(new File(dir, "apk.sha256").toPath()), StandardCharsets.UTF_8).trim();
        MrPacks.sTestCerts = new X509Certificate[] {cert};
        httpCode = 0;
        netDown = false;

        Ctx c = new Ctx(1081000);
        body = Files.readAllBytes(new File(dir, "update.json").toPath());
        MrUpdate.Result r = MrUpdate.check(c);
        check("real tools: update.json (make_update.py + SignCatalog --domain update) is accepted with the certificate", r.status == MrUpdate.AVAILABLE,
                "status " + r.status + " error " + r.error);
        check("real tools: its fields are those of the APK and of the notes", r.notice != null && r.notice.versionName.equals("v1.82.0")
                && r.notice.versionCode == 1082000 && r.notice.apkSha256.equals(shaApk) && r.notice.apkSize == 3
                && r.notice.notes(new Locale("pt")).equals("• Novidade boa.") && r.notice.notes(Locale.US).equals("• Good news."));
        check("real tools: the APK address", r.notice != null && r.notice.apkUrl().endsWith("/v1.82.0/mr-keyboard-v1.82.0.apk"));

        c = new Ctx(1081000);
        body = Files.readAllBytes(new File(dir, "as_catalog.json").toPath());
        r = MrUpdate.check(c);
        check("real tools: the same data signed for the catalog is not accepted", r.status == MrUpdate.FAILED && r.error == MrUpdate.ERR_SIGNATURE);

        c = new Ctx(1081000);
        String tampered = new String(Files.readAllBytes(new File(dir, "update.json").toPath()), StandardCharsets.UTF_8)
                .replace("1082000", "1099000");
        body = tampered.getBytes(StandardCharsets.UTF_8);
        r = MrUpdate.check(c);
        check("real tools: update.json changed after signing is not accepted", r.status == MrUpdate.FAILED && r.error == MrUpdate.ERR_SIGNATURE);
    }
}
