.class final Lcom/mrkeyboard/app/KeyEditDialog$Editor;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/KeyEditDialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Editor"
.end annotation


# instance fields
.field private mAutoLabel:Z

.field private final mCanDelete:Z

.field private final mCanDuplicate:Z

.field private final mCanMoveLeft:Z

.field private final mCanMoveRight:Z

.field private mChips:[Landroid/widget/TextView;

.field private final mContext:Landroid/content/Context;

.field private mDialog:Landroid/app/AlertDialog;

.field private mGroupLabel:Landroid/widget/LinearLayout;

.field private mGroupPopup:Landroid/widget/LinearLayout;

.field private mGroupSheet:Landroid/widget/LinearLayout;

.field private mGroupSpecial:Landroid/widget/LinearLayout;

.field private mGroupTasker:Landroid/widget/LinearLayout;

.field private mGroupValue:Landroid/widget/LinearLayout;

.field private mGroupWidth:Landroid/widget/LinearLayout;

.field private final mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

.field private mLabelField:Landroid/widget/EditText;

.field private final mListener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

.field private final mPopup:Z

.field private mPopupBtn:Landroid/widget/TextView;

.field private mSheetBtn:Landroid/widget/TextView;

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

.field private mSpacerHint:Landroid/widget/TextView;

.field private mSpecialBtn:Landroid/widget/TextView;

.field private mSpecialCode:I

.field private mStep:I

.field private mTarget:Ljava/lang/String;

.field private mTaskerField:Landroid/widget/EditText;

.field private mTypes:[Ljava/lang/String;

.field private mValueField:Landroid/widget/EditText;

.field private mWidthBar:Landroid/widget/SeekBar;

.field private mWidthTitle:Landroid/widget/TextView;


# direct methods
.method constructor <init>(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            "ZZZZZ",
            "Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;",
            ")V"
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 156
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 157
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    .line 158
    iput-object p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheets:Ljava/util/List;

    .line 159
    if-eqz p3, :cond_0

    invoke-virtual {p3}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->deepCopy()Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v0

    :goto_0
    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 160
    iput-boolean p4, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopup:Z

    .line 161
    iput-boolean p5, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanMoveLeft:Z

    .line 162
    iput-boolean p6, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanMoveRight:Z

    .line 163
    iput-boolean p7, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanDuplicate:Z

    .line 164
    iput-boolean p8, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanDelete:Z

    .line 165
    iput-object p9, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    .line 166
    return-void

    .line 159
    :cond_0
    new-instance v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v1, "text"

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-direct {v0, v3, v1, v3, v2}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    goto :goto_0
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V
    .locals 0

    .prologue
    .line 114
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->save()V

    return-void
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/app/AlertDialog;
    .locals 1

    .prologue
    .line 114
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mDialog:Landroid/app/AlertDialog;

    return-object v0
.end method

.method static synthetic access$1100(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/content/Context;
    .locals 1

    .prologue
    .line 114
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$1200(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)I
    .locals 1

    .prologue
    .line 114
    iget v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialCode:I

    return v0
.end method

.method static synthetic access$1202(Lcom/mrkeyboard/app/KeyEditDialog$Editor;I)I
    .locals 0

    .prologue
    .line 114
    iput p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialCode:I

    return p1
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/TextView;
    .locals 1

    .prologue
    .line 114
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialBtn:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$1400(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 114
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTarget:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$1402(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 114
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTarget:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$1500(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/TextView;
    .locals 1

    .prologue
    .line 114
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheetBtn:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$1600(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Ljava/lang/String;Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;)V
    .locals 0

    .prologue
    .line 114
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->showTargetPicker(Ljava/lang/String;Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;)V

    return-void
.end method

.method static synthetic access$1700(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Ljava/util/List;
    .locals 1

    .prologue
    .line 114
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheets:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$1800(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Lcom/mrkeyboard/app/SheetModel$KeySpec;
    .locals 1

    .prologue
    .line 114
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    return-object v0
.end method

.method static synthetic access$1900(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V
    .locals 0

    .prologue
    .line 114
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->refreshPopupLabel()V

    return-void
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 114
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->selectType(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$2000(Lcom/mrkeyboard/app/KeyEditDialog$Editor;I)V
    .locals 0

    .prologue
    .line 114
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->perform(I)V

    return-void
.end method

.method static synthetic access$2100(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Z
    .locals 1

    .prologue
    .line 114
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mAutoLabel:Z

    return v0
.end method

.method static synthetic access$2102(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Z)Z
    .locals 0

    .prologue
    .line 114
    iput-boolean p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mAutoLabel:Z

    return p1
.end method

.method static synthetic access$2200(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 114
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mValueField:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 114
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTaskerField:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 114
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mLabelField:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$602(Lcom/mrkeyboard/app/KeyEditDialog$Editor;I)I
    .locals 0

    .prologue
    .line 114
    iput p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mStep:I

    return p1
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V
    .locals 0

    .prologue
    .line 114
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->refreshWidthTitle()V

    return-void
.end method

.method static synthetic access$900(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/SeekBar;
    .locals 1

    .prologue
    .line 114
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mWidthBar:Landroid/widget/SeekBar;

    return-object v0
.end method

.method private bind(Landroid/view/View;)V
    .locals 11

    .prologue
    const/4 v10, 0x4

    const/4 v9, 0x3

    const/4 v8, 0x2

    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 193
    const-string v0, "title"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 194
    iget-boolean v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopup:Z

    if-eqz v1, :cond_0

    const-string v1, "mr_key_ed_title_popup"

    :goto_0
    new-array v2, v5, [Ljava/lang/Object;

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 196
    const-string v0, "chip_text"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 197
    const-string v1, "chip_tasker"

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    .line 198
    const-string v2, "chip_special"

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    .line 199
    const-string v3, "chip_sheet"

    invoke-virtual {p1, v3}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    .line 200
    const-string v4, "chip_spacer"

    invoke-virtual {p1, v4}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/TextView;

    .line 201
    iget-boolean v7, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopup:Z

    if-eqz v7, :cond_1

    .line 203
    const/16 v7, 0x8

    invoke-virtual {v4, v7}, Landroid/widget/TextView;->setVisibility(I)V

    .line 204
    new-array v4, v10, [Landroid/widget/TextView;

    aput-object v0, v4, v5

    aput-object v1, v4, v6

    aput-object v2, v4, v8

    aput-object v3, v4, v9

    iput-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mChips:[Landroid/widget/TextView;

    .line 205
    new-array v0, v10, [Ljava/lang/String;

    const-string v1, "text"

    aput-object v1, v0, v5

    const-string v1, "tasker"

    aput-object v1, v0, v6

    const-string v1, "special"

    aput-object v1, v0, v8

    const-string v1, "sheet"

    aput-object v1, v0, v9

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTypes:[Ljava/lang/String;

    :goto_1
    move v0, v5

    .line 212
    :goto_2
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mChips:[Landroid/widget/TextView;

    array-length v1, v1

    if-ge v0, v1, :cond_2

    .line 213
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTypes:[Ljava/lang/String;

    aget-object v1, v1, v0

    .line 214
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mChips:[Landroid/widget/TextView;

    aget-object v2, v2, v0

    new-instance v3, Lcom/mrkeyboard/app/KeyEditDialog$Editor$2;

    invoke-direct {v3, p0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$2;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Ljava/lang/String;)V

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 212
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 194
    :cond_0
    const-string v1, "mr_key_ed_title"

    goto :goto_0

    .line 208
    :cond_1
    const/4 v7, 0x5

    new-array v7, v7, [Landroid/widget/TextView;

    aput-object v0, v7, v5

    aput-object v1, v7, v6

    aput-object v2, v7, v8

    aput-object v3, v7, v9

    aput-object v4, v7, v10

    iput-object v7, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mChips:[Landroid/widget/TextView;

    .line 209
    const/4 v0, 0x5

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "text"

    aput-object v1, v0, v5

    const-string v1, "tasker"

    aput-object v1, v0, v6

    const-string v1, "special"

    aput-object v1, v0, v8

    const-string v1, "sheet"

    aput-object v1, v0, v9

    const-string v1, "spacer"

    aput-object v1, v0, v10

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTypes:[Ljava/lang/String;

    goto :goto_1

    .line 221
    :cond_2
    const-string v0, "group_label"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupLabel:Landroid/widget/LinearLayout;

    .line 222
    const-string v0, "group_value"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupValue:Landroid/widget/LinearLayout;

    .line 223
    const-string v0, "group_tasker"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupTasker:Landroid/widget/LinearLayout;

    .line 224
    const-string v0, "group_special"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupSpecial:Landroid/widget/LinearLayout;

    .line 225
    const-string v0, "group_sheet"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupSheet:Landroid/widget/LinearLayout;

    .line 226
    const-string v0, "group_width"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupWidth:Landroid/widget/LinearLayout;

    .line 227
    const-string v0, "group_popup"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupPopup:Landroid/widget/LinearLayout;

    .line 228
    const-string v0, "spacer_hint"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpacerHint:Landroid/widget/TextView;

    .line 230
    const-string v0, "field_label"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mLabelField:Landroid/widget/EditText;

    .line 231
    const-string v0, "field_value"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mValueField:Landroid/widget/EditText;

    .line 232
    const-string v0, "field_tasker"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTaskerField:Landroid/widget/EditText;

    .line 233
    const-string v0, "btn_special"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialBtn:Landroid/widget/TextView;

    .line 234
    const-string v0, "btn_sheet"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheetBtn:Landroid/widget/TextView;

    .line 235
    const-string v0, "btn_popup"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopupBtn:Landroid/widget/TextView;

    .line 236
    const-string v0, "width_title"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mWidthTitle:Landroid/widget/TextView;

    .line 237
    const-string v0, "width_seek"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/SeekBar;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mWidthBar:Landroid/widget/SeekBar;

    .line 240
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mLabelField:Landroid/widget/EditText;

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    if-nez v0, :cond_7

    invoke-static {}, Lcom/mrkeyboard/app/KeyEditDialog;->access$300()Ljava/lang/String;

    move-result-object v0

    :goto_3
    invoke-virtual {v1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 241
    const-string v0, "text"

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 242
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mValueField:Landroid/widget/EditText;

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    if-nez v0, :cond_8

    invoke-static {}, Lcom/mrkeyboard/app/KeyEditDialog;->access$300()Ljava/lang/String;

    move-result-object v0

    :goto_4
    invoke-virtual {v1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 244
    :cond_3
    const-string v0, "tasker"

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 245
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTaskerField:Landroid/widget/EditText;

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-static {v1}, Lcom/mrkeyboard/app/SheetModel;->stripTaskerPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 248
    :cond_4
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindTaskerPresets(Landroid/view/View;)V

    .line 249
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindWidth(Landroid/view/View;)V

    .line 250
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindSpecial()V

    .line 251
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindSheet()V

    .line 252
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindPopup()V

    .line 254
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopup:Z

    if-eqz v0, :cond_9

    .line 256
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupWidth:Landroid/widget/LinearLayout;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 257
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupPopup:Landroid/widget/LinearLayout;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 258
    const-string v0, "group_actions"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 263
    :goto_5
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindLabelSync()V

    .line 264
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_5

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    :cond_5
    move v5, v6

    :cond_6
    iput-boolean v5, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mAutoLabel:Z

    .line 265
    return-void

    .line 240
    :cond_7
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    goto/16 :goto_3

    .line 242
    :cond_8
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    goto :goto_4

    .line 260
    :cond_9
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindActions(Landroid/view/View;)V

    goto :goto_5
.end method

.method private bindAction(Landroid/view/View;Ljava/lang/String;ZI)V
    .locals 2

    .prologue
    .line 365
    invoke-virtual {p1, p2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 366
    invoke-virtual {v0, p3}, Landroid/widget/TextView;->setEnabled(Z)V

    .line 367
    new-instance v1, Lcom/mrkeyboard/app/KeyEditDialog$Editor$9;

    invoke-direct {v1, p0, p4}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$9;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;I)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 372
    return-void
.end method

.method private bindActions(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 358
    const-string v0, "act_left"

    iget-boolean v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanMoveLeft:Z

    const/4 v2, 0x1

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindAction(Landroid/view/View;Ljava/lang/String;ZI)V

    .line 359
    const-string v0, "act_right"

    iget-boolean v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanMoveRight:Z

    const/4 v2, 0x2

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindAction(Landroid/view/View;Ljava/lang/String;ZI)V

    .line 360
    const-string v0, "act_duplicate"

    iget-boolean v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanDuplicate:Z

    const/4 v2, 0x3

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindAction(Landroid/view/View;Ljava/lang/String;ZI)V

    .line 361
    const-string v0, "act_delete"

    iget-boolean v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanDelete:Z

    const/4 v2, 0x4

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindAction(Landroid/view/View;Ljava/lang/String;ZI)V

    .line 362
    return-void
.end method

.method private bindLabelSync()V
    .locals 2

    .prologue
    .line 376
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mLabelField:Landroid/widget/EditText;

    new-instance v1, Lcom/mrkeyboard/app/KeyEditDialog$Editor$10;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$10;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 386
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mValueField:Landroid/widget/EditText;

    new-instance v1, Lcom/mrkeyboard/app/KeyEditDialog$Editor$11;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$11;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 399
    return-void
.end method

.method private bindPopup()V
    .locals 2

    .prologue
    .line 342
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopup:Z

    if-eqz v0, :cond_0

    .line 355
    :goto_0
    return-void

    .line 343
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopupBtn:Landroid/widget/TextView;

    new-instance v1, Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$8;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    goto :goto_0
.end method

.method private bindSheet()V
    .locals 2

    .prologue
    .line 326
    const-string v0, "sheet"

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 327
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    :goto_0
    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTarget:Ljava/lang/String;

    .line 328
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheetBtn:Landroid/widget/TextView;

    new-instance v1, Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 339
    return-void

    .line 327
    :cond_0
    const-string v0, "next"

    goto :goto_0
.end method

.method private bindSpecial()V
    .locals 3

    .prologue
    const/16 v0, -0x15

    .line 308
    const-string v1, "special"

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/KeyEditDialog;->access$1000(Ljava/lang/String;I)I

    move-result v0

    :cond_0
    iput v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialCode:I

    .line 309
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialBtn:Landroid/widget/TextView;

    new-instance v1, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 323
    return-void
.end method

.method private bindTaskerPresets(Landroid/view/View;)V
    .locals 4

    .prologue
    .line 268
    const-string v0, "tasker_presets"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 269
    const/4 v1, 0x0

    move v2, v1

    :goto_0
    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v1

    if-ge v2, v1, :cond_0

    .line 270
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    .line 271
    new-instance v3, Lcom/mrkeyboard/app/KeyEditDialog$Editor$3;

    invoke-direct {v3, p0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$3;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Landroid/widget/TextView;)V

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 269
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    goto :goto_0

    .line 279
    :cond_0
    return-void
.end method

.method private bindWidth(Landroid/view/View;)V
    .locals 5

    .prologue
    const/16 v3, 0xe

    const/4 v1, 0x0

    .line 282
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v0

    const/high16 v2, 0x3f000000    # 0.5f

    sub-float/2addr v0, v2

    const/high16 v2, 0x3e800000    # 0.25f

    div-float/2addr v0, v2

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mStep:I

    .line 283
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mWidthBar:Landroid/widget/SeekBar;

    invoke-virtual {v0, v3}, Landroid/widget/SeekBar;->setMax(I)V

    .line 284
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mWidthBar:Landroid/widget/SeekBar;

    iget v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mStep:I

    invoke-static {v3, v2}, Ljava/lang/Math;->min(II)I

    move-result v2

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 285
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mWidthBar:Landroid/widget/SeekBar;

    new-instance v2, Lcom/mrkeyboard/app/KeyEditDialog$Editor$4;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$4;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V

    invoke-virtual {v0, v2}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 295
    const-string v0, "width_presets"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 296
    :goto_0
    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v2

    if-ge v1, v2, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/KeyEditDialog;->access$800()[F

    move-result-object v2

    array-length v2, v2

    if-ge v1, v2, :cond_0

    .line 297
    invoke-static {}, Lcom/mrkeyboard/app/KeyEditDialog;->access$800()[F

    move-result-object v2

    aget v2, v2, v1

    .line 298
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/KeyEditDialog$Editor$5;

    invoke-direct {v4, p0, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$5;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;F)V

    invoke-virtual {v3, v4}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 296
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 304
    :cond_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->refreshWidthTitle()V

    .line 305
    return-void
.end method

.method private color(Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 576
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "color"

    invoke-direct {p0, p1, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->res(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getColor(I)I

    move-result v0

    return v0
.end method

.method private describeTarget(Ljava/lang/String;)Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v2, 0x0

    .line 448
    const-string v0, "prev"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "mr_key_ed_target_prev"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 456
    :goto_0
    return-object v0

    .line 449
    :cond_0
    const-string v0, "abc"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "mr_key_ed_target_abc"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 450
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheets:Ljava/util/List;

    if-eqz v0, :cond_3

    move v1, v2

    .line 451
    :goto_1
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheets:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_3

    .line 452
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheets:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 453
    iget-object v3, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v1, "mr_key_ed_target_sheet"

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    iget-object v4, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    aput-object v4, v3, v2

    const/4 v2, 0x1

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v0, v3, v2

    invoke-direct {p0, v1, v3}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 451
    :cond_2
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 456
    :cond_3
    const-string v0, "mr_key_ed_target_next"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private perform(I)V
    .locals 1

    .prologue
    .line 463
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    .line 464
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    if-nez v0, :cond_0

    .line 474
    :goto_0
    return-void

    .line 465
    :cond_0
    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    .line 466
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    invoke-interface {v0}, Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;->onMoveLeft()V

    goto :goto_0

    .line 467
    :cond_1
    const/4 v0, 0x2

    if-ne p1, v0, :cond_2

    .line 468
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    invoke-interface {v0}, Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;->onMoveRight()V

    goto :goto_0

    .line 469
    :cond_2
    const/4 v0, 0x3

    if-ne p1, v0, :cond_3

    .line 470
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    invoke-interface {v0}, Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;->onDuplicate()V

    goto :goto_0

    .line 472
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    invoke-interface {v0}, Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;->onDelete()V

    goto :goto_0
.end method

.method private refresh()V
    .locals 7

    .prologue
    const/16 v3, 0x8

    const/4 v1, 0x0

    .line 413
    move v0, v1

    :goto_0
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mChips:[Landroid/widget/TextView;

    array-length v2, v2

    if-ge v0, v2, :cond_2

    .line 414
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTypes:[Ljava/lang/String;

    aget-object v2, v2, v0

    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v4, v4, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    .line 415
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mChips:[Landroid/widget/TextView;

    aget-object v5, v2, v0

    if-eqz v4, :cond_0

    const-string v2, "mr_key_ed_chip_on"

    :goto_1
    const-string v6, "drawable"

    invoke-direct {p0, v2, v6}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->res(Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v5, v2}, Landroid/widget/TextView;->setBackgroundResource(I)V

    .line 416
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mChips:[Landroid/widget/TextView;

    aget-object v5, v2, v0

    if-eqz v4, :cond_1

    const-string v2, "mr_ui_text"

    :goto_2
    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->color(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v5, v2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 413
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 415
    :cond_0
    const-string v2, "mr_key_ed_chip"

    goto :goto_1

    .line 416
    :cond_1
    const-string v2, "mr_ui_text2"

    goto :goto_2

    .line 418
    :cond_2
    const-string v0, "spacer"

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    .line 419
    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupLabel:Landroid/widget/LinearLayout;

    if-eqz v2, :cond_4

    move v0, v3

    :goto_3
    invoke-virtual {v4, v0}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 420
    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupValue:Landroid/widget/LinearLayout;

    const-string v0, "text"

    iget-object v5, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v5, v5, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    move v0, v1

    :goto_4
    invoke-virtual {v4, v0}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 421
    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupTasker:Landroid/widget/LinearLayout;

    const-string v0, "tasker"

    iget-object v5, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v5, v5, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    move v0, v1

    :goto_5
    invoke-virtual {v4, v0}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 422
    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupSpecial:Landroid/widget/LinearLayout;

    const-string v0, "special"

    iget-object v5, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v5, v5, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    move v0, v1

    :goto_6
    invoke-virtual {v4, v0}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 423
    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupSheet:Landroid/widget/LinearLayout;

    const-string v0, "sheet"

    iget-object v5, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v5, v5, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_8

    move v0, v1

    :goto_7
    invoke-virtual {v4, v0}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 424
    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpacerHint:Landroid/widget/TextView;

    if-eqz v2, :cond_9

    move v0, v1

    :goto_8
    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setVisibility(I)V

    .line 425
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopup:Z

    if-nez v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupPopup:Landroid/widget/LinearLayout;

    if-eqz v2, :cond_a

    :goto_9
    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 426
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialBtn:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    iget v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialCode:I

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/SpecialKeyPicker;->describeCode(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "  \u25be"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 427
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheetBtn:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTarget:Ljava/lang/String;

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->describeTarget(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "  \u25be"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 428
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->refreshPopupLabel()V

    .line 429
    return-void

    :cond_4
    move v0, v1

    .line 419
    goto/16 :goto_3

    :cond_5
    move v0, v3

    .line 420
    goto/16 :goto_4

    :cond_6
    move v0, v3

    .line 421
    goto/16 :goto_5

    :cond_7
    move v0, v3

    .line 422
    goto :goto_6

    :cond_8
    move v0, v3

    .line 423
    goto :goto_7

    :cond_9
    move v0, v3

    .line 424
    goto :goto_8

    :cond_a
    move v3, v1

    .line 425
    goto :goto_9
.end method

.method private refreshPopupLabel()V
    .locals 5

    .prologue
    const/4 v2, 0x1

    const/4 v4, 0x0

    .line 436
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopupBtn:Landroid/widget/TextView;

    if-nez v0, :cond_0

    .line 444
    :goto_0
    return-void

    .line 437
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->hasPopupKeys()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 438
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopupBtn:Landroid/widget/TextView;

    const-string v1, "mr_key_ed_popup_keys"

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v4

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 439
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->hasPopupChars()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 440
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopupBtn:Landroid/widget/TextView;

    const-string v1, "mr_key_ed_popup_chars"

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    aput-object v3, v2, v4

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 442
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopupBtn:Landroid/widget/TextView;

    const-string v1, "mr_key_ed_popup_none"

    new-array v2, v4, [Ljava/lang/Object;

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0
.end method

.method private refreshWidthTitle()V
    .locals 6

    .prologue
    .line 432
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mWidthTitle:Landroid/widget/TextView;

    const-string v1, "mr_key_ed_width_title"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mStep:I

    int-to-float v4, v4

    const/high16 v5, 0x3e800000    # 0.25f

    mul-float/2addr v4, v5

    const/high16 v5, 0x3f000000    # 0.5f

    add-float/2addr v4, v5

    invoke-static {v4}, Lcom/mrkeyboard/app/KeyEditDialog;->access$2300(F)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 433
    return-void
.end method

.method private res(Ljava/lang/String;Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 572
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, p1, p2, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method private save()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    const/4 v5, 0x6

    const/4 v4, 0x0

    .line 478
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mLabelField:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v2

    .line 479
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopup:Z

    if-eqz v0, :cond_2

    const/high16 v0, 0x3f800000    # 1.0f

    .line 480
    :goto_0
    const-string v1, "spacer"

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 481
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-static {}, Lcom/mrkeyboard/app/KeyEditDialog;->access$300()Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    .line 482
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-static {}, Lcom/mrkeyboard/app/KeyEditDialog;->access$300()Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    .line 483
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v6, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    .line 484
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v6, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    .line 517
    :cond_0
    :goto_1
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput v0, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    .line 518
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    .line 519
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-interface {v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;->onSave(Lcom/mrkeyboard/app/SheetModel$KeySpec;)V

    .line 520
    :cond_1
    :goto_2
    return-void

    .line 479
    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mStep:I

    int-to-float v0, v0

    const/high16 v1, 0x3e800000    # 0.25f

    mul-float/2addr v0, v1

    const/high16 v1, 0x3f000000    # 0.5f

    add-float/2addr v0, v1

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v0

    goto :goto_0

    .line 485
    :cond_3
    const-string v1, "text"

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_7

    .line 486
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mValueField:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v1

    .line 487
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_4

    .line 488
    const-string v0, "mr_key_ed_toast_text"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->toast(Ljava/lang/String;)V

    goto :goto_2

    .line 491
    :cond_4
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_5

    move-object v1, v2

    .line 492
    :cond_5
    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_6

    .line 494
    const/16 v2, 0xa

    const/16 v3, 0x21b5

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v2

    .line 495
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    if-le v3, v5, :cond_6

    invoke-virtual {v2, v4, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    .line 497
    :cond_6
    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v2, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    .line 498
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v1, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    goto :goto_1

    .line 499
    :cond_7
    const-string v1, "tasker"

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_a

    .line 500
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTaskerField:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/mrkeyboard/app/SheetModel;->stripTaskerPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 501
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_8

    .line 502
    const-string v0, "mr_key_ed_toast_tasker"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->toast(Ljava/lang/String;)V

    goto/16 :goto_2

    .line 505
    :cond_8
    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v1, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    .line 506
    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_9

    move-object v2, v1

    .line 507
    :cond_9
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v2, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    goto/16 :goto_1

    .line 508
    :cond_a
    const-string v1, "special"

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_c

    .line 509
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialCode:I

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    .line 510
    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_b

    iget v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialCode:I

    invoke-static {v1}, Lcom/mrkeyboard/app/SpecialKeyPicker;->defaultLabelForCode(I)Ljava/lang/String;

    move-result-object v2

    .line 511
    :cond_b
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v2, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    goto/16 :goto_1

    .line 512
    :cond_c
    const-string v1, "sheet"

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 513
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTarget:Ljava/lang/String;

    iput-object v3, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    .line 514
    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_d

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheets:Ljava/util/List;

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->effectiveDisplayLabel(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/util/List;)Ljava/lang/String;

    move-result-object v2

    .line 515
    :cond_d
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v2, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    goto/16 :goto_1
.end method

.method private selectType(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 404
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object p1, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    .line 405
    const-string v0, "special"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mLabelField:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 406
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mLabelField:Landroid/widget/EditText;

    iget v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialCode:I

    invoke-static {v1}, Lcom/mrkeyboard/app/SpecialKeyPicker;->defaultLabelForCode(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 408
    :cond_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->refresh()V

    .line 409
    return-void
.end method

.method private showTargetPicker(Ljava/lang/String;Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;)V
    .locals 10

    .prologue
    const/4 v7, 0x0

    .line 524
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 525
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .line 526
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    .line 527
    const-string v0, "next"

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 528
    const-string v0, "123\u25b8"

    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 529
    const-string v0, "mr_key_ed_target_next"

    new-array v1, v7, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 530
    const-string v0, "prev"

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 531
    const-string v0, "\u25c2123"

    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 532
    const-string v0, "mr_key_ed_target_prev"

    new-array v1, v7, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 533
    const-string v0, "abc"

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 534
    const-string v0, "ABC"

    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 535
    const-string v0, "mr_key_ed_target_abc"

    new-array v1, v7, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 536
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheets:Ljava/util/List;

    if-eqz v0, :cond_0

    move v1, v7

    .line 537
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheets:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_0

    .line 538
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheets:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 539
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 540
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-virtual {v4, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 541
    const-string v2, "mr_key_ed_target_sheet"

    const/4 v6, 0x2

    new-array v6, v6, [Ljava/lang/Object;

    iget-object v8, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    aput-object v8, v6, v7

    const/4 v8, 0x1

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v0, v6, v8

    invoke-direct {p0, v2, v6}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 537
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    :cond_0
    move v1, v7

    move v8, v7

    .line 545
    :goto_1
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_1

    .line 546
    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    move v2, v1

    .line 545
    :goto_2
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    move v8, v2

    goto :goto_1

    .line 548
    :cond_1
    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/CharSequence;

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    move-object v6, v0

    check-cast v6, [Ljava/lang/CharSequence;

    .line 549
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "mr_key_ed_choose_sheet"

    new-array v2, v7, [Ljava/lang/Object;

    .line 550
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v9

    new-instance v0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$12;

    move-object v1, p0

    move-object v2, p2

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$12;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;)V

    .line 551
    invoke-virtual {v9, v6, v8, v0}, Landroid/app/AlertDialog$Builder;->setSingleChoiceItems([Ljava/lang/CharSequence;ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_key_ed_cancel"

    new-array v2, v7, [Ljava/lang/Object;

    .line 557
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 558
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 559
    return-void

    :cond_2
    move v2, v8

    goto :goto_2
.end method

.method private varargs t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 564
    const-string v0, "string"

    invoke-direct {p0, p1, v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->res(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 565
    if-nez v0, :cond_0

    .line 566
    :goto_0
    return-object p1

    :cond_0
    array-length v1, p2

    if-nez v1, :cond_1

    .line 567
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    :goto_1
    move-object p1, v0

    .line 566
    goto :goto_0

    .line 568
    :cond_1
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0, p2}, Landroid/content/res/Resources;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method private toast(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 580
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    const/4 v1, 0x0

    invoke-static {v0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 581
    return-void
.end method


# virtual methods
.method show()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x0

    .line 169
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const-string v1, "mr_key_ed_dialog"

    const-string v2, "layout"

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->res(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    .line 170
    new-instance v1, Landroid/app/AlertDialog$Builder;

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    invoke-direct {v1, v2}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 171
    invoke-virtual {v1, v0}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const-string v2, "mr_key_ed_save"

    new-array v3, v5, [Ljava/lang/Object;

    .line 172
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v4}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const-string v2, "mr_key_ed_cancel"

    new-array v3, v5, [Ljava/lang/Object;

    .line 173
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v4}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 174
    invoke-virtual {v1}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v1

    iput-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mDialog:Landroid/app/AlertDialog;

    .line 175
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bind(Landroid/view/View;)V

    .line 176
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->refresh()V

    .line 178
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mDialog:Landroid/app/AlertDialog;

    new-instance v1, Lcom/mrkeyboard/app/KeyEditDialog$Editor$1;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$1;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->setOnShowListener(Landroid/content/DialogInterface$OnShowListener;)V

    .line 187
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 188
    return-void
.end method
