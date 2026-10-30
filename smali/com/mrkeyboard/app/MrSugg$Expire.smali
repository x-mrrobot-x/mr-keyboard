.class final Lcom/mrkeyboard/app/MrSugg$Expire;
.super Ljava/lang/Object;
.source "MrSugg.java"

# Fim da espera de MrSugg: depois de DELAY sem sugestoes, a linha mostra as ferramentas.

# interfaces
.implements Ljava/lang/Runnable;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 0

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->expire()V

    return-void
.end method
