# CI — libmrengine.so no APK (motor nativo, etapa 1)

Sem mudança de versão (continua 1.77.0), como as outras revisões `revisao-ci-*`: o código Java do motor nativo já entrou na 1.77.0; esta mudança só traz o binário que ele usa.

## Pedido
Testar a 1.77.0 no aparelho com a biblioteca do `mr-engine` dentro do APK. A lib foi gerada pelo workflow do `mr-engine` e copiada para `lib/`.

## O que mudou
- `lib/arm64-v8a/libmrengine.so`, `lib/armeabi-v7a/libmrengine.so` e `lib/x86/libmrengine.so`, **ao lado** da `libjni_pckeyboard.so` (que continua lendo o dicionário principal e não foi tocada).
- `mrengine-info.txt` e `mrengine-src.sha256`: de qual código e de qual commit do `mr-engine` os binários saíram (contrato 1, código `de68890a…`, commit `6eb5fedc…`).
- Nenhum arquivo de código, recurso, workflow ou dicionário mudou. `native/` e `native-src.sha256` continuam valendo para a `libjni_pckeyboard.so`.

## Conferido (aqui)
- O hash do código gravado em `mrengine-src.sha256` é o do `CMakeLists.txt` + `src/` que entreguei no zip do `mr-engine`.
- Nas 3 ABIs: alinhamento de 16 KB (`0x4000`), dependem só de `libc`, `libm` e `libdl` (sem `libc++_shared.so`), só `JNI_OnLoad` exportado, sem símbolos de depuração, assinatura de `nSearch` registrada igual à do `MrNative`.
- Montagem **temporária** (não entregue): `apktool b` sem erro; o APK traz as 6 libs.

## Por que sem versão nova
Um push com versão nova publica a Release sozinho (se houver chave nos secrets). Esta lib ainda não foi vista em aparelho; por isso este commit mantém a 1.77.0. Se a 1.77.0 já tiver sido publicada, o push **não publica nada** e o APK para teste fica em Actions → execução → Artifacts → `apk`. Depois de validar no aparelho, a lib chega aos usuários numa versão nova (1.77.1), com notas.

## Voltar atrás
Apagar os três `libmrengine.so` (e os dois `mrengine-*`): o app volta ao Java sozinho.

## Testes Android necessários
Os de `docs/revisao-1.7.7.md` (seção "Testes Android necessários"), em especial: a tela Sugestões e dicionários mostrando "Nativo (C++)" e as correções "vda", "sepre", "durate", "agoa", "porisso" iguais às da 1.76.
