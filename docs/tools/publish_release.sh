#!/bin/bash
# Publica o APK assinado em Releases (usado pelo workflow "Mr Keyboard - APK").
# A tag é o versionName do apktool.yml (v1.72.0) e as notas vêm de docs/revisao-<versão>.md
# (ou docs/revisao-1.M.M.md para v1.MM.0). Anexa MrKeyboard-v<versão>.apk e MrKeyboard.apk (nome fixo,
# usado pelo link direto do README: .../releases/latest/download/MrKeyboard.apk).
#
# Variáveis:
#   MODO   manual (rodou à mão com "publicar") ou automatico (push na main)
#   LIB_OK false quando a lib/ não bate com o native/ atual
#   GH_TOKEN, GITHUB_SHA, GITHUB_REPOSITORY, ANDROID_HOME (do Actions)
# No modo manual qualquer problema é erro (você pediu para publicar). No automatico, o que impede de
# publicar (sem chave, versão já publicada, lib velha) só avisa e deixa o APK nos artefatos.
set -e
MODO=${MODO:-manual}

para() {   # $1 = mensagem; gravidade conforme o modo
  if [ "$MODO" = "manual" ]; then echo "::error::$1 Nada foi publicado."; exit 1; fi
  echo "::warning::$1 Nada foi publicado."; exit 0
}

if [ "$LIB_OK" = "false" ]; then
  para "A lib/ não foi compilada a partir do native/ atual (rode 'Mr Keyboard - lib nativa', extraia o artifact libs-nativas na raiz do projeto e faça o commit)."
fi
if [ ! -f MrKeyboard-signed.apk ]; then
  para "Sem APK assinado (faltam os secrets da chave)."
fi

# só vai para a Release um APK com assinatura válida (nunca o MrKeyboard-unsigned.apk)
BT=$(ls -d "$ANDROID_HOME"/build-tools/* | sort -V | tail -1)
if ! "$BT/apksigner" verify MrKeyboard-signed.apk > /dev/null 2>&1; then
  para "O APK não tem assinatura válida (apksigner verify falhou)."
fi

VER=$(sed -n 's/^  versionName: *//p' apktool.yml | tr -d "'\" ")
N="${VER#v}"
TAG="v$N"
if gh release view "$TAG" > /dev/null 2>&1; then
  if [ "$MODO" = "manual" ]; then
    echo "::error::A versão $TAG já foi publicada; aumente versionCode e versionName no apktool.yml."; exit 1
  fi
  echo "::notice::A versão $TAG já está nas Releases; suba a versão no apktool.yml para publicar outra."; exit 0
fi

# notas: docs/revisao-1.6.3.md para a v1.63.0 (o padrão dos arquivos), ou docs/revisao-<versão>.md
MAJ=${N%%.*}; REST=${N#*.}; MIN=${REST%%.*}; PAT=${REST#*.}
NOTAS="docs/revisao-$N.md"
if [ ${#MIN} -eq 2 ] && [ "$PAT" = "0" ] && [ -f "docs/revisao-$MAJ.${MIN:0:1}.${MIN:1:1}.md" ]; then
  NOTAS="docs/revisao-$MAJ.${MIN:0:1}.${MIN:1:1}.md"
fi
APK="MrKeyboard-$TAG.apk"
cp MrKeyboard-signed.apk "$APK"
# mesmo arquivo com nome fixo: dá o link que não muda a cada versão
cp MrKeyboard-signed.apk MrKeyboard.apk
CERT=$("$BT/apksigner" verify --print-certs "$APK" | sed -n 's/.*certificate SHA-256 digest: //p' | head -1)
if [ -z "$CERT" ]; then
  para "Não consegui ler o certificado do APK."
fi
{
  echo "Download: **$APK** · [installation / instalação](https://github.com/$GITHUB_REPOSITORY#installation)"
  echo
  echo "- SHA-256 do APK: \`$(sha256sum "$APK" | cut -d' ' -f1)\`"
  echo "- Certificado (SHA-256): \`$CERT\`"
  echo
  if [ -f "$NOTAS" ]; then cat "$NOTAS"; else echo "Mr Keyboard $TAG"; fi
} > notas.md
gh release create "$TAG" "$APK" MrKeyboard.apk --title "Mr Keyboard $TAG" --notes-file notas.md \
  --target "$GITHUB_SHA" --latest
echo "Publicado: $TAG ($NOTAS)"
