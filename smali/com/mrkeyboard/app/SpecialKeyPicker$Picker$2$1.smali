.class Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2$1;
.super Ljava/lang/Object;
.source "SpecialKeyPicker.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2;->onShow(Landroid/content/DialogInterface;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2;)V
    .locals 0

    .prologue
    .line 191
    iput-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2$1;->this$1:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 193
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2$1;->this$1:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2;

    iget-object v0, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;

    invoke-static {v0}, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->access$300(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;)Landroid/app/AlertDialog;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    .line 194
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2$1;->this$1:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2;

    iget-object v0, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;

    invoke-static {v0}, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->access$400(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;)Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2$1;->this$1:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2;

    iget-object v1, v1, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;

    invoke-static {v1}, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->access$500(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2$1;->this$1:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2;

    iget-object v2, v2, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;

    invoke-static {v2}, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->access$600(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;)Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/SpecialKeyPicker;->showCustomCodeDialog(Landroid/content/Context;ILcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V

    .line 195
    return-void
.end method
