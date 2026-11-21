.class Lcom/mrkeyboard/app/MrThemesActivity$41;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->loadScenes(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$todo:Ljava/util/List;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1684
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$41;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$41;->val$todo:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    .line 1686
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$41;->val$todo:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_0

    .line 1687
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$41;->val$todo:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 1688
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$41;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    const/4 v3, 0x2

    invoke-static {v2, v0, v3}, Lcom/mrkeyboard/app/MrScenes;->load(Landroid/content/Context;II)Landroid/graphics/Bitmap;

    move-result-object v2

    .line 1689
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$41;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    new-instance v4, Lcom/mrkeyboard/app/MrThemesActivity$41$1;

    invoke-direct {v4, p0, v0, v2}, Lcom/mrkeyboard/app/MrThemesActivity$41$1;-><init>(Lcom/mrkeyboard/app/MrThemesActivity$41;ILandroid/graphics/Bitmap;)V

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 1686
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 1696
    :cond_0
    return-void
.end method
