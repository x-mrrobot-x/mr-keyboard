.class Lcom/mrkeyboard/app/MrThemesActivity$7;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->styleTabs()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$open:Landroid/widget/TextView;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/widget/TextView;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 430
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$7;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$7;->val$open:Landroid/widget/TextView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 432
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$7;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mStrip:Landroid/widget/HorizontalScrollView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$7;->val$open:Landroid/widget/TextView;

    invoke-virtual {v1}, Landroid/widget/TextView;->getLeft()I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$7;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v2, v2, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x42400000    # 48.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    sub-int/2addr v1, v2

    invoke-static {v4, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-virtual {v0, v1, v4}, Landroid/widget/HorizontalScrollView;->smoothScrollTo(II)V

    .line 433
    return-void
.end method
