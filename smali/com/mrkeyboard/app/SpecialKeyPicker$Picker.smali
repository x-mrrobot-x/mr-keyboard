.class final Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;
.super Ljava/lang/Object;
.source "SpecialKeyPicker.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/SpecialKeyPicker;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Picker"
.end annotation


# instance fields
.field private final mContext:Landroid/content/Context;

.field private mDialog:Landroid/app/AlertDialog;

.field private mList:Landroid/widget/LinearLayout;

.field private final mListener:Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

.field private mSearch:Landroid/widget/EditText;

.field private final mSelected:I


# direct methods
.method constructor <init>(Landroid/content/Context;ILcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V
    .locals 0

    .prologue
    .line 164
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 165
    iput-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mContext:Landroid/content/Context;

    .line 166
    iput p2, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mSelected:I

    .line 167
    iput-object p3, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mListener:Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

    .line 168
    return-void
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;)V
    .locals 0

    .prologue
    .line 155
    invoke-direct {p0}, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->fillList()V

    return-void
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;)Landroid/app/AlertDialog;
    .locals 1

    .prologue
    .line 155
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mDialog:Landroid/app/AlertDialog;

    return-object v0
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;)Landroid/content/Context;
    .locals 1

    .prologue
    .line 155
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;)I
    .locals 1

    .prologue
    .line 155
    iget v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mSelected:I

    return v0
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;)Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;
    .locals 1

    .prologue
    .line 155
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mListener:Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

    return-object v0
.end method

.method private buildRow(Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;Ljava/lang/String;)Landroid/view/View;
    .locals 4

    .prologue
    .line 240
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mContext:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mContext:Landroid/content/Context;

    const-string v2, "mr_pick_row"

    const-string v3, "layout"

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/SpecialKeyPicker;->access$000(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mList:Landroid/widget/LinearLayout;

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v1

    .line 241
    const-string v0, "key_label"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iget-object v2, p1, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->defaultLabel:Ljava/lang/String;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 242
    const-string v0, "key_name"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 243
    const-string v0, "key_code"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iget v2, p1, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->code:I

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 244
    iget v0, p1, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->code:I

    iget v2, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mSelected:I

    if-ne v0, v2, :cond_0

    .line 245
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mContext:Landroid/content/Context;

    const-string v2, "mr_pick_row_on"

    const-string v3, "drawable"

    invoke-static {v0, v2, v3}, Lcom/mrkeyboard/app/SpecialKeyPicker;->access$000(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Landroid/view/View;->setBackgroundResource(I)V

    .line 247
    :cond_0
    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$3;

    invoke-direct {v0, p0, p1}, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$3;-><init>(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;)V

    invoke-virtual {v1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 253
    return-object v1
.end method

.method private fillList()V
    .locals 12

    .prologue
    const/4 v2, 0x0

    .line 208
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v7

    .line 209
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mSearch:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v8

    .line 210
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mList:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 211
    invoke-static {}, Lcom/mrkeyboard/app/SpecialKeyPicker;->access$700()Ljava/lang/String;

    move-result-object v0

    move v1, v2

    move v3, v2

    .line 213
    :goto_0
    invoke-static {}, Lcom/mrkeyboard/app/SpecialKeyPicker;->access$800()[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-result-object v4

    array-length v4, v4

    if-ge v1, v4, :cond_4

    .line 214
    invoke-static {}, Lcom/mrkeyboard/app/SpecialKeyPicker;->access$800()[Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;

    move-result-object v4

    aget-object v9, v4, v1

    .line 215
    if-eqz v7, :cond_0

    iget-object v4, v9, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->namePt:Ljava/lang/String;

    invoke-static {v4}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    move-object v6, v4

    .line 216
    :goto_1
    if-eqz v7, :cond_1

    iget-object v4, v9, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->catPt:Ljava/lang/String;

    invoke-static {v4}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 217
    :goto_2
    invoke-virtual {v8}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_3

    .line 218
    if-eqz v7, :cond_2

    iget-object v5, v9, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->searchKeyPt:Ljava/lang/String;

    :goto_3
    invoke-virtual {v5, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_3

    sget-object v5, Ljava/util/Locale;->US:Ljava/util/Locale;

    .line 219
    invoke-virtual {v6, v5}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_3

    move-object v4, v0

    .line 213
    :goto_4
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    move-object v0, v4

    goto :goto_0

    .line 215
    :cond_0
    iget-object v4, v9, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->nameEn:Ljava/lang/String;

    move-object v6, v4

    goto :goto_1

    .line 216
    :cond_1
    iget-object v4, v9, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->catEn:Ljava/lang/String;

    goto :goto_2

    .line 218
    :cond_2
    iget-object v5, v9, Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;->searchKeyEn:Ljava/lang/String;

    goto :goto_3

    .line 222
    :cond_3
    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_6

    .line 223
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mContext:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iget-object v5, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mContext:Landroid/content/Context;

    const-string v10, "mr_pick_header"

    const-string v11, "layout"

    .line 224
    invoke-static {v5, v10, v11}, Lcom/mrkeyboard/app/SpecialKeyPicker;->access$000(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    iget-object v10, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mList:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v5, v10, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 225
    sget-object v5, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v4, v5}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 226
    iget-object v5, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mList:Landroid/widget/LinearLayout;

    invoke-virtual {v5, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 229
    :goto_5
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mList:Landroid/widget/LinearLayout;

    invoke-direct {p0, v9, v6}, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->buildRow(Lcom/mrkeyboard/app/SpecialKeyPicker$SpecialEntry;Ljava/lang/String;)Landroid/view/View;

    move-result-object v5

    invoke-virtual {v0, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 230
    add-int/lit8 v3, v3, 0x1

    goto :goto_4

    .line 232
    :cond_4
    if-nez v3, :cond_5

    .line 233
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mContext:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mContext:Landroid/content/Context;

    const-string v3, "mr_pick_empty"

    const-string v4, "layout"

    .line 234
    invoke-static {v1, v3, v4}, Lcom/mrkeyboard/app/SpecialKeyPicker;->access$000(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    iget-object v3, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mList:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v1, v3, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 235
    iget-object v1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mList:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 237
    :cond_5
    return-void

    :cond_6
    move-object v4, v0

    goto :goto_5
.end method


# virtual methods
.method show()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x0

    .line 171
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mContext:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mContext:Landroid/content/Context;

    const-string v2, "mr_pick_dialog"

    const-string v3, "layout"

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/SpecialKeyPicker;->access$000(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 172
    const-string v0, "search"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mSearch:Landroid/widget/EditText;

    .line 173
    const-string v0, "key_list"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mList:Landroid/widget/LinearLayout;

    .line 174
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mSearch:Landroid/widget/EditText;

    new-instance v2, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$1;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$1;-><init>(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;)V

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 183
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v2, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mContext:Landroid/content/Context;

    invoke-direct {v0, v2}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 184
    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mContext:Landroid/content/Context;

    const-string v2, "mr_pick_custom_btn"

    new-array v3, v5, [Ljava/lang/Object;

    .line 185
    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/SpecialKeyPicker;->access$200(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, v4}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mContext:Landroid/content/Context;

    const-string v2, "mr_pick_cancel"

    new-array v3, v5, [Ljava/lang/Object;

    .line 186
    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/SpecialKeyPicker;->access$200(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, v4}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 187
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mDialog:Landroid/app/AlertDialog;

    .line 189
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mDialog:Landroid/app/AlertDialog;

    new-instance v1, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker$2;-><init>(Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;)V

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->setOnShowListener(Landroid/content/DialogInterface$OnShowListener;)V

    .line 199
    invoke-direct {p0}, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->fillList()V

    .line 200
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$Picker;->mDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 201
    return-void
.end method
