.class Lcom/mrkeyboard/app/PopupEditDialog$Editor$9;
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
    .line 251
    iput-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$9;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$Editor;

    iput p2, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$9;->val$index:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 253
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$9;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->access$600(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)Ljava/util/ArrayList;

    move-result-object v0

    iget v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$9;->val$index:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 254
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$9;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->access$700(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)V

    .line 255
    return-void
.end method
