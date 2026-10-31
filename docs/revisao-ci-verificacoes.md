# Revisão: workflow de verificações (CI)

## Pedido
Das melhorias apontadas na análise, a número 2: o CI só montava o APK. Nenhuma das conferências que fazíamos à mão (registradores do smali, recursos, textos em espanhol, chaves do "Restaurar padrões", testes de PC) rodava sozinha, e foi esse tipo de conferência que pegou o erro que fechava as Configurações na 1.67.

Mudança só de ferramentas e CI: **o app não muda e a versão não sobe** (como em `revisao-ci-workflows.md`).

## O que mudou
- **`.github/workflows/mr-checks.yml`** (*Mr Keyboard - verificações*), separado dos outros dois. Roda nos pushes na `main` e nos pull requests que mexem no app (`smali/`, `res/`, manifest, `apktool.yml/json`, `docs/tools/`, `docs/revisao-*.md`) ou à mão. Não publica nada e não guarda APK.
  - **`rapidas`** (segundos): `check_version.py`, `check_reset_keys.py`, `mres_check.py`, `res_check.py`, `smali_regcheck.py smali` e `run_java_tests.sh`.
  - **`montagem`** (alguns minutos): baixa o apktool 2.11.1 e o dex2jar 2.1 (com o SHA-256 conferido), roda `check_java_smali.sh`, monta o APK só para verificar, roda `verify_dex.sh`, o `smali_regcheck.py` no smali decodificado do APK e o `run_java_tests.sh` com o jar do APK (testes do espanhol).
- **Scripts novos em `docs/tools/`** (todos rodam também no seu computador, na raiz do projeto):

| Script | O que confere |
|---|---|
| `check_version.py` | `apktool.yml` e `apktool.json` iguais; `versionCode` = maior·1000000 + menor·1000 + correção (v1.72.0 → 1072000); existe `docs/revisao-<versão>.md` (ou `revisao-1.M.M.md` para v1.MM.0), como o workflow de publicação procura |
| `res_check.py` | XMLs bem formados; `public.xml` sem entrada sem recurso nem repetida; todo ID de recurso do smali está no `public.xml`; toda referência `@tipo/nome` existe; nenhum recurso sem uso (alcançado pelo manifest, pelos IDs do smali e pelos nomes lidos por texto no smali e no Java); `values-es` com as mesmas chaves e listas do português e os mesmos marcadores (`%s`, `%1$d`) do original |
| `run_java_tests.sh` | compila stubs e fontes Java e roda `AuthorTest`; com o jar do APK, roda também `EsTest` |
| `verify_dex.sh` | dex2jar + `d2j-asm-verify` no dex de um APK. O `d2j-asm-verify` **sai com 0 mesmo quando acha erro** (imprime `Error verify method ...`), por isso o script falha quando sobra qualquer linha além de `verify <jar>` |
| `check_java_smali.sh` | roda o `build_java.sh` num diretório temporário e compara com o smali do repositório: pega Java mudado sem regenerar o smali, smali editado à mão no lugar do Java e classe interna que sobrou |

## Como foi feito
- Os scripts novos nasceram das conferências que vínhamos fazendo à mão (varredura de recursos, `public.xml`, espanhol x português, conferência dos IDs).
- Cada script foi provado nos dois sentidos, no projeto atual (passa) e numa cópia com problemas plantados (falha): chave em espanhol faltando, marcador `%1$d` trocado, lista com item a menos, `@string/` que não existe, recurso sem uso, `versionCode` diferente entre `apktool.yml` e `apktool.json`, uma classe inválida no dex, um `MrBar.smali` alterado e um `MrReset$9.smali` que sobrou.
- Sem âncoras YAML no workflow (o `paths` está repetido nos dois gatilhos) para não depender de recurso novo do Actions.
- README (inglês e português): a seção *Building* passa a falar em três workflows.

## Validação
- Todos os passos do job `rapidas` rodados aqui, em ordem: passam. `check_java_smali.sh` rodado aqui: passa, e falha com problemas plantados. `verify_dex.sh` rodado aqui: passa num APK real e falha num jar inválido. O `EsTest` rodou pelo `run_java_tests.sh` com um jar do APK.
- YAML do workflow lido e conferido (gatilhos, jobs, passos).
- **Não rodou no GitHub:** o workflow em si (downloads, `apktool b`, tempo) só se prova no primeiro push. Pontos para olhar nele: o link do dex2jar (`v2.1/dex2jar-2.1.zip`, SHA-256 `7a9bdf84…a46f08`, o mesmo arquivo usado aqui) e o `check_java_smali.sh`, que depende de o JDK 21 do Actions gerar o mesmo bytecode do daqui (JDK 21.0.12); se ele falhar só no CI com "DIFERENTE", é isso, e dá para tirá-lo do workflow sem perder as outras conferências.
