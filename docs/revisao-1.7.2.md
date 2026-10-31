# 1.72 — Links não derrubam o app em aparelho sem navegador

## Pedido
Dois pontos da análise e do uso: o cartão "by x-mrrobot-x" (Sobre) abria o GitHub por um `<intent>` no XML, e o guia da tela principal tem o link "página do projeto" (*Informações adicionais*). Em aparelho sem navegador o toque não pode fechar o app.

## O que mudou
- **`MrLink`** (Java → smali): a regra de abrir link num lugar só.
  - `open(Context, url)`: intent `ACTION_VIEW` com `startActivity` dentro de `try/catch` de `ActivityNotFoundException`. Sem app para abrir o link, mostra um aviso e devolve `false`.
  - `protect(TextView)`: troca cada `URLSpan` do texto por um span próprio (mesmo trecho e mesmas marcas) que chama `open()`. A aparência do link não muda.
- **Cartão do autor** (`MrAuthor`): o `<intent>` saiu do `prefs.xml`; o clique é ligado no `LatinIMESettings.onCreate` (mesmo caminho do "Restaurar padrões", com guarda caso o cartão não exista) e usa `MrLink.open`. O clique devolve `true`, então o sistema não tenta abrir o link de novo.
- **Tela principal**: `Main.onCreate` chama `MrLink.protect` logo depois de pôr o texto do guia. Antes, o toque caía no `URLSpan` padrão do Android, que só chama `startActivity`: sem navegador, conforme a versão do Android, ou lança `ActivityNotFoundException` (fecha o app) ou só escreve no log (o toque parece não fazer nada).
- **Aviso nos três idiomas** (`mr_ui_link_no_browser`): "No app found to open the link" / "Nenhum app encontrado para abrir o link" / "No hay ninguna app para abrir el enlace". Se o texto não for achado, o aviso mostra o próprio link.

## Por que assim (documentação do Android)
Conferido na documentação oficial (guia *Fulfill common use cases while having limited package visibility*, seção *Open URLs*, `developer.android.com/training/package-visibility/use-cases`):
- para abrir uma URL, usa-se um intent com a ação `ACTION_VIEW`; o guia recomenda tratar o `ActivityNotFoundException` quando ele acontecer (caso incomum: nenhum app instalado abre a URL);
- não é preciso `<queries>` no manifest para abrir URLs (a visibilidade de pacotes só pesa se o app precisar saber **antes** se há navegador, o que não é o caso);
- a abordagem mais direta para um app que mira o Android 11 ou mais novo é chamar o intent e tratar a exceção, em vez de consultar com `resolveActivity()`.
Fica de fora, de propósito: Custom Tabs (exige a biblioteca `androidx.browser`, que o app não usa) e as marcas `FLAG_ACTIVITY_REQUIRE_NON_BROWSER`/`REQUIRE_DEFAULT` (servem para preferir um app que não seja navegador). O código captura só `ActivityNotFoundException`, como o guia manda, para não esconder outros erros. `FLAG_ACTIVITY_NEW_TASK`, que os exemplos do guia usam por poderem partir de contexto sem tela, não é preciso: os dois links partem de uma tela (`Activity`).

## Validação
- `author_test` (PC, 12 verificações): cartão do autor com navegador (abre, sem aviso) e sem navegador (`ActivityNotFoundException` vira aviso e devolve `false`; sem o texto do idioma mostra o link); um erro que não é falta de app **não** é engolido; o clique do cartão devolve `true`; `MrLink.protect` tira o `URLSpan`, põe o span seguro no mesmo trecho e com as mesmas marcas, abre uma vez com navegador, avisa sem navegador e aceita texto sem spans.
- `smali_regcheck.py`: 0 problemas; rótulos do `LatinIMESettings.onCreate`, `MrAuthor` e `MrLink` conferidos; nenhum recurso sem uso nem entrada de `public.xml` sem recurso; `mres_check.py` e `check_reset_keys.py` sem erro; XMLs de valores e telas válidos.
- **Não gerei o APK** (a pedido): o `apktool b` completo fica para o CI. No smali, os acréscimos fora das classes geradas são o bloco novo do `LatinIMESettings.onCreate` (copiado do que liga o "Restaurar padrões") e uma chamada em `Main.onCreate`, com o `TextView` que acabou de receber o texto.
- **Não testado no aparelho.**

## Testes Android necessários
1. *Configurações → Sobre*: tocar em "by x-mrrobot-x" abre o perfil no navegador.
2. Tela principal, em *Informações adicionais*: tocar em "página do projeto" abre o GitHub; o link continua sublinhado e na mesma cor.
3. Aparelho ou perfil **sem navegador** (ou navegador desativado em Apps): os dois toques mostram o aviso e o app continua aberto.
4. O aviso sai no idioma do app (inglês, português ou espanhol).
5. O cartão do autor continua com o mesmo visual; o "Restaurar padrões" e o resto do guia da tela principal continuam funcionando.
