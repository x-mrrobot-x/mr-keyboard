# 1.1.1 — correção de inicialização

## Defeito encontrado
Em MrTools.init(), após `const/4 v0, 0x1`, havia instruções `sput-object v0` para o executor de tradução e para campos de MrEmotes. O inteiro não nulo 1 não é uma referência válida. Esse erro de tipos pode causar rejeição de MrTools pelo verificador do Android (VerifyError) logo na abertura do teclado.

Esse trecho era de limpeza e havia sido inserido incorretamente na inicialização. Foi removido de init() e transferido para release(), após `const/4 v0, 0x0`, onde zero representa null. A criação do executor continua no ponto correto de init().

As otimizações de cache, consultas e miniaturas da 1.1.0 foram mantidas.

## Verificações
- Regressão estática específica: init() apenas define sInited com true nesse trecho; limpeza de Emotes/executor ocorre em release() com null.
- Checagem estática limitada de constantes em campos de referência: 1.693 usos de armazenamento/retorno examinados sem violação detectada. Não é um verificador completo de tipos ou fluxo de controle.
- Mantidas as 17 verificações estáticas da otimização de Anexos.
- Montagem completa, desmontagem e remontagem para DEX sem erros.
- ZIP verificado.

Não houve execução do APK no Android nem acesso ao Logcat do aparelho. O erro encontrado é concreto e compatível com o fechamento na inicialização, mas a confirmação de que era a causa observada depende do Logcat ou de testar esta versão no aparelho. Se persistir, coletar FATAL EXCEPTION, Caused by e eventual VerifyError completo.
