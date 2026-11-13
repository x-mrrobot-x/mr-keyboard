.class Lcom/mrkeyboard/app/MrGestureInput$3;
.super Ljava/lang/Object;
.source "MrGestureInput.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrGestureInput;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 742
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 744
    invoke-static {v2}, Lcom/mrkeyboard/app/MrGestureInput;->access$002(Z)Z

    .line 746
    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->access$100()I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->access$200()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->access$300()Lcom/mrkeyboard/app/LatinKeyboardView;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->access$400()I

    move-result v0

    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->access$500()I

    move-result v1

    if-le v0, v1, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrGestureInput;->access$300()Lcom/mrkeyboard/app/LatinKeyboardView;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrGestureInput;->access$600(Lcom/mrkeyboard/app/LatinKeyboardView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 750
    :cond_0
    :goto_0
    return-void

    .line 747
    :catch_0
    move-exception v0

    .line 748
    invoke-static {v2}, Lcom/mrkeyboard/app/MrGestureInput;->access$202(Z)Z

    goto :goto_0
.end method
