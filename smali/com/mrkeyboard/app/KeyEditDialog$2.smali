.class Lcom/mrkeyboard/app/KeyEditDialog$2;
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
.field final synthetic val$ctx:Landroid/content/Context;

.field final synthetic val$labelInput:Landroid/widget/EditText;

.field final synthetic val$selectedSpecialCode:[I

.field final synthetic val$specialPickBtn:Landroid/widget/TextView;


# direct methods
.method constructor <init>(Landroid/content/Context;[ILandroid/widget/TextView;Landroid/widget/EditText;)V
    .registers 5

    .line 271
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$2;->val$ctx:Landroid/content/Context;

    iput-object p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$2;->val$selectedSpecialCode:[I

    iput-object p3, p0, Lcom/mrkeyboard/app/KeyEditDialog$2;->val$specialPickBtn:Landroid/widget/TextView;

    iput-object p4, p0, Lcom/mrkeyboard/app/KeyEditDialog$2;->val$labelInput:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 4

    .line 274
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$2;->val$ctx:Landroid/content/Context;

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$2;->val$selectedSpecialCode:[I

    const/4 v1, 0x0

    aget v0, v0, v1

    new-instance v1, Lcom/mrkeyboard/app/KeyEditDialog$2$1;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/KeyEditDialog$2$1;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$2;)V

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/SpecialKeyPicker;->show(Landroid/content/Context;ILcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V

    .line 286
    return-void
.end method
