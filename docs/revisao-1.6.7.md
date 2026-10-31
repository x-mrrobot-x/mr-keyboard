# 1.67 — Tela única "Sugestões e dicionários"

## Pedido
- Juntar "Idiomas de entrada" e "Dicionários" numa tela só, com os 3 idiomas já visíveis e o estado de cada dicionário.
- Tirar a opção de baixar só no Wi-Fi e todo o código ligado a ela.
- Passo 3 do guia deixando claro que é sobre sugestões; trazer para a mesma tela as opções de sugestões.

## O que mudou
1. **Tela "Sugestões e dicionários"** (antes "Dicionários"), com três blocos:
   - **Idiomas:** cartões de Português (Brasil), English (US) e Español sempre visíveis, até offline, mais o que o catálogo trouxer. Cada cartão mostra "Não baixado", "Não baixado · <tamanho>" (depois de ver o catálogo), "Baixando…", "Instalado · versão 2 · <tamanho>" ou "Atualização disponível". Tocar abre os detalhes (baixar, atualizar, remover). Sem catálogo guardado, tocar num idioma ainda não baixado busca o catálogo primeiro (para mostrar o tamanho) e abre os detalhes quando chega.
   - **Sugestões:** Mostrar sugestões, Autocompletar, Correções rápidas, Tocar para corrigir palavras, Sugestões no modo horizontal e Pontuação sugerida (vieram de Configurações → Digitação). "Capitalização automática" ficou em Configurações, por não ser sobre sugestões.
   - **Privacidade:** o texto de sempre, agora citando o toque num idioma não baixado.
2. **Idioma do teclado = dicionário instalado.** Baixou, o idioma entra no teclado (a barra de espaço alterna entre eles); removeu, sai. Sem nenhum pacote, o teclado usa o idioma do aparelho. O idioma do app vem primeiro na lista, e é nele que o teclado começa. Uma linha no fim do bloco explica isso.
3. **Saiu a tela "Idiomas de entrada"** (`InputLanguageSelection`, `$Loc`, entrada no manifest e em Configurações), com as listas fixas do Hacker's Keyboard (59 layouts que este projeto não tem). As três checagens por idioma do `LanguageSwitcher` (maiúscula, espaço e teclas mortas automáticos) agora valem sempre.
4. **Saíram "Só baixar no Wi-Fi" e "Procurar atualizações ao abrir esta tela"**: `KEY_WIFI`, `wifiOnly`, `isMetered`, `autoCheck`, a categoria Opções, 6 textos nos dois idiomas e a permissão `ACCESS_NETWORK_STATE`, que só servia para isso. O app deixa de pedir "Estado da rede" e continua pedindo Internet. Ele só se conecta quando você toca.
5. **Passo 3 do guia:** título "Sugestões de palavras", descrição "Baixe os dicionários e ligue as sugestões", e o toque abre a tela nova.
6. READMEs (en e pt-BR): passos de instalação, privacidade e tabela de permissões.

Versão 1.67.0 (1067000). Os pacotes de dicionário não mudam.

## Como foi feito
- `MrPacksActivity` (Java → smali pelo `build_java.sh`) agora carrega `res/xml/prefs_suggestions.xml` nas preferências padrão do app (as mesmas que o teclado lê) e só preenche o bloco Idiomas por código.
- `MrPacks`: `cardIds` (ordem dos cartões), `languageKeys` (valor de `selected_languages`, ex.: `pt_BR,en_US,`) e `syncLanguages` (grava só se mudou). A tela chama a sincronização toda vez que monta a lista, então abrir a tela já acerta a seleção.
- "Correções rápidas" continua tendo o comportamento de antes: a tela nova a esconde quando o Android não tem tabela de autotexto para o idioma (como a tela de configurações fazia). O trecho antigo em `LatinIMESettings` foi tirado.
- Os 3 cartões fixos usam os nomes de `mr_lang_*` (iguais aos do `pack.json`); idiomas novos do catálogo aparecem sozinhos, sem atualizar o app.
- Stubs de compilação: entraram `AutoText`, `ListView`, `View`; saíram os de rede.

## Validação
- `build_java.sh` e `apktool b` sem erro; APK de 974 KB.
- `d2j-asm-verify` no jar inteiro, sem erros.
- Nenhuma das 264 constantes de ID de recurso do smali mudou ou sumiu (conferido contra o APK da 1.66); o manifest não tem mais `ACCESS_NETWORK_STATE` nem `InputLanguageSelection`.
- `PacksTest`: 55 verificações OK (as 50 de antes, sem o caso de Wi-Fi, e 6 novas: ordem dos cartões, `selected_languages` com e sem pacote, remoção tira o idioma).
- `ThreeLangTest`: 23 OK (3 novas: app em pt, en e es dão `pt_BR,en_US,es,`, `en_US,pt_BR,es,` e `es,pt_BR,en_US,`).
- **Não testado no aparelho**: a tela em si (cartões, tocar, caixas de seleção, ocultar "Correções rápidas").

## Testes Android necessários
1. Configurações → **Digitação e sugestões** → **Sugestões e dicionários**: os 3 cartões aparecem logo, "Não baixado", com a tela em português e depois em inglês (Configurações → idioma do app). O idioma do app vem primeiro.
2. Sem internet, tocar num idioma: aparece a mensagem de falta de conexão, sem travar. Com internet, abre os detalhes com o tamanho; **Baixar** instala e o cartão vira "Instalado".
3. Depois do primeiro download, aparece o aviso para ligar "Mostrar sugestões"; ligar na mesma tela e conferir que "Autocompletar" destrava.
4. Baixar um segundo idioma: a barra de espaço passa a alternar entre os dois e o rótulo muda. Remover um: volta a ter só um.
5. Remover todos: o teclado usa o idioma do aparelho e a faixa de sugestões oferece "Baixar dicionário", que abre a tela nova.
6. Tela inicial do app, passo 3 ("Sugestões de palavras"): toca e abre a tela nova.
7. "Correções rápidas" aparece ou some conforme o idioma do aparelho, como antes; ligar/desligar e as outras 5 opções funcionam (sugestões em modo horizontal, pontuação sugerida).
8. Girar a tela durante o download não perde o andamento. Baixar com dados móveis agora não pede confirmação: o tamanho aparece nos detalhes.
