.class Lcom/mrkeyboard/app/MrImportActivity$2;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrImportActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 147
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$2;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 1

    .prologue
    .line 155
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$2;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$000(Lcom/mrkeyboard/app/MrImportActivity;)V

    .line 157
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$2;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$100(Lcom/mrkeyboard/app/MrImportActivity;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    invoke-interface {p1}, Landroid/text/Editable;->length()I

    move-result v0

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$2;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$200(Lcom/mrkeyboard/app/MrImportActivity;)V

    .line 159
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$2;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$300(Lcom/mrkeyboard/app/MrImportActivity;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$2;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$400(Lcom/mrkeyboard/app/MrImportActivity;)V

    .line 160
    :cond_1
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 149
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 152
    return-void
.end method
