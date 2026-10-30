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
- **Sugestões de palavras** (português do Brasil por enquanto; inglês está planejado):
  - o dicionário é baixado em *Configurações → Dicionários*, por isso o app em si tem só cerca de 1 MB;
  - correção de erros de digitação e previsão da próxima palavra;
  - aprende as palavras que você usa, nunca em campos de senha ou anônimos;
  - tudo roda no aparelho;
  - vem desligado: ligue *Mostrar sugestões* nas configurações.
- **Temas:** Mr Keyboard Neon, Dark Tech (suave e em relevo), Midnight Steel, Material Dark/Light, Stone, Gingerbread e outros.
- **Gestos e teclas:** deslizar para cima, baixo, esquerda e direita e as teclas de volume podem executar ações do teclado.
- **Configurações em português ou inglês.**

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
  - **Traduzir** envia ao Google Tradutor (`translate.googleapis.com`) o texto que você digita no campo de tradução. Só esse texto, e só quando você usa.
  - **Dicionários** (*Configurações → Dicionários*): o app só se conecta quando você toca em *Procurar atualizações*, *Baixar* ou *Atualizar*, e só baixa arquivos dos [releases](../../releases/tag/dicionarios) deste repositório. Cada arquivo é conferido com uma lista assinada com a chave do próprio app antes de ser usado.

| Permissão | Para quê |
|---|---|
| Internet | Traduzir e baixar dicionários |
| Estado da rede | Ver se você está no Wi-Fi antes de baixar um dicionário |
| Notificações | Notificação fixa opcional para abrir o teclado |
| Armazenamento / Acesso a todos os arquivos | Anexos: listar e enviar suas fotos, vídeos e arquivos |
| Dicionário do usuário | Ler e adicionar palavras ao dicionário pessoal do Android |
| Vibração | Vibrar ao tocar nas teclas |

## Instalação
1. Baixe o APK em [Releases](../../releases) e instale.
2. Abra o **Mr Keyboard** e toque em **Ativar teclado**. Ligue o Mr Keyboard na lista e aceite o aviso do sistema. O Android mostra esse aviso para qualquer teclado que não veio com o celular.
3. Toque em **Definir método de entrada** e escolha o Mr Keyboard.
4. Opcional: em **Idiomas de entrada**, escolha os layouts. Deslize a barra de espaço para os lados para alternar entre eles.
5. Para ter sugestões de palavras: nas configurações, abra **Dicionários**, baixe o do seu idioma e ligue **Mostrar sugestões**.

## Como compilar
Este repositório guarda o app como projeto do [apktool](https://apktool.org/) (código smali e recursos). Também tem:
- `native/`: o motor de dicionário em C++ (CMake);
- `docs/`: anotações de cada versão e as ferramentas usadas para gerar o dicionário e as classes Java.

**Pelo GitHub Actions** (*Actions → Mr Keyboard - nativo e APK → Run workflow*), o workflow:
1. compila a lib nativa para arm64-v8a, armeabi-v7a e x86 com o NDK 27;
2. gera o APK com o apktool 2.11.1;
3. assina, se existirem os secrets `KEYSTORE_B64`, `KEYSTORE_PASS`, `KEY_ALIAS` e `KEY_PASS`.

Sem os secrets (num fork, por exemplo), sai um APK sem assinatura no artefato `apk`.

**Publicar (para quem mantém o projeto):**
- **App:** rode o mesmo workflow com *publicar* marcado. O APK assinado vai para [Releases](../../releases) com a tag do `versionName` do `apktool.yml` (ex.: `v1.63.0`).
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
- Dados do dicionário em português:
  - lista pt_BR do AOSP (Apache 2.0);
  - [Leipzig Corpora Collection](https://wortschatz-leipzig.de/) (CC BY 4.0);
  - [Tatoeba](https://tatoeba.org/) (CC BY 2.0 FR).

  Créditos completos em `dicts/pt-BR/NOTICE.txt`.
