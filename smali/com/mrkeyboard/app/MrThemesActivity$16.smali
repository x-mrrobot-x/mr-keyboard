.class Lcom/mrkeyboard/app/MrThemesActivity$16;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->showPreview(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;IZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$chips:Landroid/widget/LinearLayout;

.field final synthetic val$draw:[Ljava/lang/Runnable;

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$style:[I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/widget/LinearLayout;[ILjava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 767
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$chips:Landroid/widget/LinearLayout;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$style:[I

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$redraw:Ljava/lang/Runnable;

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$draw:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .prologue
    const/4 v6, -0x2

    const/4 v1, 0x0

    .line 769
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$chips:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    move v0, v1

    .line 770
    :goto_0
    sget v2, Lcom/mrkeyboard/app/MrBackdrop;->STYLES:I

    if-ge v0, v2, :cond_2

    .line 772
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v3, v2, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->styleName(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v4

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$style:[I

    aget v2, v2, v1

    if-ne v0, v2, :cond_1

    const/4 v2, 0x1

    :goto_1
    new-instance v5, Lcom/mrkeyboard/app/MrThemesActivity$16$1;

    invoke-direct {v5, p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity$16$1;-><init>(Lcom/mrkeyboard/app/MrThemesActivity$16;I)V

    invoke-virtual {v3, v4, v2, v5}, Lcom/mrkeyboard/app/MrKit;->chip(Ljava/lang/String;ZLandroid/view/View$OnClickListener;)Landroid/widget/TextView;

    move-result-object v2

    .line 779
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v6, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 780
    if-lez v0, :cond_0

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v4, v4, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x41000000    # 8.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    invoke-virtual {v3, v4, v1, v1, v1}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 781
    :cond_0
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$chips:Landroid/widget/LinearLayout;

    invoke-virtual {v4, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 770
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    move v2, v1

    .line 772
    goto :goto_1

    .line 783
    :cond_2
    return-void
.end method
