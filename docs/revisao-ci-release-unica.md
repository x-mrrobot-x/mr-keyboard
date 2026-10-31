# Revisão: uma release única por lançamento (etapa a: ferramentas e CI)

## Pedido
O dono achou bagunçado ter **duas releases** (a do app e a `dicionarios`) e notou que a `dicionarios` **acumula várias versões do mesmo idioma** (`pt-BR-1.zip`, `pt-BR-2.zip`, ...). O certo: **uma release por lançamento**, já com o APK e os dicionários, e **uma só versão por idioma**.

Plano aprovado, em etapas (cada uma é um commit):

| Etapa | O que faz | Versão do app |
|---|---|---|
| **a) esta** | ferramentas e CI publicam a release única | não sobe (só CI e ferramentas, como em `revisao-ci-workflows.md`) |
| b) | o app passa a ler `releases/latest/download/catalogo.json` | sobe |
| c) | primeira release única de verdade | (a versão da etapa b) |
| d) | apagar a release `dicionarios` e o `mr-dicts.yml`; atualizar README e docs | não sobe |

Decisões do dono: a release é sempre **completa** (APK + catálogo + um zip por idioma); a release `dicionarios` antiga é apagada depois da migração; mudança só de dicionário = sobe a versão e sai uma release nova.

## Como fica a release
Tag = `versionName` (ex.: `v1.73.0`). Anexos, e só estes:

- `MrKeyboard.apk`: o APK assinado (nome fixo; o link `releases/latest/download/MrKeyboard.apk` do README continua valendo);
- `catalogo.json`: o catálogo assinado com a **mesma chave do APK**; o `baseUrl` dele aponta para a própria release (`.../releases/download/v1.73.0/`);
- `<id>-<versão>.zip`: **um zip por idioma**, só a versão atual (`pt-BR-3.zip`, `en-US-2.zip`, `es-1.zip`).

Texto: a seção `## Notas da release` + "Dicionários incluídos" (ex.: `pt-BR v3, en-US v2, es v1`) + SHA-256 do APK e do certificado + link das notas completas.

## O que mudou
- **`docs/tools/make_catalog.py`**: ganhou o modo unificado (`--tag` e `--reuse`). Escreve **um zip por id** em `--out` (apaga os de versões velhas), reaproveita **byte a byte** o zip de quem não mudou (vindo da release anterior; confere o SHA-256 antes de aceitar), mantém o `serial` quando nada mudou e soma 1 quando algo mudou. Erra se o conteúdo de um pacote mudou sem subir a `version` (o app não atualizaria). Sem `--tag` funciona como antes (é o que o `mr-dicts.yml` ainda usa até a etapa d).
- **`docs/tools/sign_catalog.sh`** (novo): assina o catálogo com a chave dos secrets (`KEYSTORE_B64`... ou `KEY_PK8_B64`+`CERT_PEM_B64`) usando `SignCatalog.java`. Os arquivos da chave só existem numa pasta temporária apagada no fim.
- **`docs/tools/release_assets.py`** (novo): lista os anexos esperados da release (APK, catálogo, cada zip); o script de publicação compara com o que o GitHub recebeu.
- **`docs/tools/publish_release.sh`** (reescrito): além do APK, monta o catálogo. O catálogo de partida é o de **maior `serial`** entre a release mais recente e a antiga `dicionarios`; assim a primeira release única continua a série do catálogo que os apps já conhecem (o app recusa `serial` menor que o guardado). A release sai como **rascunho**, os anexos são conferidos contra a lista esperada (se diferir, o rascunho é apagado e dá erro) e só então vira pública e `latest`. Uma execução que falhou no meio não deixa release pela metade: o rascunho velho da mesma tag é apagado na execução seguinte.
- **`.github/workflows/mr-apk.yml`**: o passo de publicar recebe os secrets da chave (o catálogo é assinado ali). Comentário do cabeçalho descreve a release única.
- **`.github/workflows/mr-checks.yml`**: `rapidas` ganhou `test_make_catalog.py` e `publish_test/run.sh`.
- **README** (inglês e português): *Publishing/Publicar* descreve a release única, a regra de uma versão por idioma e a transição.

## Validação (tudo rodado aqui)
- `docs/tools/test_make_catalog.py`: 19 verificações (primeira montagem, rodada sem mudança mantém série e bytes, pt-BR v3 remove o zip da v2, idioma removido, conteúdo mudou sem subir a versão, zip de reaproveitamento ausente ou adulterado, `--reuse` faltando, modo antigo).
- `docs/tools/publish_test/run.sh` (novo): roda o `publish_release.sh` de ponta a ponta com um `gh` de mentira (`publish_test/gh`), um `apksigner` de mentira e a **assinatura de verdade** (keystore de teste, `SignCatalog.java`). 23 verificações: primeira release única a partir do catálogo antigo (série 5 continua, `baseUrl` da release nova, anexos = APK + catálogo + um zip por idioma, nenhum APK sem assinatura, é a `latest`, texto com notas curtas + dicionários + link); segunda release sem mudança (mesma série, mesmos bytes); pt-BR v3 (série +1, sem o `pt-BR-2.zip`); série maior vence entre as duas origens; sem catálogo anterior (série 1); anexo que não subiu (rascunho apagado, nada publicado); rascunho velho; versão já publicada (automático avisa, manual dá erro); sem APK assinado; assinatura inválida; lib desatualizada; dicionário mudou sem subir a versão; sem chave para o catálogo.
- YAML dos dois workflows lido e conferido.

## O que NÃO foi testado
- **No GitHub de verdade:** o `gh` é simulado. As chamadas usadas (`gh api .../releases/latest`, `gh release view --json assets|isDraft`, `gh release download -p -D`, `gh release create --draft ...`, `gh release edit --draft=false --latest`, `gh release delete -y`) são as mesmas da execução anterior que publicou a v1.72.0, mais `release download -p -D` e vários anexos num `release create`; pela documentação do `gh` funcionam assim, mas só a primeira execução no GitHub confirma.
- Um APK de verdade nunca passou por isso (o `apksigner` é de mentira); a assinatura do **catálogo** é real.

## O que fazer depois do commit
1. Nada muda de imediato: a versão `v1.72.0` já existe, então o push **não publica** nada (o passo só avisa).
2. A v1.72.0 que já está publicada continua precisando do ajuste manual (apagar o `MrKeyboard-v1.72.0.apk` e trocar o texto pelo da seção `## Notas da release` de `docs/revisao-1.7.2.md`).
3. Até a etapa b) sair, os apps leem a release `dicionarios`; mantenha o `mr-dicts.yml` para mudanças de dicionário que precisem chegar a eles.
4. O primeiro lançamento depois da etapa b) cria a primeira release única (etapa c).
