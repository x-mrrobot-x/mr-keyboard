.class Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindSpecial()V
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
    .line 309
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 311
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$1100(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$1200(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)I

    move-result v1

    new-instance v2, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6$1;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6$1;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;)V

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/SpecialKeyPicker;->show(Landroid/content/Context;ILcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V

    .line 321
    return-void
.end method
