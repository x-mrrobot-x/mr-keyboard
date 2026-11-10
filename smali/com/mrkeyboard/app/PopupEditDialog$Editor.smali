.class final Lcom/mrkeyboard/app/PopupEditDialog$Editor;
.super Ljava/lang/Object;
.source "PopupEditDialog.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/PopupEditDialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Editor"
.end annotation


# instance fields
.field private mAddItem:Landroid/widget/TextView;

.field private mBoxChars:Landroid/view/View;

.field private mBoxKeys:Landroid/view/View;

.field private mBoxNone:Landroid/view/View;

.field private final mChars:Ljava/lang/String;

.field private mCharsField:Landroid/widget/EditText;

.field private mChipChars:Landroid/widget/TextView;

.field private mChipKeys:Landroid/widget/TextView;

.field private mChipNone:Landroid/widget/TextView;

.field private final mContext:Landroid/content/Context;

.field private mDialog:Landroid/app/AlertDialog;

.field private final mKeys:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            ">;"
        }
    .end annotation
.end field

.field private mKeysHeader:Landroid/widget/TextView;

.field private mKeysList:Landroid/widget/LinearLayout;

.field private final mListener:Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;

.field private mMode:I

.field private final mSheets:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;)V
    .locals 4
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
    const/4 v2, 0x0

    .line 142
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 126
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mKeys:Ljava/util/ArrayList;

    .line 143
    iput-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mContext:Landroid/content/Context;

    .line 144
    iput-object p2, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mSheets:Ljava/util/List;

    .line 145
    iput-object p5, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;

    .line 146
    iput-object p3, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mChars:Ljava/lang/String;

    .line 147
    if-eqz p4, :cond_1

    move v1, v2

    .line 148
    :goto_0
    invoke-interface {p4}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_1

    .line 149
    invoke-interface {p4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 150
    if-eqz v0, :cond_0

    iget-object v3, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mKeys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->deepCopy()Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 148
    :cond_0
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 153
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mKeys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    .line 154
    const/4 v0, 0x2

    iput v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mMode:I

    .line 160
    :goto_1
    return-void

    .line 155
    :cond_2
    if-eqz p3, :cond_3

    invoke-virtual {p3}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 156
    :cond_3
    iput v2, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mMode:I

    goto :goto_1

    .line 158
    :cond_4
    const/4 v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mMode:I

    goto :goto_1
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/PopupEditDialog$Editor;I)V
    .locals 0

    .prologue
    .line 121
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->setMode(I)V

    return-void
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)V
    .locals 0

    .prologue
    .line 121
    invoke-direct {p0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->addItem()V

    return-void
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)V
    .locals 0

    .prologue
    .line 121
    invoke-direct {p0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->save()V

    return-void
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)Ljava/util/ArrayList;
    .locals 1

    .prologue
    .line 121
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mKeys:Ljava/util/ArrayList;

    return-object v0
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)V
    .locals 0

    .prologue
    .line 121
    invoke-direct {p0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->refresh()V

    return-void
.end method

.method static synthetic access$800(Lcom/mrkeyboard/app/PopupEditDialog$Editor;I)V
    .locals 0

    .prologue
    .line 121
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->editItem(I)V

    return-void
.end method

.method private addItem()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 267
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mKeys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v1, 0xa

    if-lt v0, v1, :cond_0

    .line 268
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mContext:Landroid/content/Context;

    const-string v2, "mr_pop_ed_limit"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/PopupEditDialog;->access$400(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, v4}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 272
    :goto_0
    return-void

    .line 271
    :cond_0
    const/4 v0, -0x1

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->editItem(I)V

    goto :goto_0
.end method

.method private editItem(I)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 276
    if-gez p1, :cond_0

    .line 277
    new-instance v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v1, "text"

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-direct {v0, v3, v1, v3, v2}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    .line 279
    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mSheets:Ljava/util/List;

    new-instance v3, Lcom/mrkeyboard/app/PopupEditDialog$Editor$10;

    invoke-direct {v3, p0, p1}, Lcom/mrkeyboard/app/PopupEditDialog$Editor$10;-><init>(Lcom/mrkeyboard/app/PopupEditDialog$Editor;I)V

    invoke-static {v1, v2, v0, v3}, Lcom/mrkeyboard/app/KeyEditDialog;->showForPopupItem(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V

    .line 297
    return-void

    .line 278
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mKeys:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    goto :goto_0
.end method

.method private refresh()V
    .locals 10

    .prologue
    const/16 v3, 0x8

    const/4 v5, 0x2

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 217
    iget-object v4, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mChipNone:Landroid/widget/TextView;

    iget v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mMode:I

    if-nez v0, :cond_1

    move v0, v1

    :goto_0
    invoke-direct {p0, v4, v0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->style(Landroid/widget/TextView;Z)V

    .line 218
    iget-object v4, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mChipChars:Landroid/widget/TextView;

    iget v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mMode:I

    if-ne v0, v1, :cond_2

    move v0, v1

    :goto_1
    invoke-direct {p0, v4, v0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->style(Landroid/widget/TextView;Z)V

    .line 219
    iget-object v4, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mChipKeys:Landroid/widget/TextView;

    iget v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mMode:I

    if-ne v0, v5, :cond_3

    move v0, v1

    :goto_2
    invoke-direct {p0, v4, v0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->style(Landroid/widget/TextView;Z)V

    .line 220
    iget-object v4, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mBoxNone:Landroid/view/View;

    iget v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mMode:I

    if-nez v0, :cond_4

    move v0, v2

    :goto_3
    invoke-virtual {v4, v0}, Landroid/view/View;->setVisibility(I)V

    .line 221
    iget-object v4, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mBoxChars:Landroid/view/View;

    iget v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mMode:I

    if-ne v0, v1, :cond_5

    move v0, v2

    :goto_4
    invoke-virtual {v4, v0}, Landroid/view/View;->setVisibility(I)V

    .line 222
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mBoxKeys:Landroid/view/View;

    iget v4, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mMode:I

    if-ne v4, v5, :cond_0

    move v3, v2

    :cond_0
    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    .line 223
    iget v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mMode:I

    if-eq v0, v5, :cond_6

    .line 259
    :goto_5
    return-void

    :cond_1
    move v0, v2

    .line 217
    goto :goto_0

    :cond_2
    move v0, v2

    .line 218
    goto :goto_1

    :cond_3
    move v0, v2

    .line 219
    goto :goto_2

    :cond_4
    move v0, v3

    .line 220
    goto :goto_3

    :cond_5
    move v0, v3

    .line 221
    goto :goto_4

    .line 224
    :cond_6
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mKeysHeader:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mContext:Landroid/content/Context;

    const-string v4, "mr_pop_ed_keys_header"

    new-array v1, v1, [Ljava/lang/Object;

    iget-object v5, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mKeys:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v1, v2

    invoke-static {v3, v4, v1}, Lcom/mrkeyboard/app/PopupEditDialog;->access$400(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 225
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mKeysList:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    move v3, v2

    .line 226
    :goto_6
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mKeys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v3, v0, :cond_7

    .line 228
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mKeys:Ljava/util/ArrayList;

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 229
    iget-object v9, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mKeysList:Landroid/widget/LinearLayout;

    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mSheets:Ljava/util/List;

    iget-object v4, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mKeys:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    new-instance v5, Lcom/mrkeyboard/app/PopupEditDialog$Editor$6;

    invoke-direct {v5, p0, v3}, Lcom/mrkeyboard/app/PopupEditDialog$Editor$6;-><init>(Lcom/mrkeyboard/app/PopupEditDialog$Editor;I)V

    new-instance v6, Lcom/mrkeyboard/app/PopupEditDialog$Editor$7;

    invoke-direct {v6, p0, v3}, Lcom/mrkeyboard/app/PopupEditDialog$Editor$7;-><init>(Lcom/mrkeyboard/app/PopupEditDialog$Editor;I)V

    new-instance v7, Lcom/mrkeyboard/app/PopupEditDialog$Editor$8;

    invoke-direct {v7, p0, v3}, Lcom/mrkeyboard/app/PopupEditDialog$Editor$8;-><init>(Lcom/mrkeyboard/app/PopupEditDialog$Editor;I)V

    new-instance v8, Lcom/mrkeyboard/app/PopupEditDialog$Editor$9;

    invoke-direct {v8, p0, v3}, Lcom/mrkeyboard/app/PopupEditDialog$Editor$9;-><init>(Lcom/mrkeyboard/app/PopupEditDialog$Editor;I)V

    invoke-static/range {v0 .. v8}, Lcom/mrkeyboard/app/PopupEditDialog;->buildPopupItemRow(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;IILjava/lang/Runnable;Ljava/lang/Runnable;Ljava/lang/Runnable;Ljava/lang/Runnable;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v9, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 226
    add-int/lit8 v3, v3, 0x1

    goto :goto_6

    .line 258
    :cond_7
    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mAddItem:Landroid/widget/TextView;

    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mKeys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v2, 0xa

    if-ge v0, v2, :cond_8

    const/high16 v0, 0x3f800000    # 1.0f

    :goto_7
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setAlpha(F)V

    goto :goto_5

    :cond_8
    const v0, 0x3ee66666    # 0.45f

    goto :goto_7
.end method

.method private save()V
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 301
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;

    if-nez v0, :cond_0

    .line 310
    :goto_0
    return-void

    .line 302
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mMode:I

    const/4 v2, 0x1

    if-ne v0, v2, :cond_2

    .line 303
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mCharsField:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    .line 304
    iget-object v2, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_1

    move-object v0, v1

    :cond_1
    invoke-interface {v2, v0, v1}, Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;->onPopupSaved(Ljava/lang/String;Ljava/util/ArrayList;)V

    goto :goto_0

    .line 305
    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mMode:I

    const/4 v2, 0x2

    if-ne v0, v2, :cond_4

    .line 306
    iget-object v2, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;

    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mKeys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    move-object v0, v1

    :goto_1
    invoke-interface {v2, v1, v0}, Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;->onPopupSaved(Ljava/lang/String;Ljava/util/ArrayList;)V

    goto :goto_0

    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mKeys:Ljava/util/ArrayList;

    goto :goto_1

    .line 308
    :cond_4
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;

    invoke-interface {v0, v1, v1}, Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;->onPopupSaved(Ljava/lang/String;Ljava/util/ArrayList;)V

    goto :goto_0
.end method

.method private setMode(I)V
    .locals 0

    .prologue
    .line 211
    iput p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mMode:I

    .line 212
    invoke-direct {p0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->refresh()V

    .line 213
    return-void
.end method

.method private style(Landroid/widget/TextView;Z)V
    .locals 3

    .prologue
    .line 262
    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mContext:Landroid/content/Context;

    if-eqz p2, :cond_0

    const-string v0, "mr_pop_ed_chip_on"

    :goto_0
    const-string v2, "drawable"

    invoke-static {v1, v0, v2}, Lcom/mrkeyboard/app/PopupEditDialog;->access$000(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setBackgroundResource(I)V

    .line 263
    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mContext:Landroid/content/Context;

    if-eqz p2, :cond_1

    const-string v0, "mr_ui_text"

    :goto_1
    invoke-static {v1, v0}, Lcom/mrkeyboard/app/PopupEditDialog;->access$900(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 264
    return-void

    .line 262
    :cond_0
    const-string v0, "mr_pop_ed_chip"

    goto :goto_0

    .line 263
    :cond_1
    const-string v0, "mr_ui_text2"

    goto :goto_1
.end method


# virtual methods
.method show()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x0

    .line 163
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mContext:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mContext:Landroid/content/Context;

    const-string v2, "mr_pop_ed_dialog"

    const-string v3, "layout"

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/PopupEditDialog;->access$000(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1, v5}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 164
    const-string v0, "mode_none"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mChipNone:Landroid/widget/TextView;

    .line 165
    const-string v0, "mode_chars"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mChipChars:Landroid/widget/TextView;

    .line 166
    const-string v0, "mode_keys"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mChipKeys:Landroid/widget/TextView;

    .line 167
    const-string v0, "box_none"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mBoxNone:Landroid/view/View;

    .line 168
    const-string v0, "box_chars"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mBoxChars:Landroid/view/View;

    .line 169
    const-string v0, "box_keys"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mBoxKeys:Landroid/view/View;

    .line 170
    const-string v0, "keys_header"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mKeysHeader:Landroid/widget/TextView;

    .line 171
    const-string v0, "keys_list"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mKeysList:Landroid/widget/LinearLayout;

    .line 172
    const-string v0, "add_item"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mAddItem:Landroid/widget/TextView;

    .line 173
    const-string v0, "field_chars"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mCharsField:Landroid/widget/EditText;

    .line 174
    iget-object v2, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mCharsField:Landroid/widget/EditText;

    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mChars:Ljava/lang/String;

    if-nez v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/PopupEditDialog;->access$100()Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {v2, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 176
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mChipNone:Landroid/widget/TextView;

    new-instance v2, Lcom/mrkeyboard/app/PopupEditDialog$Editor$1;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor$1;-><init>(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)V

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 181
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mChipChars:Landroid/widget/TextView;

    new-instance v2, Lcom/mrkeyboard/app/PopupEditDialog$Editor$2;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor$2;-><init>(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)V

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 186
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mChipKeys:Landroid/widget/TextView;

    new-instance v2, Lcom/mrkeyboard/app/PopupEditDialog$Editor$3;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor$3;-><init>(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)V

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 191
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mAddItem:Landroid/widget/TextView;

    new-instance v2, Lcom/mrkeyboard/app/PopupEditDialog$Editor$4;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor$4;-><init>(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)V

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 197
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v2, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mContext:Landroid/content/Context;

    invoke-direct {v0, v2}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 198
    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mContext:Landroid/content/Context;

    const-string v2, "mr_pop_ed_done"

    new-array v3, v4, [Ljava/lang/Object;

    .line 199
    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/PopupEditDialog;->access$400(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/PopupEditDialog$Editor$5;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor$5;-><init>(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mContext:Landroid/content/Context;

    const-string v2, "mr_pop_ed_cancel"

    new-array v3, v4, [Ljava/lang/Object;

    .line 204
    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/PopupEditDialog;->access$400(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, v5}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 205
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mDialog:Landroid/app/AlertDialog;

    .line 206
    invoke-direct {p0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->refresh()V

    .line 207
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 208
    return-void

    .line 174
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->mChars:Ljava/lang/String;

    goto :goto_0
.end method
