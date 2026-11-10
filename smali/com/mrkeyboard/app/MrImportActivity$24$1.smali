.class Lcom/mrkeyboard/app/MrImportActivity$24$1;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity$24;->progress(II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrImportActivity$24;

.field final synthetic val$done:I

.field final synthetic val$total:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity$24;II)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 776
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$24$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$24;

    iput p2, p0, Lcom/mrkeyboard/app/MrImportActivity$24$1;->val$done:I

    iput p3, p0, Lcom/mrkeyboard/app/MrImportActivity$24$1;->val$total:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .prologue
    .line 778
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$24$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$24;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$24;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1300(Lcom/mrkeyboard/app/MrImportActivity;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$24$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$24;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$24;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$3600(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$24$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$24;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrImportActivity$24;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$1900(Lcom/mrkeyboard/app/MrImportActivity;)Lcom/mrkeyboard/app/MrKit;

    move-result-object v1

    const-string v2, "mr_import_ai_progress"

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    iget v5, p0, Lcom/mrkeyboard/app/MrImportActivity$24$1;->val$done:I

    add-int/lit8 v5, v5, 0x1

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x1

    iget v5, p0, Lcom/mrkeyboard/app/MrImportActivity$24$1;->val$total:I

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 779
    :cond_0
    return-void
.end method
