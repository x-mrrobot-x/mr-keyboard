.class Lcom/mrkeyboard/app/SpecialKeyPicker$3$1;
.super Ljava/lang/Object;
.source "SpecialKeyPicker.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SpecialKeyPicker$3;->onShow(Landroid/content/DialogInterface;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$3;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SpecialKeyPicker$3;)V
    .registers 2

    .line 257
    iput-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$3$1;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 4

    .line 260
    iget-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$3$1;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$3;

    iget-object p1, p1, Lcom/mrkeyboard/app/SpecialKeyPicker$3;->val$dialog:Landroid/app/AlertDialog;

    invoke-virtual {p1}, Landroid/app/AlertDialog;->dismiss()V

    .line 261
    iget-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$3$1;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$3;

    iget-object p1, p1, Lcom/mrkeyboard/app/SpecialKeyPicker$3;->val$ctx:Landroid/content/Context;

    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$3$1;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$3;

    iget v0, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$3;->val$currentCode:I

    iget-object v1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$3$1;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$3;

    iget-object v1, v1, Lcom/mrkeyboard/app/SpecialKeyPicker$3;->val$listener:Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

    # invokes: Lcom/mrkeyboard/app/SpecialKeyPicker;->showCustomCodeDialog(Landroid/content/Context;ILcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V
    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/SpecialKeyPicker;->access$100(Landroid/content/Context;ILcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V

    .line 262
    return-void
.end method
