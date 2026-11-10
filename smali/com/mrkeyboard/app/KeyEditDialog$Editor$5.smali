.class Lcom/mrkeyboard/app/KeyEditDialog$Editor$5;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindWidth(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

.field final synthetic val$width:F


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;F)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 298
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$5;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    iput p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$5;->val$width:F

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 300
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$5;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$900(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/SeekBar;

    move-result-object v0

    iget v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$5;->val$width:F

    const/high16 v2, 0x3f000000    # 0.5f

    sub-float/2addr v1, v2

    const/high16 v2, 0x3e800000    # 0.25f

    div-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 301
    return-void
.end method
