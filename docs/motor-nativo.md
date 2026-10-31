# Bibliotecas nativas e motor nativo (1.77)

O app usa duas bibliotecas nativas, as duas com o código **neste repositório** e geradas pelo mesmo workflow (`mr-native.yml`, NDK):

| Biblioteca | Código | O que faz |
|---|---|---|
| `libjni_pckeyboard.so` | `native/` | leitor do dicionário (`BinaryDictionary`): completar palavras, palavra válida, bigramas. Obrigatória. Base: Hacker's Keyboard / LatinIME (Apache-2.0) |
| `libmrengine.so` | `engine/` | motor nativo, etapa 1 (1.77): a busca de correção (`MrFuzzy`) e a consulta de trigramas (`MrTrigram`) em C++. Opcional: sem ela o app usa o código Java |

Os binários prontos ficam em `lib/<abi>/`. Detalhes do motor: `engine/README.md`.

## Como o app usa o motor nativo
- `MrNative` (Java) carrega a `libmrengine.so` uma vez, em segundo plano, confere o contrato (`ENGINE_VERSION`) e entrega os custos de `MrFuzzy`,
  as tabelas de maiúscula/minúscula/sem acento e as regras do idioma (`rules.txt`) que já estão carregados. A **fonte da verdade
  continua no Java**; a lib não tem constante própria.
- `MrFuzzy.search` e `MrTrigram.find` perguntam à lib; se ela não estiver lá, não carregou, recusou a consulta ou ainda está carregando,
  seguem pelo código Java de antes. O resultado é o mesmo nos dois caminhos (teste de paridade).
- Configurações → Sugestões e dicionários mostra **Motor de sugestões: Nativo (C++)** ou **Java (biblioteca nativa não encontrada)**.

## Mudou `native/` ou `engine/`: gerar as libs
1. Faça o push. O workflow **Mr Keyboard - lib nativa** roda sozinho (ou à mão: Actions → Run workflow). Ele testa no PC (`dict_test`, `mr_test`, `JniSmoke`, ASan/UBSan) e compila as duas libs para arm64-v8a, armeabi-v7a e x86.
2. Baixe o artifact `libs-nativas` e extraia na raiz do projeto, **mesclando** com o que já existe. Ele grava `lib/<abi>/libjni_pckeyboard.so` e `libmrengine.so`, `native-src.sha256` e `mrengine-src.sha256` (de qual código cada lib saiu) e `mrengine-info.txt` (contrato, commit e SHA-256 de cada `.so`).
3. Faça o commit.

O passo **Conferir se lib/ foi compilada do native/ e do engine/ atuais** do *Mr Keyboard - APK* recalcula os dois hashes e confere que as 6 libs existem; se algo não bater, avisa e **não publica** (com *publicar* marcado, dá erro). A conta do `native/` é sobre `native/CMakeLists.txt` + `native/src`; a do motor é feita de dentro de `engine/` (`CMakeLists.txt` + `src`). Testes e dados não entram.

## Paridade Java × C++
O *Mr Keyboard - verificações* roda `docs/tools/e2e/run_native_parity.sh`: monta o APK, compila as duas libs de PC e roda o `NativeParity` nos 3 idiomas, com as consultas tiradas do próprio `dicts/`. A busca, a lista final de sugestões e os trigramas têm de ser **idênticos** pelo Java e pela lib (pela JNI). Isso também vale para mudanças em `dicts/` (rules, dicionários, trigramas): a paridade é refeita sobre os arquivos novos, sem nada a regenerar.

## Quando mexer no motor
- Mudar um **custo** ou uma regra de idioma em `MrFuzzy.java`/`rules.txt`: só o Java; a lib recebe os valores novos sozinha.
- Mudar o **algoritmo** de `MrFuzzy.search/walk/split` ou de `MrTrigram`: porte a mudança para `engine/src/mr_fuzzy.cpp`/`mr_tri.cpp`, rode `run_native_parity.sh` (tem de dar 0 diferenças), gere as libs (acima) e suba `kEngineVersion` (C++) e `ENGINE_VERSION` (Java) se o contrato mudou.
- Mudar a **assinatura** de um `native` de `MrNative`: mude `engine/src/mr_jni.cpp` e `engine/test/java/.../MrNative.java` e suba a versão do contrato.

## Voltar atrás
Apagar os três `libmrengine.so` (e publicar uma versão nova): o app volta ao Java sozinho, como na 1.76. Sem a `libjni_pckeyboard.so` o teclado não lê o dicionário.
