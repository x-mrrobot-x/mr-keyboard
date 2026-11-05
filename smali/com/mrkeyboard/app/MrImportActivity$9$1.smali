.class Lcom/mrkeyboard/app/MrImportActivity$9$1;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity$9;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrImportActivity$9;

.field final synthetic val$loaded:Ljava/lang/String;

.field final synthetic val$wasCut:Z


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity$9;Ljava/lang/String;Z)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 330
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$9;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->val$loaded:Ljava/lang/String;

    iput-boolean p3, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->val$wasCut:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .prologue
    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 332
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$9;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrImportActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 345
    :cond_0
    :goto_0
    return-void

    .line 333
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$9;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    const/4 v1, 0x0

    invoke-static {v0, v5, v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$1100(Lcom/mrkeyboard/app/MrImportActivity;ZLjava/lang/String;)V

    .line 334
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->val$loaded:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->val$loaded:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_4

    .line 335
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$9;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1200(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;

    move-result-object v1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$9;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1200(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;

    move-result-object v2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->val$loaded:Ljava/lang/String;

    if-nez v0, :cond_3

    const-string v0, "mr_import_read_failed"

    :goto_1
    new-array v3, v5, [Ljava/lang/Object;

    invoke-virtual {v2, v0, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    const-string v0, "mr_import_file_empty"

    goto :goto_1

    .line 338
    :cond_4
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$9;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1300(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/EditText;

    move-result-object v0

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 339
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$9;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->val$loaded:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$002(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 340
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$9;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->val$loaded:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    div-int/lit16 v1, v1, 0x400

    invoke-static {v6, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$1402(Lcom/mrkeyboard/app/MrImportActivity;I)I

    .line 341
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$9;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1500(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$9;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrImportActivity$9;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$1200(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;

    move-result-object v1

    const-string v2, "mr_import_file_loaded"

    new-array v3, v6, [Ljava/lang/Object;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$9;

    iget-object v4, v4, Lcom/mrkeyboard/app/MrImportActivity$9;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v4}, Lcom/mrkeyboard/app/MrImportActivity;->access$1400(Lcom/mrkeyboard/app/MrImportActivity;)I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v5

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 342
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$9;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1500(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setVisibility(I)V

    .line 343
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$9;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$900(Lcom/mrkeyboard/app/MrImportActivity;)V

    .line 344
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->val$wasCut:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$9;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1200(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$9;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrImportActivity$9;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$1200(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;

    move-result-object v1

    const-string v2, "mr_import_file_cut"

    new-array v3, v6, [Ljava/lang/Object;

    const/16 v4, 0x8

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v5

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->toast(Ljava/lang/String;)V

    goto/16 :goto_0
.end method
