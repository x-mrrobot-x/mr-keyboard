.class final Lcom/mrkeyboard/app/MrKeep$Tick;
.super Ljava/lang/Object;
.source "MrKeep.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrKeep;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Tick"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 155
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/mrkeyboard/app/MrKeep$1;)V
    .locals 0

    .prologue
    .line 155
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrKeep$Tick;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 157
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeep;->access$102(Z)Z

    .line 158
    invoke-static {}, Lcom/mrkeyboard/app/MrKeep;->tick()V

    .line 159
    return-void
.end method
