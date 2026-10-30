# 1.63 — Dicionários baixáveis: APK sem dicionário, tela Dicionários e regras do idioma no pacote

## Pedido
Fase B do `docs/plano-dicionarios.md`:
- o app baixa e confere os pacotes de dicionário publicados na fase A;
- tela "Dicionários" nas configurações;
- o que é só do português sai do código e vai para o pacote;
- o APK sai sem nenhum dicionário.

## O que mudou
- **APK de 5,63 MB para 0,98 MB** (975.457 bytes sem assinatura). Saíram `res/raw/main_pt.dict`, `res/raw/notice_main_pt.txt` e `assets/mr_trigrams.bin`. Os créditos dos dados vão no `NOTICE.txt` do pacote.
- **Nova tela Dicionários** (*Configurações → Digitação → Dicionários*):
  - lista os pacotes do catálogo e os instalados, com a situação de cada um: não instalado (tamanho), baixando (%), instalado (versão, tamanho), atualização disponível, ou precisa de app mais novo;
  - tocar num idioma mostra descrição, tamanhos, licenças e créditos, com os botões **Baixar / Atualizar / Remover / Cancelar download**;
  - "Procurar atualizações" é o único jeito de buscar a lista, a não ser que o usuário ligue "Procurar atualizações ao abrir esta tela" (vem desligado);
  - "Só baixar no Wi-Fi" vem ligado;
  - texto de privacidade;
  - textos em português e inglês (46 novos), seguindo o idioma das configurações.
- **Item "Baixar dicionário" na faixa:** aparece com as sugestões ligadas e sem dicionário do idioma em uso. Tocar abre a tela e não digita nada. Ele só aparece se ainda não houve catálogo, ou se o último catálogo tem pacote para o idioma. Assim, quem digita num idioma sem pacote não fica vendo o item.
- **Regras do idioma no pacote:** `MrFix`, `MrPredict` e `MrFuzzy` leem as regras de `MrRules`, carregadas do `rules.txt` do pacote em uso. Sem pacote, não há regras, e o código não tem mais nada de português.
- **Pacote pt-BR versão 2** (`dicts/pt-BR`):
  - começos de frase na ordem de probabilidade (Eu, Você, Não; na faixa: Você · **Eu** · Não, como na 1.62);
  - custo 40 para o "u" que falta depois de q/g, igual à 1.62 (o formato aceita um custo opcional em `[silent]`).
- **Permissão nova `ACCESS_NETWORK_STATE`.** É uma permissão normal: o Android não pergunta nada, e ela só deixa ver se a rede é Wi-Fi ou cobrada por uso. Sem ela, "Só baixar no Wi-Fi" não funcionaria. No plano eu tinha dito "nenhuma permissão nova".
- O link da tela inicial vai para `github.com/x-mrrobot-x/mr-keyboard`, não mais para o Hacker's Keyboard.
- Versão 1.63.0 (versionCode 1063000).
- **CI:** o teste da lib nativa no PC usa `dicts/pt-BR/main.dict`, e o `make_catalog.py` exige `main.dict` no pacote.

## Como foi feito
### Carregamento (smali)
- **`Suggest(Context, int[])`:** sem dicionário embutido, chama `MrPacks.mainDictionary` no lugar de `PluginManager.getDictionary`. Esse método:
  1. acha o pacote instalado do idioma, preferindo a mesma região (`pt_BR` → `pt-BR`);
  2. mapeia o `main.dict` só para leitura (`FileChannel.map`);
  3. entrega o arquivo mapeado ao `BinaryDictionary` pelo construtor que já aceitava `ByteBuffer`;
  4. ativa o `rules.txt` e o `trigrams.bin` do mesmo pacote.

  Sem pacote, as regras ficam vazias e o código cai nos apps de dicionário do Hacker's Keyboard, como antes.
- **`PluginManager.getDictionary`:** procura o pacote primeiro. Assim a tela de idiomas marca os idiomas que têm dicionário.
- **`LatinIME.pickSuggestionManually`:** o item "Baixar dicionário" é reconhecido pelo próprio objeto, não pelo texto. Então digitar uma palavra igual não abre nada.
- **`LatinIME.onSharedPreferenceChanged`:** quando muda `mr_dicts_updated_at` (gravado ao instalar ou remover um pacote), chama `initSuggest` do idioma atual. O dicionário novo entra sem reiniciar o teclado.
- **Memória:** o dicionário não é mais copiado para a memória (3,7 MB a menos). O sistema só carrega as partes lidas do arquivo, e o trigrams.bin continua como na 1.62.

### Download (`MrPacks`)
- **Catálogo:**
  - a assinatura é conferida com o certificado com que o app foi instalado (`SigningInfo` no Android 9+, `signatures` no 8; o código do 9+ fica numa classe separada);
  - só são aceitos SHA256 com RSA, ECDSA ou DSA;
  - a série guardada não pode voltar;
  - formato 1 e `baseUrl` em https;
  - um JSON mal formado ou fundo demais é recusado.

  Assinatura com outra chave dá uma mensagem própria, "este app foi instalado de outra fonte?".
- **Pacote:**
  1. HTTPS sem gzip e com `User-Agent` fixo "MrKeyboard" (o padrão do Android manda o modelo do aparelho);
  2. confere o tamanho e o SHA-256 do zip;
  3. extrai só os nomes listados no catálogo, cada um com o tamanho e o SHA-256 certos;
  4. confere o cabeçalho do dicionário, o `MRT1` e as regras;
  5. só então renomeia a pasta, troca a versão e apaga a anterior.

  Se algo falha em qualquer ponto, a versão anterior continua e nada sobra no cache.
- **Só Wi-Fi:** usa `isActiveNetworkMetered`, que conta Wi-Fi e cabo, mas não dados móveis nem roteador cobrado por uso. O catálogo (≈3 KB) é baixado mesmo em rede móvel quando o usuário toca em "Procurar atualizações".
- O app confere o espaço livre antes, e o download pode ser cancelado.
- **Estado:** fica em `SharedPreferences` "mr_packs", separado das preferências do teclado, para mexer no estado não recarregar o teclado. Os arquivos ficam em `files/dicts/<id>/<versão>/`.

### Tela (`MrPacksActivity`)
`PreferenceActivity` montada em código, com o mesmo tema, cabeçalho (`ListDividerFix` → `SettingsHeader`) e idioma (`UiLocale`) das outras telas. O download roda numa thread separada, e a tela atualiza o progresso a cada 0,4 s.

### Regras (`MrRules`)
O `rules.txt` formato 1 vira tabelas para `MrFuzzy`:
- letras parecidas e vogais trocadas;
- grupos de 2 letras por 1 e de 1 por 2;
- letras mudas, com custo opcional;
- letra que sobra;
- palavras de uma letra.

As primeiras letras aceitas na busca saem dessas mesmas regras.

## Validação
- **Paridade com a 1.62:** 14.041 palavras digitadas: 2.500 palavras dos textos de teste com erros de propósito (tecla vizinha, troca, letra que falta ou dobra, fonética), prefixos e as 217 correções.
  - As 6 primeiras sugestões e a decisão da autocorreção saíram idênticas às da 1.62, com as classes compiladas e com as do APK 1.63 convertidas para jar.
  - Sem o `rules.txt`, 2.230 resultados mudam, o que mostra que as regras vêm mesmo do arquivo.
- **Ponta a ponta** (classes do APK + lib do PC + pacote): TUDO OK. Tempo por tecla: média 0,24 ms, p99 0,94 ms.
- **Fluxo de pacotes** (`docs/tools/packs_test`, classes do APK): 50 verificações OK.
  - Sem pacote: o teclado fica sem dicionário e sem regras, e a faixa oferece o download. Tocar abre a tela; uma palavra igual digita normal.
  - Recusados:
    - catálogo com série menor, alterado ou de outra chave;
    - HTTP 404, com a mensagem do código;
    - zip com um byte trocado, cortado, ou com arquivo a mais (inclusive `../evil.txt`, que não é gravado);
    - arquivo com SHA-256 errado;
    - pacote para app mais novo.

    Depois de cada falha, a versão instalada continua intacta.
  - "Só Wi-Fi" em rede cobrada nem chega a conectar. Cancelar no meio funciona.
  - **Instalação:**
    - caem os 5 arquivos certos, não sobra nada e o teclado é avisado;
    - o `Suggest` pega o dicionário mapeado, com 217 correções e começo de frase "Você · Eu · Não";
    - previsão de duas palavras;
    - vc → você, omem → homem, enchergar → enxergar, concerteza → com certeza;
    - a tela de idiomas acha pt e não acha en.
  - **Atualizar:** troca a v2 pela v7 e apaga a v2.
  - **Remover:** volta tudo ao estado sem pacote.
- **Download de verdade:** o catálogo e o `pt-BR-1.zip` foram baixados do GitHub pelo código de rede do app (o GitHub redireciona para `release-assets.githubusercontent.com`). O SHA-256 conferiu e a instalação levou 1,8 s no PC.
- **API:** todas as chamadas novas existem no Android 8. Conferi uma a uma as 85 que o app ainda não usava; `SigningInfo` (Android 9) só é usado numa classe separada.
- **Bytecode:** `d2j-asm-verify` no jar inteiro, sem erros, como na 1.62.
- **Recursos:** nenhum ID de recurso usado no smali mudou. Algumas strings sem ID fixo mudaram de número, mas só são usadas pelo nome no XML.
- **Workflows:** `actionlint` sem erros.

## Testes Android necessários
1. **Antes de instalar:** fazer o push e rodar *Mr Keyboard - dicionários*. Isso publica o pacote pt-BR v2 (série 2). Sem esse passo, a tela oferece a v1, que funciona, mas com os começos de frase trocados de posição.
2. **Instalar a 1.63 por cima da 1.62.** Tem que ser a mesma chave, senão o catálogo é recusado com "outra chave".
   - Sem pacote: o teclado funciona, só sem sugestões.
   - Com "Mostrar sugestões" ligado: a faixa mostra "Baixar dicionário", e tocar abre a tela.
3. **Instalar o pacote:**
   1. Dicionários → Procurar atualizações: aparece Português (Brasil), versão 2, ≈4,5 MB.
   2. Baixar no Wi-Fi: o progresso aparece, depois "Dicionário instalado".
   3. Voltar ao teclado sem reiniciar e conferir:
      - as sugestões (vc → você, omem → homem);
      - o começo de frase (Eu no centro);
      - a previsão depois de duas palavras.
4. Em dados móveis com "Só baixar no Wi-Fi": aparece a mensagem; com a opção desligada, baixa.
5. Cancelar no meio. Em modo avião, a mensagem de sem conexão.
6. Remover: as sugestões somem e o item da faixa volta. Baixar de novo.
7. Idiomas de entrada: Português aparece como idioma com dicionário.
8. Interface em inglês: a tela e o item da faixa ficam em inglês.
9. Conferir o tamanho do APK (≈1 MB) e a memória do teclado com o dicionário carregado.
