.class Lcom/mrkeyboard/app/MrKit$1$1;
.super Ljava/lang/Object;
.source "MrKit.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrKit$1;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrKit$1;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrKit$1;)V
    .locals 0

    .prologue
    .line 197
    iput-object p1, p0, Lcom/mrkeyboard/app/MrKit$1$1;->this$1:Lcom/mrkeyboard/app/MrKit$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    .prologue
    .line 199
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    .line 200
    iget-object v0, p0, Lcom/mrkeyboard/app/MrKit$1$1;->this$1:Lcom/mrkeyboard/app/MrKit$1;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrKit$1;->val$langs:Ljava/util/List;

    invoke-interface {v0, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 201
    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit$1$1;->this$1:Lcom/mrkeyboard/app/MrKit$1;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrKit$1;->val$current:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit$1$1;->this$1:Lcom/mrkeyboard/app/MrKit$1;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrKit$1;->val$onPick:Lcom/mrkeyboard/app/MrKit$LangPick;

    invoke-interface {v1, v0}, Lcom/mrkeyboard/app/MrKit$LangPick;->onPick(Ljava/lang/String;)V

    .line 202
    :cond_0
    return-void
.end method
