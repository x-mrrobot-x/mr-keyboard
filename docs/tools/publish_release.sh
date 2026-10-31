#!/bin/bash
# Publica a release única do lançamento (usado pelo workflow "Mr Keyboard - APK"): o APK assinado, o
# catálogo de dicionários (assinado com a mesma chave) e UM zip por idioma, tudo numa release só.
# A tag é o versionName do apktool.yml (v1.72.0) e as notas vêm de docs/revisao-<versão>.md
# (ou docs/revisao-1.M.M.md para v1.MM.0). O texto da release é a seção "## Notas da release" desse arquivo
# (curta, para quem vai baixar) mais a lista dos dicionários incluídos e o link para o arquivo inteiro.
# O APK tem nome fixo, MrKeyboard.apk (link direto do README: .../releases/latest/download/MrKeyboard.apk), e o
# app lê o catálogo em .../releases/latest/download/catalogo.json.
#
# Os dicionários: parte do catálogo mais novo que existir (a release mais recente ou, enquanto ainda existir,
# a antiga "dicionarios"; vale a de maior série), reaproveita os zips dos pacotes que não mudaram e só gera os que subiram de version em
# dicts/ (make_catalog.py --tag). A release sai como rascunho, os anexos são conferidos e só então ela é
# publicada: nunca fica uma release pela metade como "latest".
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

# notas: docs/revisao-1.6.3.md para a v1.63.0 (o padrão dos arquivos), ou docs/revisao-<versão>.md
MAJ=${N%%.*}; REST=${N#*.}; MIN=${REST%%.*}; PAT=${REST#*.}
NOTAS="docs/revisao-$N.md"
if [ ${#MIN} -eq 2 ] && [ "$PAT" = "0" ] && [ -f "docs/revisao-$MAJ.${MIN:0:1}.${MIN:1:1}.md" ]; then
  NOTAS="docs/revisao-$MAJ.${MIN:0:1}.${MIN:1:1}.md"
fi
APK=MrKeyboard.apk
# um APK só, com nome fixo: dá o link que não muda a cada versão (README: .../releases/latest/download/MrKeyboard.apk)
cp MrKeyboard-signed.apk "$APK"
CERT=$("$BT/apksigner" verify --print-certs "$APK" | sed -n 's/.*certificate SHA-256 digest: //p' | head -1)
if [ -z "$CERT" ]; then
  para "Não consegui ler o certificado do APK."
fi
# ---- dicionários: parte do catálogo de maior série entre a release mais recente e a antiga "dicionarios"
# (se ela já foi apagada, o loop só a ignora; nesse caso a série vem da release mais recente)
mkdir -p prev out
PREV_TAG=""; PREV_SERIAL=-1
LATEST=$(gh api "repos/$GITHUB_REPOSITORY/releases/latest" -q .tag_name 2> /dev/null || true)
for T in $LATEST dicionarios; do
  [ -n "$T" ] || continue
  if gh release view "$T" --json assets -q '.assets[].name' 2> /dev/null | grep -qx catalogo.json; then
    mkdir -p "prev/$T"
    gh release download "$T" -p catalogo.json -D "prev/$T"
    S=$(python3 -c "import json,sys; print(json.loads(json.load(open(sys.argv[1]))['data'])['serial'])" "prev/$T/catalogo.json")
    echo "catálogo de $T: série $S"
    if [ "$S" -gt "$PREV_SERIAL" ]; then PREV_SERIAL=$S; PREV_TAG=$T; fi
  fi
done
PREV_ARGS=""
if [ -n "$PREV_TAG" ]; then
  mkdir -p prev/zips
  gh release download "$PREV_TAG" -p '*.zip' -D prev/zips
  PREV_ARGS="--prev prev/$PREV_TAG/catalogo.json --reuse prev/zips"
  echo "dicionários: partindo do catálogo de $PREV_TAG (série $PREV_SERIAL)"
else
  echo "::warning::Nenhum catálogo de dicionários publicado antes: a série começa em 1. Apps que já guardaram uma série maior vão recusar este catálogo; só siga se for mesmo o primeiro."
fi
python3 -I docs/tools/make_catalog.py --dicts dicts --out out --repo "$GITHUB_REPOSITORY" --tag "$TAG" $PREV_ARGS
sh docs/tools/sign_catalog.sh out/dados.json out/catalogo.json
ESPERADO=$(python3 docs/tools/release_assets.py out/dados.json)
DICIONARIOS=$(python3 -c "import json,sys; print(', '.join('%s v%d' % (p['id'], p['version']) for p in json.load(open(sys.argv[1]))['packs']))" out/dados.json)

# ---- texto da release: só a seção "## Notas da release" do arquivo de notas (curta, para quem vai baixar);
# o arquivo inteiro (texto de desenvolvimento) fica no repositório, com o link no fim
RESUMO=""
if [ -f "$NOTAS" ]; then
  RESUMO=$(awk '/^## Notas da release/{f=1; next} /^## /{f=0} f' "$NOTAS" | sed '/./,$!d')
fi
if [ -z "$RESUMO" ]; then
  echo "::warning::$NOTAS não tem a seção '## Notas da release'; a release sai só com o título."
  RESUMO="Mr Keyboard $TAG"
fi
{
  echo "Download: **$APK** · [installation / instalação](https://github.com/$GITHUB_REPOSITORY#installation)"
  echo
  echo "$RESUMO"
  echo
  echo "Dicionários incluídos / Included dictionaries: $DICIONARIOS."
  echo "Você só precisa do \`MrKeyboard.apk\`: o app baixa os dicionários sozinho. / You only need \`MrKeyboard.apk\`: the app downloads the dictionaries by itself."
  echo
  echo "- SHA-256 do APK: \`$(sha256sum "$APK" | cut -d' ' -f1)\`"
  echo "- Certificado (SHA-256): \`$CERT\`"
  if [ -f "$NOTAS" ]; then
    echo
    echo "[Notas completas (em português) / Full notes (Portuguese)](https://github.com/$GITHUB_REPOSITORY/blob/$TAG/$NOTAS)"
  fi
} > notas.md

# ---- rascunho com tudo anexado, conferência dos anexos e só então a publicação
ARQUIVOS="$APK out/catalogo.json"
for z in $(cat out/enviar.txt); do ARQUIVOS="$ARQUIVOS out/$z"; done
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
