.class Lcom/mrkeyboard/app/MrLearnedActivity$2;
.super Ljava/lang/Object;
.source "MrLearnedActivity.java"

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrLearnedActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrLearnedActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrLearnedActivity;)V
    .locals 0

    .prologue
    .line 134
    iput-object p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$2;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 2

    .prologue
    .line 142
    if-nez p1, :cond_0

    const-string v0, ""

    .line 143
    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$2;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$000(Lcom/mrkeyboard/app/MrLearnedActivity;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 147
    :goto_1
    return-void

    .line 142
    :cond_0
    invoke-interface {p1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 144
    :cond_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$2;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$002(Lcom/mrkeyboard/app/MrLearnedActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 145
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$2;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    const/16 v1, 0x32

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$102(Lcom/mrkeyboard/app/MrLearnedActivity;I)I

    .line 146
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$2;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$200(Lcom/mrkeyboard/app/MrLearnedActivity;)V

    goto :goto_1
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 136
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 139
    return-void
.end method
