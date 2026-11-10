.class Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$3;
.super Ljava/lang/Object;
.source "SpecialKeyPicker.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->buildRow(Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;Ljava/lang/String;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;

.field final synthetic val$entry:Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 247
    iput-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$3;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;

    iput-object p2, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$3;->val$entry:Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 249
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$3;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;

    invoke-static {v0}, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->access$300(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;)Landroid/app/AlertDialog;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    .line 250
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$3;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;

    invoke-static {v0}, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->access$600(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;)Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$3;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;

    invoke-static {v0}, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->access$600(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;)Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$3;->val$entry:Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    iget v1, v1, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->code:I

    iget-object v2, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$3;->val$entry:Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    iget-object v2, v2, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->defaultLabel:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;->onSpecialKeySelected(ILjava/lang/String;)V

    .line 251
    :cond_0
    return-void
.end method
