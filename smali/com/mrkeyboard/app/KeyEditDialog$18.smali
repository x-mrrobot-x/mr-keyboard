.class Lcom/mrkeyboard/app/KeyEditDialog$18;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog;->showSheetTargetDialog(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$badges:Ljava/util/ArrayList;

.field final synthetic val$cb:Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;

.field final synthetic val$ids:Ljava/util/ArrayList;

.field final synthetic val$titles:Ljava/util/ArrayList;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;)V
    .registers 5

    .line 635
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$18;->val$cb:Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;

    iput-object p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$18;->val$ids:Ljava/util/ArrayList;

    iput-object p3, p0, Lcom/mrkeyboard/app/KeyEditDialog$18;->val$badges:Ljava/util/ArrayList;

    iput-object p4, p0, Lcom/mrkeyboard/app/KeyEditDialog$18;->val$titles:Ljava/util/ArrayList;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .registers 6

    .line 638
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    .line 639
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$18;->val$cb:Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$18;->val$ids:Ljava/util/ArrayList;

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$18;->val$badges:Ljava/util/ArrayList;

    invoke-virtual {v1, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$18;->val$titles:Ljava/util/ArrayList;

    invoke-virtual {v2, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/String;

    invoke-interface {p1, v0, v1, p2}, Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;->onPicked(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 640
    return-void
.end method
