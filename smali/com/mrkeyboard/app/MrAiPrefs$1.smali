.class Lcom/mrkeyboard/app/MrAiPrefs$1;
.super Ljava/lang/Object;
.source "MrAiPrefs.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrAiPrefs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrAiPrefs;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAiPrefs;)V
    .locals 0

    .prologue
    .line 36
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAiPrefs$1;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 38
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs$1;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrAiPrefs;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs$1;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrAiPrefs;->isDestroyed()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs$1;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrAiPrefs;->recreate()V

    .line 39
    :cond_0
    return-void
.end method
