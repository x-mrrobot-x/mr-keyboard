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

.field private mWidthPresets:Landroid/widget/LinearLayout;

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

    .line 184
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 185
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    .line 186
    iput-object p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheets:Ljava/util/List;

    .line 187
    if-eqz p3, :cond_0

    invoke-virtual {p3}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->deepCopy()Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v0

    :goto_0
    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 188
    iput-boolean p4, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopup:Z

    .line 189
    iput-boolean p5, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanMoveLeft:Z

    .line 190
    iput-boolean p6, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanMoveRight:Z

    .line 191
    iput-boolean p7, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanDuplicate:Z

    .line 192
    iput-boolean p8, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanDelete:Z

    .line 193
    iput-object p9, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    .line 194
    return-void

    .line 187
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
    .line 141
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->save()V

    return-void
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/app/AlertDialog;
    .locals 1

    .prologue
    .line 141
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mDialog:Landroid/app/AlertDialog;

    return-object v0
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/SeekBar;
    .locals 1

    .prologue
    .line 141
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mWidthBar:Landroid/widget/SeekBar;

    return-object v0
.end method

.method static synthetic access$1200(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/content/Context;
    .locals 1

    .prologue
    .line 141
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)I
    .locals 1

    .prologue
    .line 141
    iget v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialCode:I

    return v0
.end method

.method static synthetic access$1302(Lcom/mrkeyboard/app/KeyEditDialog$Editor;I)I
    .locals 0

    .prologue
    .line 141
    iput p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialCode:I

    return p1
.end method

.method static synthetic access$1400(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/TextView;
    .locals 1

    .prologue
    .line 141
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialBtn:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$1500(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 141
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTarget:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$1502(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .prologue
    .line 141
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTarget:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$1600(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/TextView;
    .locals 1

    .prologue
    .line 141
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheetBtn:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$1700(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Ljava/lang/String;Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;)V
    .locals 0

    .prologue
    .line 141
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->showTargetPicker(Ljava/lang/String;Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;)V

    return-void
.end method

.method static synthetic access$1800(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Ljava/util/List;
    .locals 1

    .prologue
    .line 141
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheets:Ljava/util/List;

    return-object v0
.end method

.method static synthetic access$1900(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Lcom/mrkeyboard/app/SheetModel$KeySpec;
    .locals 1

    .prologue
    .line 141
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    return-object v0
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 141
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->selectType(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$2000(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V
    .locals 0

    .prologue
    .line 141
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->refreshPopupLabel()V

    return-void
.end method

.method static synthetic access$2100(Lcom/mrkeyboard/app/KeyEditDialog$Editor;I)V
    .locals 0

    .prologue
    .line 141
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->perform(I)V

    return-void
.end method

.method static synthetic access$2200(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Z
    .locals 1

    .prologue
    .line 141
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mAutoLabel:Z

    return v0
.end method

.method static synthetic access$2202(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Z)Z
    .locals 0

    .prologue
    .line 141
    iput-boolean p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mAutoLabel:Z

    return p1
.end method

.method static synthetic access$2300(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 141
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mValueField:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 141
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTaskerField:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 141
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mLabelField:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$602(Lcom/mrkeyboard/app/KeyEditDialog$Editor;I)I
    .locals 0

    .prologue
    .line 141
    iput p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mStep:I

    return p1
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V
    .locals 0

    .prologue
    .line 141
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->refreshWidthTitle()V

    return-void
.end method

.method static synthetic access$800(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V
    .locals 0

    .prologue
    .line 141
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->refreshWidthPresets()V

    return-void
.end method

.method private bind(Landroid/view/View;)V
    .locals 11

    .prologue
    const/4 v10, 0x4

    const/4 v9, 0x3

    const/4 v8, 0x2

    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 222
    const-string v0, "title"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 223
    iget-boolean v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopup:Z

    if-eqz v1, :cond_0

    const-string v1, "mr_key_ed_title_popup"

    :goto_0
    new-array v2, v5, [Ljava/lang/Object;

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 225
    const-string v0, "chip_text"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 226
    const-string v1, "chip_tasker"

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    .line 227
    const-string v2, "chip_special"

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    .line 228
    const-string v3, "chip_sheet"

    invoke-virtual {p1, v3}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    .line 229
    const-string v4, "chip_spacer"

    invoke-virtual {p1, v4}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/TextView;

    .line 230
    iget-boolean v7, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopup:Z

    if-eqz v7, :cond_1

    .line 232
    const/16 v7, 0x8

    invoke-virtual {v4, v7}, Landroid/widget/TextView;->setVisibility(I)V

    .line 233
    new-array v4, v10, [Landroid/widget/TextView;

    aput-object v0, v4, v5

    aput-object v1, v4, v6

    aput-object v2, v4, v8

    aput-object v3, v4, v9

    iput-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mChips:[Landroid/widget/TextView;

    .line 234
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

    .line 241
    :goto_2
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mChips:[Landroid/widget/TextView;

    array-length v1, v1

    if-ge v0, v1, :cond_2

    .line 242
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTypes:[Ljava/lang/String;

    aget-object v1, v1, v0

    .line 243
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mChips:[Landroid/widget/TextView;

    aget-object v2, v2, v0

    new-instance v3, Lcom/mrkeyboard/app/KeyEditDialog$Editor$2;

    invoke-direct {v3, p0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$2;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Ljava/lang/String;)V

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 241
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 223
    :cond_0
    const-string v1, "mr_key_ed_title"

    goto :goto_0

    .line 237
    :cond_1
    const/4 v7, 0x5

    new-array v7, v7, [Landroid/widget/TextView;

    aput-object v0, v7, v5

    aput-object v1, v7, v6

    aput-object v2, v7, v8

    aput-object v3, v7, v9

    aput-object v4, v7, v10

    iput-object v7, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mChips:[Landroid/widget/TextView;

    .line 238
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

    .line 250
    :cond_2
    const-string v0, "group_label"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupLabel:Landroid/widget/LinearLayout;

    .line 251
    const-string v0, "group_value"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupValue:Landroid/widget/LinearLayout;

    .line 252
    const-string v0, "group_tasker"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupTasker:Landroid/widget/LinearLayout;

    .line 253
    const-string v0, "group_special"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupSpecial:Landroid/widget/LinearLayout;

    .line 254
    const-string v0, "group_sheet"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupSheet:Landroid/widget/LinearLayout;

    .line 255
    const-string v0, "group_width"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupWidth:Landroid/widget/LinearLayout;

    .line 256
    const-string v0, "group_popup"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupPopup:Landroid/widget/LinearLayout;

    .line 257
    const-string v0, "spacer_hint"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpacerHint:Landroid/widget/TextView;

    .line 259
    const-string v0, "field_label"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mLabelField:Landroid/widget/EditText;

    .line 260
    const-string v0, "field_value"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mValueField:Landroid/widget/EditText;

    .line 261
    const-string v0, "field_tasker"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTaskerField:Landroid/widget/EditText;

    .line 262
    const-string v0, "btn_special"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialBtn:Landroid/widget/TextView;

    .line 263
    const-string v0, "btn_sheet"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheetBtn:Landroid/widget/TextView;

    .line 264
    const-string v0, "btn_popup"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopupBtn:Landroid/widget/TextView;

    .line 265
    const-string v0, "width_title"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mWidthTitle:Landroid/widget/TextView;

    .line 266
    const-string v0, "width_seek"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/SeekBar;

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mWidthBar:Landroid/widget/SeekBar;

    .line 269
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mLabelField:Landroid/widget/EditText;

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    if-nez v0, :cond_9

    invoke-static {}, Lcom/mrkeyboard/app/KeyEditDialog;->access$300()Ljava/lang/String;

    move-result-object v0

    :goto_3
    invoke-virtual {v1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 270
    const-string v0, "text"

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 271
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mValueField:Landroid/widget/EditText;

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    if-nez v0, :cond_a

    invoke-static {}, Lcom/mrkeyboard/app/KeyEditDialog;->access$300()Ljava/lang/String;

    move-result-object v0

    :goto_4
    invoke-virtual {v1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 273
    :cond_3
    const-string v0, "tasker"

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 274
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTaskerField:Landroid/widget/EditText;

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-static {v1}, Lcom/mrkeyboard/app/SheetModel;->stripTaskerPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 277
    :cond_4
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindTaskerPresets(Landroid/view/View;)V

    .line 278
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindWidth(Landroid/view/View;)V

    .line 279
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindSpecial()V

    .line 280
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindSheet()V

    .line 281
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindPopup()V

    .line 283
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopup:Z

    if-nez v0, :cond_5

    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanMoveLeft:Z

    if-nez v0, :cond_b

    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanMoveRight:Z

    if-nez v0, :cond_b

    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanDuplicate:Z

    if-nez v0, :cond_b

    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanDelete:Z

    if-nez v0, :cond_b

    .line 285
    :cond_5
    const-string v0, "group_actions"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 289
    :goto_5
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopup:Z

    if-eqz v0, :cond_6

    .line 291
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupWidth:Landroid/widget/LinearLayout;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 292
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupPopup:Landroid/widget/LinearLayout;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 295
    :cond_6
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindLabelSync()V

    .line 296
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_7

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_8

    :cond_7
    move v5, v6

    :cond_8
    iput-boolean v5, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mAutoLabel:Z

    .line 297
    return-void

    .line 269
    :cond_9
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    goto/16 :goto_3

    .line 271
    :cond_a
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    goto/16 :goto_4

    .line 287
    :cond_b
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindActions(Landroid/view/View;)V

    goto :goto_5
.end method

.method private bindAction(Landroid/view/View;Ljava/lang/String;ZI)V
    .locals 2

    .prologue
    .line 400
    invoke-virtual {p1, p2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 401
    invoke-virtual {v0, p3}, Landroid/widget/TextView;->setEnabled(Z)V

    .line 402
    new-instance v1, Lcom/mrkeyboard/app/KeyEditDialog$Editor$9;

    invoke-direct {v1, p0, p4}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$9;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;I)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 407
    return-void
.end method

.method private bindActions(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 393
    const-string v0, "act_left"

    iget-boolean v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanMoveLeft:Z

    const/4 v2, 0x1

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindAction(Landroid/view/View;Ljava/lang/String;ZI)V

    .line 394
    const-string v0, "act_right"

    iget-boolean v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanMoveRight:Z

    const/4 v2, 0x2

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindAction(Landroid/view/View;Ljava/lang/String;ZI)V

    .line 395
    const-string v0, "act_duplicate"

    iget-boolean v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanDuplicate:Z

    const/4 v2, 0x3

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindAction(Landroid/view/View;Ljava/lang/String;ZI)V

    .line 396
    const-string v0, "act_delete"

    iget-boolean v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mCanDelete:Z

    const/4 v2, 0x4

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindAction(Landroid/view/View;Ljava/lang/String;ZI)V

    .line 397
    return-void
.end method

.method private bindLabelSync()V
    .locals 2

    .prologue
    .line 411
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mLabelField:Landroid/widget/EditText;

    new-instance v1, Lcom/mrkeyboard/app/KeyEditDialog$Editor$10;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$10;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 421
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mValueField:Landroid/widget/EditText;

    new-instance v1, Lcom/mrkeyboard/app/KeyEditDialog$Editor$11;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$11;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 434
    return-void
.end method

.method private bindPopup()V
    .locals 2

    .prologue
    .line 377
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopup:Z

    if-eqz v0, :cond_0

    .line 390
    :goto_0
    return-void

    .line 378
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
    .line 361
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

    .line 362
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    :goto_0
    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTarget:Ljava/lang/String;

    .line 363
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheetBtn:Landroid/widget/TextView;

    new-instance v1, Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 374
    return-void

    .line 362
    :cond_0
    const-string v0, "next"

    goto :goto_0
.end method

.method private bindSpecial()V
    .locals 3

    .prologue
    const/16 v0, -0x15

    .line 343
    const-string v1, "special"

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/KeyEditDialog;->access$1100(Ljava/lang/String;I)I

    move-result v0

    :cond_0
    iput v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialCode:I

    .line 344
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialBtn:Landroid/widget/TextView;

    new-instance v1, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 358
    return-void
.end method

.method private bindTaskerPresets(Landroid/view/View;)V
    .locals 4

    .prologue
    .line 300
    const-string v0, "tasker_presets"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 301
    const/4 v1, 0x0

    move v2, v1

    :goto_0
    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v1

    if-ge v2, v1, :cond_0

    .line 302
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    .line 303
    new-instance v3, Lcom/mrkeyboard/app/KeyEditDialog$Editor$3;

    invoke-direct {v3, p0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$3;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Landroid/widget/TextView;)V

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 301
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    goto :goto_0

    .line 311
    :cond_0
    return-void
.end method

.method private bindWidth(Landroid/view/View;)V
    .locals 5

    .prologue
    const/16 v3, 0xe

    const/4 v1, 0x0

    .line 314
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

    .line 315
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mWidthBar:Landroid/widget/SeekBar;

    invoke-virtual {v0, v3}, Landroid/widget/SeekBar;->setMax(I)V

    .line 316
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mWidthBar:Landroid/widget/SeekBar;

    iget v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mStep:I

    invoke-static {v3, v2}, Ljava/lang/Math;->min(II)I

    move-result v2

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 317
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mWidthBar:Landroid/widget/SeekBar;

    new-instance v2, Lcom/mrkeyboard/app/KeyEditDialog$Editor$4;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$4;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V

    invoke-virtual {v0, v2}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 328
    const-string v0, "width_presets"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 329
    iput-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mWidthPresets:Landroid/widget/LinearLayout;

    .line 330
    :goto_0
    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v2

    if-ge v1, v2, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/KeyEditDialog;->access$900()[F

    move-result-object v2

    array-length v2, v2

    if-ge v1, v2, :cond_0

    .line 331
    invoke-static {}, Lcom/mrkeyboard/app/KeyEditDialog;->access$900()[F

    move-result-object v2

    aget v2, v2, v1

    .line 332
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/KeyEditDialog$Editor$5;

    invoke-direct {v4, p0, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$5;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;F)V

    invoke-virtual {v3, v4}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 330
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 338
    :cond_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->refreshWidthTitle()V

    .line 339
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->refreshWidthPresets()V

    .line 340
    return-void
.end method

.method private color(Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 615
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
    .locals 2

    .prologue
    .line 495
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheets:Ljava/util/List;

    invoke-static {v0, v1, p1}, Lcom/mrkeyboard/app/KeyEditDialog;->describeTarget(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private perform(I)V
    .locals 1

    .prologue
    .line 502
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    .line 503
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    if-nez v0, :cond_0

    .line 513
    :goto_0
    return-void

    .line 504
    :cond_0
    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    .line 505
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    invoke-interface {v0}, Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;->onMoveLeft()V

    goto :goto_0

    .line 506
    :cond_1
    const/4 v0, 0x2

    if-ne p1, v0, :cond_2

    .line 507
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    invoke-interface {v0}, Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;->onMoveRight()V

    goto :goto_0

    .line 508
    :cond_2
    const/4 v0, 0x3

    if-ne p1, v0, :cond_3

    .line 509
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    invoke-interface {v0}, Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;->onDuplicate()V

    goto :goto_0

    .line 511
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

    .line 448
    move v0, v1

    :goto_0
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mChips:[Landroid/widget/TextView;

    array-length v2, v2

    if-ge v0, v2, :cond_2

    .line 449
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTypes:[Ljava/lang/String;

    aget-object v2, v2, v0

    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v4, v4, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    .line 450
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mChips:[Landroid/widget/TextView;

    aget-object v5, v2, v0

    if-eqz v4, :cond_0

    const-string v2, "mr_key_ed_chip_on"

    :goto_1
    const-string v6, "drawable"

    invoke-direct {p0, v2, v6}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->res(Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v5, v2}, Landroid/widget/TextView;->setBackgroundResource(I)V

    .line 451
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mChips:[Landroid/widget/TextView;

    aget-object v5, v2, v0

    if-eqz v4, :cond_1

    const-string v2, "mr_ui_text"

    :goto_2
    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->color(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v5, v2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 448
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 450
    :cond_0
    const-string v2, "mr_key_ed_chip"

    goto :goto_1

    .line 451
    :cond_1
    const-string v2, "mr_ui_text2"

    goto :goto_2

    .line 453
    :cond_2
    const-string v0, "spacer"

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    .line 454
    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupLabel:Landroid/widget/LinearLayout;

    if-eqz v2, :cond_4

    move v0, v3

    :goto_3
    invoke-virtual {v4, v0}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 455
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

    .line 456
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

    .line 457
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

    .line 458
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

    .line 459
    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpacerHint:Landroid/widget/TextView;

    if-eqz v2, :cond_9

    move v0, v1

    :goto_8
    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setVisibility(I)V

    .line 460
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopup:Z

    if-nez v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mGroupPopup:Landroid/widget/LinearLayout;

    if-eqz v2, :cond_a

    :goto_9
    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 461
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

    .line 462
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

    .line 463
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->refreshPopupLabel()V

    .line 464
    return-void

    :cond_4
    move v0, v1

    .line 454
    goto/16 :goto_3

    :cond_5
    move v0, v3

    .line 455
    goto/16 :goto_4

    :cond_6
    move v0, v3

    .line 456
    goto/16 :goto_5

    :cond_7
    move v0, v3

    .line 457
    goto :goto_6

    :cond_8
    move v0, v3

    .line 458
    goto :goto_7

    :cond_9
    move v0, v3

    .line 459
    goto :goto_8

    :cond_a
    move v3, v1

    .line 460
    goto :goto_9
.end method

.method private refreshPopupLabel()V
    .locals 5

    .prologue
    const/4 v2, 0x1

    const/4 v4, 0x0

    .line 483
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopupBtn:Landroid/widget/TextView;

    if-nez v0, :cond_0

    .line 491
    :goto_0
    return-void

    .line 484
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->hasPopupKeys()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 485
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

    .line 486
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->hasPopupChars()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 487
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

    .line 489
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopupBtn:Landroid/widget/TextView;

    const-string v1, "mr_key_ed_popup_none"

    new-array v2, v4, [Ljava/lang/Object;

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0
.end method

.method private refreshWidthPresets()V
    .locals 7

    .prologue
    const/4 v2, 0x0

    .line 472
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mWidthPresets:Landroid/widget/LinearLayout;

    if-nez v0, :cond_1

    .line 480
    :cond_0
    return-void

    .line 473
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mStep:I

    int-to-float v0, v0

    const/high16 v1, 0x3e800000    # 0.25f

    mul-float/2addr v0, v1

    const/high16 v1, 0x3f000000    # 0.5f

    add-float v5, v0, v1

    move v1, v2

    .line 474
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mWidthPresets:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v0

    if-ge v1, v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/KeyEditDialog;->access$900()[F

    move-result-object v0

    array-length v0, v0

    if-ge v1, v0, :cond_0

    .line 475
    invoke-static {}, Lcom/mrkeyboard/app/KeyEditDialog;->access$900()[F

    move-result-object v0

    aget v0, v0, v1

    sub-float/2addr v0, v5

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    const v3, 0x3c23d70a    # 0.01f

    cmpg-float v0, v0, v3

    if-gez v0, :cond_2

    const/4 v0, 0x1

    move v3, v0

    .line 476
    :goto_1
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mWidthPresets:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 477
    if-eqz v3, :cond_3

    const-string v4, "mr_key_ed_chip_on"

    :goto_2
    const-string v6, "drawable"

    invoke-direct {p0, v4, v6}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->res(Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setBackgroundResource(I)V

    .line 478
    if-eqz v3, :cond_4

    const-string v3, "mr_ui_text"

    :goto_3
    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->color(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 474
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    :cond_2
    move v3, v2

    .line 475
    goto :goto_1

    .line 477
    :cond_3
    const-string v4, "mr_key_ed_pill"

    goto :goto_2

    .line 478
    :cond_4
    const-string v3, "mr_ui_cyan"

    goto :goto_3
.end method

.method private refreshWidthTitle()V
    .locals 6

    .prologue
    .line 467
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

    invoke-static {v4}, Lcom/mrkeyboard/app/KeyEditDialog;->access$2400(F)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 468
    return-void
.end method

.method private res(Ljava/lang/String;Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 611
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

    .line 517
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mLabelField:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v2

    .line 518
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mPopup:Z

    if-eqz v0, :cond_2

    const/high16 v0, 0x3f800000    # 1.0f

    .line 519
    :goto_0
    const-string v1, "spacer"

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 520
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-static {}, Lcom/mrkeyboard/app/KeyEditDialog;->access$300()Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    .line 521
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-static {}, Lcom/mrkeyboard/app/KeyEditDialog;->access$300()Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    .line 522
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v6, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    .line 523
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v6, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    .line 556
    :cond_0
    :goto_1
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput v0, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    .line 557
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    .line 558
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mListener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-interface {v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;->onSave(Lcom/mrkeyboard/app/SheetModel$KeySpec;)V

    .line 559
    :cond_1
    :goto_2
    return-void

    .line 518
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

    .line 524
    :cond_3
    const-string v1, "text"

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_7

    .line 525
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mValueField:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v1

    .line 526
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_4

    .line 527
    const-string v0, "mr_key_ed_toast_text"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->toast(Ljava/lang/String;)V

    goto :goto_2

    .line 530
    :cond_4
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_5

    move-object v1, v2

    .line 531
    :cond_5
    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_6

    .line 533
    const/16 v2, 0xa

    const/16 v3, 0x21b5

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v2

    .line 534
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    if-le v3, v5, :cond_6

    invoke-virtual {v2, v4, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    .line 536
    :cond_6
    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v2, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    .line 537
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v1, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    goto :goto_1

    .line 538
    :cond_7
    const-string v1, "tasker"

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_a

    .line 539
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTaskerField:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/mrkeyboard/app/SheetModel;->stripTaskerPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 540
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_8

    .line 541
    const-string v0, "mr_key_ed_toast_tasker"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->toast(Ljava/lang/String;)V

    goto/16 :goto_2

    .line 544
    :cond_8
    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v1, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    .line 545
    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_9

    move-object v2, v1

    .line 546
    :cond_9
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v2, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    goto/16 :goto_1

    .line 547
    :cond_a
    const-string v1, "special"

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_c

    .line 548
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialCode:I

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    .line 549
    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_b

    iget v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialCode:I

    invoke-static {v1}, Lcom/mrkeyboard/app/SpecialKeyPicker;->defaultLabelForCode(I)Ljava/lang/String;

    move-result-object v2

    .line 550
    :cond_b
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v2, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    goto/16 :goto_1

    .line 551
    :cond_c
    const-string v1, "sheet"

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 552
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mTarget:Ljava/lang/String;

    iput-object v3, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    .line 553
    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_d

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheets:Ljava/util/List;

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->effectiveDisplayLabel(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/util/List;)Ljava/lang/String;

    move-result-object v2

    .line 554
    :cond_d
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v2, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    goto/16 :goto_1
.end method

.method private selectType(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 439
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mKey:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object p1, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    .line 440
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

    .line 441
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mLabelField:Landroid/widget/EditText;

    iget v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSpecialCode:I

    invoke-static {v1}, Lcom/mrkeyboard/app/SpecialKeyPicker;->defaultLabelForCode(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 443
    :cond_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->refresh()V

    .line 444
    return-void
.end method

.method private showTargetPicker(Ljava/lang/String;Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;)V
    .locals 10

    .prologue
    const/4 v7, 0x0

    .line 563
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 564
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .line 565
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    .line 566
    const-string v0, "next"

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 567
    const-string v0, "123\u25b8"

    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 568
    const-string v0, "mr_key_ed_target_next"

    new-array v1, v7, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 569
    const-string v0, "prev"

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 570
    const-string v0, "\u25c2123"

    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 571
    const-string v0, "mr_key_ed_target_prev"

    new-array v1, v7, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 572
    const-string v0, "abc"

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 573
    invoke-static {}, Lcom/mrkeyboard/app/MrAbcKeys;->badge()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 574
    const-string v0, "mr_key_ed_target_abc"

    new-array v1, v7, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 575
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheets:Ljava/util/List;

    if-eqz v0, :cond_0

    move v1, v7

    .line 576
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheets:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_0

    .line 577
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mSheets:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 578
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 579
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-virtual {v4, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 580
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

    .line 576
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    :cond_0
    move v1, v7

    move v8, v7

    .line 584
    :goto_1
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_1

    .line 585
    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    move v2, v1

    .line 584
    :goto_2
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    move v8, v2

    goto :goto_1

    .line 587
    :cond_1
    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/CharSequence;

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    move-object v6, v0

    check-cast v6, [Ljava/lang/CharSequence;

    .line 588
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "mr_key_ed_choose_sheet"

    new-array v2, v7, [Ljava/lang/Object;

    .line 589
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v9

    new-instance v0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$12;

    move-object v1, p0

    move-object v2, p2

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$12;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;)V

    .line 590
    invoke-virtual {v9, v6, v8, v0}, Landroid/app/AlertDialog$Builder;->setSingleChoiceItems([Ljava/lang/CharSequence;ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_key_ed_cancel"

    new-array v2, v7, [Ljava/lang/Object;

    .line 596
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 597
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 598
    return-void

    :cond_2
    move v2, v8

    goto :goto_2
.end method

.method private varargs t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 603
    const-string v0, "string"

    invoke-direct {p0, p1, v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->res(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 604
    if-nez v0, :cond_0

    .line 605
    :goto_0
    return-object p1

    :cond_0
    array-length v1, p2

    if-nez v1, :cond_1

    .line 606
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    :goto_1
    move-object p1, v0

    .line 605
    goto :goto_0

    .line 607
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
    .line 619
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    const/4 v1, 0x0

    invoke-static {v0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 620
    return-void
.end method


# virtual methods
.method show()Landroid/app/AlertDialog;
    .locals 6

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x0

    .line 197
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const-string v1, "mr_key_ed_dialog"

    const-string v2, "layout"

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->res(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    .line 198
    new-instance v1, Landroid/app/AlertDialog$Builder;

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mContext:Landroid/content/Context;

    invoke-direct {v1, v2}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 199
    invoke-virtual {v1, v0}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const-string v2, "mr_key_ed_save"

    new-array v3, v5, [Ljava/lang/Object;

    .line 200
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v4}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const-string v2, "mr_key_ed_cancel"

    new-array v3, v5, [Ljava/lang/Object;

    .line 201
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v4}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 202
    invoke-virtual {v1}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v1

    iput-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mDialog:Landroid/app/AlertDialog;

    .line 203
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bind(Landroid/view/View;)V

    .line 204
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->refresh()V

    .line 206
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mDialog:Landroid/app/AlertDialog;

    new-instance v1, Lcom/mrkeyboard/app/KeyEditDialog$Editor$1;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor$1;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->setOnShowListener(Landroid/content/DialogInterface$OnShowListener;)V

    .line 215
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 216
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->mDialog:Landroid/app/AlertDialog;

    return-object v0
.end method
