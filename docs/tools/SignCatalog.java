import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.security.KeyFactory;
import java.security.KeyStore;
import java.security.MessageDigest;
import java.security.PrivateKey;
import java.security.Signature;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Base64;

/**
 * Assina o catálogo de dicionários com a mesma chave que assina o APK.
 *
 * O app confere a assinatura com o certificado com que ele mesmo foi instalado, então só aceita
 * catálogos feitos por quem tem a chave do APK. Rodar com o Java 11 ou mais novo:
 *
 *   java SignCatalog.java --data out/dados.json --out out/catalogo.json --keystore key.jks
 *       (senhas e alias nas variáveis KEYSTORE_PASS, KEY_ALIAS e KEY_PASS)
 *   java SignCatalog.java --data out/dados.json --out out/catalogo.json --pk8 key.pk8 --cert cert.pem
 *
 * A mensagem assinada é PREFIX + bytes de dados.json; o prefixo impede que a assinatura sirva
 * para qualquer outra coisa. Saída (JSON):
 *   {"format":1,"algorithm":"SHA256withRSA","signer":"<SHA-256 do certificado>",
 *    "signature":"<base64>","data":"<dados.json como texto>"}
 */
public class SignCatalog {
    static final String PREFIX = "mr-keyboard/catalogo/v1\n";

    public static void main(String[] args) throws Exception {
        String data = null, out = null, ks = null, pk8 = null, cert = null;
        for (int i = 0; i + 1 < args.length; i += 2) {
            switch (args[i]) {
                case "--data": data = args[i + 1]; break;
                case "--out": out = args[i + 1]; break;
                case "--keystore": ks = args[i + 1]; break;
                case "--pk8": pk8 = args[i + 1]; break;
                case "--cert": cert = args[i + 1]; break;
                default: die("opção desconhecida: " + args[i]);
            }
        }
        if (data == null || out == null || (ks == null && (pk8 == null || cert == null))) {
            die("uso: --data dados.json --out catalogo.json (--keystore arq | --pk8 arq --cert arq)");
        }

        PrivateKey key;
        X509Certificate crt;
        if (ks != null) {
            char[] storePass = env("KEYSTORE_PASS").toCharArray();
            String alias = env("KEY_ALIAS");
            String kp = System.getenv("KEY_PASS");
            char[] keyPass = (kp == null || kp.isEmpty()) ? storePass : kp.toCharArray();
            KeyStore store = null;
            try {
                store = KeyStore.getInstance(new File(ks), storePass);
            } catch (Exception e) {
                die("não abriu o keystore: senha (KEYSTORE_PASS) errada ou arquivo incompleto (" + e.getMessage() + ")");
            }
            try {
                key = (PrivateKey) store.getKey(alias, keyPass);
            } catch (java.security.UnrecoverableKeyException e) {
                die("a senha da chave (KEY_PASS) está errada");
                return;
            }
            crt = (X509Certificate) store.getCertificate(alias);
            if (key == null || crt == null) die("o alias " + alias + " não tem chave privada no keystore");
        } else {
            byte[] der = Files.readAllBytes(new File(pk8).toPath());
            key = readPk8(der);
            try (InputStream in = new FileInputStream(cert)) {
                crt = (X509Certificate) CertificateFactory.getInstance("X.509").generateCertificate(in);
            }
        }

        String alg;
        switch (key.getAlgorithm()) {
            case "RSA": alg = "SHA256withRSA"; break;
            case "EC": alg = "SHA256withECDSA"; break;
            case "DSA": alg = "SHA256withDSA"; break;
            default: die("tipo de chave não suportado: " + key.getAlgorithm()); return;
        }

        byte[] dataBytes = Files.readAllBytes(new File(data).toPath());
        String dataText = new String(dataBytes, StandardCharsets.UTF_8);
        if (!java.util.Arrays.equals(dataText.getBytes(StandardCharsets.UTF_8), dataBytes)) {
            die("dados.json não é UTF-8 válido");
        }
        byte[] msg = message(dataBytes);

        Signature s = Signature.getInstance(alg);
        s.initSign(key);
        s.update(msg);
        byte[] sig = s.sign();

        Signature v = Signature.getInstance(alg);
        v.initVerify(crt.getPublicKey());
        v.update(msg);
        if (!v.verify(sig)) die("a assinatura não confere com o certificado (chave e certificado não combinam)");

        String signer = hex(MessageDigest.getInstance("SHA-256").digest(crt.getEncoded()));
        StringBuilder j = new StringBuilder();
        j.append("{\n \"format\": 1,\n \"algorithm\": ").append(quote(alg))
         .append(",\n \"signer\": ").append(quote(signer))
         .append(",\n \"signature\": ").append(quote(Base64.getEncoder().encodeToString(sig)))
         .append(",\n \"data\": ").append(quote(dataText)).append("\n}\n");
        Files.write(new File(out).toPath(), j.toString().getBytes(StandardCharsets.UTF_8));
        System.out.println("catálogo assinado (" + alg + ")");
        System.out.println("certificado SHA-256: " + signer);
        System.out.println("(tem que ser igual ao \"certificate SHA-256 digest\" do APK)");
    }

    static byte[] message(byte[] data) {
        ByteArrayOutputStream b = new ByteArrayOutputStream();
        byte[] p = PREFIX.getBytes(StandardCharsets.UTF_8);
        b.write(p, 0, p.length);
        b.write(data, 0, data.length);
        return b.toByteArray();
    }

    static PrivateKey readPk8(byte[] der) throws Exception {
        PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec(der);
        for (String a : new String[] {"RSA", "EC", "DSA"}) {
            try {
                return KeyFactory.getInstance(a).generatePrivate(spec);
            } catch (Exception ignored) {
                // tenta o próximo tipo
            }
        }
        die("não consegui ler a chave .pk8 (precisa ser PKCS#8 DER sem senha)");
        return null;
    }

    static String quote(String s) {
        StringBuilder b = new StringBuilder(s.length() + 16).append('"');
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            switch (c) {
                case '"': b.append("\\\""); break;
                case '\\': b.append("\\\\"); break;
                case '\n': b.append("\\n"); break;
                case '\r': b.append("\\r"); break;
                case '\t': b.append("\\t"); break;
                default:
                    if (c < 0x20 || c == 0x2028 || c == 0x2029) b.append(String.format("\\u%04x", (int) c));
                    else b.append(c);
            }
        }
        return b.append('"').toString();
    }

    static String hex(byte[] d) {
        StringBuilder b = new StringBuilder();
        for (byte x : d) b.append(String.format("%02x", x & 0xff));
        return b.toString();
    }

    static String env(String name) {
        String v = System.getenv(name);
        if (v == null || v.isEmpty()) die("falta a variável " + name);
        return v;
    }

    static void die(String msg) {
        System.out.println("::error::" + msg);
        System.exit(1);
    }
}
