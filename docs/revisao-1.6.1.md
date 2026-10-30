# 1.6.1 — Lib nativa recompilada com o NDK (GitHub Actions)

## Pedido
Fase 1 do `docs/plano-nativo.md`: provar o caminho do NDK recompilando a lib do dicionário no GitHub Actions, sem mudar o comportamento.

## O que mudou
| Item | 1.6.0 | 1.6.1 |
|---|---|---|
| `lib/*/libjni_pckeyboard.so` | compilada em 2018 (clang 7), alinhamento de 4 KB | compilada pelo workflow `.github/workflows/mr-native.yml` (NDK r27c, código em `native/`), alinhamento de 16 KB |
| Acento nos bigramas no x86 | errado na lib ("é" virava U+FFE9), consertado em Java (`MrText.fixNative`) | certo na própria lib (`followingChar` sem sinal); o conserto em Java fica como segurança |
| Versão | 1060000 / v1.60.0 | 1061000 / v1.61.0 |

Tamanhos: arm64-v8a 272 KB (era 219 KB), armeabi-v7a 161 KB (108 KB), x86 240 KB (207 KB). A diferença vem do preenchimento para 16 KB.

## Como foi feito
- Código: `native/src` = `dictionary.cpp`, `char_utils.cpp` e a camada JNI do Hacker's Keyboard (Apache-2.0, `native/LICENSE-Apache-2.0`), com a classe `com/mrkeyboard/app/BinaryDictionary` e o `followingChar` sem sinal. `native/CMakeLists.txt` compila para Android (NDK) e para o PC (teste).
- O workflow compila as 3 arquiteturas, confere o alinhamento, o `JNI_OnLoad` e o nome da classe, roda `dict_test` no PC com o dicionário do projeto e monta o APK.

## Validação
- Execução nº 1 do workflow concluída sem erro (57 s).
- Conferi as 3 libs baixadas do Artifact: arquitetura certa (aarch64, ARM EABI5, i386), segmentos LOAD alinhados em 0x4000, só dependem de `liblog`, `libm`, `libdl` e `libc` (o C++ vai embutido), `JNI_OnLoad` exportado, nome da classe e as 5 assinaturas JNI iguais às do smali.
- O mesmo código, compilado no PC, passou: palavras válidas, os bigramas exatos da amostra (também compilado com char com sinal, como no x86) e as consultas.
- **Não rodei a lib num aparelho** (o ambiente não tem Android).

## Testes Android necessários
1. Instalar por cima da 1.6.0 e abrir o teclado: sugestões e previsões como na 1.6.0. Se o teclado abrir sem nenhuma sugestão, a lib não carregou: procurar "Could not load native library jni_pckeyboard" no logcat.
2. Repetir os testes 2 a 5 da `revisao-1.6.0.md`.
3. Se tiver aparelho com Android 15+ e páginas de 16 KB (ou o emulador com imagem de 16 KB): o teclado precisa abrir normalmente.
4. Aparelho ou emulador x86: previsões com acento (depois de "não ").
