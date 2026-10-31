# 1.77.2 — Busca à prova de dicionário estragado; motor nativo junto do app

## Pedido
Juntar o código do motor nativo no repositório do app (em vez de um repositório separado), usando os dicionários de `dicts/` nos testes em vez de cópias pequenas. Ao rodar os testes de arquivos estragados com o dicionário **de verdade**, apareceu um travamento que o dicionário pequeno escondia.

## Notas da release
**Português**
- Torna a busca de correção à prova de dicionário estragado: um arquivo de dicionário corrompido não pode mais travar o teclado (a verificação de prefixo e a separação de palavras coladas ganharam um teto de trabalho). Dicionários normais não mudam em nada.
- Inclui o motor de sugestões nativo (C++) recompilado com essa proteção.

**English**
- Makes correction search safe against a damaged dictionary file: a corrupted dictionary can no longer freeze the keyboard (the prefix check and the split of run-together words now have a work limit). Normal dictionaries are unaffected.
- Includes the native suggestion engine (C++), rebuilt with that protection.

## A falha
`isPrefix` (o teste "a digitada ainda é começo de palavra?") e o `lookup` da separação de palavras (`split`, "porisso" → "por isso") descem o trie e entram em **todos** os filhos cuja letra combina. Num dicionário de verdade isso é pouco: no máximo 41 e 379 nós por consulta em 43 mil consultas (medido nos 3 idiomas). Num arquivo estragado, com ponteiros em ciclo e letras repetidas, o número de caminhos cresce exponencialmente: a busca não termina e o teclado trava. Achei com o teste de arquivos estragados sobre o `main.dict` completo de 3,7 MB (o dicionário pequeno de 330 KB não chegava lá). O código Java tinha a mesma falha; a C++ a herdou na porta.

## O que mudou
- **`MrFuzzy.java`** (e a mesma coisa em **`engine/src/mr_fuzzy.cpp`**): um contador de nós para `isPrefix` e outro para o `lookup` do `split`, com teto de `NODE_BUDGET` (12.000, o mesmo do `walk`). No dicionário normal o teto nunca é atingido (máximo medido: 379), então o resultado é o mesmo; no estragado a busca termina em milissegundos. Estourou o teto: `isPrefix` responde "não" e o `split` fica com o que achou.
- **O motor passa a viver neste repositório**, em `engine/` (`src/`, `test/`, `tools/`, `CMakeLists.txt`, `README.md`). `native/` continua como estava. O `mr-native.yml` compila as duas libs; o `mr-apk.yml` confere os dois hashes (`native-src.sha256` e `mrengine-src.sha256`) e que as 6 libs existem; o `mr-checks.yml` roda a **paridade Java × C++ ao vivo** (`docs/tools/e2e/run_native_parity.sh`) com os dicionários de `dicts/`.
- **Testes sem arquivos de ouro**: acabaram os dicionários pequenos de teste, as tabelas e as respostas gravadas do Java (`NativeDump`, `TriDump`, `testdata/`). O `mr_test` usa os `dicts/` de verdade (busca, independência de ordem, trigramas, arquivos estragados com ASan/UBSan, bordas); a igualdade com o Java é conferida ao vivo, por `NativeParity`, com consultas geradas do próprio dicionário (`engine/tools/gen_parity_queries.py`). Nada a regenerar quando `dicts/` muda.
- `docs/motor-nativo.md`, READMEs (inglês e português), `docs/tools/e2e/` (`run_eval.sh` compila as duas libs de PC; `LEIA-ME.md`) e `docs/melhorias-motor.md` atualizados. Versão 1.77.2 (`versionCode` 1077002).
- **Não mudou**: nenhum dicionário, nenhum resultado de sugestão com dicionário normal.

## Medido (rodado aqui, PC)
- **Paridade Java × C++ ao vivo** (`run_native_parity.sh`, com o código novo dos dois lados): pt-BR 10.944 buscas, en-US 11.200, es 10.907, mais 2.000 listas finais de `Suggest` por idioma e 24.000 pares de trigramas por idioma, todos pela JNI: **0 diferenças**; dicionário feito à mão com caractere de 2 bytes: 0 diferenças.
- **Arquivos estragados**, `mr_test` com ASan + UBSan sobre os `dicts/` de verdade: 600 dicionários de 3,7 MB (cortados, bytes trocados, lixo) com 14 mil buscas e 2.400 `trigrams.bin` estragados, sem queda, sem leitura fora do arquivo e sem travar (antes do teto, uma única busca não terminava).
- `JniSmoke` (ponte JNI, 86 verificações com o dicionário e os trigramas de verdade, argumentos ruins incluídos).
- `check_java_smali.sh` em dia; `run_java_tests.sh` com o jar do APK; verificações estáticas (`check_version`, `res_check`, `mres_check`, `check_reset_keys`, `check_catalog_url`, `test_make_catalog`, `publish_test`).
- Velocidade e memória do motor: as da 1.77 (busca ~1,8 a 2,0× mais rápida no PC com a ponte JNI; trigramas fora do heap Java). Nada mudou aqui.

## Não testado
- O passo novo do `mr-apk.yml` e o passo de paridade do `mr-checks.yml` no Actions: o YAML foi validado e os trechos de shell simulados no PC. (O `mr-native.yml` ampliado rodou e gerou as libs.)
- **Em aparelho**: a `libmrengine.so` nova (com o teto) foi compilada pelo workflow, mas ainda não foi testada no aparelho.

## Libs geradas (workflow `Mr Keyboard - lib nativa`, commit `970c2158` do repositório)
As 6 libs de `lib/` e os três arquivos de hash (`native-src.sha256`, `mrengine-src.sha256`, `mrengine-info.txt`) vêm do artifact `libs-nativas` dessa execução. Conferido aqui:
- Os hashes gravados são os dos fontes de hoje: `native/` `57f975b6…` e `engine/` `60b8b53a…`; o passo **Conferir se lib/ foi compilada do native/ e do engine/ atuais** do `mr-apk.yml`, simulado, dá `lib_ok=true` (também com *publicar*).
- Os SHA-256 das 6 libs de `lib/` são os do `mrengine-info.txt`.
- **A `libjni_pckeyboard.so` recompilada é idêntica, byte a byte, à que já estava no repositório** (arm64-v8a `d439792d…`, armeabi-v7a `bc493307…`, x86 `121bbd15…`): mover o código de `native/` pelos repositórios não mudou o binário, e o NDK e os flags reproduzem a build antiga.
- `libmrengine.so` nova (com o teto de nós): arm64-v8a `1781e838…`, armeabi-v7a `ca09210f…`, x86 `d514647a…`. Nas 3 ABIs: alinhamento de 16 KB (`0x4000`), dependem só de `libc`, `libm` e `libdl` (a do dicionário também de `liblog`), só `JNI_OnLoad` exportado e os nomes `MrNative`/`BinaryDictionary` registrados.

Falta só testar no aparelho (lista abaixo). Com tudo certo, o push publica a 1.77.2.

## Testes Android necessários
1. Configurações → Sugestões e dicionários: **Motor de sugestões: Nativo (C++)**.
2. Digitar erros ("vda", "sepre", "durate", "agoa", "porisso") e conferir as sugestões da 1.77.
3. Previsão depois do espaço, trocando de idioma (pt-BR, en, es) algumas vezes.
4. Atualizar um dicionário pela tela e voltar a digitar.
5. Usar o teclado alguns minutos em apps diferentes; queda do teclado com a lib presente é erro desta versão (apague a lib para voltar ao Java).

## Voltar atrás
Restaurar o `engine/` e os workflows pelo histórico do git; para só desligar o motor, apagar os três `libmrengine.so`.
