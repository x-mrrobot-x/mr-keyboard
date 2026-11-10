.class Lcom/mrkeyboard/app/PopupEditDialog$Editor$8;
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
    .line 246
    iput-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$8;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$Editor;

    iput p2, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$8;->val$index:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 248
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$8;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$Editor;

    iget v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$8;->val$index:I

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->access$800(Lcom/mrkeyboard/app/PopupEditDialog$Editor;I)V

    .line 249
    return-void
.end method
