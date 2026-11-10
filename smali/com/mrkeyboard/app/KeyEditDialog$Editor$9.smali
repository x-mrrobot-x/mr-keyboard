.class Lcom/mrkeyboard/app/KeyEditDialog$Editor$9;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindAction(Landroid/view/View;Ljava/lang/String;ZI)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

.field final synthetic val$action:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 367
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$9;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    iput p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$9;->val$action:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 369
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$9;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    iget v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$9;->val$action:I

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$2000(Lcom/mrkeyboard/app/KeyEditDialog$Editor;I)V

    .line 370
    return-void
.end method
