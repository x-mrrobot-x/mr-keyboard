.class Lcom/mrkeyboard/app/KeyboardSwitcher$1;
.super Ljava/lang/Object;
.source "KeyboardSwitcher.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyboardSwitcher;->changeLatinKeyboardView(IZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/KeyboardSwitcher;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyboardSwitcher;)V
    .locals 0

    .line 643
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher$1;->this$0:Lcom/mrkeyboard/app/KeyboardSwitcher;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 645
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher$1;->this$0:Lcom/mrkeyboard/app/KeyboardSwitcher;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->access$100(Lcom/mrkeyboard/app/KeyboardSwitcher;)Lcom/mrkeyboard/app/LatinKeyboardView;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 646
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher$1;->this$0:Lcom/mrkeyboard/app/KeyboardSwitcher;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->access$200(Lcom/mrkeyboard/app/KeyboardSwitcher;)Lcom/mrkeyboard/app/LatinIME;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher$1;->this$0:Lcom/mrkeyboard/app/KeyboardSwitcher;

    invoke-static {v1}, Lcom/mrkeyboard/app/KeyboardSwitcher;->access$100(Lcom/mrkeyboard/app/KeyboardSwitcher;)Lcom/mrkeyboard/app/LatinKeyboardView;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/LatinIME;->setInputView(Landroid/view/View;)V

    .line 648
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher$1;->this$0:Lcom/mrkeyboard/app/KeyboardSwitcher;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->access$200(Lcom/mrkeyboard/app/KeyboardSwitcher;)Lcom/mrkeyboard/app/LatinIME;

    move-result-object v0

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->updateInputViewShown()V

    return-void
.end method
