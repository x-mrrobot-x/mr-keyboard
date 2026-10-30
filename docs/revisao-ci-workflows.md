# Revisão: workflows separados (lib nativa × APK) e link de download

## Pedido
- O workflow que roda a cada push ainda compilava a lib com o NDK. Separar a compilação nativa do resto.
- Conferir se a publicação do APK assinado em Releases serve de referência de download na documentação.

## O que mudou
| Arquivo | Mudança |
|---|---|
| `.github/workflows/mr-native.yml` | agora é só a lib nativa (NDK, conferência, teste no PC). Roda quando `native/**` muda ou à mão. Não monta mais o APK |
| `.github/workflows/mr-apk.yml` | novo. Monta, assina e publica o APK usando as libs que já estão em `lib/`. Sem NDK |
| `native-src.sha256` | novo. Hash do código (`native/CMakeLists.txt` e `native/src/`) de que a `lib/` foi compilada |
| `README.md`, `README.pt-BR.md` | link de download para a última versão e link direto `MrKeyboard.apk`; descrição dos dois workflows |
| `.github/workflows/mr-dicts.yml`, `docs/plano-nativo.md` | só os nomes dos arquivos citados |

Comportamento:
- push em `smali/`, `res/`, `assets/`, `lib/`, `apktool.yml`: só o *Mr Keyboard - APK* (sem compilar a lib nativa);
- push em `native/`: só o *Mr Keyboard - lib nativa*. Quando terminar, baixe o artefato `libs-nativas`, extraia **na raiz** do projeto (atualiza `lib/` e `native-src.sha256`) e faça o commit;
- mudanças em `dicts/` não disparam mais nada sozinhas (o APK não leva dicionário; os pacotes saem por *Mr Keyboard - dicionários*). O teste do `main.dict` no PC continua no workflow nativo, quando ele roda.

## Como foi feito
- **Conferência de lib velha.** Sem o NDK a cada push, a `lib/` do repositório passa a ser a verdade. Para ninguém lançar um APK com lib antiga depois de mexer em `native/`, os dois workflows calculam o mesmo hash dos arquivos que entram na compilação. O nativo grava em `native-src.sha256`; o do APK compara. Diferente: aviso na compilação normal, **erro** (nada publicado) com *publicar* marcado. Os arquivos de `native/test/` ficam fora do hash, porque não mudam a lib.
- **Link de download.** A Release do app é marcada como `latest` e a dos dicionários não, então `releases/latest` sempre cai na última versão do app. Como o nome do arquivo muda a cada versão (`MrKeyboard-v1.66.0.apk`), a publicação anexa também o mesmo arquivo como `MrKeyboard.apk`; o endereço `releases/latest/download/MrKeyboard.apk` não muda nunca e é o que o README usa.
- O `native-src.sha256` inicial foi calculado do `native/` atual. Pela data dos arquivos, só os de teste de `native/test/` são mais novos que as libs de `lib/`; os `.cpp`, os `.h` e o `CMakeLists.txt` não. Por isso assumi que as libs atuais correspondem ao código atual. Se houver dúvida, rode o workflow nativo uma vez e substitua `lib/` e `native-src.sha256` pelo resultado.

## Validação
- YAML dos três workflows lido sem erro; sintaxe de todos os trechos de shell conferida com `bash -n`.
- Conferência de lib simulada no PC: hash igual passa (normal e publicar); `native/src` alterado dá aviso na compilação normal e erro ao publicar; `native-src.sha256` ausente também bloqueia a publicação.
- Escolha das notas da Release para `1.66.0` dá `docs/revisao-1.6.6.md`.
- **Não testado no GitHub**: o repositório não estava acessível daqui. O que o Actions faz de verdade só aparece na primeira execução.

## Testes necessários (no GitHub)
1. Depois do push: *Actions* deve mostrar **dois** workflows disparados (o nativo e o do APK, porque os próprios arquivos de workflow mudaram). Nas execuções seguintes de `smali/` ou `res/`, só o do APK.
2. Na execução do APK, o passo *Conferir se lib/ foi compilada do native/ atual* deve dizer "lib/ confere com o native/ atual". Se der aviso, rode o workflow nativo, extraia o artefato na raiz e faça o commit de `lib/` e `native-src.sha256`.
3. *Mr Keyboard - APK → Run workflow* com *publicar* marcado: cria a Release `v1.66.0` com `MrKeyboard-v1.66.0.apk` e `MrKeyboard.apk`.
4. Abrir `https://github.com/x-mrrobot-x/mr-keyboard/releases/latest/download/MrKeyboard.apk`: deve baixar o APK. Conferir se a Release `dicionarios` continua sem a marca *Latest*.
