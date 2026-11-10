.class Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindSheet()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V
    .locals 0

    .prologue
    .line 328
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 330
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$1400(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/KeyEditDialog$Editor$7$1;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$7$1;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;)V

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$1600(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Ljava/lang/String;Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;)V

    .line 337
    return-void
.end method
