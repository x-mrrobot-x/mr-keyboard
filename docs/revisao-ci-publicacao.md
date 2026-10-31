# Revisão: publicação automática do APK em Releases

## Pedido
O dono olhou a página de Releases do GitHub e viu só a release dos dicionários (`dicionarios`: `catalogo.json` e os `.zip`), sem nenhuma release do app, sem APK e sem notas. O link de download do README (`releases/latest/download/MrKeyboard.apk`) precisa de uma release do app.

## Por que não havia release do app
O passo "Publicar em Releases" do *Mr Keyboard - APK* só rodava quando o workflow era executado **à mão** com "publicar" marcado. Num push, o workflow só montava, assinava e guardava o APK em *Artifacts*. A release `dicionarios` (que o screenshot mostra, com as notas dos pacotes) vem de outro workflow, o *Mr Keyboard - dicionários*, e é de propósito marcada como não-`latest`.

Mudança só de CI e ferramentas: **o app não muda e a versão não sobe** (como em `revisao-ci-workflows.md`).

## O que mudou
- **`docs/tools/publish_release.sh`** (novo): a lógica de publicação saiu do YAML para um script que se testa fora do GitHub. Tag = `versionName` (v1.72.0); texto da release = só a seção **`## Notas da release`** de `docs/revisao-<versão>.md` (ou `revisao-1.M.M.md` para v1.MM.0), em português e inglês, curta, para quem vai baixar, mais o SHA-256 do APK e do certificado e o link para as notas completas no repositório; um **único** anexo, `MrKeyboard.apk` (nome fixo do link do README); release marcada como `latest`.
- **`.github/workflows/mr-apk.yml`**: o passo de publicar roda também no **push na `main`** (modo `automatico`), além da execução manual (modo `manual`). O passo da `lib/` passou a gravar `lib_ok`. Novo `concurrency` (uma execução por vez no mesmo branch) para dois pushes seguidos não disputarem a mesma tag.
- **Modos**:

| Situação | `manual` (Run workflow + publicar) | `automatico` (push na main) |
|---|---|---|
| tudo certo e versão nova | publica | publica |
| versão (tag) já publicada | erro | aviso e segue (o APK fica nos artefatos) |
| sem APK assinado (secrets ausentes) | erro | aviso e segue |
| `lib/` desatualizada em relação ao `native/` | erro | aviso e segue |

- **README** (inglês e português): a seção *Publishing/Publicar* descreve o fluxo novo (subir a versão, criar `docs/revisao-<versão>.md`, push).
- **Só APK assinado na Release.** A Release leva exatamente um arquivo, `MrKeyboard.apk`, cópia do `MrKeyboard-signed.apk`. O `MrKeyboard-unsigned.apk` nunca vai para lá (ele só fica no artefato `apk` do Actions, para quem faz fork sem a chave). Para garantir isso, o script confere a assinatura com `apksigner verify` antes de publicar e também exige conseguir ler o certificado; sem isso, no modo automático só avisa e não publica, e no manual dá erro.

## Validação
- `publish_release.sh` rodado aqui nos 13 casos com um `gh` e um `apksigner` de mentira: automático (tudo certo; versão já publicada; sem APK assinado; lib velha; assinatura inválida; certificado ilegível), manual (os mesmos, com assinatura inválida) e a escolha das notas (v1.72.0 → `revisao-1.7.2.md`, v1.63.0 → `revisao-1.6.3.md`, que não tem a seção e cai no aviso e no título). Em todos os casos de publicação o `gh release create` recebe só o `MrKeyboard.apk` assinado (nada com `unsigned`), a tag, o título, o arquivo de notas, o `--target` e `--latest`; o texto leva só a seção "Notas da release", o SHA-256, o certificado e o link para as notas completas.
- YAML do `mr-apk.yml` lido e conferido. Pegamos no teste que o script precisa rodar com `bash` (usa `${VAR:0:1}`; o `sh` do Ubuntu é o dash): o workflow chama `bash docs/tools/publish_release.sh`.
- **Não rodou no GitHub:** o workflow em si. Para a release aparecer, os secrets de assinatura têm que existir no repositório (`KEYSTORE_B64`, `KEYSTORE_PASS`, `KEY_ALIAS`, `KEY_PASS`, ou `KEY_PK8_B64` e `CERT_PEM_B64`), com a **mesma chave** que assina o app instalado. Sem eles o log mostra "sem chave: só o APK sem assinatura" e o aviso "Sem APK assinado".

## O que fazer depois do commit
1. Faça o push na `main` com a versão nova (a 1.72.0 já está no `apktool.yml`).
2. Veja a execução de *Mr Keyboard - APK* em Actions: no fim, o passo *Publicar em Releases* diz "Publicado: v1.72.0" ou explica por que não publicou.
3. Confira em Releases: release `Mr Keyboard v1.72.0` com o `MrKeyboard.apk` e o texto curto das notas, marcada como Latest. O link `releases/latest/download/MrKeyboard.apk` passa a funcionar.

## Ajuste depois da primeira release (a v1.72.0 saiu com o texto inteiro e dois APKs)
A primeira publicação funcionou, mas saiu com **dois defeitos de apresentação**: o texto da release era o arquivo de notas inteiro (`## Pedido`, `## Como foi feito`, testes de aparelho: texto de desenvolvimento) e havia **dois APKs idênticos** (`MrKeyboard-v1.72.0.apk` e `MrKeyboard.apk`), o que confunde quem só quer baixar.
- **Um APK só:** `MrKeyboard.apk`. A versão já está na tag e no título, e o nome fixo é o que o link do README precisa (`releases/latest/download/MrKeyboard.apk`).
- **Texto curto:** só a seção `## Notas da release` de cada `docs/revisao-*.md` (português e inglês), mais o link para o arquivo inteiro no repositório. Sem a seção, a release sai só com o título e o script avisa.
- **`check_version.py`** passou a exigir a seção `## Notas da release` nas notas da versão atual (o CI de verificações acusa se esquecer).
- **A v1.72.0 que já está publicada** não é refeita pelo workflow (a tag existe): edite a release no GitHub, apague o `MrKeyboard-v1.72.0.apk` e troque o texto pelo da seção `## Notas da release` de `docs/revisao-1.7.2.md`. As próximas versões já saem certas.
