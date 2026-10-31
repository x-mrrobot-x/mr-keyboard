# 1.77.1 — Motor nativo de sugestões incluído no APK

## Pedido
A 1.77.0 trouxe o código do motor nativo (`MrNative`), mas o APK testado só passou a ter a `libmrengine.so` no commit seguinte, sem versão nova. A lib foi validada no aparelho; esta versão leva o motor nativo aos usuários.

## Notas da release
**Português**
- O teclado agora usa o novo motor de sugestões nativo (C++) para a correção e a previsão por duas palavras: as mesmas sugestões de antes, com bem menos memória. Se o motor nativo não estiver disponível no aparelho, o teclado usa o de antes, sem diferença.
- Em Configurações → Sugestões e dicionários, a linha "Motor de sugestões" mostra qual está em uso.

**English**
- The keyboard now uses the new native suggestion engine (C++) for correction and two-word prediction: the same suggestions as before, with much less memory. If the native engine is not available on the device, the keyboard uses the previous one, with no difference.
- In Settings → Suggestions and dictionaries, the "Suggestion engine" line shows which one is in use.

## O que mudou
- **Só a versão**: 1.77.1 (`versionCode` 1077001). Os binários (`lib/<abi>/libmrengine.so`, contrato 1, código `de68890a…`, commit `6eb5fedc…` do `mr-engine`) já estavam no repositório desde `docs/revisao-ci-libmrengine.md`; nenhum código, recurso ou dicionário mudou.
- Uma versão nova faz o workflow do APK publicar a Release sozinho (se houver chave nos secrets).
- `docs/melhorias-motor.md`: o item 9a passa a constar como validado no aparelho.

## Validação
- Validado no aparelho pelo mantenedor (Android) com a lib dentro do APK, seguindo os testes de `docs/revisao-1.7.7.md`. Aparelho, ABI e versão do Android não foram informados.
- Medidas de PC (paridade 0 diferenças, velocidade 1,8 a 2,0× na busca, trigramas ~0 MB no heap Java) e verificações estáticas: ver `docs/revisao-1.7.7.md`.
- `check_version.py` ok. Nenhuma montagem de APK foi feita para esta versão (só mudou o número).

## Voltar atrás
Apagar os três `libmrengine.so` (e os dois `mrengine-*`) e publicar uma versão nova: o app volta ao Java sozinho.
