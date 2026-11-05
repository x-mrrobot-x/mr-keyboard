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

nota() {  # fake notes file (does not depend on the project's real notes)
  mkdir -p "$(dirname "$1")"
  printf '**Português**\n- Corrige o fechamento do app de teste.\n\n**English**\n- Fixes the test app closing.\n' > "$1"
}

novo() {  # cria um espaço de trabalho: $W (projeto) e $S (estado do gh)
  W=$(mktemp -d -p "$T"); S=$(mktemp -d -p "$T")
  mkdir -p "$W/docs" "$S/rel"; ln -s "$ROOT/docs/tools" "$W/docs/tools"
  nota "$W/docs/release-notes/v1.72.0.md"
  printf "versionInfo:\n  versionCode: '1'\n  versionName: %s\n" "${1:-v1.72.0}" > "$W/apktool.yml"
  echo apk > "$W/mr-keyboard-signed.apk"; echo apk > "$W/mr-keyboard-unsigned.apk"
  pack "$W/dicts" pt-BR 2 aaaa; pack "$W/dicts" en-US 2 bbbb; pack "$W/dicts" es 1 cccc
  : > "$S/log"
}

anterior() {  # tag serial: puts an earlier published release (APK, zips and signed catalog) in the state, as the latest
  local tag=$1 serie=$2
  python3 -I "$ROOT/docs/tools/make_catalog.py" --dicts "$W/dicts" --out "$T/ant" --repo dono/repo --tag "$tag" > /dev/null
  python3 - "$T/ant/data.json" "$serie" <<'EOP'
import json, sys
d = json.load(open(sys.argv[1])); d['serial'] = int(sys.argv[2]); open(sys.argv[1], 'w').write(json.dumps(d, indent=1))
EOP
  sh "$ROOT/docs/tools/sign_catalog.sh" "$T/ant/data.json" "$T/ant/catalog.json"
  mkdir -p "$S/rel/$tag/assets"; echo false > "$S/rel/$tag/draft"; echo "$tag" > "$S/latest"
  cp "$T/ant"/*.zip "$T/ant/catalog.json" "$S/rel/$tag/assets/"; echo apk > "$S/rel/$tag/assets/mr-keyboard-$tag.apk"; rm -rf "$T/ant"
}

publicar() {  # modo lib_ok [ambiente extra]  -> $COD, $SAIDA
  ( cd "$W" && env "${@:3}" PATH="$T/bin:$PATH" FAKE_STATE="$S" MODO="$1" LIB_OK="$2" GITHUB_SHA=abc123 \
      GITHUB_REPOSITORY=dono/repo ANDROID_HOME="$T/android" GH_TOKEN=t bash "$ROOT/docs/tools/publish_release.sh" ) > "$T/saida" 2>&1
  COD=$?; SAIDA=$(cat "$T/saida")
}
serie() { python3 -c "import json,sys; print(json.loads(json.load(open(sys.argv[1]))['data'])['serial'])" "$1"; }
base() { python3 -c "import json,sys; print(json.loads(json.load(open(sys.argv[1]))['data'])['baseUrl'])" "$1"; }
lista() { ls "$S/rel/$1/assets" | LC_ALL=C sort | tr '\n' ' '; }
publicada() { [ -d "$S/rel/$1" ] && [ "$(cat "$S/rel/$1/draft")" = "false" ] && echo 1 || echo 0; }

# ---- 1) release depois de uma anterior (série 5): continua a série e reaproveita os zips
novo; anterior v1.71.0 5
publicar automatico true X=1
check "release nova: publica" "$([ $COD = 0 ] && [ "$(publicada v1.72.0)" = 1 ] && echo 1 || echo 0)" "$SAIDA"
check "release nova: anexos = APK com a versão no nome + catálogo + um zip por idioma" "$([ "$(lista v1.72.0)" = "catalog.json en-US-2.zip es-1.zip mr-keyboard-v1.72.0.apk pt-BR-2.zip " ] && echo 1 || echo 0)" "$(lista v1.72.0)"
check "release nova: nenhum APK sem assinatura" "$([ -z "$(ls "$S/rel/v1.72.0/assets" | grep -i unsigned)" ] && echo 1 || echo 0)"
check "release nova: série continua a do catálogo anterior (5), endereço-base da release nova" "$([ "$(serie "$S/rel/v1.72.0/assets/catalog.json")" = 5 ] && [ "$(base "$S/rel/v1.72.0/assets/catalog.json")" = "https://github.com/dono/repo/releases/download/v1.72.0/" ] && echo 1 || echo 0)" "$(serie "$S/rel/v1.72.0/assets/catalog.json") $(base "$S/rel/v1.72.0/assets/catalog.json")"
check "release nova: é a latest" "$([ "$(cat "$S/latest")" = v1.72.0 ] && echo 1 || echo 0)"
check "texto da release: as duas línguas das notas + dicionários incluídos + SHA-256, sem link de notas completas" "$(grep -q 'Corrige o fechamento do app de teste' "$S/rel/v1.72.0/notes.md" && grep -q 'Fixes the test app closing' "$S/rel/v1.72.0/notes.md" && grep -q 'Dicionários incluídos' "$S/rel/v1.72.0/notes.md" && grep -q 'pt-BR v2' "$S/rel/v1.72.0/notes.md" && grep -q 'SHA-256 do APK' "$S/rel/v1.72.0/notes.md" && ! grep -q 'blob/' "$S/rel/v1.72.0/notes.md" && echo 1 || echo 0)"

# ---- 2) segunda release (nada mudou nos dicionários): mesma série, mesmos zips, endereço novo
sed -i 's/v1.72.0/v1.73.0/' "$W/apktool.yml"; nota "$W/docs/release-notes/v1.73.0.md"
publicar automatico true X=1
check "2ª release: publica e vira a latest" "$([ $COD = 0 ] && [ "$(cat "$S/latest")" = v1.73.0 ] && echo 1 || echo 0)" "$SAIDA"
check "2ª release: série mantida (5) e endereço da v1.73.0" "$([ "$(serie "$S/rel/v1.73.0/assets/catalog.json")" = 5 ] && [ "$(base "$S/rel/v1.73.0/assets/catalog.json")" = "https://github.com/dono/repo/releases/download/v1.73.0/" ] && echo 1 || echo 0)"
check "2ª release: zips com os mesmos bytes da anterior" "$(cmp -s "$S/rel/v1.72.0/assets/pt-BR-2.zip" "$S/rel/v1.73.0/assets/pt-BR-2.zip" && cmp -s "$S/rel/v1.72.0/assets/es-1.zip" "$S/rel/v1.73.0/assets/es-1.zip" && echo 1 || echo 0)"

# ---- 3) pt-BR sobe de versão: série +1 e só o zip novo desse idioma
sed -i 's/v1.73.0/v1.74.0/' "$W/apktool.yml"; nota "$W/docs/release-notes/v1.74.0.md"; pack "$W/dicts" pt-BR 3 aaaaX
publicar automatico true X=1
check "pt-BR v3: série 6 e anexos com um zip por idioma (sem o pt-BR-2)" "$([ $COD = 0 ] && [ "$(serie "$S/rel/v1.74.0/assets/catalog.json")" = 6 ] && [ "$(lista v1.74.0)" = "catalog.json en-US-2.zip es-1.zip mr-keyboard-v1.74.0.apk pt-BR-3.zip " ] && echo 1 || echo 0)" "$(lista v1.74.0) série $(serie "$S/rel/v1.74.0/assets/catalog.json")"

# ---- 5) sem nenhum catálogo publicado: série 1
novo
publicar automatico true X=1
check "sem catálogo anterior: série 1 e três zips" "$([ $COD = 0 ] && [ "$(serie "$S/rel/v1.72.0/assets/catalog.json")" = 1 ] && [ "$(ls "$S/rel/v1.72.0/assets" | grep -c zip)" = 3 ] && echo 1 || echo 0)" "$SAIDA"

# ---- 6) um anexo não subiu: o rascunho é apagado e nada é publicado
novo; anterior v1.71.0 5
publicar automatico true FAKE_DROP=es-1.zip
check "anexo faltando: erro, rascunho apagado, nada publicado e a latest continua a anterior" "$([ $COD != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && [ "$(cat "$S/latest")" = v1.71.0 ] && echo 1 || echo 0)" "$COD $SAIDA"

# ---- 7) rascunho velho da mesma versão: é apagado e a publicação segue
novo; anterior v1.71.0 5
mkdir -p "$S/rel/v1.72.0/assets"; echo true > "$S/rel/v1.72.0/draft"; echo sobra > "$S/rel/v1.72.0/assets/velho.zip"
publicar automatico true X=1
check "rascunho velho: apagado, publica de novo" "$([ $COD = 0 ] && [ "$(publicada v1.72.0)" = 1 ] && [ ! -f "$S/rel/v1.72.0/assets/velho.zip" ] && echo 1 || echo 0)" "$SAIDA"

# ---- 8) versão já publicada
novo; anterior v1.71.0 5
mkdir -p "$S/rel/v1.72.0/assets"; echo false > "$S/rel/v1.72.0/draft"; echo v1.72.0 > "$S/latest"
publicar automatico true X=1
check "versão já publicada, automático: avisa e não mexe" "$([ $COD = 0 ] && [ "$(ls "$S/rel/v1.72.0/assets" | wc -l)" = 0 ] && echo 1 || echo 0)"
publicar manual true X=1
check "versão já publicada, manual: erro" "$([ $COD != 0 ] && echo 1 || echo 0)"

# ---- 9) impedimentos antes de montar qualquer coisa
novo; anterior v1.71.0 5; rm "$W/mr-keyboard-signed.apk"
publicar automatico true X=1
check "sem APK assinado, automático: avisa, não publica" "$([ $COD = 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)"
publicar manual true X=1
check "sem APK assinado, manual: erro" "$([ $COD != 0 ] && echo 1 || echo 0)"
echo apk > "$W/mr-keyboard-signed.apk"
publicar automatico true FAKE_UNSIGNED=1
check "assinatura inválida, automático: não publica" "$([ $COD = 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)"
publicar automatico false X=1
check "lib desatualizada, automático: não publica" "$([ $COD = 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)"
publicar manual false X=1
check "lib desatualizada, manual: erro" "$([ $COD != 0 ] && echo 1 || echo 0)"

# ---- 10) erros reais nos dicionários: falham e não deixam nada
novo; anterior v1.71.0 5; pack "$W/dicts" en-US 2 bbbbMUDOU
publicar automatico true X=1
check "dicionário mudou sem subir a version: erro e nada criado" "$([ $COD != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)"
novo; anterior v1.71.0 5
publicar automatico true KEYSTORE_B64=
check "sem chave para o catálogo: erro e nada criado" "$([ $COD != 0 ] && [ ! -d "$S/rel/v1.72.0" ] && echo 1 || echo 0)"

# ---- 11) a latest existe mas não tem catálogo (ex.: release feita antes do catálogo): série 1, tudo anexado
novo v1.73.0; nota "$W/docs/release-notes/v1.73.0.md"
mkdir -p "$S/rel/v1.72.0/assets"; echo false > "$S/rel/v1.72.0/draft"; echo apk > "$S/rel/v1.72.0/assets/mr-keyboard-v1.72.0.apk"; echo v1.72.0 > "$S/latest"
publicar automatico true X=1
check "latest sem catálogo: v1.73.0 sai com série 1, tudo anexado e vira a latest" "$([ $COD = 0 ] && [ "$(serie "$S/rel/v1.73.0/assets/catalog.json")" = 1 ] && [ "$(lista v1.73.0)" = "catalog.json en-US-2.zip es-1.zip mr-keyboard-v1.73.0.apk pt-BR-2.zip " ] && [ "$(cat "$S/latest")" = v1.73.0 ] && echo 1 || echo 0)" "$SAIDA"

rm -rf "$T"
if [ $falhas = 0 ]; then echo "TUDO OK ($ok verificações)"; else echo "$falhas FALHA(S) em $((ok+falhas)) verificações"; exit 1; fi
