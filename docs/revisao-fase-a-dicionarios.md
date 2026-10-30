# Fase A dos dicionários baixáveis: pacote pt-BR, catálogo assinado e Releases

## Pedido
Plano `docs/plano-dicionarios.md` aprovado. A fase A publica o pacote pt-BR e o catálogo assinado no Release `dicionarios`, sem mudar o app. Também entram:
- a publicação do APK assinado em Releases (o README aponta para lá);
- um `LICENSE` na raiz.

## O que mudou
- **`dicts/pt-BR/`**: o pacote. Tem `main.dict` e `trigrams.bin`, cópias exatas de `res/raw/main_pt.dict` e `assets/mr_trigrams.bin`. O Git guarda arquivos iguais uma vez só, então o repositório não cresce. Também tem:
  - `rules.txt` (novo): tira do código o que é só do português e é lido pelo app a partir da 1.63:
    - as 3 sugestões de começo de frase;
    - as 217 correções do `MrFix`;
    - as letras parecidas, as trocas de vogal e os grupos (ch = x, ss = ç…);
    - as letras mudas, a letra que pode sobrar e as palavras de uma letra.
  - `NOTICE.txt`: os créditos de `notice_main_pt.txt`, com os nomes dos arquivos do pacote.
  - `pack.json`: id, idioma, nome e descrição em pt e en, `version`, `format`, `minApp` 1063000, lista de arquivos e licenças.
- **`docs/tools/make_catalog.py`** (novo): confere e monta os pacotes e escreve os dados do catálogo.
- **`docs/tools/SignCatalog.java`** (novo): assina o catálogo com a chave do APK.
- **`.github/workflows/mr-dicts.yml`** (novo): workflow *Mr Keyboard - dicionários*, rodado à mão.
- **`.github/workflows/mr-native.yml`**: nova opção *publicar* no *Run workflow*. Com ela marcada, o APK assinado vai para Releases.
- **`LICENSE`** (Apache 2.0) na raiz, e `README.md` / `README.pt-BR.md` atualizados (licença, publicação, créditos do pacote).
- **`docs/release-dicionarios.md`**: o texto do Release `dicionarios`.
- O app não mudou: `res/raw/main_pt.dict` e `assets/mr_trigrams.bin` continuam no APK até a 1.63.

## Como foi feito
### Pacote
O pacote é um zip `<id>-<versão>.zip` (ex.: `pt-BR-1.zip`) com `pack.json` e os arquivos da lista, nessa ordem. Ele sai sempre igual para o mesmo conteúdo: data fixa, ordem fixa e compressão 9.
- `pt-BR-1.zip`: 4.465.320 bytes para baixar e 6.738.199 bytes instalado.
- Antes de montar, o script confere:
  - cabeçalho [200,1] do dicionário e o limite de 4 MB do formato;
  - `MRT1` no começo do `trigrams.bin`;
  - UTF-8 dos `.txt`;
  - nomes de arquivo sem `/` nem `..`;
  - `id` igual ao nome da pasta.
- Cada pacote no ar é comparado com o pacote em `dicts/`:
  - mesma `version` e mesmo conteúdo: reaproveita a entrada publicada e não envia nada;
  - `version` maior: gera um zip novo;
  - mesma `version` com conteúdo diferente, ou `version` menor: para com erro.

### Catálogo
- `catalogo.json` é um envelope JSON:
  - `format`;
  - `algorithm` (SHA256withRSA para a chave atual);
  - `signer`: SHA-256 do certificado;
  - `signature` (base64);
  - `data`: os dados do catálogo como texto.
- Os dados levam:
  - `serial`: aumenta a cada publicação, e o app vai recusar um catálogo com série menor que a última vista, para ninguém conseguir voltar a um catálogo antigo;
  - `generated`;
  - `baseUrl`;
  - por pacote: tamanho, SHA-256 do zip, SHA-256 de cada arquivo e do `pack.json`, tamanho instalado, `minApp` e licenças.
- A assinatura cobre `mr-keyboard/catalogo/v1\n` + os bytes exatos de `data`. O prefixo garante que essa assinatura não sirva para mais nada.
- **Sem chave nova:** o workflow assina com a chave do APK, a partir dos mesmos secrets (`KEYSTORE_*`, ou `KEY_PK8_B64` + `CERT_PEM_B64`). O app vai conferir a assinatura com o certificado com que ele mesmo foi instalado. Quem não tem a chave do APK não consegue fazer um catálogo que o app aceite. Um fork assinado com outra chave precisa publicar o próprio catálogo.

### Publicação
- O workflow *Mr Keyboard - dicionários*:
  1. baixa o catálogo no ar. Se o Release tem catálogo e o download falha, o workflow para, para não tratar versões publicadas como novas;
  2. monta e assina;
  3. envia os zips novos primeiro e o `catalogo.json` por último. Assim o catálogo nunca aponta para um zip que ainda não subiu.
- O Release `dicionarios` é criado com `--latest=false`, para não tomar o lugar das versões do APK.
- Se uma execução parou depois de enviar o zip e antes do catálogo, a próxima substitui esse zip. O catálogo no ar não aponta para ele, então a troca não atrapalha ninguém.
- A publicação do APK roda só com *publicar* marcado e só com o APK assinado:
  - tag `v` + `versionName` (hoje `v1.62.0`), que nunca é sobrescrita;
  - as notas são as de `docs/revisao-1.6.2.md`, mais o SHA-256 do APK e do certificado.

## Validação
- `make_catalog.py`:
  - gera zip e dados idênticos em duas execuções;
  - na segunda execução com o catálogo publicado, diz "nada mudou";
  - com `version` 2 gera `pt-BR-2.zip` e a série 2;
  - para com erro nos casos errados: conteúdo mudado sem nova `version`, `version` menor, cabeçalho do dicionário errado e nome `../x`.
- `SignCatalog.java` foi testado com:
  - keystore PKCS12 RSA (como o `mrkeyboard.p12`);
  - keystore JKS com senha da chave diferente;
  - chave EC em `.pk8` + `.pem`.

  Senha errada e alias errado dão mensagens claras.
- **Conferência independente:** um verificador em Python (`cryptography`) e o `openssl dgst -verify` conferiram a assinatura com o certificado. Também conferiram:
  - que `data` é byte a byte igual a `dados.json`;
  - o tamanho e o SHA-256 do zip;
  - a ordem e o SHA-256 de cada arquivo dentro dele.

  Um catálogo com a `version` alterada à mão foi recusado (assinatura inválida).
- **Workflow simulado** com um `gh` falso, rodando os passos do `mr-dicts.yml`:
  1. primeira publicação: cria o Release e envia;
  2. sem mudança: não publica nada;
  3. versão 2: envia só o zip novo e o catálogo;
  4. zip que sobrou de uma execução incompleta: é substituído;
  5. sem chave: para antes de publicar, e o catálogo no ar continua o anterior.
- `actionlint` 1.7.7 nos dois workflows: nenhum erro. O shellcheck só deu avisos informativos, em trechos que já existiam (o `ls` de build-tools e o `$SIGN` sem aspas, de propósito).

## Testes no GitHub necessários
1. Copiar os arquivos para o repositório e fazer o push. O push do `mr-native.yml` dispara uma compilação normal, sem publicar.
2. Antes de deixar o repositório público, conferir que nenhum commit tem a chave:
   `git log --all --name-only --format= | grep -iE '\.(p12|jks|keystore|pk8|pem)$'` não pode mostrar nada.
3. *Actions → Mr Keyboard - dicionários → Run workflow*. No log, a linha "certificado SHA-256" tem que ser igual ao "certificate SHA-256 digest" que o *apksigner* mostra no workflow do APK.
4. Com o repositório público, abrir no navegador, sem login:
   - `https://github.com/x-mrrobot-x/mr-keyboard/releases/download/dicionarios/catalogo.json`
   - `.../dicionarios/pt-BR-1.zip`
5. Opcional: *Mr Keyboard - nativo e APK → Run workflow* com *publicar* marcado. Isso cria o Release `v1.62.0` com o APK assinado, e o link de download do README passa a funcionar.
