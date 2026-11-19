.class Lcom/mrkeyboard/app/MrThemesActivity$15;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


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

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$softNow:[I

.field final synthetic val$softText:Landroid/widget/TextView;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;[ILandroid/widget/TextView;Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 792
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$15;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$15;->val$softNow:[I

    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$15;->val$softText:Landroid/widget/TextView;

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$15;->val$redraw:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 794
    if-nez p3, :cond_0

    .line 798
    :goto_0
    return-void

    .line 795
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$15;->val$softNow:[I

    const/16 v1, 0x46

    invoke-static {p2, v3, v1}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v1

    aput v1, v0, v3

    .line 796
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$15;->val$softText:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$15;->val$softNow:[I

    aget v2, v2, v3

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "%"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 797
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$15;->val$redraw:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    goto :goto_0
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    .prologue
    .line 801
    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    .prologue
    .line 804
    return-void
.end method
