.class Lcom/mrkeyboard/app/MrThemesActivity$35;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->showCrop(Landroid/graphics/Bitmap;Lcom/mrkeyboard/app/MrBackdrop$Spec;IZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$bitmap:Landroid/graphics/Bitmap;

.field final synthetic val$crop:Lcom/mrkeyboard/app/MrCropView;

.field final synthetic val$pending:Z

.field final synthetic val$softNow:[I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;ZLcom/mrkeyboard/app/MrCropView;Landroid/graphics/Bitmap;[I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1226
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-boolean p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->val$pending:Z

    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->val$crop:Lcom/mrkeyboard/app/MrCropView;

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->val$bitmap:Landroid/graphics/Bitmap;

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->val$softNow:[I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 6

    .prologue
    .line 1228
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->val$pending:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->pendingStamp(Landroid/content/Context;)J

    move-result-wide v0

    .line 1229
    :goto_0
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->val$crop:Lcom/mrkeyboard/app/MrCropView;

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrCropView;->zoom()I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->val$crop:Lcom/mrkeyboard/app/MrCropView;

    invoke-virtual {v4}, Lcom/mrkeyboard/app/MrCropView;->dx()I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->val$crop:Lcom/mrkeyboard/app/MrCropView;

    invoke-virtual {v5}, Lcom/mrkeyboard/app/MrCropView;->dy()I

    move-result v5

    invoke-static {v3, v4, v5, v0, v1}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->image(IIIJ)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->val$bitmap:Landroid/graphics/Bitmap;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->val$softNow:[I

    const/4 v4, 0x0

    aget v3, v3, v4

    iget-boolean v4, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->val$pending:Z

    invoke-virtual {v2, v0, v1, v3, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->showPreview(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;IZ)V

    .line 1230
    return-void

    .line 1228
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$35;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->imageStamp(Landroid/content/Context;)J

    move-result-wide v0

    goto :goto_0
.end method
