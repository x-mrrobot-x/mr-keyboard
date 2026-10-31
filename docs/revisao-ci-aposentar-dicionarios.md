# Revisão: aposentar a release `dicionarios` e o `mr-dicts.yml` (etapa d)

## Pedido
Última etapa do plano "uma release única por lançamento" (a: `revisao-ci-release-unica.md`; b e c: `revisao-1.7.3.md`). Com o app 1.73.0 lendo o catálogo da release mais recente, a release separada `dicionarios` e o workflow que a alimentava não têm mais função.

Esta etapa só mexe em CI, ferramentas e documentação (o app não muda por causa dela, como em `revisao-ci-workflows.md`). Ela vai no **mesmo commit da 1.73.0** (etapa b), que é quem sobe a versão.

## O que mudou no repositório
- **`.github/workflows/mr-dicts.yml`** (*Mr Keyboard - dicionários*): removido. Dicionário novo agora sai pelo fluxo normal: sobe a `version` em `dicts/<id>/pack.json` **e** a versão do app, e o push publica a release completa.
- **`docs/release-dicionarios.md`** (texto da release `dicionarios`): removido. O texto da release única é montado pelo `publish_release.sh`.
- **`docs/tools/publish_release.sh`**: continua aceitando a `dicionarios` como origem do catálogo *enquanto ela existir* (é o que garante que a primeira release única continue a série dos apps antigos); se ela já foi apagada, o loop só a ignora. Novo: se **nenhum** catálogo anterior for achado, sai um `::warning::` explicando que a série começa em 1 e que apps com série maior guardada vão recusá-lo.
- **`docs/tools/make_catalog.py`**: o modo sem `--tag` não é mais usado por nenhum workflow; o comentário diz que ele só existe para os testes reproduzirem o catálogo antigo (`test_make_catalog.py`, `publish_test/run.sh`, `packs_test/`).
- **README** (inglês e português): saiu a nota de transição; *Publishing/Publicar* descreve só o fluxo novo.
- **`docs/plano-dicionarios.md`**: aviso no topo de que, desde a 1.73, os pacotes saem na release do lançamento (as seções 1 e 3 ficam como histórico do desenho original).

## Ordem segura no GitHub (o que **você** faz; eu não apago nada lá)
O commit pode ir agora. Apagar a release `dicionarios` é uma decisão separada e **tem uma ordem**:
1. Faça o push. O CI publica a `v1.73.0`. Confira em Releases: ela é a **Latest** e tem `MrKeyboard.apk`, `catalogo.json` e os três zips (`en-US-2.zip`, `es-1.zip`, `pt-BR-2.zip`, ou as versões atuais).
2. Confira que `https://github.com/x-mrrobot-x/mr-keyboard/releases/latest/download/catalogo.json` baixa o arquivo.
3. Instale o APK da `v1.73.0` e faça os testes de `revisao-1.7.3.md` (principalmente *Procurar atualizações* e baixar um idioma).
4. **Só então** apague a `dicionarios` (Releases → `dicionarios` → Delete, e apague também a tag; ou `gh release delete dicionarios --cleanup-tag -y`).

Por quê nessa ordem: a primeira release única continua a série (`serial`) do catálogo da `dicionarios`. Se ela for apagada **antes** da `v1.73.0` sair, o script não acha catálogo nenhum, começa na série 1 e os apps que já guardaram uma série maior recusam o catálogo (o aviso novo avisa isso no log).

## O que acontece com quem ainda está na 1.72 ou antes
Esses apps continuam abrindo `.../releases/download/dicionarios/catalogo.json`. Com a release apagada, *Procurar atualizações* e *Baixar* dão erro de rede (HTTP 404) e o app segue aberto; **os dicionários já baixados continuam funcionando**, mas quem não baixou nenhum só consegue depois de atualizar o app. Se isso importar, deixe a `dicionarios` no ar por um tempo (ela é inofensiva parada); só lembre que mudanças de dicionário posteriores à 1.73 não chegam a esses apps.

## Validação (rodado aqui)
- `publish_test/run.sh` (24 verificações) e `test_make_catalog.py` (19) passam depois da mudança; o caso "sem catálogo anterior" continua publicando na série 1, agora com o aviso.
- `check_version.py`, `check_catalog_url.py`, `res_check.py`, `mres_check.py`, `check_reset_keys.py`, `smali_regcheck.py`, `run_java_tests.sh` e `check_java_smali.sh` passam; YAML dos workflows restantes lido (`mr-apk`, `mr-checks`, `mr-native`).
- Referências a `mr-dicts.yml` e `release-dicionarios.md` só restam de propósito: nas notas históricas (`revisao-*`), no aviso do topo do `plano-dicionarios.md` e no comentário do `make_catalog.py`. Nenhum script, workflow ou README as usa.
- **Não rodou no GitHub.**
