# 1.73 — O app lê os dicionários da mesma release do APK

## Pedido
Etapa b) do plano "uma release única por lançamento" (a etapa a, de CI e ferramentas, está em `revisao-ci-release-unica.md`). O app ainda procurava o catálogo de dicionários numa release separada, a `dicionarios`. Agora ele procura na **release mais recente**, a mesma que traz o APK, o `catalogo.json` e um zip por idioma.

## Notas da release
**Português**
- Cada lançamento agora é uma release só, com o APK e os dicionários juntos. O app procura as atualizações de dicionário nessa release mais recente.
- Nada muda no uso: os dicionários que você já baixou continuam funcionando e a tela *Sugestões e dicionários* é a mesma.

**English**
- Each launch is now a single release, with the APK and the dictionaries together. The app looks for dictionary updates in that latest release.
- Nothing changes in use: dictionaries you already downloaded keep working and the *Suggestions and dictionaries* screen is the same.

## O que mudou
- **`MrPacks.CATALOG_URL`** (Java → smali): de `.../releases/download/dicionarios/catalogo.json` para `https://github.com/x-mrrobot-x/mr-keyboard/releases/latest/download/catalogo.json`. No smali só mudam as duas linhas da URL (o campo e o `const-string`); nenhuma outra classe é alterada.
- **Nada mais muda no app.** O endereço dos zips continua vindo do `baseUrl` de dentro do catálogo assinado (a release nova aponta para a própria tag, ex.: `.../releases/download/v1.73.0/`), a assinatura continua sendo conferida com o certificado do APK e a regra "a série não volta" continua valendo. Por isso o primeiro catálogo da release única **continua a série** do catálogo antigo (o `publish_release.sh` parte do maior `serial` entre a release mais recente e a `dicionarios`): o app que já guardou a série N aceita o novo (N ou maior).
- **`docs/tools/check_catalog_url.py`** (novo, no CI `rapidas`): confere que o Java tem a URL `.../releases/latest/download/catalogo.json`, que o smali tem essa mesma URL duas vezes, que nada aponta de volta para a release `dicionarios` e que o `publish_release.sh` anexa o `catalogo.json`.
- **Testes de PC dos pacotes** (`docs/tools/packs_test/`): os arquivos de teste passam a ser gerados com `--tag v1.73.0` (endereço-base de release única) e o `PacksTest` ganhou a verificação do endereço do catálogo.
- **Etapa d no mesmo commit:** `mr-dicts.yml` e `docs/release-dicionarios.md` removidos; README e `plano-dicionarios.md` atualizados (detalhes e ordem segura no GitHub em `revisao-ci-aposentar-dicionarios.md`).
- **Versão** 1.73.0 (`versionCode` 1073000) em `apktool.yml` e `apktool.json`; README (inglês e português): o link da seção de dicionários e a nota de transição.

## Por que assim (a ordem importa)
- O link `releases/latest/download/catalogo.json` só funciona quando a release mais recente **tem** o `catalogo.json`. A `v1.72.0` não tem. Por isso este commit já sai como a **primeira release única**: o push da 1.73.0 faz o CI publicar a `v1.73.0` com APK + catálogo + zips, e só depois ela vira a `latest`. Ninguém consegue instalar a 1.73.0 antes de a release existir, então não há janela em que o app procure um catálogo que não está lá.
- **Toda release daqui para frente precisa levar o catálogo.** O `publish_release.sh` sempre anexa, então basta não marcar à mão outra release (sem `catalogo.json`) como "Latest".
- Os apps até a 1.72.0 continuam lendo a release `dicionarios`. Este commit já tira do repositório o `mr-dicts.yml` e o texto dessa release (etapa d, em `revisao-ci-aposentar-dicionarios.md`), mas a release em si só sai do GitHub quando você apagar na mão, **depois** de conferir a `v1.73.0`. Apagar antes tira as atualizações de dicionário de quem ainda não atualizou o app (os dicionários já baixados seguem funcionando) e quebra a continuidade da série.

## Validação (rodado aqui)
- `build_java.sh` regenerou o smali; `check_java_smali.sh`: "smali da camada Java em dia". Em relação à versão anterior, só `MrPacks.smali` mudou, em 2 linhas (a URL).
- `check_catalog_url.py` passa, e falha com a URL antiga plantada no Java (prova nos dois sentidos).
- `check_version.py` (1.73.0 / 1073000, notas com a seção), `res_check.py`, `mres_check.py`, `check_reset_keys.py`, `smali_regcheck.py`, `run_java_tests.sh`, `test_make_catalog.py` e `publish_test/run.sh` (24 verificações, com o cenário real de hoje) passam; YAML dos workflows lido.
- **Não gerei o APK** (a pedido): o `apktool b` completo fica para o CI (`montagem` monta e verifica o dex).
- **Não rodei o `PacksTest` completo no PC** (ele precisa da lib nativa de PC e do jar do APK, que não estão montados aqui); a mudança no app é só a constante da URL, que o teste troca por `sCatalogUrl`. O `LiveTest` (baixa do GitHub de verdade) vai dar 404 até a `v1.73.0` ser publicada.
- **Não testado no aparelho.**

## Testes Android necessários (depois que a release `v1.73.0` estiver publicada)
1. Instalar o `MrKeyboard.apk` da release por cima da 1.72.0 (mesma chave): o teclado abre e as sugestões dos dicionários já baixados continuam aparecendo.
2. *Configurações → Sugestões e dicionários → Procurar atualizações*: termina sem erro (em dia).
3. Baixar um idioma que ainda não está no aparelho: o download conclui e o idioma aparece no teclado (deslizar a barra de espaço).
4. Sem internet, *Procurar atualizações* mostra o aviso de rede e o app continua aberto.
