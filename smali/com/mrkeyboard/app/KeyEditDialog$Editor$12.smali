.class Lcom/mrkeyboard/app/KeyEditDialog$Editor$12;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$Editor;->showTargetPicker(Ljava/lang/String;Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

.field final synthetic val$badges:Ljava/util/ArrayList;

.field final synthetic val$labels:Ljava/util/ArrayList;

.field final synthetic val$picked:Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;

.field final synthetic val$values:Ljava/util/ArrayList;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 551
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$12;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    iput-object p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$12;->val$picked:Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;

    iput-object p3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$12;->val$values:Ljava/util/ArrayList;

    iput-object p4, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$12;->val$badges:Ljava/util/ArrayList;

    iput-object p5, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$12;->val$labels:Ljava/util/ArrayList;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 4

    .prologue
    .line 553
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    .line 554
    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$12;->val$picked:Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$12;->val$values:Ljava/util/ArrayList;

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$12;->val$badges:Ljava/util/ArrayList;

    invoke-virtual {v1, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$12;->val$labels:Ljava/util/ArrayList;

    invoke-virtual {v2, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-interface {v3, v0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;->onPicked(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 555
    return-void
.end method
