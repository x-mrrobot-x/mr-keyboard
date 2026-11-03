.class public Lcom/mrkeyboard/app/MrAiStyleActivity;
.super Landroid/app/Activity;
.source "MrAiStyleActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrAiStyleActivity$Act;
    }
.end annotation


# static fields
.field private static final C_CLOSE:I = 0x1

.field private static final C_DELETE:I = 0x3

.field private static final C_EMOJI:I = 0x64

.field private static final C_SAVE:I = 0x2

.field private static final EMOJIS:[Ljava/lang/String;


# instance fields
.field private mCircle:Landroid/widget/TextView;

.field private mDelete:Landroid/widget/TextView;

.field private mDeleteArmed:Z

.field private mEmoji:Ljava/lang/String;

.field private final mEmojiViews:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/widget/TextView;",
            ">;"
        }
    .end annotation
.end field

.field private mIndex:I

.field private mInstr:Landroid/widget/EditText;

.field private mName:Landroid/widget/EditText;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 29
    const/16 v0, 0x28

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "\u2728"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "\ud83c\udff4"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "\u2620\ufe0f"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "\u2694\ufe0f"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "\ud83d\udee1\ufe0f"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "\ud83d\udc51"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "\ud83e\uddd9"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "\ud83e\uddb8"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "\ud83e\udd20"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "\ud83e\udd16"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "\ud83e\udde0"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "\ud83d\udca1"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "\ud83d\udcdc"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, "\ud83d\udcda"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, "\ud83c\udf93"

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, "\ud83d\udcbc"

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, "\ud83c\udfe2"

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, "\ud83d\udcbb"

    aput-object v2, v0, v1

    const/16 v1, 0x12

    const-string v2, "\ud83d\ude80"

    aput-object v2, v0, v1

    const/16 v1, 0x13

    const-string v2, "\ud83d\udd25"

    aput-object v2, v0, v1

    const/16 v1, 0x14

    const-string v2, "\u26a1"

    aput-object v2, v0, v1

    const/16 v1, 0x15

    const-string v2, "\ud83c\udf0a"

    aput-object v2, v0, v1

    const/16 v1, 0x16

    const-string v2, "\ud83c\udf3f"

    aput-object v2, v0, v1

    const/16 v1, 0x17

    const-string v2, "\u2600\ufe0f"

    aput-object v2, v0, v1

    const/16 v1, 0x18

    const-string v2, "\ud83c\udf19"

    aput-object v2, v0, v1

    const/16 v1, 0x19

    const-string v2, "\u2b50"

    aput-object v2, v0, v1

    const/16 v1, 0x1a

    const-string v2, "\ud83d\ude0e"

    aput-object v2, v0, v1

    const/16 v1, 0x1b

    const-string v2, "\ud83d\ude02"

    aput-object v2, v0, v1

    const/16 v1, 0x1c

    const-string v2, "\ud83e\udd70"

    aput-object v2, v0, v1

    const/16 v1, 0x1d

    const-string v2, "\ud83e\udd14"

    aput-object v2, v0, v1

    const/16 v1, 0x1e

    const-string v2, "\ud83d\ude34"

    aput-object v2, v0, v1

    const/16 v1, 0x1f

    const-string v2, "\ud83c\udfad"

    aput-object v2, v0, v1

    const/16 v1, 0x20

    const-string v2, "\ud83c\udfb8"

    aput-object v2, v0, v1

    const/16 v1, 0x21

    const-string v2, "\ud83c\udfaf"

    aput-object v2, v0, v1

    const/16 v1, 0x22

    const-string v2, "\u270d\ufe0f"

    aput-object v2, v0, v1

    const/16 v1, 0x23

    const-string v2, "\ud83d\udcdd"

    aput-object v2, v0, v1

    const/16 v1, 0x24

    const-string v2, "\ud83d\udcac"

    aput-object v2, v0, v1

    const/16 v1, 0x25

    const-string v2, "\ud83d\udce2"

    aput-object v2, v0, v1

    const/16 v1, 0x26

    const-string v2, "\u2764\ufe0f"

    aput-object v2, v0, v1

    const/16 v1, 0x27

    const-string v2, "\ud83d\udd2e"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->EMOJIS:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    .line 28
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 53
    const/4 v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    .line 54
    sget-object v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->EMOJIS:[Ljava/lang/String;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmoji:Ljava/lang/String;

    .line 60
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmojiViews:Ljava/util/ArrayList;

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/MrAiStyleActivity;I)V
    .locals 0

    .prologue
    .line 28
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->onAction(I)V

    return-void
.end method

.method private color(Ljava/lang/String;)I
    .locals 4

    .prologue
    .line 85
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "color"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, p1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getColor(I)I

    move-result v0

    return v0
.end method

.method private delete()V
    .locals 3

    .prologue
    .line 309
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDeleteArmed:Z

    if-nez v0, :cond_1

    .line 310
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDeleteArmed:Z

    .line 311
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    const-string v1, "mr_ai_style_delete_again"

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 321
    :cond_0
    :goto_0
    return-void

    .line 314
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAi;->loadCustom(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    .line 315
    iget v1, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    if-ltz v1, :cond_2

    iget v1, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_2

    .line 316
    iget v1, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 317
    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrAi;->saveCustom(Landroid/content/Context;Ljava/util/ArrayList;)V

    .line 318
    const-string v0, "mr_ai_style_deleted"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 320
    :cond_2
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->finish()V

    goto :goto_0
.end method

.method private dp(F)I
    .locals 1

    .prologue
    .line 89
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr v0, p1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    return v0
.end method

.method private field(IIIILjava/lang/String;I)Landroid/widget/EditText;
    .locals 6

    .prologue
    const/high16 v5, 0x41800000    # 16.0f

    const/high16 v3, 0x41600000    # 14.0f

    const/high16 v4, 0x41400000    # 12.0f

    .line 238
    new-instance v0, Landroid/widget/EditText;

    invoke-direct {v0, p0}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    .line 239
    invoke-virtual {v0, p5}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    .line 240
    invoke-virtual {v0, p4}, Landroid/widget/EditText;->setHintTextColor(I)V

    .line 241
    invoke-virtual {v0, p3}, Landroid/widget/EditText;->setTextColor(I)V

    .line 242
    invoke-virtual {v0, v5}, Landroid/widget/EditText;->setTextSize(F)V

    .line 243
    invoke-virtual {v0, p6}, Landroid/widget/EditText;->setInputType(I)V

    .line 244
    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v1

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v2

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v3

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/widget/EditText;->setPadding(IIII)V

    .line 245
    const/4 v1, 0x0

    invoke-direct {p0, p1, p2, v5, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 246
    return-object v0
.end method

.method private fieldParams(I)Landroid/widget/LinearLayout$LayoutParams;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 250
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x1

    const/4 v2, -0x2

    invoke-direct {v0, v1, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 252
    if-lez p1, :cond_0

    int-to-float v1, p1

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v1

    invoke-virtual {v0, v3, v1, v3, v3}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 253
    :cond_0
    return-object v0
.end method

.method private onAction(I)V
    .locals 2

    .prologue
    .line 266
    const/16 v0, 0x64

    if-lt p1, v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->EMOJIS:[Ljava/lang/String;

    array-length v0, v0

    add-int/lit8 v0, v0, 0x64

    if-ge p1, v0, :cond_0

    .line 267
    sget-object v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->EMOJIS:[Ljava/lang/String;

    add-int/lit8 v1, p1, -0x64

    aget-object v0, v0, v1

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmoji:Ljava/lang/String;

    .line 268
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->refreshEmoji()V

    .line 284
    :goto_0
    return-void

    .line 271
    :cond_0
    packed-switch p1, :pswitch_data_0

    goto :goto_0

    .line 273
    :pswitch_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->finish()V

    goto :goto_0

    .line 276
    :pswitch_1
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->save()V

    goto :goto_0

    .line 279
    :pswitch_2
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->delete()V

    goto :goto_0

    .line 271
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method private refreshEmoji()V
    .locals 5

    .prologue
    const/4 v2, 0x0

    .line 257
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mCircle:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmoji:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 258
    const-string v0, "mr_ui_cyan_soft"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->color(Ljava/lang/String;)I

    move-result v4

    move v1, v2

    .line 259
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmojiViews:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_1

    .line 260
    sget-object v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->EMOJIS:[Ljava/lang/String;

    aget-object v0, v0, v1

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmoji:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    .line 261
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmojiViews:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    if-eqz v3, :cond_0

    const/high16 v3, 0x41400000    # 12.0f

    invoke-direct {p0, v4, v2, v3, v2}, Lcom/mrkeyboard/app/MrAiStyleActivity;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    :goto_1
    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 259
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 261
    :cond_0
    const/4 v3, 0x0

    goto :goto_1

    .line 263
    :cond_1
    return-void
.end method

.method private round(IIFZ)Landroid/graphics/drawable/GradientDrawable;
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 93
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 94
    if-eqz p4, :cond_1

    invoke-virtual {v0, v2}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    .line 96
    :goto_0
    invoke-virtual {v0, p1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 97
    if-eqz p2, :cond_0

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-virtual {v0, v1, p2}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 98
    :cond_0
    return-object v0

    .line 95
    :cond_1
    invoke-direct {p0, p3}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    goto :goto_0
.end method

.method private save()V
    .locals 6

    .prologue
    const/16 v3, 0x28

    const/4 v5, 0x0

    .line 287
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mName:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, ""

    .line 288
    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v1

    if-nez v1, :cond_1

    const-string v1, ""

    .line 289
    :goto_1
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_2

    .line 290
    const-string v0, "mr_ai_style_need_name"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0, v5}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 306
    :goto_2
    return-void

    .line 287
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mName:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 288
    :cond_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    .line 293
    :cond_2
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_3

    .line 294
    const-string v0, "mr_ai_style_need_instr"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0, v5}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    goto :goto_2

    .line 297
    :cond_3
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-le v2, v3, :cond_4

    invoke-virtual {v0, v5, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 298
    :cond_4
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAi;->loadCustom(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v2

    .line 299
    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/String;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmoji:Ljava/lang/String;

    aput-object v4, v3, v5

    const/4 v4, 0x1

    aput-object v0, v3, v4

    const/4 v0, 0x2

    aput-object v1, v3, v0

    .line 300
    iget v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    if-ltz v0, :cond_5

    iget v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge v0, v1, :cond_5

    iget v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    invoke-virtual {v2, v0, v3}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 303
    :goto_3
    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrAi;->saveCustom(Landroid/content/Context;Ljava/util/ArrayList;)V

    .line 304
    const-string v0, "mr_ai_style_saved"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0, v5}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 305
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->finish()V

    goto :goto_2

    .line 301
    :cond_5
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v1, 0x32

    if-ge v0, v1, :cond_6

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_3

    .line 302
    :cond_6
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {v2, v0, v3}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    goto :goto_3
.end method

.method private t(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 80
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {p0, p1, v0}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 81
    if-eqz v0, :cond_0

    move-object p1, v0

    :cond_0
    return-object p1
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 64
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 65
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 20

    .prologue
    .line 103
    invoke-super/range {p0 .. p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 104
    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->getIntent()Landroid/content/Intent;

    move-result-object v3

    if-eqz v3, :cond_0

    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->getIntent()Landroid/content/Intent;

    move-result-object v3

    const-string v4, "mr_ai_style_index"

    const/4 v5, -0x1

    invoke-virtual {v3, v4, v5}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    move-object/from16 v0, p0

    iput v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    .line 105
    :cond_0
    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/MrAi;->loadCustom(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v11

    .line 106
    move-object/from16 v0, p0

    iget v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    if-ltz v3, :cond_2

    move-object/from16 v0, p0

    iget v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    invoke-virtual {v11}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-ge v3, v4, :cond_2

    const/4 v3, 0x1

    move v10, v3

    .line 107
    :goto_0
    if-nez v10, :cond_1

    const/4 v3, -0x1

    move-object/from16 v0, p0

    iput v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    .line 109
    :cond_1
    const-string v3, "mr_ui_bg"

    move-object/from16 v0, p0

    invoke-direct {v0, v3}, Lcom/mrkeyboard/app/MrAiStyleActivity;->color(Ljava/lang/String;)I

    move-result v3

    .line 110
    const-string v4, "mr_ui_card"

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/MrAiStyleActivity;->color(Ljava/lang/String;)I

    move-result v4

    .line 111
    const-string v5, "mr_ui_stroke_strong"

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/MrAiStyleActivity;->color(Ljava/lang/String;)I

    move-result v5

    .line 112
    const-string v6, "mr_ui_text"

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrAiStyleActivity;->color(Ljava/lang/String;)I

    move-result v6

    .line 113
    const-string v7, "mr_ui_text2"

    move-object/from16 v0, p0

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/MrAiStyleActivity;->color(Ljava/lang/String;)I

    move-result v7

    .line 114
    const-string v8, "mr_accent"

    move-object/from16 v0, p0

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/MrAiStyleActivity;->color(Ljava/lang/String;)I

    move-result v12

    .line 115
    const-string v8, "mr_text_on_accent"

    move-object/from16 v0, p0

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/MrAiStyleActivity;->color(Ljava/lang/String;)I

    move-result v13

    .line 116
    const-string v8, "mr_ui_rose"

    move-object/from16 v0, p0

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/MrAiStyleActivity;->color(Ljava/lang/String;)I

    move-result v14

    .line 118
    new-instance v15, Landroid/widget/ScrollView;

    move-object/from16 v0, p0

    invoke-direct {v15, v0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 119
    const/4 v8, 0x0

    const/4 v9, 0x0

    const/16 v16, 0x0

    move-object/from16 v0, p0

    move/from16 v1, v16

    invoke-direct {v0, v3, v8, v9, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    invoke-virtual {v15, v3}, Landroid/widget/ScrollView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 120
    new-instance v16, Landroid/widget/LinearLayout;

    move-object/from16 v0, v16

    move-object/from16 v1, p0

    invoke-direct {v0, v1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 121
    const/4 v3, 0x1

    move-object/from16 v0, v16

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 122
    const/high16 v3, 0x41a00000    # 20.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v3}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v3

    const/high16 v8, 0x41800000    # 16.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v8

    const/high16 v9, 0x41a00000    # 20.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v9

    const/high16 v17, 0x41c00000    # 24.0f

    move-object/from16 v0, p0

    move/from16 v1, v17

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v17

    move-object/from16 v0, v16

    move/from16 v1, v17

    invoke-virtual {v0, v3, v8, v9, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 123
    new-instance v3, Landroid/view/ViewGroup$LayoutParams;

    const/4 v8, -0x1

    const/4 v9, -0x2

    invoke-direct {v3, v8, v9}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    move-object/from16 v0, v16

    invoke-virtual {v15, v0, v3}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 127
    new-instance v8, Landroid/widget/LinearLayout;

    move-object/from16 v0, p0

    invoke-direct {v8, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 128
    const/4 v3, 0x0

    invoke-virtual {v8, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 129
    const/16 v3, 0x10

    invoke-virtual {v8, v3}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 130
    new-instance v9, Landroid/widget/TextView;

    move-object/from16 v0, p0

    invoke-direct {v9, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 131
    if-eqz v10, :cond_3

    const-string v3, "mr_ai_edit_style"

    :goto_1
    move-object/from16 v0, p0

    invoke-direct {v0, v3}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v9, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 132
    invoke-virtual {v9, v6}, Landroid/widget/TextView;->setTextColor(I)V

    .line 133
    const/high16 v3, 0x41c00000    # 24.0f

    invoke-virtual {v9, v3}, Landroid/widget/TextView;->setTextSize(F)V

    .line 134
    const/4 v3, 0x0

    const/16 v17, 0x1

    move/from16 v0, v17

    invoke-virtual {v9, v3, v0}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 135
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/16 v17, 0x0

    const/16 v18, -0x2

    const/high16 v19, 0x3f800000    # 1.0f

    move/from16 v0, v17

    move/from16 v1, v18

    move/from16 v2, v19

    invoke-direct {v3, v0, v1, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v8, v9, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 136
    new-instance v3, Landroid/widget/TextView;

    move-object/from16 v0, p0

    invoke-direct {v3, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 137
    const-string v9, "\u2715"

    invoke-virtual {v3, v9}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 138
    invoke-virtual {v3, v6}, Landroid/widget/TextView;->setTextColor(I)V

    .line 139
    const/high16 v9, 0x41a00000    # 20.0f

    invoke-virtual {v3, v9}, Landroid/widget/TextView;->setTextSize(F)V

    .line 140
    const/16 v9, 0x11

    invoke-virtual {v3, v9}, Landroid/widget/TextView;->setGravity(I)V

    .line 141
    const/high16 v9, 0x41200000    # 10.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v9

    const/high16 v17, 0x40c00000    # 6.0f

    move-object/from16 v0, p0

    move/from16 v1, v17

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v17

    const/high16 v18, 0x41200000    # 10.0f

    move-object/from16 v0, p0

    move/from16 v1, v18

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v18

    const/high16 v19, 0x40c00000    # 6.0f

    move-object/from16 v0, p0

    move/from16 v1, v19

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v19

    move/from16 v0, v17

    move/from16 v1, v18

    move/from16 v2, v19

    invoke-virtual {v3, v9, v0, v1, v2}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 142
    new-instance v9, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;

    const/16 v17, 0x1

    move-object/from16 v0, p0

    move/from16 v1, v17

    invoke-direct {v9, v0, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;-><init>(Lcom/mrkeyboard/app/MrAiStyleActivity;I)V

    invoke-virtual {v3, v9}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 143
    new-instance v9, Landroid/widget/LinearLayout$LayoutParams;

    const/16 v17, -0x2

    const/16 v18, -0x2

    move/from16 v0, v17

    move/from16 v1, v18

    invoke-direct {v9, v0, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v8, v3, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 145
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v9, -0x1

    const/16 v17, -0x2

    move/from16 v0, v17

    invoke-direct {v3, v9, v0}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    move-object/from16 v0, v16

    invoke-virtual {v0, v8, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 149
    new-instance v3, Landroid/widget/LinearLayout;

    move-object/from16 v0, p0

    invoke-direct {v3, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 150
    const/4 v8, 0x0

    invoke-virtual {v3, v8}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 151
    const/16 v8, 0x11

    invoke-virtual {v3, v8}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 152
    const/4 v8, 0x0

    const/high16 v9, 0x41900000    # 18.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v9

    const/16 v17, 0x0

    const/high16 v18, 0x41900000    # 18.0f

    move-object/from16 v0, p0

    move/from16 v1, v18

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v18

    move/from16 v0, v17

    move/from16 v1, v18

    invoke-virtual {v3, v8, v9, v0, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 153
    new-instance v8, Landroid/widget/TextView;

    move-object/from16 v0, p0

    invoke-direct {v8, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    move-object/from16 v0, p0

    iput-object v8, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mCircle:Landroid/widget/TextView;

    .line 154
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mCircle:Landroid/widget/TextView;

    invoke-virtual {v8, v6}, Landroid/widget/TextView;->setTextColor(I)V

    .line 155
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mCircle:Landroid/widget/TextView;

    const/high16 v9, 0x42200000    # 40.0f

    invoke-virtual {v8, v9}, Landroid/widget/TextView;->setTextSize(F)V

    .line 156
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mCircle:Landroid/widget/TextView;

    const/16 v9, 0x11

    invoke-virtual {v8, v9}, Landroid/widget/TextView;->setGravity(I)V

    .line 157
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mCircle:Landroid/widget/TextView;

    const/4 v9, 0x0

    const/16 v17, 0x1

    move-object/from16 v0, p0

    move/from16 v1, v17

    invoke-direct {v0, v4, v5, v9, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v9

    invoke-virtual {v8, v9}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 158
    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mCircle:Landroid/widget/TextView;

    new-instance v9, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v17, 0x42b00000    # 88.0f

    move-object/from16 v0, p0

    move/from16 v1, v17

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v17

    const/high16 v18, 0x42b00000    # 88.0f

    move-object/from16 v0, p0

    move/from16 v1, v18

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v18

    move/from16 v0, v17

    move/from16 v1, v18

    invoke-direct {v9, v0, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v8, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 159
    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v9, -0x1

    const/16 v17, -0x2

    move/from16 v0, v17

    invoke-direct {v8, v9, v0}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    move-object/from16 v0, v16

    invoke-virtual {v0, v3, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 162
    const-string v3, "mr_ai_style_name_hint"

    move-object/from16 v0, p0

    invoke-direct {v0, v3}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    const/16 v9, 0x4001

    move-object/from16 v3, p0

    invoke-direct/range {v3 .. v9}, Lcom/mrkeyboard/app/MrAiStyleActivity;->field(IIIILjava/lang/String;I)Landroid/widget/EditText;

    move-result-object v3

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mName:Landroid/widget/EditText;

    .line 164
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mName:Landroid/widget/EditText;

    const/4 v8, 0x1

    invoke-virtual {v3, v8}, Landroid/widget/EditText;->setSingleLine(Z)V

    .line 165
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mName:Landroid/widget/EditText;

    const/4 v8, 0x0

    move-object/from16 v0, p0

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/MrAiStyleActivity;->fieldParams(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v8

    move-object/from16 v0, v16

    invoke-virtual {v0, v3, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 167
    const-string v3, "mr_ai_style_instr_hint"

    move-object/from16 v0, p0

    invoke-direct {v0, v3}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    const v9, 0x24001

    move-object/from16 v3, p0

    invoke-direct/range {v3 .. v9}, Lcom/mrkeyboard/app/MrAiStyleActivity;->field(IIIILjava/lang/String;I)Landroid/widget/EditText;

    move-result-object v3

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    .line 170
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    const/4 v4, 0x3

    invoke-virtual {v3, v4}, Landroid/widget/EditText;->setMinLines(I)V

    .line 171
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    const/16 v4, 0x30

    invoke-virtual {v3, v4}, Landroid/widget/EditText;->setGravity(I)V

    .line 172
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    const/16 v4, 0xc

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/MrAiStyleActivity;->fieldParams(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    move-object/from16 v0, v16

    invoke-virtual {v0, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 174
    new-instance v3, Landroid/widget/TextView;

    move-object/from16 v0, p0

    invoke-direct {v3, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 175
    const-string v4, "mr_ai_style_icon"

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 176
    invoke-virtual {v3, v7}, Landroid/widget/TextView;->setTextColor(I)V

    .line 177
    const/high16 v4, 0x41500000    # 13.0f

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setTextSize(F)V

    .line 178
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, -0x1

    const/4 v6, -0x2

    invoke-direct {v4, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 180
    const/high16 v5, 0x40800000    # 4.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v5

    const/high16 v6, 0x41900000    # 18.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v6

    const/high16 v7, 0x40800000    # 4.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v7

    const/high16 v8, 0x40c00000    # 6.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v8

    invoke-virtual {v4, v5, v6, v7, v8}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 181
    move-object/from16 v0, v16

    invoke-virtual {v0, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 183
    const/4 v3, 0x0

    :goto_2
    mul-int/lit8 v4, v3, 0x8

    sget-object v5, Lcom/mrkeyboard/app/MrAiStyleActivity;->EMOJIS:[Ljava/lang/String;

    array-length v5, v5

    if-ge v4, v5, :cond_5

    .line 184
    new-instance v5, Landroid/widget/LinearLayout;

    move-object/from16 v0, p0

    invoke-direct {v5, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 185
    const/4 v4, 0x0

    invoke-virtual {v5, v4}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 186
    const/4 v4, 0x0

    :goto_3
    const/16 v6, 0x8

    if-ge v4, v6, :cond_4

    mul-int/lit8 v6, v3, 0x8

    add-int/2addr v6, v4

    sget-object v7, Lcom/mrkeyboard/app/MrAiStyleActivity;->EMOJIS:[Ljava/lang/String;

    array-length v7, v7

    if-ge v6, v7, :cond_4

    .line 187
    mul-int/lit8 v6, v3, 0x8

    add-int/2addr v6, v4

    .line 188
    new-instance v7, Landroid/widget/TextView;

    move-object/from16 v0, p0

    invoke-direct {v7, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 189
    sget-object v8, Lcom/mrkeyboard/app/MrAiStyleActivity;->EMOJIS:[Ljava/lang/String;

    aget-object v8, v8, v6

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 190
    const/high16 v8, 0x41b00000    # 22.0f

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setTextSize(F)V

    .line 191
    const/16 v8, 0x11

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setGravity(I)V

    .line 192
    new-instance v8, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;

    add-int/lit8 v6, v6, 0x64

    move-object/from16 v0, p0

    invoke-direct {v8, v0, v6}, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;-><init>(Lcom/mrkeyboard/app/MrAiStyleActivity;I)V

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 193
    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmojiViews:Ljava/util/ArrayList;

    invoke-virtual {v6, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 194
    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v8, 0x0

    const/high16 v9, 0x42300000    # 44.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v9

    const/high16 v17, 0x3f800000    # 1.0f

    move/from16 v0, v17

    invoke-direct {v6, v8, v9, v0}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v5, v7, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 186
    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    .line 106
    :cond_2
    const/4 v3, 0x0

    move v10, v3

    goto/16 :goto_0

    .line 131
    :cond_3
    const-string v3, "mr_ai_new_style"

    goto/16 :goto_1

    .line 196
    :cond_4
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x1

    const/high16 v7, 0x42300000    # 44.0f

    .line 197
    move-object/from16 v0, p0

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v7

    invoke-direct {v4, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 196
    move-object/from16 v0, v16

    invoke-virtual {v0, v5, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 183
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_2

    .line 200
    :cond_5
    new-instance v4, Landroid/widget/TextView;

    move-object/from16 v0, p0

    invoke-direct {v4, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 201
    if-eqz v10, :cond_8

    const-string v3, "mr_ai_style_save_btn"

    :goto_4
    move-object/from16 v0, p0

    invoke-direct {v0, v3}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v4, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 202
    invoke-virtual {v4, v13}, Landroid/widget/TextView;->setTextColor(I)V

    .line 203
    const/high16 v3, 0x41800000    # 16.0f

    invoke-virtual {v4, v3}, Landroid/widget/TextView;->setTextSize(F)V

    .line 204
    const/4 v3, 0x0

    const/4 v5, 0x1

    invoke-virtual {v4, v3, v5}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 205
    const/16 v3, 0x11

    invoke-virtual {v4, v3}, Landroid/widget/TextView;->setGravity(I)V

    .line 206
    const/4 v3, 0x0

    const/high16 v5, 0x41d00000    # 26.0f

    const/4 v6, 0x0

    move-object/from16 v0, p0

    invoke-direct {v0, v12, v3, v5, v6}, Lcom/mrkeyboard/app/MrAiStyleActivity;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    invoke-virtual {v4, v3}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 207
    new-instance v3, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;

    const/4 v5, 0x2

    move-object/from16 v0, p0

    invoke-direct {v3, v0, v5}, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;-><init>(Lcom/mrkeyboard/app/MrAiStyleActivity;I)V

    invoke-virtual {v4, v3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 208
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, -0x1

    const/high16 v6, 0x42500000    # 52.0f

    .line 209
    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v6

    invoke-direct {v3, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 210
    const/4 v5, 0x0

    const/high16 v6, 0x41b00000    # 22.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v6

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-virtual {v3, v5, v6, v7, v8}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 211
    move-object/from16 v0, v16

    invoke-virtual {v0, v4, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 213
    if-eqz v10, :cond_6

    .line 214
    new-instance v3, Landroid/widget/TextView;

    move-object/from16 v0, p0

    invoke-direct {v3, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    .line 215
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    const-string v4, "mr_ai_style_delete"

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 216
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    invoke-virtual {v3, v14}, Landroid/widget/TextView;->setTextColor(I)V

    .line 217
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    const/high16 v4, 0x41600000    # 14.0f

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setTextSize(F)V

    .line 218
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    const/16 v4, 0x11

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setGravity(I)V

    .line 219
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    const/high16 v4, 0x41000000    # 8.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v4

    const/high16 v5, 0x41400000    # 12.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v5

    const/high16 v6, 0x41000000    # 8.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v6

    const/high16 v7, 0x40800000    # 4.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v7

    invoke-virtual {v3, v4, v5, v6, v7}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 220
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    new-instance v4, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;

    const/4 v5, 0x3

    move-object/from16 v0, p0

    invoke-direct {v4, v0, v5}, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;-><init>(Lcom/mrkeyboard/app/MrAiStyleActivity;I)V

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 221
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, -0x1

    const/4 v5, -0x2

    invoke-direct {v3, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 223
    const/4 v4, 0x0

    const/high16 v5, 0x41200000    # 10.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v5

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-virtual {v3, v4, v5, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 224
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    move-object/from16 v0, v16

    invoke-virtual {v0, v4, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 227
    :cond_6
    if-eqz v10, :cond_7

    .line 228
    move-object/from16 v0, p0

    iget v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    invoke-virtual {v11, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [Ljava/lang/String;

    .line 229
    const/4 v4, 0x0

    aget-object v4, v3, v4

    move-object/from16 v0, p0

    iput-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmoji:Ljava/lang/String;

    .line 230
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mName:Landroid/widget/EditText;

    const/4 v5, 0x1

    aget-object v5, v3, v5

    invoke-virtual {v4, v5}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 231
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    const/4 v5, 0x2

    aget-object v3, v3, v5

    invoke-virtual {v4, v3}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 233
    :cond_7
    invoke-direct/range {p0 .. p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->refreshEmoji()V

    .line 234
    move-object/from16 v0, p0

    invoke-virtual {v0, v15}, Lcom/mrkeyboard/app/MrAiStyleActivity;->setContentView(Landroid/view/View;)V

    .line 235
    return-void

    .line 201
    :cond_8
    const-string v3, "mr_ai_style_create_btn"

    goto/16 :goto_4
.end method

.method protected onPause()V
    .locals 1

    .prologue
    .line 75
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAiDialog;->setAuxiliaryUiVisible(Z)V

    .line 76
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    .line 77
    return-void
.end method

.method protected onResume()V
    .locals 1

    .prologue
    .line 69
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 70
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAiDialog;->setAuxiliaryUiVisible(Z)V

    .line 71
    return-void
.end method
