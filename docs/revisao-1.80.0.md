# 1.80.0 — Editor de IA (diálogo na barra de ferramentas)

## Pedido
Entregar o Editor de IA como diálogo aberto pelo botão da barra de ferramentas, depois da revisão das mudanças (`diff`), e subir a versão do APK: `versionCode`/`versionName` no `apktool.yml` e no `apktool.json`, notas em `docs/revisao-<versão>.md` e as verificações de `docs/tools/`.

## Notas da release
**Português**
- Novo *Editor de IA*: o botão da barra abre um diálogo acima do teclado que reescreve o texto selecionado (ou o trecho antes do cursor) em estilos prontos (Formal, Curto, Corrigir, Expandir, Amigável, Profissional, Pontuação), estilos criados por você, com opção de emojificar, copiar, refazer e aplicar.
- O serviço é configurado em *Configurações → Editor de IA* (provedor pronto ou endereço e modelo próprios, chave de API e teste de conexão). Só endereços `https://` e sempre com chave.
- A chave de API fica só neste aparelho: não entra mais no backup na nuvem nem na transferência de aparelho. *Restaurar padrões* também apaga a chave.
- O diálogo usa sempre as cores das configurações e não muda com o tema do teclado.

**English**
- New *AI Editor*: the toolbar button opens a dialog above the keyboard that rewrites the selected text (or what is before the cursor) in ready-made styles (Formal, Short, Fix, Expand, Friendly, Professional, Punctuation) and in your own styles, with emojify, copy, redo and apply.
- The service is set up in *Settings → AI Editor* (ready-made provider or your own endpoint and model, API key and a connection test). Only `https://` endpoints, always with a key.
- The API key stays on this device: it is no longer part of cloud backup or device transfer. *Reset defaults* also clears the key.
- The dialog always uses the settings palette and does not change with the keyboard theme.

## O que mudou nesta revisão (sobre o diff do Editor de IA)
- **Só https + chave.** Saiu o suporte a `http://` e a exceção "sem chave" em `MrAi` (`configured`, `rewrite`) e no smali.
- **Cores sem hex duplicado.** Novo `mr_ai_scrim` (`#b8000000`) em `mr_colors.xml`, usado por `mr_ai_dialog.xml`. `MrAi.uiColor(nome)` e `MrAiStyleActivity.color(nome)` leem direto o recurso, sem fallback.
- **Sem `contentDescription`.** Removidos os 5 (4 do diálogo, 1 do botão da barra) e as strings `mr_ai_close`, `mr_ai_open_settings`, `mr_ai_copy`, `mr_ai_redo` e `mr_ai_tool` nos três idiomas.
- **Smali sem ruído.** Revertidos para o original `MrPacks`, `MrPacksActivity$2/4/4$1/6/7/8/8$1/9`, `MrSheetOpt$1/$2`, `MrTrigram$1` e `MrReset$1` (só ordem de anotações, `Signature "()V"` e linhas de debug).
- **`MrTune` mantido.** `NOT_FOCUSABLE` e o fechamento em `onWindowHidden` continuam, para o Editor de IA reaproveitar o padrão.
- **Chave de API fora do backup.** O valor vai para `SharedPreferences` `mr_ai` (chave `api_key`), arquivo que `backup_rules.xml` e `data_extraction_rules.xml` não incluem. A linha `pref_ai_key` do `prefs_ai.xml` ficou `persistent="false"`; `MrAiPrefs` grava/lê por `MrAi.setApiKey/apiKey` e `MrReset.apply` apaga o valor. `pref_ai_key` segue em `MrReset.KEYS` (limpa qualquer cópia antiga nas preferências padrão) e entrou nas exceções de `check_reset_keys.py`. Stub `EditTextPreference` novo para compilar.
- **Documentação.** Comentários de cabeçalho em v1.80; `docs/editor-ia.md` atualizado.
- **Versão.** `versionName` v1.80.0, `versionCode` 1080000 (1×1000000 + 80×1000 + 0) no `apktool.yml` e no `apktool.json`; `apkFileName` passa a `Mr Keyboard_v1.80.0.apk`.
- **Não mudou**: dicionários, motor nativo (`engine/`, `native/`, `.sha256`) e `lib/`; portanto sem `serial` novo de catálogo nem `libmrengine.so` para regerar.

## Verificado aqui
`check_version.py`, `check_catalog_url.py`, `check_reset_keys.py`, `mres_check.py`, `res_check.py` e `smali_regcheck.py smali` sem problemas; os fontes Java compilam contra os stubs. **Não rodou** `check_java_smali.sh`, `apktool b`, `verify_dex.sh` nem os testes de PC (sem dx, apktool nem `--release 8`). Os smali de `MrAi`, `MrAiPrefs`, `MrAiPrefs$5`, `MrAiStyleActivity` e `MrReset` foram ajustados à mão: regenere com `DX_JAR=… APKTOOL_JAR=… sh docs/tools/build_java.sh` antes de subir. Reverter `MrReset$1` deixa suas linhas de debug defasadas até essa regeneração. Não foi testado no aparelho.

## Conferir no aparelho
- Endereço `http://` ou sem chave: o Editor de IA recusa com a mensagem certa; com `https://` e chave, reescreve.
- Digitar a chave, sair e voltar: resumo "salva"; abrir a linha mostra o valor mascarado. *Restaurar padrões* volta a "não salva".
- Backup/transferência: a chave não vem junto no aparelho novo.
- Botão da barra e botões do diálogo funcionam sem `contentDescription`; fundo escurecido igual ao de antes.
- Trocar o tema do teclado não muda as cores do Editor de IA.
