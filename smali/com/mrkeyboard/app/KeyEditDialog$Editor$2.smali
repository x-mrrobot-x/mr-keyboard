.class Lcom/mrkeyboard/app/KeyEditDialog$Editor$2;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bind(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

.field final synthetic val$type:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 214
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$2;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    iput-object p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$2;->val$type:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 216
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$2;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$2;->val$type:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$200(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Ljava/lang/String;)V

    .line 217
    return-void
.end method
