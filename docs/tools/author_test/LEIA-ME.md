# Teste do cartão do autor e dos links da tela principal (1.72)

Confere que `MrAuthor` abre o link e que, sem app para abri-lo (`ActivityNotFoundException`), não propaga o erro: mostra o aviso no idioma do app
(ou o próprio link, se faltar o texto) e devolve `false`. Também confere `MrLink.protect`: o link do texto da tela principal vira um span que abre o link (ou avisa) sem derrubar o app. Roda no PC, sem APK.

1. `javac --release 8 -d stubs $(find docs/tools/java/stubs -name '*.java')`
2. `javac --release 8 -cp stubs -d main $(find docs/tools/java/src -name '*.java')`
3. Sobreposições só do teste: `javac -cp stubs -d ov docs/tools/author_test/stubs/android/widget/Toast.java docs/tools/author_test/stubs/android/content/res/Resources.java`
   (o `Toast` registra o texto; o `Resources` resolve `mr_ui_author_no_browser`).
4. `javac -cp ov:stubs:main -d test docs/tools/author_test/AuthorTest.java` e
   `java -cp test:ov:stubs:main com.mrkeyboard.app.AuthorTest`
