# 1.4.9 — Dicionário pt-BR embutido

## Contexto
O app não tinha dicionário principal (`raw/main` não existe), então as sugestões vinham só de palavras aprendidas, do dicionário pessoal do Android e de apps de dicionário externos. A 1.4.8 levou as sugestões para a linha da barra de ferramentas; esta revisão dá a elas um vocabulário pt-BR.

## Fonte
- `dictionaries/pt_BR_wordlist.combined.gz` do AOSP LatinIME, obtido do espelho público do LineageOS: https://github.com/LineageOS/android_packages_inputmethods_LatinIME (commit `c9e8aa87038e1194d2717ac48f207df4068cebd9`). O arquivo traz `locale=pt_BR, version=54`.
- 170.044 palavras com frequência de 0 a 255, todas em Latin-1, com maiúsculas próprias (ex.: Brasil, Brasília) e siglas.
- Licença: Apache 2.0 (NOTICE do AOSP), com o crédito "Includes Dictionaries © Lexiteria LLC. Used by permission." O aviso está em `res/raw/notice_main_pt.txt`, que vai dentro do APK.

## Formato
- A `libjni_pckeyboard.so` é o leitor de dicionário do LatinIME da época do Gingerbread (símbolos `latinime::Dictionary::getWordsRec`, `checkIfDictVersionIsLatest` etc.), o mesmo do Hacker's Keyboard (`app/src/main/cpp/dictionary.cpp`).
- Os dicionários `.dict` atuais (AOSP, HeliBoard/OpenBoard) usam formatos mais novos, que esse leitor não reconhece. Por isso a lista foi convertida.
- O formato gerado é o antigo, sem cabeçalho e sem bigramas, com o grupo raiz no offset 0 (71 filhos, abaixo de 200, então lido como formato antigo). Cada entrada tem caractere (1 byte, ou 0xFF + 2), flags (0x80 terminal, 0x40 com filhos) com endereço absoluto de 22 bits do grupo filho e, se terminal, a frequência (1 byte).
- Gerador: `build_dict.py` (montagem em largura). Tamanho final: 1.922.681 bytes, limite do formato de 4 MB.
- Foram removidas 6 entradas que só existiam como origem de atalho (atras, cade, cafe, ferias, musica, musicas). O leitor compara letras sem acento, então digitar "musica" já sugere "música".

## Validação
- **Leitor original:** `dictionary.cpp` e `char_utils.cpp` do Hacker's Keyboard foram compilados com g++, com os parâmetros do app (`openNative(buf, 2, 2, tamanho)`, 18 palavras, 16 alternativas, até 48 caracteres).
  - `isValidWord`: 170.038 de 170.038 palavras válidas; não-palavras ("xqzwv", "nao", "voce", "obrigadoo") inválidas.
  - `getSuggestions`: 22 de 22 consultas trazem a palavra esperada. Exemplos: nao→não, voce→você, coracao→coração, informac→informação, brasil→Brasil, obrig→obrigado, p→para/por.
- **Leitor independente:** percorre o arquivo e mostra palavras e frequências idênticas às da fonte (170.038 de 170.038).
- `apktool b` (2.11.1) sem erros. No APK, `res/raw/main_pt.dict` está sem compressão e é idêntico ao arquivo validado. O ID 0x7f0b0000 era um espaço livre; `sheets_default` continua com 0x7f0b0001.

## Integração
- `res/raw/main_pt.dict` e `res/raw/notice_main_pt.txt`.
- Nova classe `MrDict.ids(Context, String idioma, int[] padrão)`: usa o prefixo do idioma antes de `_`/`-`, em minúsculas, e procura `raw/main_<idioma>`. Se encontrar, devolve esse recurso; senão, devolve o padrão. O app monta a localidade com `new Locale("pt_BR")` (idioma "pt_br"), por isso não foi usado qualificador de recurso (`raw-pt`).
- `LatinIME.initSuggest`: aplica `MrDict.ids` ao resultado de `getDictionary` com `mInputLocale`. Português (pt_BR, pt_PT ou pt) usa o dicionário embutido; outros idiomas continuam como antes (dicionários de outros apps).
- `InputLanguageSelection.hasDictionary`: mesmo critério, para a tela de idiomas reconhecer que português tem dicionário.
- `apktool.yml`/`apktool.json`: `dict` em `doNotCompress`. O `BinaryDictionary` calcula o tamanho com `available()` e lê por canal numa só passada; sem compressão a leitura é direta.
- Versão: 1.49.0 (código 1049000). Tamanho do APK montado: cerca de 2,8 MB.

## Preservado
Aprendizado de palavras, dicionário pessoal, dicionários de outros apps (usados quando não há dicionário embutido para o idioma), autocorreção (continua desligada por padrão) e sugestões na barra (1.4.8).

## Testes Android necessários
1. Ligar "Mostrar sugestões" com o idioma de entrada em português (padrão: idioma do sistema). Digitar "nao", "voce", "obrig" e conferir "não", "você", "obrigado" na linha de sugestões.
2. Logcat: deve aparecer `Loaded dictionary, len=1922681` (tag PCKeyboard).
3. Trocar o idioma de entrada para inglês: comportamento anterior (sem dicionário embutido).
4. Tela "Idiomas de entrada": português deve constar como com dicionário.
5. Uso de memória: o dicionário ocupa cerca de 1,9 MB em buffer direto enquanto o teclado está ativo.

## Observações
- A lista do AOSP tem algumas grafias raras ou incorretas com frequência baixa (ex.: "náo"), que podem aparecer depois das corretas.
- Não há próxima palavra (bigramas) no dicionário embutido; as previsões de próxima palavra continuam vindo do que o teclado aprende.
