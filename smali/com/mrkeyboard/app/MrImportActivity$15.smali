.class Lcom/mrkeyboard/app/MrImportActivity$15;
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
    .line 489
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$15;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity$15;->val$box:Landroid/widget/LinearLayout;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDismiss(Landroid/content/DialogInterface;)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 492
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$15;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$2300(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/widget/LinearLayout;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$15;->val$box:Landroid/widget/LinearLayout;

    if-ne v0, v1, :cond_0

    .line 493
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$15;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrImportActivity;->access$1702(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImport$Plan;)Lcom/mrkeyboard/app/MrImport$Plan;

    .line 494
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$15;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrImportActivity;->access$2302(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/LinearLayout;)Landroid/widget/LinearLayout;

    .line 495
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$15;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrImportActivity;->access$2402(Lcom/mrkeyboard/app/MrImportActivity;Landroid/app/AlertDialog;)Landroid/app/AlertDialog;

    .line 496
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$15;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrImportActivity;->access$2502(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/LinearLayout;)Landroid/widget/LinearLayout;

    .line 497
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$15;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrImportActivity;->access$2602(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/TextView;)Landroid/widget/TextView;

    .line 498
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$15;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrImportActivity;->access$2702(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/TextView;)Landroid/widget/TextView;

    .line 500
    :cond_0
    return-void
.end method
