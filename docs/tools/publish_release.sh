#!/bin/bash
# Publishes the single release of a launch (used by the "Mr Keyboard - APK" workflow): the signed APK, the
# dictionary catalog (signed with the same key) and ONE zip per language, all in one release.
# The tag is the versionName from apktool.yml (v1.72.0) and the notes come from docs/release-notes/<tag>.md
# (ex.: docs/release-notes/v1.72.0.md): a short file, Portuguese and English, that is the release text itself,
# followed by the list of included dictionaries and the checksums.
# The APK is named mr-keyboard-<tag>.apk (ex.: mr-keyboard-v1.72.0.apk), so the version shows in the asset
# list; the app reads the catalog from .../releases/latest/download/catalog.json.
#
# Dictionaries: starts from the catalog of the latest release (if there is one), reuses the zips of the
# packs that did not change and only builds the ones whose version went up in dicts/ (make_catalog.py --tag).
# The release is created as a draft, the assets are checked and only then it is published: a half-made
# release never becomes "latest".
#
# Variáveis:
#   MODO   manual (rodou à mão com "publicar") ou automatico (push na main)
#   LIB_OK false quando a lib/ não bate com o native/ atual
#   GH_TOKEN, GITHUB_SHA, GITHUB_REPOSITORY, ANDROID_HOME (do Actions)
#   KEYSTORE_B64 + KEYSTORE_PASS + KEY_ALIAS + KEY_PASS, ou KEY_PK8_B64 + CERT_PEM_B64 (assinam o catálogo)
# No modo manual qualquer problema é erro (você pediu para publicar). No automatico, o que impede de
# publicar (sem chave, versão já publicada, lib velha) só avisa e deixa o APK nos artefatos.
set -e
MODO=${MODO:-manual}

para() {   # $1 = mensagem; gravidade conforme o modo
  if [ "$MODO" = "manual" ]; then echo "::error::$1 Nada foi publicado."; exit 1; fi
  echo "::warning::$1 Nada foi publicado."; exit 0
}

if [ "$LIB_OK" = "false" ]; then
  para "A lib/ não foi compilada a partir do native/ atual (rode 'Mr Keyboard - native lib', extraia o artifact native-libs na raiz do projeto e faça o commit)."
fi
if [ ! -f mr-keyboard-signed.apk ]; then
  para "Sem APK assinado (faltam os secrets da chave)."
fi

# só vai para a Release um APK com assinatura válida (nunca o mr-keyboard-unsigned.apk)
BT=$(ls -d "$ANDROID_HOME"/build-tools/* | sort -V | tail -1)
if ! "$BT/apksigner" verify mr-keyboard-signed.apk > /dev/null 2>&1; then
  para "O APK não tem assinatura válida (apksigner verify falhou)."
fi

VER=$(sed -n 's/^  versionName: *//p' apktool.yml | tr -d "'\" ")
N="${VER#v}"
TAG="v$N"
if gh release view "$TAG" > /dev/null 2>&1 && [ "$(gh release view "$TAG" --json isDraft -q .isDraft)" = "true" ]; then
  echo "::notice::Rascunho antigo de $TAG (execução anterior incompleta); apagando."
  gh release delete "$TAG" -y
fi
if gh release view "$TAG" > /dev/null 2>&1; then
  if [ "$MODO" = "manual" ]; then
    echo "::error::A versão $TAG já foi publicada; aumente versionCode e versionName no apktool.yml."; exit 1
  fi
  echo "::notice::A versão $TAG já está nas Releases; suba a versão no apktool.yml para publicar outra."; exit 0
fi

# notes: docs/release-notes/<tag>.md (ex.: docs/release-notes/v1.72.0.md)
NOTAS="docs/release-notes/$TAG.md"
APK="mr-keyboard-$TAG.apk"
# a single APK, with the version in the name (the asset list shows which version it is)
cp mr-keyboard-signed.apk "$APK"
CERT=$("$BT/apksigner" verify --print-certs "$APK" | sed -n 's/.*certificate SHA-256 digest: //p' | head -1)
if [ -z "$CERT" ]; then
  para "Não consegui ler o certificado do APK."
fi

# ---- dictionaries: start from the catalog of the latest release (if it has one)
mkdir -p prev out
PREV_TAG=$(gh api "repos/$GITHUB_REPOSITORY/releases/latest" -q .tag_name 2> /dev/null || true)
PREV_ARGS=""
if [ -n "$PREV_TAG" ] && gh release view "$PREV_TAG" --json assets -q '.assets[].name' 2> /dev/null | grep -qx catalog.json; then
  mkdir -p prev/zips
  gh release download "$PREV_TAG" -p catalog.json -D prev
  gh release download "$PREV_TAG" -p '*.zip' -D prev/zips
  PREV_SERIAL=$(python3 -c "import json,sys; print(json.loads(json.load(open(sys.argv[1]))['data'])['serial'])" prev/catalog.json)
  PREV_ARGS="--prev prev/catalog.json --reuse prev/zips"
  echo "dicionários: partindo do catálogo de $PREV_TAG (série $PREV_SERIAL)"
else
  echo "::warning::Nenhum catálogo de dicionários publicado antes: a série começa em 1. Apps que já guardaram uma série maior vão recusar este catálogo; só siga se for mesmo o primeiro."
fi
python3 -I docs/tools/make_catalog.py --dicts dicts --out out --repo "$GITHUB_REPOSITORY" --tag "$TAG" $PREV_ARGS
sh docs/tools/sign_catalog.sh out/data.json out/catalog.json
ESPERADO=$(python3 docs/tools/release_assets.py out/data.json "$APK")
DICIONARIOS=$(python3 -c "import json,sys; print(', '.join('%s v%d' % (p['id'], p['version']) for p in json.load(open(sys.argv[1]))['packs']))" out/data.json)

# ---- release text: the whole notes file (short, for people downloading)
RESUMO=""
if [ -f "$NOTAS" ]; then
  RESUMO=$(sed '/./,$!d' "$NOTAS")
fi
if [ -z "$RESUMO" ]; then
  echo "::warning::$NOTAS não existe ou está vazio; a release sai só com o título."
  RESUMO="Mr Keyboard $TAG"
fi
{
  echo "Download: **$APK** · [installation / instalação](https://github.com/$GITHUB_REPOSITORY#installation)"
  echo
  echo "$RESUMO"
  echo
  echo "Dicionários incluídos / Included dictionaries: $DICIONARIOS."
  echo "Você só precisa do \`$APK\`: o app baixa os dicionários sozinho. / You only need \`$APK\`: the app downloads the dictionaries by itself."
  echo
  echo "- SHA-256 do APK: \`$(sha256sum "$APK" | cut -d' ' -f1)\`"
  echo "- Certificado (SHA-256): \`$CERT\`"
} > notas.md

# ---- rascunho com tudo anexado, conferência dos anexos e só então a publicação
ARQUIVOS="$APK out/catalog.json"
for z in $(cat out/upload.txt); do ARQUIVOS="$ARQUIVOS out/$z"; done
gh release create "$TAG" $ARQUIVOS --draft --title "Mr Keyboard $TAG" --notes-file notas.md --target "$GITHUB_SHA"
REAL=$(gh release view "$TAG" --json assets -q '.assets[].name' | sort)
if [ "$REAL" != "$ESPERADO" ]; then
  gh release delete "$TAG" -y || true
  echo "::error::Os anexos do rascunho não são os esperados; o rascunho foi apagado e nada foi publicado."
  echo "Esperado:"; echo "$ESPERADO"; echo "Encontrado:"; echo "$REAL"
  exit 1
fi
gh release edit "$TAG" --draft=false --latest
echo "Publicado: $TAG ($NOTAS); anexos: $(echo $REAL | tr '\n' ' ')"
