# Mr Keyboard

[English](README.md) · **Português**

Teclado Android para quem usa muito o celular, baseado no [Hacker's Keyboard](https://github.com/klausw/hackerskeyboard). Tem teclas completas de PC, folhas de teclas extras que você pode editar, comandos para o [Tasker](https://tasker.joaoapps.com/) e sugestões de palavras offline.

Precisa de Android 8.0 ou mais novo.

## Recursos
- **Teclado completo:** Ctrl, Alt, Esc, Tab, setas, Home/End, PgUp/PgDn e teclas de função, em layout compacto ou completo (com configurações separadas para retrato e paisagem).
- **Folhas:** páginas extras de teclas, abertas pelo próprio teclado: **123**, **TSK** (Tasker), **HTML**, **FRS** (frases), navegação e teclado numérico. Dá para editar as folhas e criar as suas em *Configurações → Folhas*.
- **Comandos do Tasker:** uma tecla pode disparar uma tarefa do Tasker em vez de digitar (veja abaixo).
- **Barra de ferramentas** acima das teclas:
  - **Sugestões:** sugestões e correções de palavras;
  - **Traduzir:** traduz o texto antes de enviar;
  - **Anexos:** fotos, vídeos e arquivos, enviados para o app em que você está digitando;
  - **Emotes.**
- **Sugestões de palavras** em português do Brasil, inglês americano e espanhol (um dicionário por idioma):
  - os dicionários são baixados em *Configurações → Sugestões e dicionários*, por isso o app em si tem só cerca de 1 MB. Cada idioma baixado entra no teclado: deslize a barra de espaço para os lados para alternar entre eles;
  - correção de erros de digitação e previsão da próxima palavra;
  - aprende as palavras que você usa, nunca em campos de senha ou anônimos;
  - tudo roda no aparelho;
  - vem desligado: ligue *Mostrar sugestões* na mesma tela.
- **Temas:** Mr Keyboard Neon, Dark Tech (suave e em relevo) e Midnight Steel. O espaçamento e o arredondamento das teclas valem em todos os temas.
- **Gestos e teclas:** deslizar para cima, baixo, esquerda e direita e as teclas de volume podem executar ações do teclado.
- **App em português, inglês ou espanhol:** segue o idioma do sistema, ou escolha em *Configurações → Geral → Idioma do app*.

## Integração com o Tasker
Toda tecla cujo texto de saída comece com `tskcmd:` envia um comando em vez de digitar. A primeira fileira da folha **TSK** já traz algumas, e você pode criar as suas no editor de folhas (ex.: texto de saída `tskcmd:luzes_on`).

No Tasker:
1. Crie um perfil: *Evento → Sistema → Intent Received* (o nome pode aparecer traduzido no seu Tasker).
2. Em *Ação*, coloque `com.mrkeyboard.app.TASKER_CMD`.
3. Na tarefa, a variável `%cmd` traz o comando (no exemplo, `luzes_on`).

O comando vai num broadcast que outros apps também podem receber, então não coloque senhas nem dados pessoais nele.

## Privacidade
- O que você digita fica no aparelho. Sugestões, correções e palavras aprendidas são processadas e guardadas só no celular. Não há anúncios, análise de uso nem Google Play Services.
- O app só usa a internet quando você pede:
  - **Traduzir** envia ao Google Tradutor (`translate.googleapis.com`) o texto que você digita no campo de tradução. Só esse texto, e só quando você usa. O próprio campo avisa ("Digite para traduzir com o Google"), e o app mostra um aviso na primeira vez que o painel abre.
  - **Dicionários** (*Configurações → Sugestões e dicionários*): o app só se conecta quando você toca em *Procurar atualizações*, *Baixar*, *Atualizar* ou em um idioma que ainda não foi baixado, e só baixa arquivos dos [releases](../../releases/tag/dicionarios) deste repositório. Cada arquivo é conferido com uma lista assinada com a chave do próprio app antes de ser usado.

| Permissão | Para quê |
|---|---|
| Internet | Traduzir e baixar dicionários |
| Notificações | Notificação fixa opcional para abrir o teclado |
| Armazenamento / Acesso a todos os arquivos | Anexos: listar e enviar suas fotos, vídeos e arquivos |
| Dicionário do usuário | Ler e adicionar palavras ao dicionário pessoal do Android |
| Vibração | Vibrar ao tocar nas teclas |

## Instalação
1. Baixe o APK na [última versão](../../releases/latest) (link direto: [MrKeyboard.apk](../../releases/latest/download/MrKeyboard.apk)) e instale.
2. Abra o **Mr Keyboard** e toque em **Ativar teclado**. Ligue o Mr Keyboard na lista e aceite o aviso do sistema. O Android mostra esse aviso para qualquer teclado que não veio com o celular.
3. Toque em **Definir método de entrada** e escolha o Mr Keyboard.
4. Para ter sugestões de palavras (opcional): nas configurações, abra **Sugestões e dicionários**, toque no seu idioma para baixar o dicionário e ligue **Mostrar sugestões**. Baixando mais de um idioma, deslize a barra de espaço para os lados para alternar entre eles.

## Como compilar
Este repositório guarda o app como projeto do [apktool](https://apktool.org/) (código smali e recursos). Também tem:
- `native/`: o motor de dicionário em C++ (CMake);
- `docs/`: anotações de cada versão e as ferramentas usadas para gerar o dicionário e as classes Java.

**Pelo GitHub Actions** são três workflows:
- *Mr Keyboard - APK* roda a cada push que muda o app (`smali/`, `res/`, `lib/`, `apktool.yml`). Gera o APK com o apktool 2.11.1 usando as bibliotecas que já estão em `lib/` e assina, se existirem os secrets `KEYSTORE_B64`, `KEYSTORE_PASS`, `KEY_ALIAS` e `KEY_PASS`. Sem os secrets (num fork, por exemplo), sai um APK sem assinatura no artefato `apk`.
- *Mr Keyboard - lib nativa* roda só quando `native/` muda (ou à mão). Compila a biblioteca para arm64-v8a, armeabi-v7a e x86 com o NDK 27 e roda o teste no PC. Extraia o artefato `libs-nativas` na raiz do projeto e faça o commit de `lib/` e `native-src.sha256`. O workflow do APK compara esse hash com o `native/` atual e não deixa publicar se a `lib/` estiver desatualizada.
- *Mr Keyboard - verificações* roda nos pushes na `main` e nos pull requests que mudam o app. Confere a versão e as notas, os recursos (inclusive os textos em espanhol), a lista de chaves do "Restaurar padrões", os registradores do smali e se o smali gerado da camada Java está em dia, monta o app para verificar o dex e roda os testes de PC. Os mesmos scripts estão em `docs/tools/` e rodam também no seu computador.

**Publicar (para quem mantém o projeto):**
- **App:** rode *Mr Keyboard - APK* com *publicar* marcado. O APK assinado vai para [Releases](../../releases) com a tag do `versionName` do `apktool.yml` (ex.: `v1.66.0`), como `MrKeyboard-v1.66.0.apk` e como `MrKeyboard.apk` (nome fixo, usado pelo link direto acima).
- **Dicionários:** os pacotes ficam em `dicts/<idioma>/` (o `pack.json` lista os arquivos). Depois de mudar algo, aumente `version` no `pack.json` e rode *Mr Keyboard - dicionários*. Ele publica o pacote e um `catalogo.json` assinado no Release `dicionarios`. O catálogo é assinado com a própria chave do app, e o app só aceita catálogo assinado com a chave com que foi instalado.

**No computador:**
```sh
apktool b . -o MrKeyboard-unsigned.apk
zipalign -p -f 4 MrKeyboard-unsigned.apk aligned.apk
apksigner sign --ks sua-chave.jks --out MrKeyboard.apk aligned.apk
```

## Créditos e licenças
O Mr Keyboard está sob a [Apache License 2.0](LICENSE).
- [Hacker's Keyboard](https://github.com/klausw/hackerskeyboard), de Klaus Weidner, e o LatinIME do Android Open Source Project, em que o Mr Keyboard se baseia, também estão sob a Apache License 2.0.
- Dados dos dicionários (créditos completos em `dicts/<idioma>/NOTICE.txt`):
  - listas pt_BR, en_US e es do AOSP (Apache 2.0);
  - [Leipzig Corpora Collection](https://wortschatz-leipzig.de/) (CC BY 4.0);
  - [Tatoeba](https://tatoeba.org/) (CC BY 2.0 FR).
