package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;

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
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

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

        Ctx(int installed) {
            versionCode = installed;
        }

        public android.content.res.AssetManager getAssets() { return null; }
        public Context getApplicationContext() { return this; }
        public android.content.res.Resources getResources() { return null; }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public File getFilesDir() { return null; }
        public File getCacheDir() { return null; }
        public void startActivity(android.content.Intent i) { }

        public PackageManager getPackageManager() {
            return new PackageManager() {
                public PackageInfo getPackageInfo(String name, int flags) {
                    PackageInfo pi = new PackageInfo();
                    pi.versionCode = versionCode;
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
