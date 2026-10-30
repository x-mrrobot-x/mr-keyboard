# Plano: dicionários baixáveis (versão 3, aprovada)

> Andamento: fase A feita (`revisao-fase-a-dicionarios.md`); fase B feita na 1.63 (`revisao-1.6.3.md`). fase C (inglês) feita na 1.64 (`revisao-1.6.4.md`); espanhol na 1.65 (`revisao-1.6.5.md`).

## Objetivo
O APK sai **sem nenhum dicionário**. Nas configurações, o usuário baixa o pacote do idioma que usa (pt-BR agora, inglês depois). O APK fica leve e o mesmo app serve para quem fala qualquer idioma que tiver pacote.

## Regras que continuam valendo
- **Nada do que o usuário digita sai do aparelho.** O app só baixa arquivos, e só quando o usuário toca em "Baixar" ou "Atualizar". Nada roda sozinho em segundo plano, e não há telemetria.
- O GitHub só fica sabendo o IP de quem baixou e o arquivo baixado, como em qualquer download. Isso fica escrito na tela.
- Depois de baixado, tudo funciona sem internet.
- O app já tem permissão de internet (por causa do Traduzir) e roda a partir do Android 8: nenhuma permissão nova.

## Como fica
| | Hoje (1.62) | Com pacotes |
|---|---|---|
| APK | 5,6 MB | cerca de 1 MB (5,63 − 2,90 do dicionário − 1,77 das duas palavras) |
| Sem pacote | — | teclado normal, sem sugestões, correção e previsão (as sugestões já vêm desligadas por padrão) |
| Pacote pt-BR | — | cerca de 4,7 MB para baixar; 6,7 MB ocupados depois de instalado |
| Memória | dicionário copiado na memória + 6 MB das duas palavras | dicionário lido direto do arquivo (o sistema só carrega o que for usado); duas palavras igual à 1.62 |

## Partes
### 1. Onde ficam os pacotes: no `mr-keyboard` (o `sdk` renomeado), público
- Um *Release* fixo com a tag **`dicionarios`**, separado das versões do APK. Não uso o "latest" do GitHub, para um APK publicado depois não tomar o lugar do catálogo.
- O app procura sempre o mesmo endereço:
  `https://github.com/x-mrrobot-x/mr-keyboard/releases/download/dicionarios/catalogo.json`
- Os arquivos levam a versão no nome (ex.: `pt-BR-3.dict.gz`). Assim, publicar uma versão nova não quebra quem está baixando a anterior.
- O `catalogo.json` traz, para cada pacote: idioma, nome, versão, arquivos, tamanhos, SHA-256, versão mínima do app, créditos e licenças.
- **Catálogo assinado:** o workflow assina o catálogo com a mesma chave que assina o APK (já guardada nos *Secrets*), e o app confere a assinatura com o certificado com que ele próprio foi instalado. Não há chave nova para criar. (Decidido na fase A; veja `revisao-fase-a-dicionarios.md`.) A parte nativa que lê o dicionário não foi feita para arquivo malicioso, então o app só usa arquivos cujo SHA-256 bate com o que a assinatura garante. Isso vale mesmo se alguém mexer no Release.

### 2. Antes de tornar o `mr-keyboard` público (você faz, eu confiro com você)
- Nenhum commit, inclusive os antigos, pode ter o `mrkeyboard.p12`, senhas ou arquivos `.pk8`/`.pem`. Se tiver, é melhor criar um repositório novo e limpo do que apagar só o arquivo, porque o histórico continua visível.
- Os *Secrets* não ficam visíveis em repositório público. O workflow só roda em push e manualmente, então pedidos de outras pessoas (*pull requests*) não rodam com a sua chave.
- O e-mail de quem fez os commits aparece no histórico. Se não quiser isso, é melhor ajustar antes de abrir o repositório.
- O código do Hacker's Keyboard é Apache 2.0 e os dados são CC BY, então publicar é permitido, com os créditos que já estão nos arquivos.
- O GitHub redireciona os endereços antigos do `sdk` depois da renomeação, mas o app e a documentação passam a usar só `mr-keyboard`.
- Já tem `README.md` (inglês) e `README.pt-BR.md` na raiz. Quando a 1.63 sair, as duas versões ganham a seção de dicionários.
- A tela inicial do app ainda manda para a página do Hacker's Keyboard. Na 1.63 o link passa a ser o `mr-keyboard`.

### 3. Workflow (GitHub Actions)
Um job novo, rodado à mão (*Run workflow*), escolhendo o idioma:
1. gera ou pega os arquivos do pacote;
2. comprime, calcula o SHA-256 e atualiza o `catalogo.json`;
3. assina o catálogo;
4. envia tudo para o Release `dicionarios`.

### 4. No app (Java → smali, como nas versões anteriores)
- **Ponto de encaixe já existente:** o teclado herdou do Hacker's Keyboard um mecanismo de dicionário por idioma, que buscava dicionários em apps separados (`PluginManager.getDictionary`). O pacote baixado entra ali primeiro. Com isso:
  - a troca de idioma no teclado já pega o dicionário certo;
  - a tela de idiomas já marca quais têm dicionário.
- **MrPacks** (novo): lê o catálogo, baixa com `HttpsURLConnection` numa thread à parte, mostra progresso, confere tamanho e SHA-256 e grava em `files/dicts/<idioma>/<versão>/`, na memória interna do app. Só troca pela versão nova depois de conferida, e então recarrega o dicionário sem precisar reiniciar o teclado.
- **Antes de usar:** além do SHA-256, confere o cabeçalho e algumas palavras comuns. Se algo falhar, o teclado segue sem dicionário em vez de fechar.
- **Português fora do código:** hoje algumas coisas do português estão no código:
  - as palavras de início de frase (Você, Eu, Não);
  - os ~200 erros comuns (`MrFix`);
  - as trocas fonéticas da correção (s/z/ç/ss etc.).

  Elas vão para um arquivo `regras.txt` dentro do pacote. O código fica igual para qualquer idioma, e o pacote inglês traz as regras dele.
- **Créditos** (`notice_main_pt.txt`) saem do APK e vão para o pacote; aparecem na tela de dicionários.
- **Sem pacote:** se o usuário ligar as sugestões sem ter o pacote do idioma atual, a barra mostra um único item, **"Baixar dicionário"**, que abre a tela de dicionários. Nada é baixado sem confirmação.

### 5. Tela nas configurações
Item novo **"Dicionários"**:
- lista do catálogo, por idioma: instalado ou não, versão, tamanho, botões **Baixar / Atualizar / Remover**, barra de progresso;
- **"Só baixar no Wi-Fi"**: ligado por padrão;
- **"Procurar atualizações ao abrir esta tela"**: desligado por padrão (sem ela, só confere quando o usuário toca em "Procurar atualizações");
- texto curto sobre privacidade e créditos de cada pacote;
- textos em português e inglês, porque o app vai ser compartilhado.

### 6. Testes
- **No PC:**
  - download, conferência e troca contra um servidor local: arquivo certo, cortado, com hash errado e catálogo com assinatura inválida;
  - carregamento por arquivo com a lib do PC;
  - as mesmas métricas da 1.62, para provar que o pacote dá o mesmo resultado que o APK atual.
- **No aparelho** (roteiro na revisão): primeiro uso sem pacote, download no Wi-Fi e no 4G, download interrompido, troca de versão, remoção, troca de idioma.

## Fases
1. **A — Pacote e Release:** o workflow publica o pacote pt-BR e o catálogo assinado no Release `dicionarios`. O app não muda. Você confere que os arquivos baixam pelo link.
2. **B — Versão 1.63:** MrPacks, tela "Dicionários", regras no pacote e APK sem dicionário (cerca de 1 MB).
3. **C — Inglês:** pacote `en-US` com a lista do AOSP en_US (Apache), Leipzig em inglês (CC BY) e Tatoeba em inglês, com regras próprias. Só publica no catálogo, sem APK novo.

## Decisões para você
1. Tag fixa **`dicionarios`** para o Release dos pacotes (recomendado) ou outro nome.
2. **Catálogo assinado** (recomendado) ou só o SHA-256 dentro do catálogo.
3. Padrões: "Só no Wi-Fi" ligado e verificação automática desligada.
4. Item **"Baixar dicionário"** na barra quando faltar o pacote (recomendado) ou só aviso nas configurações.
