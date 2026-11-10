.class public final Lcom/mrkeyboard/app/PopupEditDialog;
.super Ljava/lang/Object;
.source "PopupEditDialog.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/PopupEditDialog$Editor;,
        Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;,
        Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;
    }
.end annotation


# static fields
.field private static final EMPTY:Ljava/lang/String;

.field private static final MAX_ITEMS:I = 0xa

.field private static final MODE_CHARS:I = 0x1

.field private static final MODE_KEYS:I = 0x2

.field private static final MODE_NONE:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 49
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0}, Ljava/lang/String;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/PopupEditDialog;->EMPTY:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 51
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I
    .locals 1

    .prologue
    .line 29
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/PopupEditDialog;->res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method static synthetic access$100()Ljava/lang/String;
    .locals 1

    .prologue
    .line 29
    sget-object v0, Lcom/mrkeyboard/app/PopupEditDialog;->EMPTY:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$400(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 29
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/PopupEditDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$900(Landroid/content/Context;Ljava/lang/String;)I
    .locals 1

    .prologue
    .line 29
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/PopupEditDialog;->color(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public static buildPopupItemRow(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;IILjava/lang/Runnable;Ljava/lang/Runnable;Ljava/lang/Runnable;Ljava/lang/Runnable;)Landroid/view/View;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            "II",
            "Ljava/lang/Runnable;",
            "Ljava/lang/Runnable;",
            "Ljava/lang/Runnable;",
            "Ljava/lang/Runnable;",
            ")",
            "Landroid/view/View;"
        }
    .end annotation

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 80
    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const-string v1, "mr_pop_ed_item"

    const-string v4, "layout"

    invoke-static {p0, v1, v4}, Lcom/mrkeyboard/app/PopupEditDialog;->res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    const/4 v4, 0x0

    invoke-virtual {v0, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    .line 81
    invoke-static {p2, p1}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->effectiveDisplayLabel(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/util/List;)Ljava/lang/String;

    move-result-object v1

    .line 82
    const-string v0, "item_label"

    invoke-virtual {v4, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-eqz v5, :cond_0

    const-string v1, "?"

    :cond_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 83
    const-string v0, "item_desc"

    invoke-virtual {v4, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    invoke-static {p0, p2}, Lcom/mrkeyboard/app/PopupEditDialog;->describeActionShort(Landroid/content/Context;Lcom/mrkeyboard/app/SheetModel$KeySpec;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 84
    new-instance v0, Lcom/mrkeyboard/app/PopupEditDialog$1;

    invoke-direct {v0, p7}, Lcom/mrkeyboard/app/PopupEditDialog$1;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v4, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 89
    const-string v0, "item_up"

    invoke-virtual {v4, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 90
    if-lez p3, :cond_1

    move v1, v2

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setEnabled(Z)V

    .line 91
    new-instance v1, Lcom/mrkeyboard/app/PopupEditDialog$2;

    invoke-direct {v1, p5}, Lcom/mrkeyboard/app/PopupEditDialog$2;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 96
    const-string v0, "item_down"

    invoke-virtual {v4, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 97
    add-int/lit8 v1, p4, -0x1

    if-ge p3, v1, :cond_2

    :goto_1
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setEnabled(Z)V

    .line 98
    new-instance v1, Lcom/mrkeyboard/app/PopupEditDialog$3;

    invoke-direct {v1, p6}, Lcom/mrkeyboard/app/PopupEditDialog$3;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 103
    const-string v0, "item_delete"

    invoke-virtual {v4, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 104
    new-instance v1, Lcom/mrkeyboard/app/PopupEditDialog$4;

    invoke-direct {v1, p8}, Lcom/mrkeyboard/app/PopupEditDialog$4;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 109
    return-object v4

    :cond_1
    move v1, v3

    .line 90
    goto :goto_0

    :cond_2
    move v2, v3

    .line 97
    goto :goto_1
.end method

.method private static color(Landroid/content/Context;Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 328
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "color"

    invoke-static {p0, p1, v1}, Lcom/mrkeyboard/app/PopupEditDialog;->res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getColor(I)I

    move-result v0

    return v0
.end method

.method public static describeActionShort(Landroid/content/Context;Lcom/mrkeyboard/app/SheetModel$KeySpec;)Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v3, 0x1

    const/4 v0, 0x0

    .line 57
    const-string v1, "tasker"

    iget-object v2, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "tskcmd:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 68
    :goto_0
    return-object v0

    .line 58
    :cond_0
    const-string v1, "special"

    iget-object v2, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 61
    :try_start_0
    iget-object v1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 65
    :goto_1
    invoke-static {p0, v0}, Lcom/mrkeyboard/app/SpecialKeyPicker;->describeCode(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 67
    :cond_1
    const-string v1, "sheet"

    iget-object v2, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    const-string v1, "mr_pop_ed_action_sheet"

    new-array v2, v3, [Ljava/lang/Object;

    iget-object v3, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    aput-object v3, v2, v0

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/PopupEditDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 68
    :cond_2
    const-string v2, "mr_pop_ed_action_text"

    new-array v3, v3, [Ljava/lang/Object;

    .line 69
    iget-object v1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    if-nez v1, :cond_3

    sget-object v1, Lcom/mrkeyboard/app/PopupEditDialog;->EMPTY:Ljava/lang/String;

    :goto_2
    aput-object v1, v3, v0

    .line 68
    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/PopupEditDialog;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 69
    :cond_3
    iget-object v1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    const/16 v4, 0xa

    const/16 v5, 0x21b5

    invoke-virtual {v1, v4, v5}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v1

    goto :goto_2

    .line 62
    :catch_0
    move-exception v1

    goto :goto_1
.end method

.method private static res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 324
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, p1, p2, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public static show(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            ">;",
            "Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;",
            ")V"
        }
    .end annotation

    .prologue
    .line 117
    new-instance v0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;-><init>(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;)V

    invoke-virtual {v0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->show()V

    .line 118
    return-void
.end method

.method private static varargs text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 316
    const-string v0, "string"

    invoke-static {p0, p1, v0}, Lcom/mrkeyboard/app/PopupEditDialog;->res(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 317
    if-nez v0, :cond_0

    .line 318
    :goto_0
    return-object p1

    :cond_0
    array-length v1, p2

    if-nez v1, :cond_1

    .line 319
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    :goto_1
    move-object p1, v0

    .line 318
    goto :goto_0

    .line 320
    :cond_1
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0, p2}, Landroid/content/res/Resources;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method
