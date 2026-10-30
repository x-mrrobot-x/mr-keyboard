.class Lcom/mrkeyboard/app/KeyEditDialog$3;
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
.field final synthetic val$allSheets:Ljava/util/List;

.field final synthetic val$ctx:Landroid/content/Context;

.field final synthetic val$labelInput:Landroid/widget/EditText;

.field final synthetic val$selectedSheetTarget:[Ljava/lang/String;

.field final synthetic val$sheetPickBtn:Landroid/widget/TextView;


# direct methods
.method constructor <init>(Landroid/content/Context;Ljava/util/List;[Ljava/lang/String;Landroid/widget/TextView;Landroid/widget/EditText;)V
    .registers 6

    .line 300
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$3;->val$ctx:Landroid/content/Context;

    iput-object p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$3;->val$allSheets:Ljava/util/List;

    iput-object p3, p0, Lcom/mrkeyboard/app/KeyEditDialog$3;->val$selectedSheetTarget:[Ljava/lang/String;

    iput-object p4, p0, Lcom/mrkeyboard/app/KeyEditDialog$3;->val$sheetPickBtn:Landroid/widget/TextView;

    iput-object p5, p0, Lcom/mrkeyboard/app/KeyEditDialog$3;->val$labelInput:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 5

    .line 303
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$3;->val$ctx:Landroid/content/Context;

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$3;->val$allSheets:Ljava/util/List;

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$3;->val$selectedSheetTarget:[Ljava/lang/String;

    const/4 v2, 0x0

    aget-object v1, v1, v2

    new-instance v2, Lcom/mrkeyboard/app/KeyEditDialog$3$1;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/KeyEditDialog$3$1;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$3;)V

    # invokes: Lcom/mrkeyboard/app/KeyEditDialog;->showSheetTargetDialog(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;)V
    invoke-static {p1, v0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog;->access$000(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;)V

    .line 313
    return-void
.end method
