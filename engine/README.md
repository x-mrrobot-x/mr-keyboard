# engine/ — motor nativo do Mr Keyboard (etapa 1)

A busca de correção (`MrFuzzy.java`) e a consulta de trigramas (`MrTrigram.java`) do app em C++, entregues como
**`libmrengine.so`**. Lê os arquivos de hoje (`dicts/<idioma>/main.dict`, `trigrams.bin`), **sem formato novo**. Se a lib não
estiver no APK, não carregar ou tiver outra versão de contrato, o app segue pelo Java, sem perder função. O resultado do C++ é
**idêntico** ao do Java (palavras, ordem, pontuação, custo e nós visitados). Visão geral e fluxo: `docs/native-engine.md`.

O leitor do dicionário (`libjni_pckeyboard.so`) fica em `native/` e é outro projeto de CMake; as duas libs saem do mesmo workflow
(`.github/workflows/mr-native.yml`).

## Estrutura
| Caminho | O que é |
|---|---|
| `src/mr_engine.h` | contrato: constantes, tabelas, `Fuzzy`, `TriStore`, `kEngineVersion` |
| `src/mr_fuzzy.cpp` | porta de `MrFuzzy.java` (passadas, programação dinâmica em faixa, divisão de palavras coladas) |
| `src/mr_tri.cpp` | porta de `MrTrigram.java` (MRT1) e conversões UTF-8 |
| `src/mr_jni.cpp` | `JNI_OnLoad` + `RegisterNatives` de `com.mrkeyboard.app.MrNative` |
| `test/mr_test.cpp` | busca no dicionário de verdade, independência de ordem, arquivos estragados, bordas (sem o Java) |
| `test/mr_bench.cpp` | medição |
| `test/java/…` | `JniSmoke` (ponte JNI, argumentos ruins) e a cópia das declarações nativas de `MrNative` |
| `tools/gen_parity_queries.py` | consultas para a paridade, tiradas do próprio `dicts/` |

## Rodar no PC
```bash
cmake -S engine -B build/engine -DCMAKE_BUILD_TYPE=Release -DMR_HOST_TEST=ON
cmake --build build/engine -j4
./build/engine/mr_test dicts 100       # busca, trigramas, arquivos estragados, bordas (dicionários de dicts/)
./build/engine/mr_bench dicts 20       # velocidade

cmake -S engine -B build/san -DCMAKE_BUILD_TYPE=RelWithDebInfo -DMR_HOST_TEST=ON -DMR_SANITIZE=ON
cmake --build build/san -j4 && ./build/san/mr_test dicts 200            # ASan + UBSan

javac -d build/jc engine/test/java/com/mrkeyboard/app/*.java
java -cp build/jc com.mrkeyboard.app.JniSmoke build/engine/libmrengine.so dicts    # ponte JNI sem o app

bash docs/tools/e2e/run_native_parity.sh      # Java x C++ ao vivo, 3 idiomas (monta o APK temporário; veja o cabeçalho do script)
```


## Compilar e colocar no app
Mexeu em `engine/` (ou em `native/`)? O workflow **Mr Keyboard - native lib** roda no push (ou à mão: Actions → Run workflow). Ele
testa no PC e compila as duas libs para arm64-v8a, armeabi-v7a e x86 com o NDK 27. Baixe o artifact **`native-libs`**, extraia na raiz do
projeto (mesclando com `lib/`) e faça o commit de `lib/`, `native-src.sha256`, `mrengine-src.sha256` e `mrengine-info.txt`. O workflow do
APK compara os hashes com o código atual e não publica se a `lib/` estiver velha.

## Contrato com o app
- A **fonte da verdade** dos custos (`C_PROX_1`, `C_DEL`…), das regras (`rules.txt`), de `Character.toLowerCase`/`isUpperCase` e de
  `MrText.base` é o **Java do app**. Ele entrega tudo à lib na carga (`MrNative.init`) e quando o pacote de idioma muda
  (`MrNative.pushRules`). A lib não tem constante de ajuste própria. Mudar um custo em `MrFuzzy.java` **não exige** recompilar a lib;
  mudar o **algoritmo** (uma passada nova, uma regra nova no `walk`) exige portar para `src/mr_fuzzy.cpp`, rodar a paridade e subir
  `kEngineVersion`.
- **`kEngineVersion`** (`src/mr_engine.h`) tem de ser igual a `MrNative.ENGINE_VERSION`. Sobe quando muda a assinatura de uma função
  nativa, a ordem dos custos ou o significado de uma tabela. Versão diferente = o app não usa a lib.
- A pontuação do Java usa `Math.pow(2.0, -custo/25.0)`; o Java entrega essa tabela calculada por ele, então o arredondamento é o mesmo
  em qualquer aparelho.
- Os trigramas são lidos **inteiros para a memória** (uns 3 MB) e só os índices ficam à parte. Não usa `mmap` de propósito: se um pacote
  novo trocasse o arquivo no lugar, ler uma página mapeada derrubaria o app (SIGBUS).
- **Nunca confiar nos arquivos**: toda leitura é conferida contra o tamanho; as buscas recursivas têm teto de nós (`MrFuzzy.NODE_BUDGET`,
  igual no Java), porque num arquivo estragado cresceriam exponencialmente.

## O que é testado
| O quê | Como | Onde |
|---|---|---|
| Resultado igual ao do Java | ≈ 2.500 erros por idioma tirados do próprio dicionário, com a lista final de `Suggest` e 24 mil pares de trigramas, pela JNI | `NativeParity`, no CI (mr-checks.yml) |
| Busca no dicionário de verdade e independência de ordem | correções óbvias; o resultado de uma consulta não muda por causa das anteriores | `mr_test`, no CI |
| Dicionário/trigramas estragados | cortados, bytes trocados, lixo, com ASan + UBSan: sem queda, sem leitura fora do arquivo, sem travar | `mr_test`, no CI |
| Argumentos ruins na JNI | buffer não direto, arrays curtos, arquivo inexistente | `JniSmoke`, no CI |

Validado em aparelho (1.77): carga da lib, correção e previsão. Velocidade e memória no aparelho não foram medidas.
