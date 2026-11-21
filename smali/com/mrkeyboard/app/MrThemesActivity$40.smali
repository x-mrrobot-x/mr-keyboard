.class Lcom/mrkeyboard/app/MrThemesActivity$40;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->loadImage()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$load:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1652
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$40;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$40;->val$load:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 1654
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$40;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->load(Landroid/content/Context;)Landroid/graphics/Bitmap;

    move-result-object v1

    .line 1655
    if-nez v1, :cond_0

    const/4 v0, 0x0

    .line 1656
    :goto_0
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$40;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    new-instance v3, Lcom/mrkeyboard/app/MrThemesActivity$40$1;

    invoke-direct {v3, p0, v1, v0}, Lcom/mrkeyboard/app/MrThemesActivity$40$1;-><init>(Lcom/mrkeyboard/app/MrThemesActivity$40;Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;)V

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 1664
    return-void

    .line 1655
    :cond_0
    invoke-static {v1}, Lcom/mrkeyboard/app/MrThemesActivity;->thumb(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v0

    goto :goto_0
.end method
