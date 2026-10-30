# Plano: lib nativa nova e o que vem depois da 1.60

Tudo continua 100% offline. Cada fase gera uma versão que pode ser instalada e testada sozinha.

## Fase 0 — Repositório e CI (você, uma vez)
1. Criar um repositório **privado** no GitHub e subir o conteúdo do zip da 1.60 na raiz (`apktool.yml`, `smali/`, `res/`, `lib/`, `native/`, `docs/`, `.github/`).
2. Arquivos grandes (corpus Leipzig, Tatoeba) não vão no git: subir em *Releases* do próprio repositório, se um dia o CI for gerar o dicionário.
3. Em *Actions*, rodar **"Mr Keyboard - nativo e APK"** (botão *Run workflow*). Ele usa o NDK do runner (ou instala o r27c), compila as 3 arquiteturas, confere e testa.
4. Opcional: para o CI assinar o APK, cadastrar em *Settings > Secrets* `KEYSTORE_B64`, `KEYSTORE_PASS`, `KEY_ALIAS`, `KEY_PASS` com a **mesma chave de hoje**. Sem isso, baixe o APK sem assinatura e assine como sempre.

## Fase 1 — Recompilar a lib atual com o NDK (feita na 1.61)
Código em `native/` (o mesmo `dictionary.cpp` do Hacker's Keyboard, Apache-2.0), com:
- classe JNI `com/mrkeyboard/app/BinaryDictionary` (como na lib de hoje);
- acento certo no x86 (`followingChar` sem sinal; antes "é" virava U+FFE9);
- alinhamento de 16 KB, exigido por aparelhos com Android 15+ que usam páginas de 16 KB (a lib de hoje foi feita em 2018 com alinhamento de 4 KB);
- teste no PC no próprio CI (`native/test`).

Passos: rodar o workflow → baixar `libs-nativas` → extrair na raiz do projeto (atualiza `lib/` e `native-src.sha256`) → montar e testar. Desde a 1.66 o APK é montado por outro workflow (`mr-apk.yml`), com as libs de `lib/`; ver `revisao-ci-workflows.md`. Nada muda no comportamento; serve para provar que o caminho do NDK funciona.

## Fase 2 — Melhorias rápidas em Java/smali (feita na 1.62, ver `revisao-1.6.2.md`)
- tirar siglas sem uso (FHM, RBN) que atrapalham palavras curtas;
- reservar um espaço da faixa para a correção ("prota" → porta);
- previsão no início de frase (Eu, Oi, Bom...);
- aprendizado mais rápido e com esquecimento;
- misturar o Tatoeba (conversa) às notícias, com peso maior, e medir num teste de conversa.

## Fase 3 — Motor nativo novo `libmrdict` (o "mais avançado" que vale a pena)
Código próprio em C++ dentro de `native/`, carregado por uma classe nova (`MrNative`). Se a lib não carregar, a camada Java da 1.60 continua funcionando.
1. **Formato novo do dicionário** (gerado pelos scripts de `docs/tools`): endereços de 32 bits (acaba o limite de 4 MB), tabela de palavras + trie, listas de continuações ordenadas, probabilidade em 8 bits.
2. **Previsão olhando as duas palavras anteriores**: a 1.62 já faz em Java (`MrTrigram`); no motor nativo os trigramas passam para o mesmo arquivo do dicionário, sem o limite de tamanho.
3. **Correção em C++**: a busca do `MrFuzzy` portada, com mais folga de tempo, e **modelo de toque pela posição do dedo** (x, y de cada toque, guardados no `LatinIME.onKey`) em vez de só "tecla vizinha".
4. **Testes**: o mesmo CMake compila no PC; o CI roda testes de precisão (as frases separadas do Leipzig e do Tatoeba) e de tempo, e falha se piorar.
5. **Integração em smali**: `Suggest` chama `MrNative` quando disponível; nada no fluxo de aprendizado e privacidade muda.

## Fase 4 — Dados
- Leipzig News 2024 1M (já usado) + News 2023 1M, só fontes brasileiras.
- Tatoeba (CC BY 2.0 FR) com peso maior, para o jeito de conversa.
- Tudo com crédito no `notice_main_pt.txt`.

## Fase 5 — Modelo neural (opcional, só se a Fase 3 deixar a desejar)
Um modelo de linguagem pequeno rodando no aparelho (runtime LiteRT/TFLite, alguns MB por arquitetura). Com o texto de licença livre que temos (cerca de 20 milhões de palavras), a expectativa é ganho pequeno sobre um bom modelo de trigramas mais o aprendizado do usuário; precisa ser medido antes de pesar o APK.

## Ordem sugerida
Fase 0 → 1 (validar o NDK no aparelho) → 2 → 3 → 4. Cada fase com revisão em `docs/revisao-X.md` e roteiro de testes no aparelho.
