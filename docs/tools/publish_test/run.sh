#!/bin/bash
# Testa docs/tools/publish_release.sh com um gh de mentira (gh), um apksigner de mentira e a assinatura de verdade
# (keystore de teste). Roda na raiz do projeto: bash docs/tools/publish_test/run.sh
ROOT=$(pwd)
AQUI=$ROOT/docs/tools/publish_test
T=$(mktemp -d)
ok=0; falhas=0
check() { if [ "$2" = "1" ]; then ok=$((ok+1)); echo "OK    $1"; else falhas=$((falhas+1)); echo "FALHA $1 ${3:+| $3}"; fi; }

# chave de teste (a mesma assina o catálogo)
keytool -genkeypair -alias k -keyalg RSA -keysize 2048 -validity 3650 -keystore "$T/t.p12" -storetype PKCS12 \
  -storepass senha123 -keypass senha123 -dname CN=Teste > /dev/null 2>&1
export KEYSTORE_B64=$(base64 -w0 "$T/t.p12") KEYSTORE_PASS=senha123 KEY_ALIAS=k KEY_PASS=senha123

# apksigner de mentira
mkdir -p "$T/android/build-tools/34.0.0"
cat > "$T/android/build-tools/34.0.0/apksigner" <<'EOS'
#!/bin/sh
if [ "$FAKE_UNSIGNED" = "1" ]; then echo "DOES NOT VERIFY" >&2; exit 1; fi
if [ "$1" = "verify" ] && [ "$2" = "--print-certs" ]; then echo "Signer #1 certificate SHA-256 digest: deadbeef1234"; fi
exit 0
EOS
chmod +x "$T/android/build-tools/34.0.0/apksigner" "$AQUI/gh"
mkdir -p "$T/bin"; cp "$AQUI/gh" "$T/bin/gh"

pack() {  # pasta id versão conteúdo
  mkdir -p "$1/$2"
  printf '{"id":"%s","lang":"%s","name":{"en":"%s"},"version":%s,"format":1,"minApp":1,"files":["main.dict"],"licenses":[]}' "$2" "${2%%-*}" "$2" "$3" > "$1/$2/pack.json"
  printf '\310\001%s' "$4" > "$1/$2/main.dict"
}

nota() {  # arquivo de notas de mentira (não depende das notas reais do projeto)
  printf '# Revisão de teste\n\n## Notas da release\n**Português**\n- Corrige o fechamento do app de teste.\n\n**English**\n- Fixes the test app closing.\n\n## O que mudou\n- Como foi feito: detalhe de desenvolvimento.\n' > "$1"
}

novo() {  # cria um espaço de trabalho: $W (projeto) e $S (estado do gh)
  W=$(mktemp -d -p "$T"); S=$(mktemp -d -p "$T")
  mkdir -p "$W/docs" "$S/rel"; ln -s "$ROOT/docs/tools" "$W/docs/tools"
  nota "$W/docs/revisao-1.7.2.md"
  printf "versionInfo:\n  versionCode: '1'\n  versionName: %s\n" "${1:-v1.72.0}" > "$W/apktool.yml"
  echo apk > "$W/MrKeyboard-signed.apk"; echo apk > "$W/MrKeyboard-unsigned.apk"
  pack "$W/dicts" pt-BR 2 aaaa; pack "$W/dicts" en-US 2 bbbb; pack "$W/dicts" es 1 cccc
  : > "$S/log"
}

legado() {  # publica no estado a release antiga "dicionarios" com a série dada (zips + catálogo assinado)
  local serie=$1
  python3 -I "$ROOT/docs/tools/make_catalog.py" --dicts "$W/dicts" --out "$T/leg" --repo dono/repo > /dev/null
  python3 - "$T/leg/dados.json" "$serie" <<'EOP'
import json, sys
d = json.load(open(sys.argv[1])); d['serial'] = int(sys.argv[2]); open(sys.argv[1], 'w').write(json.dumps(d, indent=1))
EOP
  sh "$ROOT/docs/tools/sign_catalog.sh" "$T/leg/dados.json" "$T/leg/catalogo.json"
  mkdir -p "$S/rel/dicionarios/assets"; echo false > "$S/rel/dicionarios/draft"
  cp "$T/leg"/*.zip "$T/leg/catalogo.json" "$S/rel/dicionarios/assets/"; rm -rf "$T/leg"
}

publicar() {  # modo lib_ok [ambiente extra]  -> $COD, $SAIDA
  ( cd "$W" && env "${@:3}" PATH="$T/bin:$PATH" FAKE_STATE="$S" MODO="$1" LIB_OK="$2" GITHUB_SHA=abc123 \
      GITHUB_REPOSITORY=dono/repo ANDROID_HOME="$T/android" GH_TOKEN=t bash "$ROOT/docs/tools/publish_release.sh" ) > "$T/saida" 2>&1
  COD=$?; SAIDA=$(cat "$T/saida")
}
serie() { python3 -c "import json,sys; print(json.loads(json.load(open(sys.argv[1]))['data'])['serial'])" "$1"; }
base() { python3 -c "import json,sys; print(json.loads(json.load(open(sys.argv[1]))['data'])['baseUrl'])" "$1"; }
lista() { ls "$S/rel/$1/assets" | tr '\n' ' '; }
publicada() { [ -d "$S/rel/$1" ] && [ "$(cat "$S/rel/$1/draft")" = "false" ] && echo 1 || echo 0; }

# ---- 1) primeira release única: só existe a release antiga "dicionarios" (série 5)
novo; legado 5
publicar automatico true X=1
check "1ª release única: publica" "$([ $COD = 0 ] && [ "$(publicada v1.72.0)" = 1 ] && echo 1 || echo 0)" "$SAIDA"
check "1ª release única: anexos = APK + catálogo + um zip por idioma" "$([ "$(lista v1.72.0)" = "MrKeyboard.apk catalogo.json en-US-2.zip es-1.zip pt-BR-2.zip " ] && echo 1 || echo 0)" "$(lista v1.72.0)"
check "1ª release única: nenhum APK sem assinatura" "$([ -z "$(ls "$S/rel/v1.72.0/assets" | grep -i unsigned)" ] && echo 1 || echo 0)"
check "1ª release única: série continua a do catálogo antigo (5), endereço-base da release nova" "$([ "$(serie "$S/rel/v1.72.0/assets/catalogo.json")" = 5 ] && [ "$(base "$S/rel/v1.72.0/assets/catalogo.json")" = "https://github.com/dono/repo/releases/download/v1.72.0/" ] && echo 1 || echo 0)" "$(serie "$S/rel/v1.72.0/assets/catalogo.json") $(base "$S/rel/v1.72.0/assets/catalogo.json")"
check "1ª release única: é a latest" "$([ "$(cat "$S/latest")" = v1.72.0 ] && echo 1 || echo 0)"
check "texto da release: notas curtas + dicionários incluídos + link das notas completas" "$(grep -q 'Corrige o fechamento do app de teste' "$S/rel/v1.72.0/notes.md" && grep -q 'Dicionários incluídos' "$S/rel/v1.72.0/notes.md" && grep -q 'pt-BR v2' "$S/rel/v1.72.0/notes.md" && grep -q 'blob/v1.72.0/docs/revisao-1.7.2.md' "$S/rel/v1.72.0/notes.md" && ! grep -q 'Como foi feito' "$S/rel/v1.72.0/notes.md" && echo 1 || echo 0)"

# ---- 2) segunda release (nada mudou nos dicionários): mesma série, mesmos zips, endereço novo
sed -i 's/v1.72.0/v1.73.0/' "$W/apktool.yml"; nota "$W/docs/revisao-1.7.3.md"
publicar automatico true X=1
check "2ª release: publica e vira a latest" "$([ $COD = 0 ] && [ "$(cat "$S/latest")" = v1.73.0 ] && echo 1 || echo 0)" "$SAIDA"
check "2ª release: série mantida (5) e endereço da v1.73.0" "$([ "$(serie "$S/rel/v1.73.0/assets/catalogo.json")" = 5 ] && [ "$(base "$S/rel/v1.73.0/assets/catalogo.json")" = "https://github.com/dono/repo/releases/download/v1.73.0/" ] && echo 1 || echo 0)"
check "2ª release: zips com os mesmos bytes da anterior" "$(cmp -s "$S/rel/v1.72.0/assets/pt-BR-2.zip" "$S/rel/v1.73.0/assets/pt-BR-2.zip" && cmp -s "$S/rel/v1.72.0/assets/es-1.zip" "$S/rel/v1.73.0/assets/es-1.zip" && echo 1 || echo 0)"

# ---- 3) pt-BR sobe de versão: série +1 e só o zip novo desse idioma
sed -i 's/v1.73.0/v1.74.0/' "$W/apktool.yml"; nota "$W/docs/revisao-1.7.4.md"; pack "$W/dicts" pt-BR 3 aaaaX
publicar automatico true X=1
check "pt-BR v3: série 6 e anexos com um zip por idioma (sem o pt-BR-2)" "$([ $COD = 0 ] && [ "$(serie "$S/rel/v1.74.0/assets/catalogo.json")" = 6 ] && [ "$(lista v1.74.0)" = "MrKeyboard.apk catalogo.json en-US-2.zip es-1.zip pt-BR-3.zip " ] && echo 1 || echo 0)" "$(lista v1.74.0) série $(serie "$S/rel/v1.74.0/assets/catalogo.json")"

# ---- 4) a série maior vence: antiga "dicionarios" com 9 e a latest com 4
novo; legado 9
mkdir -p "$S/rel/v1.60.0/assets"; echo false > "$S/rel/v1.60.0/draft"; echo v1.60.0 > "$S/latest"
python3 -I "$ROOT/docs/tools/make_catalog.py" --dicts "$W/dicts" --out "$T/l2" --repo dono/repo > /dev/null
python3 - "$T/l2/dados.json" <<'EOP'
import json, sys
d = json.load(open(sys.argv[1])); d['serial'] = 4; open(sys.argv[1], 'w').write(json.dumps(d, indent=1))
EOP
sh "$ROOT/docs/tools/sign_catalog.sh" "$T/l2/dados.json" "$T/l2/catalogo.json"; cp "$T/l2"/*.zip "$T/l2/catalogo.json" "$S/rel/v1.60.0/assets/"
publicar automatico true X=1
check "série maior vence (9 da antiga contra 4 da latest)" "$([ $COD = 0 ] && [ "$(serie "$S/rel/v1.72.0/assets/catalogo.json")" = 9 ] && echo 1 || echo 0)" "$SAIDA"

# ---- 5) sem nenhum catálogo publicado: série 1
novo
publicar automatico true X=1
check "sem catálogo anterior: série 1 e três zips" "$([ $COD = 0 ] && [ "$(serie "$S/rel/v1.72.0/assets/catalogo.json")" = 1 ] && [ "$(ls "$S/rel/v1.72.0/assets" | grep -c zip)" = 3 ] && echo 1 || echo 0)" "$SAIDA"

# ---- 6) um anexo não subiu: o rascunho é apagado e nada é publicado
novo; legado 5
publicar automatico true FAKE_DROP=es-1.zip
check "anexo faltando: erro, rascunho apagado e nada publicado" "$([ $COD != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && [ ! -f "$S/latest" ] && echo 1 || echo 0)" "$COD $SAIDA"

# ---- 7) rascunho velho da mesma versão: é apagado e a publicação segue
novo; legado 5
mkdir -p "$S/rel/v1.72.0/assets"; echo true > "$S/rel/v1.72.0/draft"; echo sobra > "$S/rel/v1.72.0/assets/velho.zip"
publicar automatico true X=1
check "rascunho velho: apagado, publica de novo" "$([ $COD = 0 ] && [ "$(publicada v1.72.0)" = 1 ] && [ ! -f "$S/rel/v1.72.0/assets/velho.zip" ] && echo 1 || echo 0)" "$SAIDA"

# ---- 8) versão já publicada
novo; legado 5
mkdir -p "$S/rel/v1.72.0/assets"; echo false > "$S/rel/v1.72.0/draft"; echo v1.72.0 > "$S/latest"
publicar automatico true X=1
check "versão já publicada, automático: avisa e não mexe" "$([ $COD = 0 ] && [ "$(ls "$S/rel/v1.72.0/assets" | wc -l)" = 0 ] && echo 1 || echo 0)"
publicar manual true X=1
check "versão já publicada, manual: erro" "$([ $COD != 0 ] && echo 1 || echo 0)"

# ---- 9) impedimentos antes de montar qualquer coisa
novo; legado 5; rm "$W/MrKeyboard-signed.apk"
publicar automatico true X=1
check "sem APK assinado, automático: avisa, não publica" "$([ $COD = 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)"
publicar manual true X=1
check "sem APK assinado, manual: erro" "$([ $COD != 0 ] && echo 1 || echo 0)"
echo apk > "$W/MrKeyboard-signed.apk"
publicar automatico true FAKE_UNSIGNED=1
check "assinatura inválida, automático: não publica" "$([ $COD = 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)"
publicar automatico false X=1
check "lib desatualizada, automático: não publica" "$([ $COD = 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)"
publicar manual false X=1
check "lib desatualizada, manual: erro" "$([ $COD != 0 ] && echo 1 || echo 0)"

# ---- 10) erros reais nos dicionários: falham e não deixam nada
novo; legado 5; pack "$W/dicts" en-US 2 bbbbMUDOU
publicar automatico true X=1
check "dicionário mudou sem subir a version: erro e nada criado" "$([ $COD != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)"
novo; legado 5
publicar automatico true KEYSTORE_B64=
check "sem chave para o catálogo: erro e nada criado" "$([ $COD != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)"

rm -rf "$T"
if [ $falhas = 0 ]; then echo "TUDO OK ($ok verificações)"; else echo "$falhas FALHA(S) em $((ok+falhas)) verificações"; exit 1; fi
