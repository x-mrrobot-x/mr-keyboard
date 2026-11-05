# Plano 1.82 — Nomes em inglês, release profissional (CI) e aviso de nova versão no app
<!-- target-version: v1.82.0 -->

**Andamento:** a Etapa 1a (nomes e documentos) está pronta e a 1b está em andamento (lotes A e B prontos); as outras etapas não começaram. Este arquivo e os anexos novos já usam nomes em inglês (`plan-release-update.md`, `update.json`, `catalog.json`). O app ainda não foi divulgado: o dono vai apagar todas as releases e recomeçar a distribuição do zero, então o plano **não tem migração nem compatibilidade com versões antigas**. A numeração segue de onde está (**1.82.0**).

## Pedido
1. Avaliar se o fluxo atual de gerar release é profissional e se a release única (APK + dicionários) é a melhor estratégia.
2. Incluir na release um zip só com a parte que importa para o usuário modificar e compilar o APK.
3. Pesquisar estratégias de distribuição de APK no GitHub e dizer se alguma é melhor que a atual.
4. O app deve descobrir sozinho que saiu versão nova e mostrar um diálogo com as novidades e botões (baixar, abrir a latest release no GitHub etc.), com os melhores rótulos.
5. (acréscimo) Padronizar em **inglês** os nomes de arquivos JSON e Markdown, de anexos de release e de outros itens hoje misturados com português.
6. (acréscimo) Configuração para o app **verificar atualização toda manhã, mesmo em segundo plano** (sem abrir a interface), com **notificação** quando houver versão nova.
7. (acréscimo) Retirar a ação **Pular esta versão** do diálogo.
8. (acréscimo) Resolver a poluição dos dicionários nas releases (várias versões do mesmo idioma) e definir como funciona o versionamento deles.
9. (acréscimo) Nome do APK na release em minúsculo e com a versão (ex.: `mr-keyboard-v1.40.0.apk`), para o usuário ver a versão ao bater o olho.

## Como era antes da Etapa 1a (lido em `mr-apk.yml`, `publish_release.sh`, `mr-checks.yml` e nas revisões do CI; os nomes abaixo são os de antes, já trocados por inglês)
- Push na `main` com `versionName` novo (sem Release com essa tag) → `mr-apk.yml` monta com o apktool 2.11.1, alinha (`zipalign`), assina (`apksigner`) e chama `publish_release.sh`.
- **Uma Release por versão**, tag = `versionName`. Anexos: `MrKeyboard.apk` (nome fixo, para o link `releases/latest/download/MrKeyboard.apk`), `catalogo.json` (assinado com a chave do APK) e um zip por idioma. Texto: seção `## Notas da release` (português e inglês), lista de dicionários, SHA-256 do APK e do certificado, link das notas completas.
- Rascunho → anexos conferidos contra a lista esperada → publica como `latest`. Se algo diverge, apaga o rascunho e nada sai. Sem chave, versão repetida ou `lib/` velha: só avisa.
- O script tem teste de ponta a ponta (`publish_test/run.sh`, `gh` de mentira, assinatura real do catálogo).

### Avaliação
É um fluxo **sólido**, acima da média dos projetos de APK no GitHub: rascunho antes de publicar, anexos conferidos, assinatura verificada, hash e certificado no texto, notas curtas, script testado. A estratégia "uma release com tudo" também é a certa (é o que Obtainium e IzzyOnDroid esperam: 1 APK por release, tag = versão).

Lacunas reais, da mais importante à menos:
1. **A publicação não espera as verificações.** `mr-apk.yml` e `mr-checks.yml` rodam em paralelo no push; uma release pode sair com `mr-checks` vermelho.
2. **Release mutável.** Depois de publicada, tag e anexos podem ser movidos, apagados ou trocados (por engano ou por quem roubar o token).
3. **Sem zip de fontes com hash estável.** Os "Source code (zip/tar.gz)" automáticos do GitHub têm 15 MB (levam os dicionários) e o GitHub não garante o checksum deles.
4. **Sem prova de origem** (qual commit e qual workflow geraram o APK).
5. **O app não avisa de versão nova.**
6. Higiene menor: actions por tag móvel (`@v4`), `contents: write` no workflow inteiro.

## Pesquisa (resumo)
- **Releases imutáveis** (GA em 28/10/2025): depois de publicada, a release trava anexos e tag (a tag não é movida nem apagada; mesmo apagando a release, o nome não pode ser reusado) e gera automaticamente uma **attestation** (Sigstore) com tag, commit e anexos. Título, notas e o marcador `latest` continuam editáveis. Fluxo recomendado: criar como rascunho, anexar tudo, publicar, que é exatamente o do `publish_release.sh`. Verifica-se com `gh release verify <tag>` e `gh release verify-asset <tag> <arquivo>`. No ataque ao Trivy, a única tag que o atacante não conseguiu trocar era a de uma release imutável.
- **Build provenance** (`actions/attest`, antigo `attest-build-provenance`): assinatura Sigstore que liga o arquivo ao repositório, commit e workflow; `gh attestation verify <arquivo> --repo x-mrrobot-x/mr-keyboard`. Gratuito em repositório público; pede `id-token: write` e `attestations: write`.
- **Zip de fontes:** o GitHub avisou em 2023 que o checksum dos arquivos automáticos pode mudar e que quem precisa de hash estável deve **subir o arquivo como asset da release** (esses não mudam). Um asset também pode excluir o que não interessa (dicionários, 20 MB).
- **Obtainium** usa a API de releases do GitHub; funciona com 1 `.apk` por release (filtro padrão `.apk`), então anexar zips não atrapalha. **IzzyOnDroid** pega o APK da release e **não aceita app com atualizador próprio** que instale APK (regra para apps que não são gerenciadores de pacotes).
- **API do GitHub sem token: 60 requisições/hora por IP**, e redes que compartilham o IP (comum em operadoras) esgotam isso rápido. Já `releases/latest/download/<arquivo>` é o endereço de download do site, **fora da cota da API REST** e já usado pelo app para o catálogo; com 1 consulta por dia por aparelho não chega perto de qualquer proteção do site.
- **Instalar APK de dentro de um app (Android):** exige a permissão `REQUEST_INSTALL_PACKAGES`, o usuário liberar "Instalar apps desconhecidos" para o app (`canRequestPackageInstalls`, `ACTION_MANAGE_UNKNOWN_APP_SOURCES`) e, hoje, a API `PackageInstaller` (o `ACTION_INSTALL_PACKAGE` é obsoleto). No Android 12+ um app pode se atualizar sem tela de confirmação (`setRequireUserAction(USER_ACTION_NOT_REQUIRED)` + `UPDATE_PACKAGES_WITHOUT_USER_ACTION`), com condições. A assinatura é conferida pelo sistema: um APK assinado com outra chave nunca atualiza o Mr Keyboard.
- **Verificação de desenvolvedor do Google:** desde **30/09/2026** vale no **Brasil**, Indonésia, Singapura e Tailândia (Android 7+ certificado); a primeira onda cobre instalações vindas de lojas participantes, e a expansão global é em 2027. App de desenvolvedor não registrado ainda instala por ADB ou pelo "fluxo avançado" (espera de 24 h). Quem distribui fora do Google Play usa o **Android Developer Console** (conta completa com identidade; conta "distribuição limitada" é grátis mas só até 20 aparelhos; há um guia de registro de apps open source). Fica fora do código, mas muda o risco de distribuir só por GitHub: ver Riscos.

## Nomes em inglês e documentos do repositório (Etapa 1)
Antes, os nomes se misturavam: `catalogo.json` ao lado de `release_assets.py`, `revisao-*.md` ao lado de `README.md`, `LEIA-ME.md`, `dados.json`, o cabeçalho `## Notas da release` e workflows chamados "verificações" e "lib nativa". Os campos dos JSON (`serial`, `baseUrl`, `packs`, `minApp`...) já estavam em inglês; só os **nomes** mudaram. **A Etapa 1a está pronta** e já vai neste plano; 1b e 1c (comentários e texto) faltam.

### Documentos do repositório (decidido: seguir a sugestão)
- **Saíram** 60 arquivos de `docs/`: 49 `revisao-<versão>.md`, 7 `revisao-ci-*`/`revisao-fase-a-dicionarios` e 4 `plano-*` (anexos-multiselecao, configuracoes, dicionarios, nativo). Eram diário de trabalho: o histórico fica no Git e no texto de cada release. Este plano sai quando a 1.82.0 for publicada.
- **Ficam** só os documentos vivos, que descrevem o projeto de hoje: os dois README, `docs/ai-editor.md`, `engine-improvements.md`, `native-engine.md`, `new-theme.md`, `dictionary-build.md` (era `revisao-1.6.0.md`, a documentação do build do dicionário), `engine/README.md` e os README das pastas de teste.
- **Notas por versão:** `docs/release-notes/<tag>.md`, curtas, com os blocos **Português** e **English**; o arquivo inteiro é o texto da release (sem cabeçalho fixo e sem link para notas completas). `check_version.py` exige o arquivo e os dois blocos; `mr-checks.yml` roda quando eles mudam. A 1.81.0 já tem o seu; o da 1.82.0 nasce na Etapa 9.

### Renomeado na 1a
| Antes | Agora |
|---|---|
| `docs/revisao-1.6.0.md` | `docs/dictionary-build.md` |
| `docs/editor-ia.md` · `melhorias-motor.md` · `motor-nativo.md` · `novo-tema.md` | `docs/ai-editor.md` · `engine-improvements.md` · `native-engine.md` · `new-theme.md` |
| `docs/tools/{author_test,e2e,es_test,packs_test,settings_test}/LEIA-ME.md` | `README.md` (mesma pasta) |
| `docs/tools/relatorio_lista_1.6.0.txt` | `docs/tools/report_list_1.6.0.txt` |
| `docs/tools/casos.tsv` · `native/test/casos.tsv` | `cases.tsv` (mesmas pastas) |
| `native/test/amostra_bigramas.tsv` · `amostra_palavras.tsv` | `sample_bigrams.tsv` · `sample_words.tsv` |
| `catalogo.json` (anexo da release) | `catalog.json` |
| `MrKeyboard.apk` (anexo da release) | `mr-keyboard-<versionName>.apk`, ex.: `mr-keyboard-v1.82.0.apk` (ver R6) |
| `MrKeyboard-unsigned.apk` · `MrKeyboard-signed.apk` (intermediários do CI) | `mr-keyboard-unsigned.apk` · `mr-keyboard-signed.apk` |
| Prefixo assinado `mr-keyboard/catalogo/v1\n` (`MrPacks`, `SignCatalog.java`, testes) | `mr-keyboard/catalog/v1\n` |
| Modo legado: release `dicionarios`, `RELEASE_TAG` e `make_catalog.py` sem `--tag` | removido |
| `dados.json` · `enviar.txt` (intermediários de `out/`) | `data.json` · `upload.txt` |
| Cabeçalho `## Notas da release` e `docs/revisao-*.md` como fonte do texto da release | `docs/release-notes/<tag>.md` inteiro |
| Nomes de exibição dos workflows: `Mr Keyboard - verificações` · `Mr Keyboard - lib nativa` | `Mr Keyboard - checks` · `Mr Keyboard - native lib` |
| Artifacts dos workflows: `libs-nativas` · `smali-gerado` (e a pasta `smali-gerado/`) | `native-libs` · `generated-smali` (`generated-smali/`) |

### O que continua em português (e por quê)
- `README.pt-BR.md` (sufixo de localidade, convenção comum), `res/values-pt-BR`, os blocos **Português** das notas e os campos `pt` dos manifestos de dicionário e o dicionário `dicts/pt-BR`: são conteúdo para o usuário brasileiro, não nomes de projeto.

### Cuidados da mudança (todos tratados na 1a)
1. **Catálogo.** O app lê `releases/latest/download/catalog.json` e verifica com o prefixo `mr-keyboard/catalog/v1\n` (`MrPacks.CATALOG_URL` e `SIG_PREFIX`, `SignCatalog.java`, `sign_catalog.sh`, `check_catalog_url.py`, testes, textos de erro). Não há cópia com o nome antigo nem leitura do nome antigo: não existe app em uso para proteger. Builds de teste antigos do dono (assinados com o prefixo velho) não validam o catálogo novo: basta reinstalar.
2. **Sem código legado.** Saíram a release `dicionarios`, o `RELEASE_TAG`, o modo antigo do `make_catalog.py` (sem `--tag`), o laço `for T in $LATEST dicionarios` do `publish_release.sh`, a checagem correspondente do `check_catalog_url.py` e os testes desse modo. O `publish_release.sh` lê o catálogo anterior só de `catalog.json` da release mais recente.
3. **Recomeço do zero.** O dono apaga todas as releases e tags **antes** de ligar "Immutable releases" (R1) e de publicar a primeira release nova. A série do catálogo recomeça em 1 (o script já avisa quando não há catálogo anterior) e todos os zips de dicionário são gerados de novo.
4. Nomes de exibição dos workflows: se houver "required status checks" na proteção da `main`, eles são pelo nome e precisam ser atualizados pelo dono; fora disso só muda o que aparece na aba Actions.
5. Os caminhos antigos somem: a entrega leva `renames.txt` (pares `origem destino` para `git mv`) e `removals.txt` (lista para `git rm`), para o Git registrar renomeação e remoção em vez de apagar e criar.
6. Conferência feita: nenhuma menção ao nome antigo, todo link `docs/*.md` existe, e os verificadores e testes listados na Etapa 1a passam.

### Escopo do que falta (decidido: tudo em inglês, inclusive o texto)
O dono escolheu a opção **C**: além dos nomes, passam para inglês os comentários, as mensagens de log e o texto dos documentos. Volume que resta: ~13 mil palavras em `docs/` (a maior parte é este plano), ~3 mil nos `README`, 58 scripts e testes em `docs/tools`, 24 fontes Java, 13 arquivos de `native/` e `engine/`, 4 workflows e 9 arquivos smali com comentários em português.

**Regras da tradução (para não mudar comportamento nem perder o que é do usuário):**
- Só **comentários, mensagens de log/erro de scripts e CI, rótulos de teste e prosa** mudam. Nenhuma `string` que o app mostra ao usuário muda (`res/values*`, `README.pt-BR.md`, os blocos **Português** das notas e os campos `pt` dos manifestos de dicionário continuam como estão).
- Rótulos da interface citados nos documentos ficam como aparecem no app (pt-BR), entre aspas, com a tradução em inglês entre parênteses na primeira menção de cada arquivo.
- Blocos de código, tabelas, números, links e nomes de arquivo ficam intactos.
- Este plano é traduzido por último, depois da sua aprovação.

**Como se confere cada lote:**
- Java e smali: regenerar o smali com `build_java.sh` e comparar com o anterior (comentário não muda o código, a diferença tem que ser zero fora de comentários); `check_java_smali.sh`; `apktool b` + `verify_dex.sh` com o mesmo `classes.dex`.
- C++ / `engine/`: compilar e rodar os testes de PC de antes; o binário da `libmrengine.so` não pode mudar por causa de comentário.
- Scripts e CI: `sh -n`, `py_compile`, os testes do `docs/tools` (`publish_test/run.sh`, `test_make_catalog.py`, `packs_test`...) com os rótulos já em inglês; varredura de acentos para achar o que sobrou.
- Documentos: um verificador estrutural compara original e tradução (mesmo número de títulos, tabelas, blocos de código e links, mesmos números e caminhos) e acusa diferença.
- Feito em lotes e commits separados, porque a revisão do dono é por commit.

## Dicionários: versionamento e anexos (Etapa 2)
O dono pediu para resolver a poluição de dicionários nas releases. Observação: não consegui abrir a página das releases daqui (o acesso ao GitHub desta sessão é só leitura do Git), então a análise vem do que os scripts fazem e dos números de uma montagem local.

### Como o versionamento funciona hoje
- `version` (inteiro, por idioma) em `dicts/<id>/pack.json`: o dono sobe quando o conteúdo muda; `make_catalog.py` para com erro se o conteúdo mudou sem subir, ou se a versão é menor que a já publicada.
- `minApp`: `versionCode` mínimo do app para aquele pacote. `serial` do catálogo: sobe quando algum pacote muda; o app recusa catálogo de série menor que a guardada (anti-retrocesso).
- O zip se chama `<id>-<version>.zip` (`pt-BR-2.zip`); o app compara a versão instalada com a do catálogo para mostrar "Atualizar".
- O catálogo tem **um só `baseUrl`**, o da própria release. Por isso **todo zip precisa estar na release do catálogo**: o `publish_release.sh` baixa os zips da release anterior (~13 MB) e anexa de novo, byte a byte, os que não mudaram.

### De onde vem a poluição
Montagem local: `en-US-2.zip` 4,1 MB, `es-1.zip` 4,6 MB, `pt-BR-2.zip` 4,5 MB, ou **13,2 MB de dicionários contra ~1,2 MB de APK**. Cada release repete os mesmos três zips (92% do peso são cópias idênticas, e cada publicação baixa e sobe 13 MB à toa). Na lista de releases os nomes mudam de uma para outra (`pt-BR-2.zip` numa, `pt-BR-3.zip` noutra), o que dá a impressão de "vários dicionários do mesmo idioma". Com `update.json` e o zip de fontes seriam 7 arquivos por release, 3 deles repetidos. Com release imutável (R1) as cópias nunca mais podem ser removidas.

### Opções
| Opção | Como fica | Prós | Contras |
|---|---|---|---|
| A. Como hoje | Toda release leva os 3 zips | Cada release é completa e independente; pode-se apagar releases antigas | ~13 MB repetidos por release; poluição |
| **B. Zip só na release em que o idioma mudou (recomendada)** | O catálogo diz, para cada idioma, em qual release está o zip | Cada release só traz o que é novo; publicar fica mais rápido e simples; cada versão de dicionário aparece uma vez, na release que a criou (vira histórico, não cópia) | Não se pode apagar uma release cujo zip o catálogo ainda usa (a imutável protege os anexos; o script confere antes de publicar) |
| C. Release rolante `dicionarios` ou repositório à parte | Dicionários fora das releases do app | Separa os dois ciclos | Já foi aposentada por acumular versões; release rolante é editável, contra a imutável (R1); repositório à parte dobra a manutenção |
Descartada também: dicionários como arquivos do Git (cada troca somaria 6 a 7 MB por idioma ao histórico e exigiria outro endereço de download).

### Recomendação: B
- **Catálogo.** Cada pacote ganha `release` (a tag onde está o zip, ex.: `v1.82.0`); sai o `baseUrl` global. `version`, `minApp`, `serial`, `sha256` e o nome do zip ficam como estão.
- **`make_catalog.py --tag vX`.** Pacote igual ao do catálogo anterior: reaproveita a entrada inteira (inclusive o `release` antigo), sem copiar zip (some o `--reuse`). Pacote novo ou alterado: gera o zip em `out/` e marca `release = vX`. Série: sobe só se algum pacote mudou, como hoje.
- **App (`MrPacks`).** A URL do zip é montada com uma constante do app (`https://github.com/x-mrrobot-x/mr-keyboard/releases/download/`) + `release` + nome; `release` validado por `^v\d+\.\d+\.\d+$` e o nome por `safeName`. Os links ficam em constantes do app, na mesma regra do `update.json`. O restante (baixar, conferir SHA-256, instalar) não muda. Como nada foi divulgado, o `format` do catálogo continua 1.
- **Anexos da release.** APK, `catalog.json`, `update.json`, o zip de fontes e **só os zips cujo `release` é esta tag**. O texto da release passa a dizer, por exemplo, "Dicionários: pt-BR v3 (novo nesta versão), en-US v2, es v1" (e continua dizendo que o app baixa sozinho).
- **Trava antes de publicar.** Para cada pacote cujo `release` é outra tag, o script confere por `gh api repos/.../releases/tags/<tag>` que o zip existe com o mesmo tamanho; se faltar, não cria nem o rascunho.
- **Primeira release depois do recomeço do zero:** traz os três zips; as seguintes só trazem o que mudar.
- **README (en e pt-BR):** diz onde ficam os zips e que não se apaga uma release que guarda um dicionário em uso.

## Recomendações de CI e release
- **R1. Ligar "Immutable releases"** (Settings do repositório → General → Releases). Sem código: o `publish_release.sh` já cria rascunho, anexa e publica. Cuidado: tag publicada não se reusa; release errada = subir a versão (o que o script já exige). Como o dono vai apagar todas as releases e recomeçar, a ordem é: **apagar releases e tags antigas, ligar a opção, publicar a primeira release nova**. Com a opção ligada, apagar uma release depois não libera o nome da tag.
- **R2. Só publicar com as verificações verdes.** `mr-checks.yml` ganha `workflow_call` e o job de publicação do `mr-apk.yml` passa a depender dele (`needs`). Roda as verificações uma vez a mais por push de versão; custo é tempo, não dinheiro.
- **R3. Zip de fontes como asset** (`mr-keyboard-v1.82.0-source.zip`, com a versão no nome como o APK; a pasta de dentro também, `mr-keyboard-v1.82.0/`). Gerado com `git archive` da tag (determinístico, sem depender de ferramenta) e listado em `release_assets.py`. **Conteúdo escolhido (opção B, ~1,7 MB):** projeto do apktool (`AndroidManifest.xml`, `apktool.yml`, `res/`, `smali/`, `lib/`, `original/`, `unknown/`), `native/`, `engine/` com os `.sha256` e `mrengine-info.txt`, a camada Java (`docs/tools/java`, `build_java.sh`, `check_java_smali.sh`), `LICENSE` e os dois README. Sem `dicts/` (os dicionários chegam pelo catálogo) e sem o resto de `docs/`. O README ganha o passo a passo "baixe, edite, `apktool b`, assine".
- **R4. Attestation do APK e do zip** com `actions/attest` (2 passos no job de publicação). Com R1 a release já tem attestation de tag/commit/anexos; a de procedência acrescenta qual workflow construiu. Barata; entra junto.
- **R5. Higiene:** actions fixadas por SHA, `permissions` mínimas por job (só o de publicar tem `contents: write`, `id-token` e `attestations`), notas do README sobre `gh release verify`.
- **R6. APK com a versão no nome** (pedido do dono): `mr-keyboard-<versionName>.apk`, minúsculo, ex.: `mr-keyboard-v1.82.0.apk`. É viável e continua **um só `.apk` por release**. A versão aparece na lista de anexos e no arquivo baixado (útil para quem compartilha o APK fora do GitHub). Consequências: (1) some o link direto estável `releases/latest/download/MrKeyboard.apk`, porque o GitHub não aceita curinga em `latest/download`; o README passa a apontar para `releases/latest`, onde o APK é o primeiro anexo, e quem usa terminal tem `gh release download --repo x-mrrobot-x/mr-keyboard --pattern 'mr-keyboard-v*.apk'`; (2) o Obtainium continua achando o único `.apk`; (3) o app baixa pelo `update.json` assinado (tag exata + nome validado), então não depende do link estável; (4) a v1.72.0 saiu com o APK versionado **e** uma cópia de nome fixo, e a duplicata foi tirada (registrado nas revisões do CI da época, hoje só no histórico do Git): manter as duas daria de novo dois `.apk` por release (1,2 MB a mais cada e dois arquivos para o Obtainium escolher), por isso fica só o versionado. Os intermediários do CI seguem o mesmo padrão minúsculo.

## Aviso de nova versão no app

### Como o app descobre
- Novo anexo **`update.json`**, pequeno e **assinado com a mesma chave do APK** (mesmo formato do `catalog.json`: `data`, `algorithm`, `signature`; prefixo de domínio próprio `mr-keyboard/update/v1\n`, para um arquivo nunca valer pelo outro). Conteúdo: `versionCode`, `versionName`, data, `apk` (nome `mr-keyboard-v<versionName>.apk`, tamanho, SHA-256) e `notes` por idioma (`pt-BR`, `en`; o espanhol cai para o inglês), extraídos pelo `publish_release.sh` dos blocos **Português** e **English** de `docs/release-notes/<tag>.md`.
- O app lê `https://github.com/x-mrrobot-x/mr-keyboard/releases/latest/download/update.json` (sem API, sem limite de 60/h), confere a assinatura com o certificado do próprio app (código que já existe para o catálogo, extraído para um método comum), e só aceita `versionCode` maior que o instalado e que o último visto (sem downgrade nem replay). **Os links vêm de constantes do app, nunca do JSON**: o JSON não consegue mandar o usuário para outro endereço.
- Por que não a API do GitHub nem o campo dentro do `catalog.json`: a API tem limite por IP e devolve texto sem assinatura; o catálogo tem série própria dos dicionários, e misturar os dois complica os dois.

### Quando verifica
- **Ao abrir (decidido):** na abertura da tela principal ou das Configurações, no máximo **1 vez a cada 24 h**, em segundo plano, sem Toast em caso de falha; mais uma linha **"Procurar atualização"** nas Configurações (manual, com resultado visível). Interruptor **"Verificar ao abrir o app"** (ligado por padrão) para desligar.
- **Toda manhã, em segundo plano (pedido novo, seção abaixo):** interruptor **"Verificar toda manhã"** (**ligado por padrão**), que avisa por **notificação** mesmo sem abrir o app. É um job próprio e opcional; o serviço do teclado (IME) continua sem tocar na rede.
- As duas verificações usam o mesmo código (`MrUpdate.check`) e o mesmo registro de "última verificação", então não se repetem: quem abriu o app às 7h50 não gera uma segunda consulta às 8h.

### Verificação diária de manhã, em segundo plano (nova)
**O que o usuário vê.** Nas Configurações, ao lado de "Procurar atualização": interruptor **Verificar toda manhã** (pt-BR) / **Check every morning** / **Buscar cada mañana**, com a linha de apoio "Avisa por notificação quando sair versão nova, mesmo com o app fechado." (en: "Notifies you when a new version is out, even when the app is closed."; es: "Avisa con una notificación cuando haya una versión nueva, aunque la app esté cerrada."). Não promete hora exata: diz "toda manhã".

**Padrão: ligado (decidido).** Quem atualiza para a 1.82.0 passa a ter a verificação da manhã sem fazer nada; por isso:
- A **primeira abertura depois de atualizar** explica em uma linha e, no **Android 13+**, pede `POST_NOTIFICATIONS` com esse contexto. Sem a permissão a notificação não aparece: o job nem consulta a rede e o interruptor mostra "Permita as notificações para receber o aviso" com **Abrir ajustes**. No Android 12 e anterior as notificações já vêm liberadas e funciona direto.
- O app arma o job sozinho após a atualização (receiver de `MY_PACKAGE_REPLACED`) e ao abrir, sem esperar o usuário mexer em nada.
- A mudança é dita sem rodeio: primeira linha das notas da 1.82.0, o README (privacidade) e a própria linha do interruptor. O README deixa de prometer que o app só usa a internet quando o usuário pede.

**Como roda (sem biblioteca nova; o projeto é só smali, então nada de WorkManager).**
- `JobScheduler` com um **job de execução única** que se reagenda a cada rodada: não existe job periódico "às 8h", só "a cada N horas". `MrUpdateJob` (`JobService`) é agendado com `setMinimumLatency` até a **próxima manhã local** (08:00 mais um sorteio de 0 a 59 min, guardado na instalação, para os aparelhos não baterem no GitHub todos ao mesmo tempo), `setRequiredNetworkType(NETWORK_TYPE_ANY)` e `setPersisted(true)` (sobrevive ao reinício; exige a permissão `RECEIVE_BOOT_COMPLETED`, sem pedir nada ao usuário). Sem `setOverrideDeadline`, para o job não rodar sem rede e falhar à toa.
- Ao terminar (com ou sem novidade, com ou sem rede), o job agenda a manhã seguinte. Não insiste no mesmo dia: a falha de hoje se resolve amanhã ou ao abrir o app.
- O cálculo do próximo horário trata virada de dia, fuso e horário de verão (testado no PC com datas fixas).
- Rearmar: ao ligar o interruptor, ao abrir o app (garante que existe um job) e após atualizar o app (receiver de `MY_PACKAGE_REPLACED`). Desligar cancela o job. **A confirmar no aparelho** se o Android mantém o job depois de uma atualização do APK; por isso o rearme existe.
- Dentro do job: se as notificações estão bloqueadas (`areNotificationsEnabled()` falso), **nem consulta a rede**, só reagenda. Se a última verificação tem menos de 6 h, reaproveita o resultado guardado em vez de consultar de novo. A consulta tem tempo limite curto (~10 s) e roda fora da thread principal.

**Notificação.**
- Canal `mr_update`, nome "Atualizações do app" / "App updates" / "Actualizaciones de la app", importância **baixa** (sem som nem vibração, aparece na barra; o usuário pode mudar nas configurações do sistema).
- Título "Mr Keyboard v1.82.0 disponível" / "Mr Keyboard v1.82.0 is available" / "Mr Keyboard v1.82.0 disponible"; texto "Toque para ver as novidades." / "Tap to see what's new." / "Toca para ver las novedades."
- Toque: abre as Configurações do app já com o **diálogo de nova versão** aberto (mesmas ações: Baixar e instalar, Ver no GitHub, Agora não). Some ao tocar (`autoCancel`) e também quando o app instalado já é a versão avisada.
- **Uma notificação por versão**: o app guarda a última `versionCode` avisada; se o usuário descartar, não volta a avisar a mesma versão. Versão ainda mais nova gera um aviso novo.
- **Android 13+**: o pedido de `POST_NOTIFICATIONS` (já declarada no manifest) vem na primeira abertura depois de atualizar, ou ao religar o interruptor. Se o usuário negar, o interruptor continua ligado mas mostra "Permita as notificações para receber o aviso" com o botão **Abrir ajustes**; enquanto a permissão faltar, vale a regra do job (sem notificação, sem consulta). Se a permissão for retirada depois, o mesmo.

**Limites que o usuário precisa entender (vai para o README):** o Android decide quando o job roda. Em Doze, economia de bateria ou "app dormindo" (Samsung, Xiaomi, Huawei etc.), o aviso pode chegar com horas de atraso ou, em aparelhos muito agressivos, não chegar. Por isso a verificação ao abrir continua sendo a garantia, e a diária é um aviso extra.

### Diálogo (visual das Configurações; tela, não o IME)
- Título: **Nova versão disponível**. Subtítulo: `v1.83.0 · 1,2 MB · você está na v1.82.0`. Corpo: as novidades (rolável, texto puro).
- Botões e rótulos (pt-BR / English / Español):

| Ação | pt-BR | English | Español |
|---|---|---|---|
| Principal (baixa e instala dentro do app) | **Baixar e instalar** | **Download and install** | **Descargar e instalar** |
| Abre `releases/latest` no navegador | **Ver no GitHub** | **View on GitHub** | **Ver en GitHub** |
| Fecha; volta a avisar em 24 h | **Agora não** | **Not now** | **Ahora no** |

  Razões: verbos curtos e iguais aos usados nas Configurações dos dicionários (Baixar, Atualizar); "Ver no GitHub" diz para onde vai (a página tem notas completas, hashes e o zip de fontes) sem prometer instalação; "Agora não" é o padrão do Android/iOS para adiar. São 3 ações: quem adia volta a ser avisado ao abrir o app depois de 24 h, e a notificação da manhã é **uma por versão**, então não há insistência diária. O diálogo usa layout próprio no tema `Theme.MrKeyboard.Dialog` porque troca de estado (novidades, progresso, erro).

### O que "Baixar e instalar" faz (decidido: dentro do app)
O APK tem ~1,2 MB, então o download leva segundos e o fluxo pode ser simples e preso à tela:
1. **Permissão.** Se `canRequestPackageInstalls()` for falso, mostra um aviso curto e leva o usuário a "Instalar apps desconhecidos" do Mr Keyboard (`ACTION_MANAGE_UNKNOWN_APP_SOURCES` com `package:`); ao voltar, a ação continua sozinha. Manifest ganha `REQUEST_INSTALL_PACKAGES`.
2. **Download em fluxo.** O APK da **tag exata** do JSON assinado (`releases/download/<versionName>/mr-keyboard-<versionName>.apk`, com `versionName` validado por padrão `v<n>.<n>.<n>` e o nome do arquivo conferido contra `^mr-keyboard-v<n>.<n>.<n>\.apk$` e contra o `versionName`; não `latest`, que pode mudar entre a verificação e o download) é lido por `HttpURLConnection` (mesmo cuidado do `MrPacks.download`: redirecionamento do GitHub, tempo limite, limite de tamanho) e **gravado direto numa sessão do `PackageInstaller`** enquanto o SHA-256 é calculado. Sem arquivo em cache e sem `FileProvider` novo.
3. **Conferência.** Tamanho e SHA-256 têm que bater com o `update.json` assinado; senão a sessão é abandonada e aparece "o arquivo não confere".
4. **Instalação.** `commit` da sessão com um `PendingIntent` explícito (mutável no Android 12+) para um receiver próprio (`MrUpdateReceiver`, `exported=false`); no `STATUS_PENDING_USER_ACTION` abre a tela de confirmação do sistema. Sem a permissão `UPDATE_PACKAGES_WITHOUT_USER_ACTION`: o usuário vê a confirmação do Android (um toque), o que é mais previsível para um teclado que vai ser reiniciado pela atualização.
5. **Estados do diálogo:** "Baixando… N%" com barra e **Cancelar**; "Verificando…"; "Instalando…". Sair da tela cancela o download e abandona a sessão (por ser curto, não há serviço nem notificação). Sessões antigas do app são abandonadas na próxima abertura.
6. **Erros** (mensagem curta + botão **Ver no GitHub**): sem rede, arquivo não confere, sem espaço, assinatura incompatível, instalação bloqueada pelo sistema/Play Protect. Cancelar a confirmação do sistema não é erro e não mostra nada.

Textos novos (pt-BR / English / Español), a fechar nas Etapas 6 e 7:
- Permissão: **Permitir instalação** / Allow installation / Permitir instalación · botão **Abrir ajustes** / Open settings / Abrir ajustes.
- Progresso: **Baixando… N%** / Downloading… N% / Descargando… N% · **Verificando…** / Verifying… / Verificando… · **Instalando…** / Installing… / Instalando….
- Erros: **Não foi possível baixar** / Couldn't download / No se pudo descargar · **O arquivo não confere** / The file doesn't match / El archivo no coincide · **Sem espaço no aparelho** / Not enough storage / Sin espacio en el dispositivo · **O Android recusou a instalação** / Android blocked the installation / Android bloqueó la instalación.

Consequências aceitas: o app passa a ter a permissão `REQUEST_INSTALL_PACKAGES` (entra na tabela de permissões do README) e **deixa de ser elegível ao IzzyOnDroid** (que não aceita atualizador próprio); o app continua instalável e atualizável pelo Obtainium e por baixar manualmente.

### Estado e segurança
- Preferências próprias (`mr_update`): hora da última verificação, maior `versionCode` visto (anti-replay), `versionCode` já avisada por notificação, minutos sorteados da manhã, e os dois interruptores (verificar ao abrir: ligado; verificar toda manhã: ligado). Rede só HTTPS e só `github.com`, tempo limite curto, sem reenvio em laço.
- O que sai do aparelho: só o pedido HTTPS ao GitHub (que enxerga IP e agente de usuário, como em qualquer download). Nenhum identificador, versão instalada ou dado do usuário vai no pedido: a comparação de versões é feita no aparelho.
- A verificação só existe a partir da 1.82.0; ela avisa de versões publicadas depois dela.

## Decisões (suas, confirmadas)
- **Baixar:** dentro do app (baixar, conferir e instalar), não só abrir o navegador.
- **Verificação:** ao abrir o app, no máximo 1 vez a cada 24 h, com opção para desligar e linha manual nas Configurações.
- **Zip de fontes:** opção B (projeto + libs nativas + camada Java, ~1,7 MB).
- **Recomeço do zero:** o app ainda não foi divulgado; o dono apaga todas as releases e recomeça. Sem migração nem compatibilidade com versões antigas; a numeração continua em 1.82.0.
- **Nomes em inglês:** arquivos JSON e Markdown, anexos de release e demais nomes misturados passam para inglês (mapa na seção **Nomes em inglês**).
- **Diálogo com 3 ações** (Baixar e instalar, Ver no GitHub, Agora não); a notificação da manhã é uma por versão.
- **Verificação diária de manhã, em segundo plano, com notificação:** incluída (Etapa 8), **ligada por padrão**, com horário **fixo a partir das 8h** (minutos sorteados por aparelho; sem seletor).
- **Dicionários:** opção B, zip só na release em que o idioma mudou (seção **Dicionários**).
- **APK com a versão no nome:** só `mr-keyboard-v<versão>.apk`, um só `.apk` por release, sem link direto estável nem cópia de nome fixo (R6).
- **Inglês em tudo (opção C):** nomes, comentários, mensagens de log e o texto dos documentos, com as regras de tradução da seção **Nomes em inglês**.
- **Documentos do repositório (siga a sugestão):** planos prontos e revisões antigas saem do repositório (o histórico fica no Git e nas notas das releases); fica só documentação viva e uma nota curta por versão em `docs/release-notes/<tag>.md` (exemplo: `v1.82.0.md`), com os blocos **Português** e **English**, cujo arquivo inteiro é o texto da release.
- Minhas escolhas, sem pergunta (digam se quiserem outra): sem `UPDATE_PACKAGES_WITHOUT_USER_ACTION` (confirmação do sistema); nomes do APK e do zip de fontes com a versão (R6); notas só em PT e EN (espanhol mostra o inglês); download preso à tela (sair cancela); job único reagendado em vez de periódico; notificação de importância baixa; sem WorkManager; este plano também sai do repositório quando a 1.82.0 for publicada.

## Etapas (1a pronta; o resto não começou)
### Etapa 0 — Decisões
- [x] Respostas do dono (acima): CI, verificação, zip, recomeço do zero, inglês em tudo, verificação da manhã ligada e fixa às 8h, dicionários na opção B, APK só versionado, documentos do repositório
- [x] Aprovação para começar (Etapa 1a)
- [ ] Aprovação para seguir com as demais; peço de novo antes das Etapas 3 (liga a imutável), 7 (instalar) e 8 (job da manhã)

### Etapa 1 — Tudo em inglês (primeiro; commits separados por parte)
**1a — Nomes e documentos** (única parte que mexe no comportamento: a URL do catálogo) — **pronta**
- [x] Documentos: 60 apagados (planos prontos e revisões antigas) e 15 renomeados (`renames.txt`/`removals.txt` na entrega); referências reescritas (README, scripts, testes, workflows, comentários); filtros `docs/release-notes/*.md` e nomes de exibição ("checks", "native lib") nos workflows
- [x] Notas por versão em `docs/release-notes/<tag>.md` (já existe `v1.81.0.md`); `publish_release.sh` usa o arquivo inteiro como texto da release; `check_version.py` exige o arquivo e os blocos **Português** e **English**
- [x] APK da release como `mr-keyboard-<versionName>.apk` (`publish_release.sh`, `release_assets.py`, `mr-apk.yml`, testes) e intermediários `mr-keyboard-signed.apk`/`-unsigned.apk`; README (en e pt-BR) aponta para `releases/latest` e dá o nome do arquivo
- [x] `publish_release.sh` publica `catalog.json` e lê o catálogo anterior só dele; modo legado removido (`dicionarios`, `RELEASE_TAG`, `make_catalog.py` sem `--tag`, checagem em `check_catalog_url.py`, testes desse modo); `data.json` e `upload.txt`
- [x] App: `MrPacks.CATALOG_URL`, `SIG_PREFIX` (`mr-keyboard/catalog/v1\n`) e textos de erro; o mesmo prefixo em `SignCatalog.java`, `sign_catalog.sh` e `packs_test`; smali regenerado
- [x] Conferido: `check_version`, `check_catalog_url`, `check_reset_keys`, `res_check`, `mres_check`, `smali_regcheck` (0 problemas), `check_java_smali`, `test_make_catalog` (15), `publish_test/run.sh` (23), `run_java_tests.sh` com o jar do APK (23), `packs_test` (63) e `ThreeLangTest` (23) com catálogo assinado de verdade, `apktool b` + `verify_dex.sh`; nenhum nome antigo sobrou
- [x] Hash do motor: trocar a referência a `docs/motor-nativo.md` no comentário de `engine/CMakeLists.txt` mudou o `mrengine-src.sha256` (o hash cobre `CMakeLists.txt` + `src/`, comentário incluído); recalculei com a mesma conta do `mr-native.yml`, sem precisar baixar o artifact `native-libs` (o `.so` de `lib/` continua valendo, comentário não muda o código gerado)
- [x] `dicts/pt-BR` subiu para a versão 3 (o `NOTICE.txt` mudou de conteúdo); o `make_fixtures.py` do `packs_test` agora monta a v2 sozinho, sem depender da versão real do pacote
- [x] Entrega: projeto em zip + `renames.txt` + `removals.txt`

**1b — Comentários, mensagens e testes** (nenhuma mudança de comportamento)
- [x] **Lote A (pronto):** workflows `mr-apk.yml`, `mr-checks.yml`, `mr-smali.yml` e os scripts/testes da publicação (`publish_release.sh`, `publish_test`, `verify_dex.sh`, `check_*.py`, `res_check.py`, `mres_check.py`, `smali_regcheck.py`, `release_assets.py`, `make_catalog.py`, `sign_catalog.sh`, `SignCatalog.java`, `packs_test/make_fixtures.py`). Nomes trocados: jobs `rapidas`/`montagem` → `quick`/`assemble` (**se alguma regra de proteção do branch exige esses checks pelo nome, ajustar**), entrada `publicar` → `publish`, `MODO` → `MODE` (`manual`/`automatic`)
- [x] **Lote B (pronto):** `mr-native.yml`, `native/`, `engine/` (C++, CMake, testes, `JniSmoke`, `gen_parity_queries.py`), `dict_test.cpp`, `run_native_parity.sh`. Marcadores de teste padronizados: `OK`, `FAIL`, `ALL OK (N checks)`, `N FAILURE(S) out of M checks` (o `grep -v` do `mr-native.yml` mudou junto com o `dict_test`). Arquivos de consulta da paridade: `typos_<id>.tsv` e `pairs_<id>.txt`; `/tmp/mr_parity`. Hashes recalculados; o código objeto não muda (só comentário e texto de teste), então as libs de `lib/` continuam valendo
- [x] **Lote C (pronto):** fontes Java do app (`docs/tools/java/src`), stubs, `FuzzyTest`/`Bench` e os comentários `#` do smali, tudo em inglês. Comportamento igual; único efeito no dex: as mensagens internas de exceção de `MrJson`, `MrPacks` e `MrTrigram` foram traduzidas (28 `const-string`; as outras 60 classes ficam byte a byte iguais). Textos de interface (`MrEs`, strings do smali) continuam em português
- [ ] **Lote D:** testes Java e e2e (rótulos e marcadores; os que sobraram com `FALHA`/`TUDO OK`/`verificações`)
- [ ] **Lote E:** ferramentas Python de dados, scripts do e2e, `cases.tsv` e `report_list`
- [ ] **Lote F:** `NOTICE.txt` dos dicionários, `AndroidManifest.xml` e a varredura final
- [x] (feito no Lote C) Java (`docs/tools/java/src`) e smali com comentário: smali regenerado só com as `const-string` das mensagens de exceção; `check_java_smali.sh`, `verify_dex.sh`, `run_java_tests.sh` e `publish_test` verdes (`native/` e `engine/` já feitos no Lote B)
- [x] (feito no Lote B) Atenção ao traduzir comentários de `native/` e `engine/`: os hashes `native-src.sha256` e `mrengine-src.sha256` cobrem esses arquivos, então mudam junto; recalcular os dois com a conta do `mr-native.yml` e deixar a "native lib" rodar para confirmar que os testes passam. Sem isso o `mr-apk.yml` acusa `lib/` desatualizada e, ao publicar, para
- [ ] `dicts/*/NOTICE.txt` (hoje em português, ASCII): traduzir muda o conteúdo dos pacotes e exige subir a versão de cada um; como a primeira release depois do recomeço leva os três zips de qualquer jeito (Etapa 2), o custo é zero se for feito antes dela
- [ ] Varredura de acentos nos arquivos de código e CI para achar o que sobrou (exceto o que a lista "continua em português" permite)

**1c — Texto dos documentos**
- [ ] `engine/README.md` e os `README.md` de `docs/tools/*` (antigos `LEIA-ME`); `README.md` já está em inglês
- [ ] `docs/ai-editor.md`, `engine-improvements.md`, `native-engine.md`, `new-theme.md`, `dictionary-build.md`; verificador estrutural em cada um
- [ ] Este plano, por último

### Etapa 2 — Dicionários: um zip só na release em que o idioma mudou (opção B)
- [ ] `make_catalog.py`: campo `release` por pacote, sem `baseUrl`; pacote igual reaproveita a entrada anterior sem copiar zip (some `--reuse`); novo/alterado gera o zip com `release` = tag atual
- [ ] `release_assets.py`: APK, `catalog.json` e só os zips com `release` igual à tag (o `update.json` e o zip de fontes entram nas Etapas 3 e 4)
- [ ] `publish_release.sh`: baixa só o `catalog.json` anterior; confere por `gh api` os zips que ficam em outras releases antes de criar o rascunho; texto da release com "novo nesta versão"
- [ ] App: `MrPacks` monta a URL com a constante + `release` validado (sem `baseUrl`); `packs_test` e `ThreeLangTest`; `build_java.sh` e `check_java_smali.sh`
- [ ] Testes: `test_make_catalog.py` e `publish_test/run.sh` (zip em outra release; zip faltando = erro; primeira release com os três; release só com mudança em um idioma)
- [ ] README (en e pt-BR): onde ficam os zips e a regra de não apagar release com dicionário em uso

### Etapa 3 — CI: release imutável, gate e fontes (sem mudar o app)
- [ ] Dono liga "Immutable releases" no repositório **antes do push da 1.82.0** (configuração manual)
- [ ] `mr-checks.yml` com `workflow_call`; `mr-apk.yml` publica só depois dele (`needs`); `permissions` por job
- [ ] `publish_release.sh`: gerar `mr-keyboard-<versionName>-source.zip` com `git archive` (conteúdo da opção B), incluir na lista de `release_assets.py` e no texto da release (SHA-256 do zip)
- [ ] `actions/attest` para o APK e o zip; actions fixadas por SHA
- [ ] `publish_test/run.sh` cobrindo o zip de fontes e o gate; README (en e pt-BR): como baixar, editar e compilar; como verificar (`gh release verify`)

### Etapa 4 — `update.json` (ferramentas e CI)
- [ ] `docs/tools/make_update.py`: monta o JSON (versão do `apktool.yml`, tamanho e SHA-256 do APK, notas pt-BR e en dos blocos **Português** e **English** de `docs/release-notes/<tag>.md`)
- [ ] `sign_catalog.sh`/`SignCatalog.java` com o prefixo de domínio como parâmetro; assinar o `update.json` com a mesma chave
- [ ] `publish_release.sh` anexa o arquivo; `release_assets.py` e `publish_test` atualizados
- [x] `check_version.py` já exige os dois blocos (**Português** e **English**) nas notas (feito na 1a)
- [ ] `check_update_url.py` confere que as URLs do app apontam para este repositório e este nome de anexo

### Etapa 5 — App: verificação (Java, `docs/tools/java`)
- [ ] `MrPacks.parseCatalog`: extrair a conferência de assinatura para um método comum (sem mudar o comportamento do catálogo; os testes de PC existentes cobrem)
- [ ] `MrUpdate.java`: ler, conferir assinatura e versão, guardar estado (`mr_update`), janela de 24 h; um único `check` usado pela abertura, pelo botão manual e pelo job
- [ ] Testes de PC do `MrUpdate` (assinatura boa e ruim, versão menor, replay, notas por idioma, `versionName` inválido, janela de 24 h)
- [ ] `build_java.sh` para gerar o smali; `check_java_smali.sh` limpo

### Etapa 6 — App: diálogo, Configurações e textos
- [ ] Layout do diálogo (novidades roláveis, 3 ações, estados de progresso), linha "Procurar atualização" e interruptor "Verificar ao abrir o app"
- [ ] Disparo na abertura da tela principal/Configurações; o diálogo também abre por intent (usado pela notificação da Etapa 8)
- [ ] Strings em pt-BR, English e Español (rótulos acima); `res_check.py` e `mres_check.py` limpos

### Etapa 7 — App: baixar e instalar
- [ ] Stubs novos em `docs/tools/java/stubs` (`PackageInstaller`, `PendingIntent`, `BroadcastReceiver`, `Settings` etc.) só para compilar
- [ ] `MrUpdate`: permissão, download em fluxo para a sessão do `PackageInstaller`, SHA-256, `commit`, limpeza de sessões antigas
- [ ] `MrUpdateReceiver` (resultado da sessão, abre a confirmação do sistema) e no `AndroidManifest.xml`: `REQUEST_INSTALL_PACKAGES` e o receiver (`exported=false`)
- [ ] Testes de PC do que não depende do Android (conferência de tamanho e SHA-256, validação de `versionName`, mapeamento de status em mensagem)

### Etapa 8 — App: verificação diária de manhã e notificação
- [ ] Stubs novos (`JobScheduler`, `JobInfo`, `JobService`, `JobParameters`, `ComponentName`, `NotificationManager`, `NotificationChannel`, `Notification`; `PendingIntent` já vem da Etapa 7)
- [ ] `MrUpdateSchedule`: próximo horário da manhã (08:00 + minutos sorteados), testado no PC (virada de dia, fuso, horário de verão); `MrUpdateJob`: consulta com `MrUpdate.check`, notifica uma vez por versão, reagenda a manhã seguinte
- [ ] `AndroidManifest.xml`: `RECEIVE_BOOT_COMPLETED`, `<service>` do job com `BIND_JOB_SERVICE`, receiver de `MY_PACKAGE_REPLACED` para rearmar; rearme também ao abrir o app e ao ligar o interruptor
- [ ] Configurações: interruptor "Verificar toda manhã" (**ligado por padrão**), explicação de uma linha e pedido de `POST_NOTIFICATIONS` na primeira abertura depois de atualizar (Android 13+), estado/aviso quando as notificações estão bloqueadas
- [ ] Canal `mr_update`, notificação (toque abre as Configurações com o diálogo; some ao abrir/atualizar); strings pt-BR, English e Español
- [ ] Testes de PC: cálculo do horário, deduplicação por `versionCode`, regra "notificações bloqueadas = sem rede", janela de 6 h; `build_java.sh` e `check_java_smali.sh` limpos

### Etapa 9 — Revisão, versão 1.82.0 e entrega
- [ ] Versão e `docs/release-notes/v1.82.0.md` (curto, blocos **Português** e **English**; a primeira linha diz que a verificação da manhã vem ligada), verificadores, `apktool b` e `verify_dex.sh`
- [ ] README (en e pt-BR): privacidade (as duas verificações, o que é enviado, que a da manhã vem ligada por padrão e como desligar; o app deixa de prometer que só usa a internet a pedido), as permissões novas na tabela (`REQUEST_INSTALL_PACKAGES`, `RECEIVE_BOOT_COMPLETED`, e `POST_NOTIFICATIONS` com o novo uso), o zip de fontes, os limites do aviso em segundo plano
- [x] Aviso `::warning::` no `check_version.py` (roda no `mr-checks.yml`): planos `docs/plan-*.md` com `<!-- target-version: vX.Y.Z -->` no topo avisam quando a versão do projeto chega ao alvo. Só avisa, não apaga nem faz commit (decisão: apagar sozinho pediria `contents: write` no workflow e brigaria com o zip completo da entrega)
- [ ] Apagar este plano no commit da 1.82.0, quando o aviso aparecer (planos prontos não ficam no repositório)
- [ ] Entrega: projeto em zip + `renames.txt` + `removals.txt` (se houver)

### Etapa 10 — Conferir no aparelho (depois da 1.82.0, com a 1.83.0 de teste)
- [ ] Aviso aparece ao abrir; "Agora não" e "Ver no GitHub" fazem o que dizem; offline não mostra erro; manual mostra resultado
- [ ] Baixar e instalar: sem a permissão (leva aos ajustes e continua), com ela (progresso, confirmação do sistema, app reabre atualizado), cancelar no meio, sem rede, arquivo adulterado, Android 8 a 11 e 12+
- [ ] Verificação da manhã: atualizar de uma versão antiga e abrir (Android 13+ explica e pede a permissão; negar mostra o aviso no interruptor; Android 12 e anterior funciona direto); forçar a execução sem esperar a manhã com `adb shell cmd jobscheduler run -f com.mrkeyboard.app <id>`; notificação aparece, toque abre o diálogo, segunda rodada não repete a mesma versão, descartar não volta; reiniciar o aparelho e atualizar o app mantêm o agendamento; notificações bloqueadas = sem consulta; app restrito pela bateria
- [ ] Dicionários baixam e verificam pelo `catalog.json` da primeira release nova (série 1); depois de uma release que não muda dicionário, ainda baixam o zip que está na release antiga

## Riscos
- Tudo que toca o GitHub só se confirma na primeira execução real (o `gh` do teste é de mentira).
- **Imutável não perdoa:** se uma release sair errada, a tag some do uso; a saída é subir a versão. Ligar a opção é decisão do dono (R1).
- **Verificação de desenvolvedor do Google (Brasil, desde 30/09/2026):** hoje a primeira onda cobre lojas participantes, e a regra chega às instalações em geral em 2027. Quem baixa o APK do GitHub pode cair no "fluxo avançado" (espera de 24 h) se o app não estiver registrado. O registro é feito pelo dono no Android Developer Console (identidade, pacote `com.mrkeyboard.app` e chave de assinatura); não é algo que o CI faça. Vale decidir antes de 2027 e escrever no README o que o usuário verá.
- Atualizar por cima exige a **mesma chave** (já é regra do projeto).
- **Instalar de dentro do app é a parte mais arriscada sem aparelho:** `PackageInstaller`, `PendingIntent` mutável e abrir a confirmação do sistema variam entre fabricantes e versões (Android 8 a 16). O Play Protect pode mostrar um aviso próprio na instalação. Por isso é a Etapa 7, separada, e o botão **Ver no GitHub** fica sempre à mão como saída.
- A atualização reinicia o app (e o teclado, se for o ativo): a confirmação do sistema acontece antes, mas quem estiver digitando perde o foco do teclado por um instante.
- **Renomear era amplo:** o risco real era um link ou filtro esquecido (por exemplo, o filtro de caminho `docs/release-notes/*.md` do `mr-checks.yml`); a Etapa 1a terminou com a varredura automática e veio **antes** de qualquer funcionalidade.
- **Traduzir o que sobrou (Etapa 1b e 1c):** comentários de ~58 scripts, 24 fontes Java e `native/`/`engine/` (risco: mexer em código sem querer; mitigação: smali e dex sem diferença) e ~13 mil palavras de documentos vivos (a maior parte é este plano) mais ~3 mil dos README. Com os planos prontos e as revisões antigas apagados, o volume caiu de ~70 mil palavras para uma fração; ainda vale lote pequeno, verificador estrutural e commits separados.
- **Release que guarda dicionário não pode ser apagada** (opção B): o catálogo de uma release nova aponta para o zip de uma antiga. A imutável protege os anexos; o script confere antes de publicar, e o README avisa.
- **Sem link direto estável do APK** (R6): quem tinha `.../latest/download/MrKeyboard.apk` salvo precisa trocar por `releases/latest`; o README e a mensagem da release dizem como.
- **Recomeço do zero + release imutável:** apagar releases depois de ligar a opção não libera o nome da tag; a ordem certa é apagar, ligar, publicar (R1). Aparelhos de teste do dono com build antigo precisam de reinstalação (prefixo de assinatura novo, série do catálogo de volta a 1).
- **Verificação da manhã não é exata:** Doze, faixas de economia de bateria (App Standby) e "app dormindo" de alguns fabricantes atrasam ou impedem o job. É aviso extra; a verificação ao abrir é a garantia, e o texto da opção não promete hora.
- **Privacidade:** a verificação da manhã é a primeira vez que o app usa a internet sem o usuário pedir naquele momento, e vem **ligada** (decisão do dono). Compensações: dita na primeira linha das notas da 1.82.0, no README e na linha do interruptor, desligável em um toque, e só consulta o `update.json` (nada do usuário vai no pedido). Quem atualizou sem ler as notas passa a ter a consulta diária até desligar.
- **Notificação sem permissão (Android 13+):** negada ou retirada, o aviso não aparece; o job nem consulta a rede e o diálogo ao abrir continua funcionando.
- Notas só em português e inglês: o espanhol mostra o inglês.
- Se o `update.json` não estiver na release (versão antiga, falha de rede), o app não mostra nada; nunca mostra erro na verificação automática.

## Fontes
- GitHub: [Immutable releases GA](https://github.blog/changelog/2025-10-28-immutable-releases-are-now-generally-available/) · [docs](https://docs.github.com/en/code-security/concepts/supply-chain-security/immutable-releases) · [Artifact attestations](https://docs.github.com/actions/security-for-github-actions/using-artifact-attestations/using-artifact-attestations-to-establish-provenance-for-builds) · [Estabilidade dos arquivos de código-fonte](https://github.blog/open-source/git/update-on-the-future-stability-of-source-code-archives-and-hashes/) · [Limites da API](https://docs.github.com/en/rest/using-the-rest-api/rate-limits-for-the-rest-api)
- Android: [Install unknown apps](https://android-developers.googleblog.com/2017/08/making-it-safer-to-get-apps-on-android-o.html) · [PackageInstaller.SessionParams](https://developer.android.com/reference/android/content/pm/PackageInstaller.SessionParams) · [Verificação de desenvolvedor](https://developer.android.com/developer-verification) · [Entenda a verificação](https://support.google.com/android-developer-console/answer/16561738)
- Distribuição: [Obtainium, fontes](https://imranr98.github.io/Obtainium-Wiki/sources) · [IzzyOnDroid, política de inclusão](https://izzyondroid.org/docs/general/AppInclusionPolicy/)
