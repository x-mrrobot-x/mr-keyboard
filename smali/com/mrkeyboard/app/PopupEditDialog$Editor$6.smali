.class Lcom/mrkeyboard/app/PopupEditDialog$Editor$6;
.super Ljava/lang/Object;
.source "PopupEditDialog.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PopupEditDialog$Editor;->refresh()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PopupEditDialog$Editor;

.field final synthetic val$index:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PopupEditDialog$Editor;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 230
    iput-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$6;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$Editor;

    iput p2, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$6;->val$index:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 232
    iget v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$6;->val$index:I

    if-lez v0, :cond_0

    .line 233
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$6;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->access$600(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)Ljava/util/ArrayList;

    move-result-object v1

    iget v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$6;->val$index:I

    add-int/lit8 v2, v0, -0x1

    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$6;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->access$600(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)Ljava/util/ArrayList;

    move-result-object v0

    iget v3, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$6;->val$index:I

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v1, v2, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 234
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$6;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->access$700(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)V

    .line 236
    :cond_0
    return-void
.end method
