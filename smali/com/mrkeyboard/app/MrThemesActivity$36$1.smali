.class Lcom/mrkeyboard/app/MrThemesActivity$36$1;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity$36;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrThemesActivity$36;

.field final synthetic val$big:Landroid/graphics/Bitmap;

.field final synthetic val$small:Landroid/graphics/Bitmap;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity$36;Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1452
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$36$1;->this$1:Lcom/mrkeyboard/app/MrThemesActivity$36;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$36$1;->val$big:Landroid/graphics/Bitmap;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$36$1;->val$small:Landroid/graphics/Bitmap;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 1454
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$36$1;->this$1:Lcom/mrkeyboard/app/MrThemesActivity$36;

    iget v0, v0, Lcom/mrkeyboard/app/MrThemesActivity$36;->val$load:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$36$1;->this$1:Lcom/mrkeyboard/app/MrThemesActivity$36;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrThemesActivity$36;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget v1, v1, Lcom/mrkeyboard/app/MrThemesActivity;->mLoad:I

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$36$1;->this$1:Lcom/mrkeyboard/app/MrThemesActivity$36;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrThemesActivity$36;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrThemesActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1458
    :cond_0
    :goto_0
    return-void

    .line 1455
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$36$1;->this$1:Lcom/mrkeyboard/app/MrThemesActivity$36;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrThemesActivity$36;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$36$1;->val$big:Landroid/graphics/Bitmap;

    iput-object v1, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mImage:Landroid/graphics/Bitmap;

    .line 1456
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$36$1;->this$1:Lcom/mrkeyboard/app/MrThemesActivity$36;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrThemesActivity$36;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$36$1;->val$small:Landroid/graphics/Bitmap;

    iput-object v1, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mThumb:Landroid/graphics/Bitmap;

    .line 1457
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$36$1;->this$1:Lcom/mrkeyboard/app/MrThemesActivity$36;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrThemesActivity$36;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrThemesActivity;->refresh()V

    goto :goto_0
.end method
