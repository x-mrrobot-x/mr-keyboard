.class Lcom/mrkeyboard/app/MrImportActivity$17;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnDismissListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity;->showPreview()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrImportActivity;

.field final synthetic val$box:Landroid/widget/LinearLayout;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/LinearLayout;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 557
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$17;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity$17;->val$box:Landroid/widget/LinearLayout;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDismiss(Landroid/content/DialogInterface;)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 560
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$17;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$2600(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/LinearLayout;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$17;->val$box:Landroid/widget/LinearLayout;

    if-ne v0, v1, :cond_0

    .line 561
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$17;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrImportActivity;->access$2002(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImport$Plan;)Lcom/mrkeyboard/app/MrImport$Plan;

    .line 562
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$17;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrImportActivity;->access$2602(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/LinearLayout;)Landroid/widget/LinearLayout;

    .line 563
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$17;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrImportActivity;->access$2702(Lcom/mrkeyboard/app/MrImportActivity;Landroid/app/AlertDialog;)Landroid/app/AlertDialog;

    .line 564
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$17;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrImportActivity;->access$2802(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/LinearLayout;)Landroid/widget/LinearLayout;

    .line 565
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$17;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrImportActivity;->access$2902(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/TextView;)Landroid/widget/TextView;

    .line 566
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$17;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrImportActivity;->access$3002(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/TextView;)Landroid/widget/TextView;

    .line 568
    :cond_0
    return-void
.end method
