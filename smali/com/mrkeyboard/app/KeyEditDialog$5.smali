.class Lcom/mrkeyboard/app/KeyEditDialog$5;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog;->showInternal(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$pt:Z

.field final synthetic val$widthStepIdx:[I

.field final synthetic val$widthTitle:Landroid/widget/TextView;


# direct methods
.method constructor <init>([ILandroid/widget/TextView;Z)V
    .registers 4

    .line 355
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$5;->val$widthStepIdx:[I

    iput-object p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$5;->val$widthTitle:Landroid/widget/TextView;

    iput-boolean p3, p0, Lcom/mrkeyboard/app/KeyEditDialog$5;->val$pt:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 5

    .line 358
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$5;->val$widthStepIdx:[I

    const/4 v1, 0x0

    aget v0, v0, v1

    int-to-float v0, v0

    const/high16 v1, 0x3e800000    # 0.25f

    mul-float/2addr v0, v1

    const/high16 v1, 0x3f000000    # 0.5f

    add-float/2addr v0, v1

    .line 359
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$5;->val$widthTitle:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-boolean v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$5;->val$pt:Z

    if-eqz v3, :cond_1a

    const-string v3, "Largura proporcional: "

    invoke-static/range {v3 .. v3}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :goto_1c

    :cond_1a
    const-string v3, "Proportional width: "

    :goto_1c
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    # invokes: Lcom/mrkeyboard/app/KeyEditDialog;->formatWidth(F)Ljava/lang/String;
    invoke-static {v0}, Lcom/mrkeyboard/app/KeyEditDialog;->access$100(F)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 360
    return-void
.end method
