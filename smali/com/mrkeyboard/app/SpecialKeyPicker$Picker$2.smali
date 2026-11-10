.class Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2;
.super Ljava/lang/Object;
.source "SpecialKeyPicker.java"

# interfaces
.implements Landroid/content/DialogInterface$OnShowListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->show()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;)V
    .locals 0

    .prologue
    .line 189
    iput-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onShow(Landroid/content/DialogInterface;)V
    .locals 2

    .prologue
    .line 191
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;

    invoke-static {v0}, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->access$300(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;)Landroid/app/AlertDialog;

    move-result-object v0

    const/4 v1, -0x3

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2$1;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2$1;-><init>(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 197
    return-void
.end method
