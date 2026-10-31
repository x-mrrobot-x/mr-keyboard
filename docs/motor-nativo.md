# Motor nativo (1.77, etapa 1)

A busca de correção (`MrFuzzy`) e a consulta de trigramas (`MrTrigram`) podem rodar em C++ na `libmrengine.so`. O código
dela vive no repositório **`mr-engine`**, separado deste (workflows próprios; nada aqui muda para compilá-la).

## Como o app usa
- `MrNative` (Java) carrega a lib uma vez, em segundo plano, confere o contrato (`ENGINE_VERSION`) e entrega os custos de `MrFuzzy`,
  as tabelas de maiúscula/minúscula/sem acento e as regras do idioma (`rules.txt`) que já estão carregados. A **fonte da verdade
  continua no Java**; a lib não tem constante própria.
- `MrFuzzy.search` e `MrTrigram.find` perguntam à lib; se ela não estiver lá, não carregou, recusou a consulta ou ainda está carregando,
  seguem pelo código Java de antes. O resultado é o mesmo nos dois caminhos (teste de paridade).
- Configurações → Sugestões e dicionários mostra **Motor de sugestões: Nativo (C++)** ou **Java (biblioteca nativa não encontrada)**.

## Colocar a lib no app
1. No repositório `mr-engine`, rode o workflow **Mr Engine - lib nativa** e baixe o artifact `libmrengine` (README do `mr-engine`, passo 1 a 3).
2. Extraia na raiz deste projeto: cria `lib/<abi>/libmrengine.so`, `mrengine-info.txt` e `mrengine-src.sha256`.
3. Faça o commit. O workflow do APK já empacota tudo que está em `lib/`.

Sem a lib o app funciona igual à 1.76. Para voltar atrás, apague os três `libmrengine.so`.

## Quando mexer no motor
- Mudar um **custo** ou uma regra de idioma em `MrFuzzy.java`/`rules.txt`: só o Java; a lib recebe os valores novos sozinha.
- Mudar o **algoritmo** de `MrFuzzy.search/walk/split` ou de `MrTrigram`: porte a mudança para `src/mr_fuzzy.cpp`/`mr_tri.cpp` do `mr-engine`,
  rode `docs/tools/e2e/NativeParity.java` (tem de dar 0 diferenças), regenere os arquivos de ouro e suba `kEngineVersion` e `ENGINE_VERSION`.
- Mudar a **assinatura** de um `native` de `MrNative`: mude `src/mr_jni.cpp` e `test/java/.../MrNative.java` do `mr-engine` e suba a versão do contrato.
