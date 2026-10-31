# Teste do fluxo de pacotes no PC (1.63)

Roda as classes do APK (dex → jar com o dex2jar) e a lib nativa compilada para o PC, com um Android
de mentira (preferências em memória, rede lida de arquivos). Cobre: catálogo assinado, série que
não volta, catálogo alterado ou de outra chave, HTTP com erro, cancelar, instalar, zip
alterado ou cortado, arquivo a mais no zip (inclusive `../`), arquivo com SHA-256 errado, pacote
para app mais novo, atualizar, remover, o item "Baixar dicionário" e a regra dos idiomas do teclado (cartões e selected_languages).

1. Chave de teste: `keytool -genkeypair -keyalg RSA -alias mrkeyboard -keystore /tmp/fa/test.p12 -storetype PKCS12 -storepass senha123 -keypass senha123 -dname CN=Teste`
   e `keytool -exportcert -rfc -alias mrkeyboard -keystore /tmp/fa/test.p12 -storepass senha123 -file /tmp/fa/cert.pem`;
   para o caso "outra chave", um par EC em `/tmp/fa/ec.pk8` e `/tmp/fa/eccert.pem` (openssl).
2. `python3 -I docs/tools/packs_test/make_fixtures.py <raiz> /tmp/pt/fx`, em que `<raiz>` tem `docs/tools` e um `dicts/` **só com o pt-BR** (o gerador supõe que o 1º pacote é o pt-BR; com os três ele monta fixtures trocadas). O `ThreeLangTest` lê o catálogo de 3 pacotes de `/tmp/v165out` (`make_catalog.py --dicts dicts --out /tmp/v165out --repo x-mrrobot-x/mr-keyboard --tag v1.73.0`, assinado). e assinar cada `dados.json` com
   `docs/tools/SignCatalog.java` (`catalogo.json`; em `ok/` também `catalogo_ec.json` com a chave EC
   e `catalogo_tamper.json` com a série trocada depois de assinar).
3. Stubs: `docs/tools/java/stubs/android` + os desta pasta (`stubs/`, que substituem os de mesmo nome).
4. `java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote -Djava.library.path=<lib do PC>
   -cp classes:stubs:e2e_classes:app_v163.jar:android_stubs com.mrkeyboard.app.PacksTest`
   (o `UiLocale.java` daqui vai antes do jar: a classe real usa APIs que o PC não tem).

`LiveTest` baixa o catálogo e o pacote de verdade do GitHub com o mesmo código do app (sem conferir
a assinatura, que depende do certificado do APK publicado).
