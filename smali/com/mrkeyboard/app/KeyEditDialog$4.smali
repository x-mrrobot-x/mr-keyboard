.class Lcom/mrkeyboard/app/KeyEditDialog$4;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog;->showInternal(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$pw:F

.field final synthetic val$seek:Landroid/widget/SeekBar;


# direct methods
.method constructor <init>(Landroid/widget/SeekBar;F)V
    .registers 3

    .line 345
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$4;->val$seek:Landroid/widget/SeekBar;

    iput p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$4;->val$pw:F

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 4

    .line 348
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$4;->val$seek:Landroid/widget/SeekBar;

    iget v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$4;->val$pw:F

    const/high16 v1, 0x3f000000    # 0.5f

    sub-float/2addr v0, v1

    const/high16 v1, 0x3e800000    # 0.25f

    div-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 349
    return-void
.end method
