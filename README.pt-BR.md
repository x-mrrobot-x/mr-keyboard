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
  - **Editor de IA:** reescreve o texto selecionado ou o que está antes do cursor em um diálogo sobre o teclado; configure o serviço em *Configurações → Editor de IA*;
  - **Anexos:** fotos, vídeos e arquivos, enviados para o app em que você está digitando;
  - **Emotes.**
- **Sugestões de palavras** em português do Brasil, inglês americano e espanhol (um dicionário por idioma):
  - os dicionários são baixados em *Configurações → Sugestões e dicionários*, por isso o app em si tem só cerca de 1 MB. Cada idioma baixado entra no teclado: deslize a barra de espaço para os lados para alternar entre eles;
  - correção de erros de digitação e previsão da próxima palavra;
  - aprende as palavras que você usa, nunca em campos de senha ou anônimos;
  - sugere os nomes e as palavras que você acabou de escrever na mesma conversa (só na memória, apagados ao trocar de campo ou de app);
  - tudo roda no aparelho;
  - vem desligado: ligue *Mostrar sugestões* na mesma tela.
- **Temas:** Mr Keyboard Neon, Dark Tech (suave e em relevo), Midnight Steel e Cobalt Glass (translúcido com blur de fundo no Android 12+; fundo escuro semitransparente onde o blur não está disponível). O espaçamento e o arredondamento das teclas valem em todos os temas, e o arredondamento também vale no popup do toque longo, no balão de preview, na barra e nos painéis. O diálogo do Editor de IA sempre usa o tema das configurações.
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
  - **Editor de IA** envia somente o texto que você escolhe reescrever, e apenas ao serviço de IA que configurar. O app avisa na primeira abertura; nada é enviado até você tocar num estilo.
  - **Dicionários** (*Configurações → Sugestões e dicionários*): o app só se conecta quando você toca em *Procurar atualizações*, *Baixar*, *Atualizar* ou em um idioma que ainda não foi baixado, e só baixa arquivos da [release mais recente](../../releases/latest) deste repositório (o catálogo, `catalog.json`, e o zip de cada idioma, anexado à release em que aquele idioma mudou pela última vez). Cada arquivo é conferido com uma lista assinada com a chave do próprio app antes de ser usado.

| Permissão | Para quê |
|---|---|
| Internet | Traduzir e baixar dicionários |
| Notificações | Notificação fixa opcional para abrir o teclado |
| Armazenamento / Acesso a todos os arquivos | Anexos: listar e enviar suas fotos, vídeos e arquivos |
| Dicionário do usuário | Ler e adicionar palavras ao dicionário pessoal do Android |
| Vibração | Vibrar ao tocar nas teclas |

## Instalação
1. Baixe o APK (`mr-keyboard-v<versão>.apk`) na [última versão](../../releases/latest) e instale.
2. Abra o **Mr Keyboard** e toque em **Ativar teclado**. Ligue o Mr Keyboard na lista e aceite o aviso do sistema. O Android mostra esse aviso para qualquer teclado que não veio com o celular.
3. Toque em **Definir método de entrada** e escolha o Mr Keyboard.
4. Para ter sugestões de palavras (opcional): nas configurações, abra **Sugestões e dicionários**, toque no seu idioma para baixar o dicionário e ligue **Mostrar sugestões**. Baixando mais de um idioma, deslize a barra de espaço para os lados para alternar entre eles.

## Como compilar
Este repositório guarda o app como projeto do [apktool](https://apktool.org/) (código smali e recursos). Também tem:
- `native/`: o leitor de dicionário em C++, `libjni_pckeyboard.so` (CMake);
- `engine/`: o motor nativo de sugestões, `libmrengine.so` (busca de correção e previsão por duas palavras em C++, com o código Java de reserva; veja `docs/native-engine.md`);
- `docs/`: anotações de cada versão e as ferramentas usadas para gerar o dicionário e as classes Java.

**Pelo GitHub Actions** são três workflows:
- *Mr Keyboard - APK* roda a cada push que muda o app (`smali/`, `res/`, `lib/`, `apktool.yml`). Gera o APK com o apktool 2.11.1 usando as bibliotecas que já estão em `lib/` e assina, se existirem os secrets `KEYSTORE_B64`, `KEYSTORE_PASS`, `KEY_ALIAS` e `KEY_PASS`. Sem os secrets (num fork, por exemplo), sai um APK sem assinatura no artefato `apk`.
- *Mr Keyboard - native lib* roda só quando `native/` ou `engine/` muda (ou à mão). Compila as duas bibliotecas para arm64-v8a, armeabi-v7a e x86 com o NDK 27 e roda os testes no PC. Extraia o artefato `native-libs` na raiz do projeto (mesclando com `lib/`) e faça o commit de `lib/`, `native-src.sha256`, `mrengine-src.sha256` e `mrengine-info.txt`. O workflow do APK compara esses hashes com o `native/` e o `engine/` atuais e não deixa publicar se a `lib/` estiver desatualizada.
- *Mr Keyboard - checks* roda nos pushes na `main` e nos pull requests que mudam o app. Confere a versão e as notas, os recursos (inclusive os textos em espanhol), a lista de chaves do "Restaurar padrões", os registradores do smali e se o smali gerado da camada Java está em dia, monta o app para verificar o dex, roda os testes de PC e confere que o motor nativo dá exatamente o mesmo resultado que o código Java (Java x C++, três idiomas). Os mesmos scripts estão em `docs/tools/` e rodam também no seu computador.

**Publicar (para quem mantém o projeto):**
- **Uma release por lançamento:** aumente `versionCode` e `versionName` no `apktool.yml`, escreva as notas curtas em `docs/release-notes/<tag>.md` (ex.: `docs/release-notes/v1.72.0.md`, com um bloco **Português** e um **English**) e faça o push na `main`. O *Mr Keyboard - APK* publica uma única [release](../../releases), com a tag do `versionName` (ex.: `v1.72.0`), com o APK assinado (`mr-keyboard-v1.72.0.apk`, a versão está no nome do arquivo), um `catalog.json` assinado e só os zips dos idiomas de dicionário que mudaram nesta versão. O texto é o arquivo de notas, a lista dos dicionários incluídos (com os que são novos nesta versão) e os hashes. Precisa dos secrets de assinatura; sem eles, com uma versão que já foi publicada ou com a `lib/` desatualizada, só avisa e o APK fica no artefato `apk`. Rodar à mão com *publish* marcado faz o mesmo, mas trata qualquer um desses casos como erro. A release é criada como rascunho, os arquivos são conferidos e só então ela é publicada.
- **Dicionários:** os pacotes ficam em `dicts/<idioma>/` (o `pack.json` lista os arquivos). Cada zip se chama `mr-keyboard-dict-<id>-<version>.zip` e é anexado **só à release em que aquele idioma mudou**; o catálogo diz, para cada idioma, qual release guarda o zip (`release`), e o app monta o endereço de download a partir dela. Depois de mudar algo, aumente `version` nesse `pack.json` **e** a versão do app e faça o push: a release nova traz o zip novo e um `catalog.json` com `serial` maior. Os idiomas que não mudaram continuam apontando para a release que fez o zip deles, sem copiar nada. **Nunca apague nem altere uma release que ainda guarda um dicionário usado pelo catálogo:** o script confere isso antes de publicar e para com um erro que diz qual zip falta. O catálogo é assinado com a própria chave do app (a mesma que assina o APK), e o app só aceita catálogo assinado com a chave com que foi instalado.

**No computador:**
```sh
apktool b . -o mr-keyboard-unsigned.apk
zipalign -p -f 4 mr-keyboard-unsigned.apk aligned.apk
apksigner sign --ks sua-chave.jks --out mr-keyboard.apk aligned.apk
```

## Créditos e licenças
O Mr Keyboard está sob a [Apache License 2.0](LICENSE).
- [Hacker's Keyboard](https://github.com/klausw/hackerskeyboard), de Klaus Weidner, e o LatinIME do Android Open Source Project, em que o Mr Keyboard se baseia, também estão sob a Apache License 2.0.
- Dados dos dicionários (créditos completos em `dicts/<idioma>/NOTICE.txt`):
  - listas pt_BR, en_US e es do AOSP (Apache 2.0);
  - [Leipzig Corpora Collection](https://wortschatz-leipzig.de/) (CC BY 4.0);
  - [Tatoeba](https://tatoeba.org/) (CC BY 2.0 FR).
