# Teste dos valores padrão do motor (1.69)

Confere que o `GlobalKeyboardSettings` (os campos que o teclado lê: Caps Lock, método do clique, modo de desenho, teclas
deslizando etc.) fica com os mesmos valores antes e depois de uma mudança, e que valores antigos guardados de opções que já
não têm tela não mudam mais nada.

1. Stubs: `docs/tools/java/stubs/android` (compilados) e, na frente, o `stubs/` desta pasta (o `Resources` com `getBoolean` e `getInteger`).
2. `javac -cp <stubs compilados>:<jar do APK> -d cls SettingsDefaultsTest.java`
3. `java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote -cp cls:<Resources desta pasta compilado>:<stubs compilados>:<jar do APK> com.mrkeyboard.app.SettingsDefaultsTest <pasta do projeto decodificado> [chave=valor ...]`
   - o jar vem do `classes.dex` do APK (`d2j-dex2jar.sh`);
   - a pasta do projeto é a que tem `res/values/public.xml` do mesmo APK (apktool d);
   - cada `chave=valor` simula uma preferência guardada (`true` e `false` viram booleanos).

A saída é a lista `campo=valor`. Rode com o jar de antes e o de depois e compare com `diff`: sem valores guardados as duas listas
têm de ser iguais; com valores antigos (`pref_caps_lock=false pref_click_method=0 pref_touch_pos=true ...`) a lista nova tem de continuar igual à dos padrões.
