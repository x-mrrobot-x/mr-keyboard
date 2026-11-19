.class Lcom/mrkeyboard/app/MrThemesActivity$16;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->loadScenes()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;)V
    .locals 0

    .prologue
    .line 709
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 711
    const/4 v0, 0x0

    :goto_0
    const/16 v1, 0x24

    if-ge v0, v1, :cond_0

    .line 713
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    const/4 v2, 0x2

    invoke-static {v1, v0, v2}, Lcom/mrkeyboard/app/MrScenes;->load(Landroid/content/Context;II)Landroid/graphics/Bitmap;

    move-result-object v1

    .line 714
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$16;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    new-instance v3, Lcom/mrkeyboard/app/MrThemesActivity$16$1;

    invoke-direct {v3, p0, v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity$16$1;-><init>(Lcom/mrkeyboard/app/MrThemesActivity$16;ILandroid/graphics/Bitmap;)V

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 711
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 721
    :cond_0
    return-void
.end method
