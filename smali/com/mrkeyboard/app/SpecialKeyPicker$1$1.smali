.class Lcom/mrkeyboard/app/SpecialKeyPicker$1$1;
.super Ljava/lang/Object;
.source "SpecialKeyPicker.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SpecialKeyPicker$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$1;

.field final synthetic val$entry:Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SpecialKeyPicker$1;Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;)V
    .registers 3

    .line 215
    iput-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1$1;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$1;

    iput-object p2, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1$1;->val$entry:Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 4

    .line 218
    iget-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1$1;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$1;

    iget-object p1, p1, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$dialog:Landroid/app/AlertDialog;

    invoke-virtual {p1}, Landroid/app/AlertDialog;->dismiss()V

    .line 219
    iget-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1$1;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$1;

    iget-object p1, p1, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$listener:Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

    if-eqz p1, :cond_1c

    .line 220
    iget-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1$1;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$1;

    iget-object p1, p1, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$listener:Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1$1;->val$entry:Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    iget v0, v0, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->code:I

    iget-object v1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1$1;->val$entry:Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    iget-object v1, v1, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->defaultLabel:Ljava/lang/String;

    invoke-interface {p1, v0, v1}, Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;->onSpecialKeySelected(ILjava/lang/String;)V

    .line 222
    :cond_1c
    return-void
.end method
