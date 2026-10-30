.class Lcom/mrkeyboard/app/KeyEditDialog$6;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog;->showInternal(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$updateWidthLabel:Ljava/lang/Runnable;

.field final synthetic val$widthStepIdx:[I


# direct methods
.method constructor <init>([ILjava/lang/Runnable;)V
    .registers 3

    .line 363
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$6;->val$widthStepIdx:[I

    iput-object p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$6;->val$updateWidthLabel:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .registers 4

    .line 366
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$6;->val$widthStepIdx:[I

    const/4 p3, 0x0

    aput p2, p1, p3

    .line 367
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$6;->val$updateWidthLabel:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 368
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .registers 2

    .line 369
    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .registers 2

    .line 370
    return-void
.end method
