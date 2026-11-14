.class Lcom/mrkeyboard/app/LatinIME$1;
.super Landroid/os/Handler;
.source "LatinIME.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/LatinIME;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/LatinIME;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/LatinIME;)V
    .locals 1

    .line 339
    iput-object p1, p0, Lcom/mrkeyboard/app/LatinIME$1;->this$0:Lcom/mrkeyboard/app/LatinIME;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-direct {p0, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 1

    # Performance meter (MrPerf, docs/plan-performance.md stage 6): no register used.
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->msgBegin()V

    .line 342
    iget p1, p1, Landroid/os/Message;->what:I

    if-eqz p1, :cond_2

    const/4 v0, 0x2

    if-eq p1, v0, :cond_1

    const/4 v0, 0x4

    if-eq p1, v0, :cond_0

    const/4 v0, 0x5

    if-eq p1, v0, :cond_mr_echo

    goto :goto_0

    # Delayed echo (docs/plan-performance.md stage 6 part 7): the reaction to the echo of our own separator that waited.
    :cond_mr_echo
    iget-object p1, p0, Lcom/mrkeyboard/app/LatinIME$1;->this$0:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {p1}, Lcom/mrkeyboard/app/LatinIME;->mrEchoRun()V

    goto :goto_0

    .line 347
    :cond_0
    iget-object p1, p0, Lcom/mrkeyboard/app/LatinIME$1;->this$0:Lcom/mrkeyboard/app/LatinIME;

    invoke-static {p1}, Lcom/mrkeyboard/app/LatinIME;->access$200(Lcom/mrkeyboard/app/LatinIME;)V

    goto :goto_0

    .line 350
    :cond_1
    iget-object p1, p0, Lcom/mrkeyboard/app/LatinIME$1;->this$0:Lcom/mrkeyboard/app/LatinIME;

    iget-object v0, p0, Lcom/mrkeyboard/app/LatinIME$1;->this$0:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/mrkeyboard/app/LatinIME;->updateShiftKeyState(Landroid/view/inputmethod/EditorInfo;)V

    goto :goto_0

    .line 344
    :cond_2
    iget-object p1, p0, Lcom/mrkeyboard/app/LatinIME$1;->this$0:Lcom/mrkeyboard/app/LatinIME;

    invoke-static {p1}, Lcom/mrkeyboard/app/LatinIME;->access$100(Lcom/mrkeyboard/app/LatinIME;)V

    :goto_0
    # Performance meter (MrPerf, docs/plan-performance.md stage 6): no register used.
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->msgEnd()V

    return-void
.end method
