.class Lcom/mrkeyboard/app/PopupEditDialog$5$2;
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

    .line 298
    iput-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$2;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$5;

    iput p2, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$2;->val$idx:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 4

    .line 301
    iget v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$2;->val$idx:I

    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$2;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$5;

    iget-object v1, v1, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$workingKeys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    if-ge v0, v1, :cond_2f

    .line 302
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$2;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$5;

    iget-object v0, v0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$workingKeys:Ljava/util/ArrayList;

    iget v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$2;->val$idx:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 303
    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$2;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$5;

    iget-object v1, v1, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$workingKeys:Ljava/util/ArrayList;

    iget v2, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$2;->val$idx:I

    add-int/lit8 v2, v2, 0x1

    invoke-virtual {v1, v2, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 304
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5$2;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$5;

    iget-object v0, v0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$refreshRef:[Ljava/lang/Runnable;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 306
    :cond_2f
    return-void
.end method
