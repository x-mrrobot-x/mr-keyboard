.class Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$1;
.super Ljava/lang/Object;
.source "SpecialKeyPicker.java"

# interfaces
.implements Landroid/text/TextWatcher;


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
    .line 174
    iput-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$1;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 1

    .prologue
    .line 180
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$1;->this$0:Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;

    invoke-static {v0}, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->access$100(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;)V

    .line 181
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 175
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 177
    return-void
.end method
