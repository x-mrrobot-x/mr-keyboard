.class Lcom/mrkeyboard/app/MrTourActivity$4;
.super Ljava/lang/Object;
.source "MrTourActivity.java"

# interfaces
.implements Landroid/animation/ValueAnimator$AnimatorUpdateListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrTourActivity;->growFill(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrTourActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrTourActivity;)V
    .locals 0

    .prologue
    .line 495
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTourActivity$4;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationUpdate(Landroid/animation/ValueAnimator;)V
    .locals 2

    .prologue
    .line 497
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity$4;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-virtual {p1}, Landroid/animation/ValueAnimator;->getAnimatedValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$702(Lcom/mrkeyboard/app/MrTourActivity;I)I

    .line 498
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$4;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$800(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/graphics/drawable/ClipDrawable;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity$4;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$700(Lcom/mrkeyboard/app/MrTourActivity;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/ClipDrawable;->setLevel(I)Z

    .line 499
    return-void
.end method
