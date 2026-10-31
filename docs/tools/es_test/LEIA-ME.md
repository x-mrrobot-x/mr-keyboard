# Teste do idioma espanhol no código (editor de folhas e anexos)

Confere `SheetStrings.isPt/p` e `MrEs` com contextos em espanhol, português, inglês e francês: no espanhol o texto em português
passa pela tabela do `MrEs` e sai em espanhol; no português e no inglês nada muda; texto sem tradução fica igual; o texto que o código
tinha só em português (anexos e limpeza de cache) sai no idioma do app. Também confere que a tabela não tem tradução vazia.

1. Stubs: `docs/tools/java/stubs/android` compilados, com o `Resources` de `docs/tools/settings_test/stubs` na frente; a `UiLocale` de
   `docs/tools/packs_test/UiLocale.java` (substitui a do APK, que usa APIs que o PC não tem).
2. `javac -cp <stubs>:<UiLocale compilada>:<jar do APK> -d cls EsTest.java`
3. `java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote -cp cls:<stubs>:<UiLocale>:<jar do APK> com.mrkeyboard.app.EsTest`
   (o jar vem do `classes.dex` do APK com `d2j-dex2jar.sh`).

`docs/tools/mres_check.py` (na raiz do projeto) confere o outro lado: que todo texto em português do smali passa por `p()`/`a()` e
está na tabela.
