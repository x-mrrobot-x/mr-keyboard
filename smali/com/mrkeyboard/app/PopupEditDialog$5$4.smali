.class Lcom/mrkeyboard/app/PopupEditDialog$5$4;
.super Ljava/lang/Object;
.source "PopupEditDialog.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PopupEditDialog$5;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PopupEditDialog$5;

.field final synthetic val$idx:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PopupEditDialog$5;I)V
    .registers 3

    .line 320
    iput-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$4;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$5;

    iput p2, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$4;->val$idx:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 3

    .line 323
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$4;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$5;

    iget-object v0, v0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$workingKeys:Ljava/util/ArrayList;

    iget v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$4;->val$idx:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 324
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$4;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$5;

    iget-object v0, v0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$refreshRef:[Ljava/lang/Runnable;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 325
    return-void
.end method
