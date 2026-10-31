#!/bin/sh
# Testes de PC da camada Java que não precisam do APK (roda na raiz do projeto):
#   - compila os stubs (docs/tools/java/stubs) e os fontes (docs/tools/java/src), como o build_java.sh;
#   - AuthorTest: cartão do autor e link da tela principal (MrAuthor, MrLink).
# Com o caminho do jar do APK (classes.dex -> d2j-dex2jar), roda também:
#   - EsTest: SheetStrings/MrEs com contextos em espanhol, português, inglês e francês.
# Uso: sh docs/tools/run_java_tests.sh [app.jar]
set -e
APPJAR=$1
T=$(mktemp -d)
D=docs/tools
javac -nowarn --release 8 -d "$T/stubs" $(find $D/java/stubs -name '*.java')
javac -Xlint:-options --release 8 -cp "$T/stubs" -d "$T/main" $(find $D/java/src -name '*.java')

echo "== AuthorTest"
javac -nowarn -cp "$T/stubs" -d "$T/ov_author" $(find $D/author_test/stubs -name '*.java')
javac -nowarn -cp "$T/ov_author:$T/stubs:$T/main" -d "$T/test_author" $D/author_test/AuthorTest.java
java -cp "$T/test_author:$T/ov_author:$T/stubs:$T/main" com.mrkeyboard.app.AuthorTest

if [ -n "$APPJAR" ]; then
  echo "== EsTest"
  javac -nowarn -cp "$T/stubs" -d "$T/ov_es" $(find $D/settings_test/stubs -name '*.java')
  javac -encoding UTF-8 -nowarn -cp "$T/ov_es:$T/stubs:$APPJAR" -d "$T/test_es" $D/es_test/EsTest.java
  # o jar vem do dex2jar, sem mapas de pilha: o verificador da JVM fica desligado só para ele
  java -XX:+UnlockDiagnosticVMOptions -XX:-BytecodeVerificationRemote \
    -cp "$T/test_es:$T/ov_es:$T/stubs:$APPJAR" com.mrkeyboard.app.EsTest
fi
rm -rf "$T"
