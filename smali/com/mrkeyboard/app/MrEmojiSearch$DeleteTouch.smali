.class final Lcom/mrkeyboard/app/MrEmojiSearch$DeleteTouch;
.super Ljava/lang/Object;
.source "MrEmojiSearch.java"

# interfaces
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrEmojiSearch;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "DeleteTouch"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 378
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/mrkeyboard/app/MrEmojiSearch$1;)V
    .locals 0

    .prologue
    .line 378
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrEmojiSearch$DeleteTouch;-><init>()V

    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 5

    .prologue
    const/4 v3, -0x5

    const/4 v4, 0x1

    .line 380
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    .line 381
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 382
    if-nez v0, :cond_2

    .line 383
    const v0, 0x3f19999a    # 0.6f

    invoke-virtual {p1, v0}, Landroid/view/View;->setAlpha(F)V

    .line 384
    if-eqz v1, :cond_0

    invoke-virtual {v1, v3}, Lcom/mrkeyboard/app/LatinIME;->onPress(I)V

    .line 385
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->access$000()V

    .line 386
    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->access$100()Landroid/os/Handler;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 387
    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->access$100()Landroid/os/Handler;

    move-result-object v0

    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->access$400()Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 388
    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->access$100()Landroid/os/Handler;

    move-result-object v0

    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->access$400()Ljava/lang/Runnable;

    move-result-object v1

    const-wide/16 v2, 0x190

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 398
    :cond_1
    :goto_0
    return v4

    .line 392
    :cond_2
    if-eq v0, v4, :cond_3

    const/4 v2, 0x3

    if-ne v0, v2, :cond_1

    .line 393
    :cond_3
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-virtual {p1, v0}, Landroid/view/View;->setAlpha(F)V

    .line 394
    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->access$500()V

    .line 395
    if-eqz v1, :cond_1

    invoke-virtual {v1, v3}, Lcom/mrkeyboard/app/LatinIME;->onRelease(I)V

    goto :goto_0
.end method
