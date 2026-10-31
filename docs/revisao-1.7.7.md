# 1.77 — Motor nativo (etapa 1): a busca de correção e os trigramas em C++

## Pedido
Implementar o motor nativo novo, com o procedimento para rodar o workflow e compilar, **em um repositório separado** para não afetar os workflows do app. Escopo escolhido: **etapa 1**, o mesmo formato de arquivos (`main.dict`, `trigrams.bin`), com o Java de reserva; o formato novo de dicionário (sem o limite de 4 MB) fica para a etapa 2. Destino da lib: repositório novo (`mr-engine`) e cópia do `.so` para o app.

## Notas da release
**Português**
- Prepara o teclado para o novo motor de sugestões nativo (C++): a busca de correção e a previsão por duas palavras podem rodar numa biblioteca própria, com as mesmas sugestões de antes e bem menos memória. Quando a biblioteca não está no aparelho, o teclado usa o motor de antes, sem diferença.
- Em Configurações → Sugestões e dicionários, a nova linha "Motor de sugestões" mostra qual está em uso.

**English**
- Prepares the keyboard for the new native suggestion engine (C++): correction search and two-word prediction can run in a dedicated library, with the same suggestions as before and much less memory. When the library is not on the device, the keyboard uses the previous engine, with no difference.
- In Settings → Suggestions and dictionaries, the new "Suggestion engine" line shows which one is in use.

## Como ficou
Dois repositórios, ligados por **um arquivo** (`libmrengine.so`):

- **`mr-engine`** (novo, entregue em zip à parte): `src/mr_fuzzy.cpp` é a porta de `MrFuzzy.java` (as 3 passadas, a programação dinâmica em faixa, a divisão de palavras coladas), `src/mr_tri.cpp` a de `MrTrigram.java` (formato MRT1), `src/mr_jni.cpp` a ponte (`RegisterNatives`). Workflow próprio (3 ABIs + testes de PC + sanitizers) e README com o passo a passo para rodar, baixar o artifact e copiar a lib.
- **este app**: `MrNative` (carrega a lib em segundo plano, confere o contrato e entrega os custos, as tabelas e as regras), ganchos em `MrFuzzy.search` e `MrTrigram.use/find`, linha de status na tela "Sugestões e dicionários". **Sem a lib, nada muda em relação à 1.76**: o código Java continua inteiro e é o caminho de reserva.

Decisões de projeto:
- **A fonte da verdade fica no Java.** Os custos (`C_PROX_1`, `C_DEL`…), as regras do idioma (`rules.txt`), `Character.toLowerCase/isUpperCase` e `MrText.base` são calculados pelo Java e entregues à lib (`MrNative.init`/`pushRules`); a lib não tem constante de ajuste. Mudar um custo não exige recompilar a lib. A pontuação (`Math.pow(2, -custo/25)`) vem como tabela calculada pelo Java, para o arredondamento ser o mesmo em qualquer aparelho.
- **Contrato versionado**: `ENGINE_VERSION` (Java) = `kEngineVersion` (C++). Versão diferente = a lib não é usada.
- **Trigramas lidos inteiros para a memória**, não por `mmap`: se um pacote novo trocasse o arquivo no lugar, ler uma página mapeada derrubaria o app (SIGBUS). O arquivo é conferido por inteiro ao abrir (ordem, ids, tamanhos); arquivo estragado vira "não abriu" e o Java carrega.
- **A primeira consulta nunca espera a carga**: se a lib ainda não carregou, a consulta daquela vez segue pelo Java (mesmo resultado) e a carga acontece em segundo plano.
- **Nenhuma exceção atravessa a JNI**; entradas fora do esperado (buffer não direto, arrays curtos) devolvem falha e o Java assume.

## Medido (PC, 3 idiomas, dicionários completos)
- **Paridade com o Java** (`docs/tools/e2e/NativeParity.java`; palavra, ordem, pontuação, custo e nós visitados): pt-BR 29.908 consultas, en-US 28.899, es 29.419 (erros sintéticos, começos de palavra, palavras certas e bordas): **0 diferenças**. A lista final de `Suggest.getSuggestions` (o que a faixa mostra), 6.000 palavras por idioma: **0 diferenças**. Trigramas: 40.980 / 37.850 / 23.276 pares: **0 diferenças**. Dicionário feito à mão com caractere de 2 bytes (0xFF + 2), que os dicionários reais não têm: 0 diferenças.
- **Velocidade da busca** (JIT do Java já aquecido; tempo da C++ inclui a ponte JNI): pt-BR 620 → 322 µs por consulta (1,9×), en-US 602 → 335 µs (1,8×), es 456 → 229 µs (2,0×). Sem a ponte, a C++ faz 176 a 310 µs. Em trigramas o tempo por consulta é o mesmo (3 a 5 µs). **No celular o ganho pode ser diferente** (o ART roda o Java mais devagar que o HotSpot do PC, mas não foi medido).
- **Memória dos trigramas** (heap Java, pt-BR / en-US / es): 7,1 / 6,4 / 8,9 MB → ~0 MB. Fora do heap ficam o arquivo (3,0 / 2,3 / 3,5 MB) e os índices (0,8 / 0,6 / 0,9 MB). Ou seja, 3,8 / 3,0 / 4,3 MB no total contra 7,1 / 6,4 / 8,9, e nada mais no coletor de lixo.
- **Arquivos estragados** (ASan + UBSan, no repositório do motor): 4.500 dicionários (cortados, bytes trocados, lixo) com 180 mil buscas e 18 mil `trigrams.bin` estragados: sem queda e sem leitura fora do arquivo. **Os sanitizers acharam uma leitura de 1 byte fora do arquivo** (um dicionário truncado logo depois de uma letra); foi corrigida na C++. O Java tem a mesma checagem faltando, mas lá a leitura fora do buffer lança `IndexOutOfBoundsException`, que `MrFuzzy.afterWords` engole.

## O que mudou no app
- **`MrNative`** (novo, Java → smali): carga (`System.loadLibrary("mrengine")` dentro de `try`), versão do contrato, `init` (custos e tabelas), regras (reenviadas quando o `MrRules` muda), `search`, `triOpen/triFind`. `-Dmr.native=off` ou `MrNative.sForceJava` desligam, para teste.
- **`MrFuzzy.search`**: depois de preparar a digitação e as teclas vizinhas, tenta `searchNative()`; se devolver `false`, segue o código de antes. `resultCost()` novo (testes).
- **`MrTrigram`**: `use()` tenta abrir o arquivo na lib (uma abertura por vez, descartando carga velha); se não abrir, o carregamento Java de antes. `find()` usa a lib quando o arquivo está nela.
- **`MrPacksActivity`**: linha "Motor de sugestões" (Nativo (C++) / Java (biblioteca nativa não encontrada)); 3 textos novos em pt-BR, en e es.
- **Testes novos**: `NativeParity`, `NativeDump` e `TriDump` (e2e, precisam da lib de PC) e `NativeFallbackTest` (no `run_java_tests.sh`, roda **sem** a lib: 15 verificações de que a correção e os trigramas seguem pelo Java).
- Versão 1.77.0 (`versionCode` 1077000). `docs/motor-nativo.md` explica como colocar a lib no app; `docs/melhorias-motor.md` e `docs/tools/e2e/LEIA-ME.md` atualizados.
- **Não mudou**: nenhum arquivo de dicionário, nenhum workflow do app, nenhum resultado de sugestão.

## Validação (rodado aqui)
- `check_version.py`, `check_java_smali.sh` (em dia), `smali_regcheck.py` (fontes e smali decodificado: 0 problemas), `res_check.py`, `mres_check.py`, `check_reset_keys.py`, `check_catalog_url.py`, `test_make_catalog.py` (19), `publish_test/run.sh` (24).
- `run_java_tests.sh` com o jar do APK: AuthorTest (12), RecorrectTest (55), RecentTest (30), NativeFallbackTest (15), EsTest (23).
- Montagem **temporária** (não entregue): `apktool b` sem erro e `verify_dex.sh` sem erro.
- No repositório `mr-engine`: `mr_test` (paridade, estragados, bordas), `JniSmoke` (ponte JNI), ASan + UBSan.

## Não testado
- **Em aparelho Android**: a carga da lib pelo ART, o `RegisterNatives` no aparelho, o desempenho real e a primeira digitação depois da carga.
- **A compilação com o NDK** (3 ABIs): só acontece no workflow do `mr-engine`, que ainda não rodou; aqui só compilei para o PC.
- O app **sem** a lib é igual à 1.76 (coberto pelo `NativeFallbackTest`); **com** a lib, a paridade vem do PC.

## Testes Android necessários
1. APK **sem** `libmrengine.so`: digitar normalmente; Configurações → Sugestões e dicionários mostra "Java (biblioteca nativa não encontrada)". Tudo como na 1.76.
2. APK **com** a lib (copiada de `lib/<abi>/`): a mesma tela mostra "Nativo (C++)". Digitar erros ("vda", "sepre", "durate", "agoa", "porisso") e conferir que as sugestões são as da 1.76.
3. Previsão depois do espaço (usa os trigramas): trocar de idioma (pt-BR, en, es) algumas vezes e conferir que a previsão continua certa.
4. Instalar um dicionário novo / atualizar um pacote pela tela e voltar a digitar (a lib reabre o `trigrams.bin`).
5. Usar o teclado alguns minutos em apps diferentes; qualquer queda do teclado com a lib presente é erro desta versão (apague a lib para voltar ao Java e me avise).
