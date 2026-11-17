.class Lcom/mrkeyboard/app/MrAppPicker$3;
.super Ljava/lang/Object;
.source "MrAppPicker.java"

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAppPicker;->open(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrAppPicker;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAppPicker;)V
    .locals 0

    .prologue
    .line 120
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$3;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 3

    .prologue
    .line 128
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$3;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAppPicker;->access$300(Lcom/mrkeyboard/app/MrAppPicker;)Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 132
    :goto_0
    return-void

    .line 129
    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker$3;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$3;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAppPicker;->access$300(Lcom/mrkeyboard/app/MrAppPicker;)Ljava/util/List;

    move-result-object v2

    if-nez p1, :cond_1

    const-string v0, ""

    :goto_1
    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrAppList;->filter(Ljava/util/List;Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrAppPicker;->access$402(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)Ljava/util/List;

    .line 130
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$3;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    const/16 v1, 0x1e

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAppPicker;->access$502(Lcom/mrkeyboard/app/MrAppPicker;I)I

    .line 131
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$3;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAppPicker;->access$600(Lcom/mrkeyboard/app/MrAppPicker;)V

    goto :goto_0

    .line 129
    :cond_1
    invoke-interface {p1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 122
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 125
    return-void
.end method
