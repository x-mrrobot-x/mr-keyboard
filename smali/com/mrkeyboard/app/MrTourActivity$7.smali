.class Lcom/mrkeyboard/app/MrTourActivity$7;
.super Ljava/lang/Object;
.source "MrTourActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrTourActivity;->go(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrTourActivity;

.field final synthetic val$dist:F

.field final synthetic val$target:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrTourActivity;IF)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 620
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTourActivity$7;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    iput p2, p0, Lcom/mrkeyboard/app/MrTourActivity$7;->val$target:I

    iput p3, p0, Lcom/mrkeyboard/app/MrTourActivity$7;->val$dist:F

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 622
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$7;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    iget v1, p0, Lcom/mrkeyboard/app/MrTourActivity$7;->val$target:I

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$1102(Lcom/mrkeyboard/app/MrTourActivity;I)I

    .line 623
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$7;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$1200(Lcom/mrkeyboard/app/MrTourActivity;)V

    .line 624
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$7;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    const/4 v1, -0x1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$1302(Lcom/mrkeyboard/app/MrTourActivity;I)I

    .line 625
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$7;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$400(Lcom/mrkeyboard/app/MrTourActivity;Z)V

    .line 626
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$7;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity$7;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$200(Lcom/mrkeyboard/app/MrTourActivity;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$302(Lcom/mrkeyboard/app/MrTourActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 627
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$7;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$1400(Lcom/mrkeyboard/app/MrTourActivity;Z)V

    .line 628
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$7;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$000(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/widget/LinearLayout;

    move-result-object v0

    iget v1, p0, Lcom/mrkeyboard/app/MrTourActivity$7;->val$dist:F

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setTranslationX(F)V

    .line 629
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$7;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$000(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->translationX(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    const-wide/16 v2, 0x154

    invoke-virtual {v0, v2, v3}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity$7;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$1700(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/view/animation/PathInterpolator;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/MrTourActivity$7$1;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrTourActivity$7$1;-><init>(Lcom/mrkeyboard/app/MrTourActivity$7;)V

    invoke-virtual {v0, v1}, Landroid/view/ViewPropertyAnimator;->withEndAction(Ljava/lang/Runnable;)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    .line 635
    invoke-virtual {v0}, Landroid/view/ViewPropertyAnimator;->start()V

    .line 636
    return-void
.end method
