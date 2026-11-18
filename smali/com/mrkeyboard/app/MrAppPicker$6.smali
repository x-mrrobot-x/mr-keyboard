.class Lcom/mrkeyboard/app/MrAppPicker$6;
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
    .line 169
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$6;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 3

    .prologue
    .line 177
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker$6;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    if-nez p1, :cond_0

    const-string v0, ""

    :goto_0
    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrAppPicker;->access$402(Lcom/mrkeyboard/app/MrAppPicker;Ljava/lang/String;)Ljava/lang/String;

    .line 178
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$6;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAppPicker;->access$500(Lcom/mrkeyboard/app/MrAppPicker;)Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_1

    .line 181
    :goto_1
    return-void

    .line 177
    :cond_0
    invoke-interface {p1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 179
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$6;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker$6;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAppPicker;->access$500(Lcom/mrkeyboard/app/MrAppPicker;)Ljava/util/List;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker$6;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v2}, Lcom/mrkeyboard/app/MrAppPicker;->access$400(Lcom/mrkeyboard/app/MrAppPicker;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrAppList;->filter(Ljava/util/List;Ljava/lang/String;)Ljava/util/List;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAppPicker;->access$602(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)Ljava/util/List;

    .line 180
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$6;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    const/16 v1, 0x1e

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAppPicker;->access$700(Lcom/mrkeyboard/app/MrAppPicker;I)V

    goto :goto_1
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 171
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 174
    return-void
.end method
