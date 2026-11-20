.class Lcom/mrkeyboard/app/MrThemesActivity$38$1;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity$38;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrThemesActivity$38;

.field final synthetic val$index:I

.field final synthetic val$small:Landroid/graphics/Bitmap;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity$38;ILandroid/graphics/Bitmap;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1570
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$38$1;->this$1:Lcom/mrkeyboard/app/MrThemesActivity$38;

    iput p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$38$1;->val$index:I

    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$38$1;->val$small:Landroid/graphics/Bitmap;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 1572
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$38$1;->this$1:Lcom/mrkeyboard/app/MrThemesActivity$38;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrThemesActivity$38;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrThemesActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1574
    :goto_0
    return-void

    .line 1573
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$38$1;->this$1:Lcom/mrkeyboard/app/MrThemesActivity$38;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrThemesActivity$38;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$38$1;->val$index:I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$38$1;->val$small:Landroid/graphics/Bitmap;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->sceneLoaded(ILandroid/graphics/Bitmap;)V

    goto :goto_0
.end method
