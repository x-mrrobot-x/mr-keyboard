.class Lcom/mrkeyboard/app/KeyEditDialog$17;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnShowListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog;->showInternal(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$allSheets:Ljava/util/List;

.field final synthetic val$ctx:Landroid/content/Context;

.field final synthetic val$dialog:Landroid/app/AlertDialog;

.field final synthetic val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

.field final synthetic val$isPopupItem:Z

.field final synthetic val$labelInput:Landroid/widget/EditText;

.field final synthetic val$listener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

.field final synthetic val$pt:Z

.field final synthetic val$selectedSheetTarget:[Ljava/lang/String;

.field final synthetic val$selectedSpecialCode:[I

.field final synthetic val$taskerInput:Landroid/widget/EditText;

.field final synthetic val$textValueInput:Landroid/widget/EditText;

.field final synthetic val$widthStepIdx:[I


# direct methods
.method constructor <init>(Landroid/app/AlertDialog;Landroid/widget/EditText;Z[ILcom/mrkeyboard/app/SheetModel$KeySpec;Landroid/widget/EditText;Landroid/content/Context;ZLandroid/widget/EditText;[I[Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V
    .registers 14

    .line 541
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$dialog:Landroid/app/AlertDialog;

    iput-object p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$labelInput:Landroid/widget/EditText;

    iput-boolean p3, p0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$isPopupItem:Z

    iput-object p4, p0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$widthStepIdx:[I

    iput-object p5, p0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object p6, p0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$textValueInput:Landroid/widget/EditText;

    iput-object p7, p0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$ctx:Landroid/content/Context;

    iput-boolean p8, p0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$pt:Z

    iput-object p9, p0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$taskerInput:Landroid/widget/EditText;

    iput-object p10, p0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$selectedSpecialCode:[I

    iput-object p11, p0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$selectedSheetTarget:[Ljava/lang/String;

    iput-object p12, p0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$allSheets:Ljava/util/List;

    iput-object p13, p0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$listener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onShow(Landroid/content/DialogInterface;)V
    .registers 3

    .line 544
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$dialog:Landroid/app/AlertDialog;

    const/4 v0, -0x1

    invoke-virtual {p1, v0}, Landroid/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object p1

    new-instance v0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/KeyEditDialog$17$1;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$17;)V

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 592
    return-void
.end method
