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

.field private static final S_ARMED:Ljava/lang/String; = "mr_style_delete_armed"

.field private static final S_EMOJI:Ljava/lang/String; = "mr_style_emoji"

.field private static final S_INSTR:Ljava/lang/String; = "mr_style_instr"

.field private static final S_NAME:Ljava/lang/String; = "mr_style_name"


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

    .line 59
    const/4 v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    .line 60
    sget-object v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->EMOJIS:[Ljava/lang/String;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmoji:Ljava/lang/String;

    .line 66
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
    .line 117
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
    .line 345
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDeleteArmed:Z

    if-nez v0, :cond_1

    .line 346
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDeleteArmed:Z

    .line 347
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    const-string v1, "mr_ai_style_delete_again"

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 357
    :cond_0
    :goto_0
    return-void

    .line 350
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAi;->loadCustom(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    .line 351
    iget v1, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    if-ltz v1, :cond_2

    iget v1, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_2

    .line 352
    iget v1, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 353
    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrAi;->saveCustom(Landroid/content/Context;Ljava/util/ArrayList;)V

    .line 354
    const-string v0, "mr_ai_style_deleted"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 356
    :cond_2
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->finish()V

    goto :goto_0
.end method

.method private dp(F)I
    .locals 1

    .prologue
    .line 121
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

    .line 274
    new-instance v0, Landroid/widget/EditText;

    invoke-direct {v0, p0}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    .line 275
    invoke-virtual {v0, p5}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    .line 276
    invoke-virtual {v0, p4}, Landroid/widget/EditText;->setHintTextColor(I)V

    .line 277
    invoke-virtual {v0, p3}, Landroid/widget/EditText;->setTextColor(I)V

    .line 278
    invoke-virtual {v0, v5}, Landroid/widget/EditText;->setTextSize(F)V

    .line 279
    invoke-virtual {v0, p6}, Landroid/widget/EditText;->setInputType(I)V

    .line 280
    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v1

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v2

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v3

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/widget/EditText;->setPadding(IIII)V

    .line 281
    const/4 v1, 0x0

    invoke-direct {p0, p1, p2, v5, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 282
    return-object v0
.end method

.method private fieldParams(I)Landroid/widget/LinearLayout$LayoutParams;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 286
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x1

    const/4 v2, -0x2

    invoke-direct {v0, v1, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 288
    if-lez p1, :cond_0

    int-to-float v1, p1

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v1

    invoke-virtual {v0, v3, v1, v3, v3}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 289
    :cond_0
    return-object v0
.end method

.method private onAction(I)V
    .locals 2

    .prologue
    .line 302
    const/16 v0, 0x64

    if-lt p1, v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->EMOJIS:[Ljava/lang/String;

    array-length v0, v0

    add-int/lit8 v0, v0, 0x64

    if-ge p1, v0, :cond_0

    .line 303
    sget-object v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->EMOJIS:[Ljava/lang/String;

    add-int/lit8 v1, p1, -0x64

    aget-object v0, v0, v1

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmoji:Ljava/lang/String;

    .line 304
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->refreshEmoji()V

    .line 320
    :goto_0
    return-void

    .line 307
    :cond_0
    packed-switch p1, :pswitch_data_0

    goto :goto_0

    .line 309
    :pswitch_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->finish()V

    goto :goto_0

    .line 312
    :pswitch_1
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->save()V

    goto :goto_0

    .line 315
    :pswitch_2
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->delete()V

    goto :goto_0

    .line 307
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

    .line 293
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mCircle:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmoji:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 294
    const-string v0, "mr_ui_cyan_soft"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->color(Ljava/lang/String;)I

    move-result v4

    move v1, v2

    .line 295
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmojiViews:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_1

    .line 296
    sget-object v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->EMOJIS:[Ljava/lang/String;

    aget-object v0, v0, v1

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmoji:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    .line 297
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

    .line 295
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 297
    :cond_0
    const/4 v3, 0x0

    goto :goto_1

    .line 299
    :cond_1
    return-void
.end method

.method private restoreDraft(Landroid/os/Bundle;)V
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 98
    if-eqz p1, :cond_0

    const-string v0, "mr_style_name"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 109
    :cond_0
    :goto_0
    return-void

    .line 99
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mName:Landroid/widget/EditText;

    const-string v2, "mr_style_name"

    invoke-virtual {p1, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 100
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    const-string v2, "mr_style_instr"

    invoke-virtual {p1, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 101
    const-string v0, "mr_style_emoji"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    move v0, v1

    .line 102
    :goto_1
    sget-object v3, Lcom/mrkeyboard/app/MrAiStyleActivity;->EMOJIS:[Ljava/lang/String;

    array-length v3, v3

    if-ge v0, v3, :cond_3

    .line 103
    sget-object v3, Lcom/mrkeyboard/app/MrAiStyleActivity;->EMOJIS:[Ljava/lang/String;

    aget-object v3, v3, v0

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmoji:Ljava/lang/String;

    .line 102
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 105
    :cond_3
    const-string v0, "mr_style_delete_armed"

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    .line 106
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDeleteArmed:Z

    .line 107
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    const-string v1, "mr_ai_style_delete_again"

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0
.end method

.method private round(IIFZ)Landroid/graphics/drawable/GradientDrawable;
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 125
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 126
    if-eqz p4, :cond_1

    invoke-virtual {v0, v2}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    .line 128
    :goto_0
    invoke-virtual {v0, p1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 129
    if-eqz p2, :cond_0

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-virtual {v0, v1, p2}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 130
    :cond_0
    return-object v0

    .line 127
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

    .line 323
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mName:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, ""

    .line 324
    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v1

    if-nez v1, :cond_1

    const-string v1, ""

    .line 325
    :goto_1
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_2

    .line 326
    const-string v0, "mr_ai_style_need_name"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0, v5}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 342
    :goto_2
    return-void

    .line 323
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mName:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 324
    :cond_1
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    .line 329
    :cond_2
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_3

    .line 330
    const-string v0, "mr_ai_style_need_instr"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0, v5}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    goto :goto_2

    .line 333
    :cond_3
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-le v2, v3, :cond_4

    invoke-virtual {v0, v5, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 334
    :cond_4
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAi;->loadCustom(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v2

    .line 335
    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/String;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmoji:Ljava/lang/String;

    aput-object v4, v3, v5

    const/4 v4, 0x1

    aput-object v0, v3, v4

    const/4 v0, 0x2

    aput-object v1, v3, v0

    .line 336
    iget v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    if-ltz v0, :cond_5

    iget v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge v0, v1, :cond_5

    iget v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    invoke-virtual {v2, v0, v3}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 339
    :goto_3
    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrAi;->saveCustom(Landroid/content/Context;Ljava/util/ArrayList;)V

    .line 340
    const-string v0, "mr_ai_style_saved"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0, v5}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 341
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->finish()V

    goto :goto_2

    .line 337
    :cond_5
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v1, 0x32

    if-ge v0, v1, :cond_6

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_3

    .line 338
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
    .line 112
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {p0, p1, v0}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 113
    if-eqz v0, :cond_0

    move-object p1, v0

    :cond_0
    return-object p1
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 70
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 71
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 20

    .prologue
    .line 135
    invoke-super/range {p0 .. p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 136
    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->getIntent()Landroid/content/Intent;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->getIntent()Landroid/content/Intent;

    move-result-object v2

    const-string v3, "mr_ai_style_index"

    const/4 v4, -0x1

    invoke-virtual {v2, v3, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v2

    move-object/from16 v0, p0

    iput v2, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    .line 137
    :cond_0
    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/MrAi;->loadCustom(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v12

    .line 138
    move-object/from16 v0, p0

    iget v2, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    if-ltz v2, :cond_2

    move-object/from16 v0, p0

    iget v2, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    invoke-virtual {v12}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v2, v3, :cond_2

    const/4 v2, 0x1

    move v11, v2

    .line 139
    :goto_0
    if-nez v11, :cond_1

    const/4 v2, -0x1

    move-object/from16 v0, p0

    iput v2, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    .line 141
    :cond_1
    const-string v2, "mr_ui_bg"

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/MrAiStyleActivity;->color(Ljava/lang/String;)I

    move-result v3

    .line 142
    const-string v2, "mr_ui_card"

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/MrAiStyleActivity;->color(Ljava/lang/String;)I

    move-result v13

    .line 143
    const-string v2, "mr_ui_stroke_strong"

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/MrAiStyleActivity;->color(Ljava/lang/String;)I

    move-result v14

    .line 144
    const-string v2, "mr_ui_text"

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/MrAiStyleActivity;->color(Ljava/lang/String;)I

    move-result v15

    .line 145
    const-string v2, "mr_ui_text2"

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/MrAiStyleActivity;->color(Ljava/lang/String;)I

    move-result v16

    .line 146
    const-string v2, "mr_accent"

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/MrAiStyleActivity;->color(Ljava/lang/String;)I

    move-result v17

    .line 147
    const-string v2, "mr_text_on_accent"

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/MrAiStyleActivity;->color(Ljava/lang/String;)I

    move-result v18

    .line 148
    const-string v2, "mr_ui_rose"

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/MrAiStyleActivity;->color(Ljava/lang/String;)I

    move-result v19

    .line 150
    new-instance v2, Landroid/widget/ScrollView;

    move-object/from16 v0, p0

    invoke-direct {v2, v0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 151
    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object/from16 v0, p0

    invoke-direct {v0, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrAiStyleActivity;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/ScrollView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 152
    new-instance v3, Landroid/widget/LinearLayout;

    move-object/from16 v0, p0

    invoke-direct {v3, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 153
    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 154
    const/high16 v4, 0x41a00000    # 20.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v4

    const/high16 v5, 0x41800000    # 16.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v5

    const/high16 v6, 0x41a00000    # 20.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v6

    const/high16 v7, 0x41c00000    # 24.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v7

    invoke-virtual {v3, v4, v5, v6, v7}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 155
    new-instance v4, Landroid/view/ViewGroup$LayoutParams;

    const/4 v5, -0x1

    const/4 v6, -0x2

    invoke-direct {v4, v5, v6}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v3, v4}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 158
    const/high16 v4, 0x41a00000    # 20.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v4

    const/high16 v5, 0x41800000    # 16.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v5

    const/high16 v6, 0x41a00000    # 20.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v6

    const/high16 v7, 0x41c00000    # 24.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v7

    const/high16 v8, 0x41400000    # 12.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v8

    invoke-static/range {v2 .. v8}, Lcom/mrkeyboard/app/MrScreenIme;->lift(Landroid/widget/ScrollView;Landroid/view/View;IIIII)V

    .line 161
    new-instance v5, Landroid/widget/LinearLayout;

    move-object/from16 v0, p0

    invoke-direct {v5, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 162
    const/4 v4, 0x0

    invoke-virtual {v5, v4}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 163
    const/16 v4, 0x10

    invoke-virtual {v5, v4}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 164
    new-instance v6, Landroid/widget/TextView;

    move-object/from16 v0, p0

    invoke-direct {v6, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 165
    if-eqz v11, :cond_3

    const-string v4, "mr_ai_edit_style"

    :goto_1
    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v6, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 166
    invoke-virtual {v6, v15}, Landroid/widget/TextView;->setTextColor(I)V

    .line 167
    const/high16 v4, 0x41c00000    # 24.0f

    invoke-virtual {v6, v4}, Landroid/widget/TextView;->setTextSize(F)V

    .line 168
    const/4 v4, 0x0

    const/4 v7, 0x1

    invoke-virtual {v6, v4, v7}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 169
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v7, 0x0

    const/4 v8, -0x2

    const/high16 v9, 0x3f800000    # 1.0f

    invoke-direct {v4, v7, v8, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v5, v6, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 170
    new-instance v4, Landroid/widget/TextView;

    move-object/from16 v0, p0

    invoke-direct {v4, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 171
    const-string v6, "\u2715"

    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 172
    invoke-virtual {v4, v15}, Landroid/widget/TextView;->setTextColor(I)V

    .line 173
    const/high16 v6, 0x41a00000    # 20.0f

    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setTextSize(F)V

    .line 174
    const/16 v6, 0x11

    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setGravity(I)V

    .line 175
    const/high16 v6, 0x41200000    # 10.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v6

    const/high16 v7, 0x40c00000    # 6.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v7

    const/high16 v8, 0x41200000    # 10.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v8

    const/high16 v9, 0x40c00000    # 6.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v9

    invoke-virtual {v4, v6, v7, v8, v9}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 176
    new-instance v6, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;

    const/4 v7, 0x1

    move-object/from16 v0, p0

    invoke-direct {v6, v0, v7}, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;-><init>(Lcom/mrkeyboard/app/MrAiStyleActivity;I)V

    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 177
    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v7, -0x2

    const/4 v8, -0x2

    invoke-direct {v6, v7, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v4, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 179
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x1

    const/4 v7, -0x2

    invoke-direct {v4, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v5, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 183
    new-instance v4, Landroid/widget/LinearLayout;

    move-object/from16 v0, p0

    invoke-direct {v4, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 184
    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 185
    const/16 v5, 0x11

    invoke-virtual {v4, v5}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 186
    const/4 v5, 0x0

    const/high16 v6, 0x41900000    # 18.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v6

    const/4 v7, 0x0

    const/high16 v8, 0x41900000    # 18.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v8

    invoke-virtual {v4, v5, v6, v7, v8}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 187
    new-instance v5, Landroid/widget/TextView;

    move-object/from16 v0, p0

    invoke-direct {v5, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    move-object/from16 v0, p0

    iput-object v5, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mCircle:Landroid/widget/TextView;

    .line 188
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mCircle:Landroid/widget/TextView;

    invoke-virtual {v5, v15}, Landroid/widget/TextView;->setTextColor(I)V

    .line 189
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mCircle:Landroid/widget/TextView;

    const/high16 v6, 0x42200000    # 40.0f

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setTextSize(F)V

    .line 190
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mCircle:Landroid/widget/TextView;

    const/16 v6, 0x11

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setGravity(I)V

    .line 191
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mCircle:Landroid/widget/TextView;

    const/4 v6, 0x0

    const/4 v7, 0x1

    move-object/from16 v0, p0

    invoke-direct {v0, v13, v14, v6, v7}, Lcom/mrkeyboard/app/MrAiStyleActivity;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v6

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 192
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mCircle:Landroid/widget/TextView;

    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v7, 0x42b00000    # 88.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v7

    const/high16 v8, 0x42b00000    # 88.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v8

    invoke-direct {v6, v7, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v4, v5, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 193
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x1

    const/4 v7, -0x2

    invoke-direct {v5, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 196
    const-string v4, "mr_ai_style_name_hint"

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    const/16 v10, 0x4001

    move-object/from16 v4, p0

    move v5, v13

    move v6, v14

    move v7, v15

    move/from16 v8, v16

    invoke-direct/range {v4 .. v10}, Lcom/mrkeyboard/app/MrAiStyleActivity;->field(IIIILjava/lang/String;I)Landroid/widget/EditText;

    move-result-object v4

    move-object/from16 v0, p0

    iput-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mName:Landroid/widget/EditText;

    .line 198
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mName:Landroid/widget/EditText;

    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Landroid/widget/EditText;->setSingleLine(Z)V

    .line 199
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mName:Landroid/widget/EditText;

    const/4 v5, 0x0

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/MrAiStyleActivity;->fieldParams(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 201
    const-string v4, "mr_ai_style_instr_hint"

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    const v10, 0x24001

    move-object/from16 v4, p0

    move v5, v13

    move v6, v14

    move v7, v15

    move/from16 v8, v16

    invoke-direct/range {v4 .. v10}, Lcom/mrkeyboard/app/MrAiStyleActivity;->field(IIIILjava/lang/String;I)Landroid/widget/EditText;

    move-result-object v4

    move-object/from16 v0, p0

    iput-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    .line 204
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    const/4 v5, 0x3

    invoke-virtual {v4, v5}, Landroid/widget/EditText;->setMinLines(I)V

    .line 205
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    const/16 v5, 0x30

    invoke-virtual {v4, v5}, Landroid/widget/EditText;->setGravity(I)V

    .line 206
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    const/16 v5, 0xc

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/MrAiStyleActivity;->fieldParams(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 208
    new-instance v4, Landroid/widget/TextView;

    move-object/from16 v0, p0

    invoke-direct {v4, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 209
    const-string v5, "mr_ai_style_icon"

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 210
    move/from16 v0, v16

    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 211
    const/high16 v5, 0x41500000    # 13.0f

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setTextSize(F)V

    .line 212
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x1

    const/4 v7, -0x2

    invoke-direct {v5, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 214
    const/high16 v6, 0x40800000    # 4.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v6

    const/high16 v7, 0x41900000    # 18.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v7

    const/high16 v8, 0x40800000    # 4.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v8

    const/high16 v9, 0x40c00000    # 6.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v9

    invoke-virtual {v5, v6, v7, v8, v9}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 215
    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 217
    const/4 v4, 0x0

    :goto_2
    mul-int/lit8 v5, v4, 0x8

    sget-object v6, Lcom/mrkeyboard/app/MrAiStyleActivity;->EMOJIS:[Ljava/lang/String;

    array-length v6, v6

    if-ge v5, v6, :cond_5

    .line 218
    new-instance v6, Landroid/widget/LinearLayout;

    move-object/from16 v0, p0

    invoke-direct {v6, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 219
    const/4 v5, 0x0

    invoke-virtual {v6, v5}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 220
    const/4 v5, 0x0

    :goto_3
    const/16 v7, 0x8

    if-ge v5, v7, :cond_4

    mul-int/lit8 v7, v4, 0x8

    add-int/2addr v7, v5

    sget-object v8, Lcom/mrkeyboard/app/MrAiStyleActivity;->EMOJIS:[Ljava/lang/String;

    array-length v8, v8

    if-ge v7, v8, :cond_4

    .line 221
    mul-int/lit8 v7, v4, 0x8

    add-int/2addr v7, v5

    .line 222
    new-instance v8, Landroid/widget/TextView;

    move-object/from16 v0, p0

    invoke-direct {v8, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 223
    sget-object v9, Lcom/mrkeyboard/app/MrAiStyleActivity;->EMOJIS:[Ljava/lang/String;

    aget-object v9, v9, v7

    invoke-virtual {v8, v9}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 224
    const/high16 v9, 0x41b00000    # 22.0f

    invoke-virtual {v8, v9}, Landroid/widget/TextView;->setTextSize(F)V

    .line 225
    const/16 v9, 0x11

    invoke-virtual {v8, v9}, Landroid/widget/TextView;->setGravity(I)V

    .line 226
    new-instance v9, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;

    add-int/lit8 v7, v7, 0x64

    move-object/from16 v0, p0

    invoke-direct {v9, v0, v7}, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;-><init>(Lcom/mrkeyboard/app/MrAiStyleActivity;I)V

    invoke-virtual {v8, v9}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 227
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmojiViews:Ljava/util/ArrayList;

    invoke-virtual {v7, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 228
    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v9, 0x0

    const/high16 v10, 0x42300000    # 44.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v10}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v10

    const/high16 v13, 0x3f800000    # 1.0f

    invoke-direct {v7, v9, v10, v13}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v6, v8, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 220
    add-int/lit8 v5, v5, 0x1

    goto :goto_3

    .line 138
    :cond_2
    const/4 v2, 0x0

    move v11, v2

    goto/16 :goto_0

    .line 165
    :cond_3
    const-string v4, "mr_ai_new_style"

    goto/16 :goto_1

    .line 230
    :cond_4
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v7, -0x1

    const/high16 v8, 0x42300000    # 44.0f

    .line 231
    move-object/from16 v0, p0

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v8

    invoke-direct {v5, v7, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 230
    invoke-virtual {v3, v6, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 217
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 234
    :cond_5
    new-instance v5, Landroid/widget/TextView;

    move-object/from16 v0, p0

    invoke-direct {v5, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 235
    if-eqz v11, :cond_8

    const-string v4, "mr_ai_style_save_btn"

    :goto_4
    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v5, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 236
    move/from16 v0, v18

    invoke-virtual {v5, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 237
    const/high16 v4, 0x41800000    # 16.0f

    invoke-virtual {v5, v4}, Landroid/widget/TextView;->setTextSize(F)V

    .line 238
    const/4 v4, 0x0

    const/4 v6, 0x1

    invoke-virtual {v5, v4, v6}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 239
    const/16 v4, 0x11

    invoke-virtual {v5, v4}, Landroid/widget/TextView;->setGravity(I)V

    .line 240
    const/4 v4, 0x0

    const/high16 v6, 0x41d00000    # 26.0f

    const/4 v7, 0x0

    move-object/from16 v0, p0

    move/from16 v1, v17

    invoke-direct {v0, v1, v4, v6, v7}, Lcom/mrkeyboard/app/MrAiStyleActivity;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v4

    invoke-virtual {v5, v4}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 241
    new-instance v4, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;

    const/4 v6, 0x2

    move-object/from16 v0, p0

    invoke-direct {v4, v0, v6}, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;-><init>(Lcom/mrkeyboard/app/MrAiStyleActivity;I)V

    invoke-virtual {v5, v4}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 242
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x1

    const/high16 v7, 0x42500000    # 52.0f

    .line 243
    move-object/from16 v0, p0

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v7

    invoke-direct {v4, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 244
    const/4 v6, 0x0

    const/high16 v7, 0x41b00000    # 22.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v7

    const/4 v8, 0x0

    const/4 v9, 0x0

    invoke-virtual {v4, v6, v7, v8, v9}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 245
    invoke-virtual {v3, v5, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 247
    if-eqz v11, :cond_6

    .line 248
    new-instance v4, Landroid/widget/TextView;

    move-object/from16 v0, p0

    invoke-direct {v4, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    move-object/from16 v0, p0

    iput-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    .line 249
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    const-string v5, "mr_ai_style_delete"

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/MrAiStyleActivity;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 250
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    move/from16 v0, v19

    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 251
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    const/high16 v5, 0x41600000    # 14.0f

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setTextSize(F)V

    .line 252
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    const/16 v5, 0x11

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setGravity(I)V

    .line 253
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    const/high16 v5, 0x41000000    # 8.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v5

    const/high16 v6, 0x41400000    # 12.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v6

    const/high16 v7, 0x41000000    # 8.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v7

    const/high16 v8, 0x40800000    # 4.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v8

    invoke-virtual {v4, v5, v6, v7, v8}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 254
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    new-instance v5, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;

    const/4 v6, 0x3

    move-object/from16 v0, p0

    invoke-direct {v5, v0, v6}, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;-><init>(Lcom/mrkeyboard/app/MrAiStyleActivity;I)V

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 255
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, -0x1

    const/4 v6, -0x2

    invoke-direct {v4, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 257
    const/4 v5, 0x0

    const/high16 v6, 0x41200000    # 10.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/MrAiStyleActivity;->dp(F)I

    move-result v6

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-virtual {v4, v5, v6, v7, v8}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 258
    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDelete:Landroid/widget/TextView;

    invoke-virtual {v3, v5, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 261
    :cond_6
    if-eqz v11, :cond_7

    .line 262
    move-object/from16 v0, p0

    iget v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mIndex:I

    invoke-virtual {v12, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [Ljava/lang/String;

    .line 263
    const/4 v4, 0x0

    aget-object v4, v3, v4

    move-object/from16 v0, p0

    iput-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmoji:Ljava/lang/String;

    .line 264
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mName:Landroid/widget/EditText;

    const/4 v5, 0x1

    aget-object v5, v3, v5

    invoke-virtual {v4, v5}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 265
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    const/4 v5, 0x2

    aget-object v3, v3, v5

    invoke-virtual {v4, v3}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 267
    :cond_7
    invoke-direct/range {p0 .. p1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->restoreDraft(Landroid/os/Bundle;)V

    .line 268
    invoke-direct/range {p0 .. p0}, Lcom/mrkeyboard/app/MrAiStyleActivity;->refreshEmoji()V

    .line 269
    move-object/from16 v0, p0

    invoke-virtual {v0, v2}, Lcom/mrkeyboard/app/MrAiStyleActivity;->setContentView(Landroid/view/View;)V

    .line 270
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mName:Landroid/widget/EditText;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    move-object/from16 v0, p1

    invoke-static {v0, v2, v3}, Lcom/mrkeyboard/app/MrScreenIme;->restore(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V

    .line 271
    return-void

    .line 235
    :cond_8
    const-string v4, "mr_ai_style_create_btn"

    goto/16 :goto_4
.end method

.method protected onPause()V
    .locals 1

    .prologue
    .line 81
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAiDialog;->setAuxiliaryUiVisible(Z)V

    .line 82
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    .line 83
    return-void
.end method

.method protected onResume()V
    .locals 1

    .prologue
    .line 75
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 76
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAiDialog;->setAuxiliaryUiVisible(Z)V

    .line 77
    return-void
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    .prologue
    .line 87
    invoke-super {p0, p1}, Landroid/app/Activity;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 88
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mName:Landroid/widget/EditText;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    if-nez v0, :cond_1

    .line 94
    :cond_0
    :goto_0
    return-void

    .line 89
    :cond_1
    const-string v1, "mr_style_name"

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mName:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    if-nez v0, :cond_2

    const-string v0, ""

    :goto_1
    invoke-virtual {p1, v1, v0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 90
    const-string v1, "mr_style_instr"

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    if-nez v0, :cond_3

    const-string v0, ""

    :goto_2
    invoke-virtual {p1, v1, v0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 91
    const-string v0, "mr_style_emoji"

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mEmoji:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 92
    const-string v0, "mr_style_delete_armed"

    iget-boolean v1, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mDeleteArmed:Z

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 93
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mName:Landroid/widget/EditText;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrScreenIme;->save(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V

    goto :goto_0

    .line 89
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mName:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 90
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity;->mInstr:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_2
.end method
