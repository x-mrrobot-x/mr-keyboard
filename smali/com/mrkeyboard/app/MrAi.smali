.class public final Lcom/mrkeyboard/app/MrAi;
.super Ljava/lang/Object;
.source "MrAi.java"

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnLongClickListener;
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrAi$AiFail;
    }
.end annotation


# static fields
.field private static final BUILTIN_EMOJI:[Ljava/lang/String;

.field private static final BUILTIN_FIX:I = 0x2

.field private static final BUILTIN_INSTR:[Ljava/lang/String;

.field private static final BUILTIN_NAME:[Ljava/lang/String;

.field private static final C_APPLY:I = 0x7

.field private static final C_BACK:I = 0x1

.field private static final C_CHIP:I = 0x64

.field private static final C_COPY:I = 0x6

.field private static final C_EMOJI:I = 0x5

.field private static final C_GEAR:I = 0x2

.field private static final C_REDO:I = 0x8

.field private static final EMOJI_NO:Ljava/lang/String; = " Do not add emojis that are not in the original text."

.field private static final EMOJI_YES:Ljava/lang/String; = " Sprinkle a few relevant emojis through the text where they fit naturally; do not overdo it."

.field static final ENDPOINT_DEF:Ljava/lang/String; = "https://api.openai.com/v1/chat/completions"

.field static final EXTRA_STYLE:Ljava/lang/String; = "mr_ai_style_index"

.field static final KEY_API_KEY:Ljava/lang/String; = "pref_ai_key"

.field static final KEY_EMOJIFY:Ljava/lang/String; = "emojify"

.field private static final KEY_EMOJI_DEFAULT_OFF_SET:Ljava/lang/String; = "emojify_default_off_set"

.field static final KEY_ENDPOINT:Ljava/lang/String; = "pref_ai_endpoint"

.field static final KEY_MODEL:Ljava/lang/String; = "pref_ai_model"

.field static final KEY_PROVIDER:Ljava/lang/String; = "pref_ai_provider"

.field static final KEY_SECRET:Ljava/lang/String; = "api_key"

.field static final KEY_STYLES:Ljava/lang/String; = "styles"

.field static final MAX_CHARS:I = 0xfa0

.field static final MAX_STYLES:I = 0x32

.field static final MODEL_DEF:Ljava/lang/String; = "gpt-6.1-terra"

.field static final PREFS:Ljava/lang/String; = "mr_ai"

.field private static final R_BG:I = 0x3e8

.field private static final R_UI:I = 0x3e9

.field private static final SYSTEM:Ljava/lang/String; = "You are a text-rewriting assistant inside a keyboard. Rewrite the text that comes after the separator, following the instruction. Keep the original language of the text unless the instruction clearly asks otherwise. Reply with ONLY the rewritten text: no quotes, no explanations, no preamble, no markdown fences."

.field private static sBlocked:Z

.field private static sBtnApply:Landroid/widget/TextView;

.field private static sBtnEmoji:Landroid/view/View;

.field private static sBusy:Z

.field private static sCustom:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<[",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static sEmojiCheck:Landroid/widget/TextView;

.field private static sEmojiLabel:Landroid/widget/TextView;

.field private static sEmojify:Z

.field private static sFired:Z

.field private static sHandler:Landroid/os/Handler;

.field private static sIsSel:Z

.field private static sOpen:Z

.field private static sResult:Landroid/widget/TextView;

.field private static sResultText:Ljava/lang/String;

.field private static sRoot:Landroid/view/View;

.field private static sSel:I

.field private static sSeq:I

.field private static sSource:Ljava/lang/String;

.field private static sStatus:Landroid/widget/TextView;

.field private static sStrip:Landroid/view/ViewGroup;


# instance fields
.field private final mCode:I

.field private mContext:Landroid/content/Context;

.field private mEmojify:Z

.field private mError:Ljava/lang/String;

.field private mSeq:I

.field private mSource:Ljava/lang/String;

.field private mTemp:D

.field private mText:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/4 v7, 0x4

    const/4 v6, 0x3

    const/4 v5, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 86
    const/4 v0, 0x7

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "\ud83e\udd1d"

    aput-object v1, v0, v3

    const-string v1, "\ud83c\udfaf"

    aput-object v1, v0, v4

    const-string v1, "\u2705"

    aput-object v1, v0, v5

    const-string v1, "\ud83d\udcdd"

    aput-object v1, v0, v6

    const-string v1, "\ud83d\ude0a"

    aput-object v1, v0, v7

    const/4 v1, 0x5

    const-string v2, "\ud83d\udcbc"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "\u270d\ufe0f"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->BUILTIN_EMOJI:[Ljava/lang/String;

    .line 87
    const/4 v0, 0x7

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "mr_ai_style_formal"

    aput-object v1, v0, v3

    const-string v1, "mr_ai_style_short"

    aput-object v1, v0, v4

    const-string v1, "mr_ai_style_fix"

    aput-object v1, v0, v5

    const-string v1, "mr_ai_style_expand"

    aput-object v1, v0, v6

    const-string v1, "mr_ai_style_friendly"

    aput-object v1, v0, v7

    const/4 v1, 0x5

    const-string v2, "mr_ai_style_pro"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "mr_ai_style_punct"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->BUILTIN_NAME:[Ljava/lang/String;

    .line 90
    const/4 v0, 0x7

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "Rewrite the text in a formal, polite and well-structured tone, fixing grammar and spelling. Keep the meaning."

    aput-object v1, v0, v3

    const-string v1, "Rewrite the text much shorter and more direct, keeping only the essential meaning. Remove filler words."

    aput-object v1, v0, v4

    const-string v1, "Correct only spelling, missing accents, grammar, punctuation and capitalization. Keep the words, the tone and the word order as they are whenever possible."

    aput-object v1, v0, v5

    const-string v1, "Expand the text with a bit more detail, clarity and completeness, keeping the same tone and meaning."

    aput-object v1, v0, v6

    const-string v1, "Rewrite the text in a warm, friendly and casual tone, like talking to a friend. Keep the meaning."

    aput-object v1, v0, v7

    const/4 v1, 0x5

    const-string v2, "Rewrite the text in a professional, clear and objective business tone, suitable for work messages and email. Keep the meaning."

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "Fix only punctuation, capitalization, spacing and missing accents. Do not change any word."

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->BUILTIN_INSTR:[Ljava/lang/String;

    .line 130
    const/4 v0, -0x1

    sput v0, Lcom/mrkeyboard/app/MrAi;->sSel:I

    .line 133
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sCustom:Ljava/util/ArrayList;

    return-void
.end method

.method private constructor <init>(I)V
    .locals 0

    .prologue
    .line 144
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 145
    iput p1, p0, Lcom/mrkeyboard/app/MrAi;->mCode:I

    .line 146
    return-void
.end method

.method private constructor <init>(ILjava/lang/String;ID)V
    .locals 0

    .prologue
    .line 148
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 149
    iput p1, p0, Lcom/mrkeyboard/app/MrAi;->mCode:I

    .line 150
    iput-object p2, p0, Lcom/mrkeyboard/app/MrAi;->mText:Ljava/lang/String;

    .line 151
    iput p3, p0, Lcom/mrkeyboard/app/MrAi;->mSeq:I

    .line 152
    iput-wide p4, p0, Lcom/mrkeyboard/app/MrAi;->mTemp:D

    .line 153
    return-void
.end method

.method private static addChip(ILjava/lang/String;Ljava/lang/String;)V
    .locals 12

    .prologue
    const/4 v11, 0x1

    const/4 v10, -0x2

    const/high16 v6, 0x41200000    # 10.0f

    const/high16 v9, 0x40400000    # 3.0f

    const/4 v8, 0x0

    .line 421
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 422
    const-string v1, "mr_ui_text2"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    .line 423
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 424
    invoke-virtual {v2, v11}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 425
    const/16 v3, 0x11

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 427
    invoke-static {v6}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v3

    invoke-static {v6}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v4

    invoke-static {v6}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v5

    invoke-static {v6}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v6

    invoke-virtual {v2, v3, v4, v5, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 428
    invoke-static {v8}, Lcom/mrkeyboard/app/MrAi;->styleChipBackground(Z)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 431
    if-nez p0, :cond_1

    .line 432
    new-instance v3, Landroid/widget/ImageView;

    invoke-direct {v3, v0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 433
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    const-string v5, "ic_mr_ai_add_edit"

    const-string v6, "drawable"

    .line 434
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v7

    .line 433
    invoke-virtual {v4, v5, v6, v7}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    .line 435
    if-eqz v4, :cond_0

    invoke-virtual {v3, v4}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 436
    :cond_0
    invoke-virtual {v3, v1}, Landroid/widget/ImageView;->setColorFilter(I)V

    .line 437
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v5, 0x41a00000    # 20.0f

    invoke-static {v5}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v5

    const/high16 v6, 0x41a00000    # 20.0f

    invoke-static {v6}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v6

    invoke-direct {v4, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 438
    const/high16 v5, 0x40000000    # 2.0f

    invoke-static {v5}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v5

    invoke-virtual {v4, v8, v8, v8, v5}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 439
    invoke-virtual {v3, v4}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 440
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 455
    :goto_0
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 456
    invoke-virtual {v3, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 457
    invoke-virtual {v3, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 458
    const/high16 v0, 0x41300000    # 11.0f

    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setTextSize(F)V

    .line 459
    const/16 v0, 0x11

    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setGravity(I)V

    .line 460
    invoke-virtual {v3, v11}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 463
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v10, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 465
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 467
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x1

    invoke-direct {v0, v10, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 469
    invoke-static {v9}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v1

    invoke-static {v9}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v3

    invoke-static {v9}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v4

    invoke-static {v9}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v5

    invoke-virtual {v0, v1, v3, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 470
    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 471
    new-instance v0, Lcom/mrkeyboard/app/MrAi;

    add-int/lit8 v1, p0, 0x64

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrAi;-><init>(I)V

    .line 472
    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 473
    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    .line 474
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStrip:Landroid/view/ViewGroup;

    invoke-virtual {v0, v2}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 475
    return-void

    .line 442
    :cond_1
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 443
    invoke-virtual {v3, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 444
    invoke-virtual {v3, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 445
    const/high16 v4, 0x41900000    # 18.0f

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setTextSize(F)V

    .line 446
    const/16 v4, 0x11

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setGravity(I)V

    .line 447
    invoke-virtual {v3, v11}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 448
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v5, 0x41b00000    # 22.0f

    .line 449
    invoke-static {v5}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v5

    invoke-direct {v4, v10, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 450
    const/high16 v5, 0x40000000    # 2.0f

    invoke-static {v5}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v5

    invoke-virtual {v4, v8, v8, v8, v5}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 451
    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 452
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto/16 :goto_0
.end method

.method static apiKey(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 530
    const-string v0, "mr_ai"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "api_key"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 531
    if-nez v0, :cond_0

    const-string v0, ""

    :goto_0
    return-object v0

    :cond_0
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private static applyResult()V
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 761
    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-eqz v1, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    if-nez v1, :cond_1

    .line 796
    :cond_0
    :goto_0
    return-void

    .line 763
    :cond_1
    :try_start_0
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 764
    if-eqz v1, :cond_0

    .line 765
    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->getAppInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v1

    .line 766
    if-eqz v1, :cond_0

    .line 767
    invoke-interface {v1}, Landroid/view/inputmethod/InputConnection;->beginBatchEdit()Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 770
    :try_start_1
    sget-boolean v2, Lcom/mrkeyboard/app/MrAi;->sIsSel:Z

    if-eqz v2, :cond_3

    .line 771
    const/4 v2, 0x0

    invoke-interface {v1, v2}, Landroid/view/inputmethod/InputConnection;->getSelectedText(I)Ljava/lang/CharSequence;

    move-result-object v2

    .line 772
    if-eqz v2, :cond_2

    sget-object v3, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 773
    invoke-interface {v1}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z

    .line 774
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    const/4 v2, 0x1

    invoke-interface {v1, v0, v2}, Landroid/view/inputmethod/InputConnection;->commitText(Ljava/lang/CharSequence;I)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v0

    .line 785
    :cond_2
    :goto_1
    :try_start_2
    invoke-interface {v1}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 787
    if-eqz v0, :cond_4

    .line 788
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    .line 793
    :catch_0
    move-exception v0

    .line 794
    const-string v0, "mr_ai_changed"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->setStatus(Ljava/lang/String;)V

    goto :goto_0

    .line 777
    :cond_3
    :try_start_3
    sget-object v2, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v2

    .line 778
    if-eqz v2, :cond_2

    sget-object v3, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 779
    invoke-interface {v1}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z

    .line 780
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v2, 0x0

    invoke-interface {v1, v0, v2}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z

    .line 781
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    const/4 v2, 0x1

    invoke-interface {v1, v0, v2}, Landroid/view/inputmethod/InputConnection;->commitText(Ljava/lang/CharSequence;I)Z
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result v0

    goto :goto_1

    .line 785
    :catchall_0
    move-exception v0

    :try_start_4
    invoke-interface {v1}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 786
    throw v0

    .line 790
    :cond_4
    const-string v0, "mr_ai_changed"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->setStatus(Ljava/lang/String;)V

    .line 791
    const-string v0, "mr_ai_changed"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->toast(Ljava/lang/String;)V
    :try_end_4
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_0

    goto/16 :goto_0
.end method

.method private static btn(Ljava/lang/String;I)Landroid/view/View;
    .locals 3

    .prologue
    .line 222
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    .line 223
    if-nez v1, :cond_0

    const/4 v1, 0x0

    .line 228
    :goto_0
    return-object v1

    .line 224
    :cond_0
    instance-of v0, v1, Landroid/widget/TextView;

    if-eqz v0, :cond_1

    move-object v0, v1

    .line 225
    check-cast v0, Landroid/widget/TextView;

    const-string v2, "mr_ui_text2"

    invoke-static {v2}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 227
    :cond_1
    new-instance v0, Lcom/mrkeyboard/app/MrAi;

    invoke-direct {v0, p1}, Lcom/mrkeyboard/app/MrAi;-><init>(I)V

    invoke-virtual {v1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    goto :goto_0
.end method

.method private static captureSource()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v0, 0x0

    .line 338
    sput-object v3, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    .line 339
    sput-boolean v0, Lcom/mrkeyboard/app/MrAi;->sIsSel:Z

    .line 340
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->isPasswordField()Z

    move-result v0

    sput-boolean v0, Lcom/mrkeyboard/app/MrAi;->sBlocked:Z

    .line 341
    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sBlocked:Z

    if-eqz v0, :cond_1

    .line 359
    :cond_0
    :goto_0
    return-void

    .line 343
    :cond_1
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 344
    if-eqz v0, :cond_0

    .line 345
    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->mrCommit()V

    .line 346
    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getAppInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v0

    .line 347
    if-eqz v0, :cond_0

    .line 348
    const/4 v1, 0x0

    invoke-interface {v0, v1}, Landroid/view/inputmethod/InputConnection;->getSelectedText(I)Ljava/lang/CharSequence;

    move-result-object v1

    .line 349
    if-eqz v1, :cond_2

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-lez v2, :cond_2

    .line 350
    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    .line 351
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrAi;->sIsSel:Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 356
    :catch_0
    move-exception v0

    .line 357
    sput-object v3, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    goto :goto_0

    .line 354
    :cond_2
    const/16 v1, 0xfa0

    const/4 v2, 0x0

    :try_start_1
    invoke-interface {v0, v1, v2}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v0

    .line 355
    if-eqz v0, :cond_0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0
.end method

.method private static cfg(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 540
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 541
    if-nez v0, :cond_0

    :goto_0
    return-object p2

    :cond_0
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p2

    goto :goto_0
.end method

.method private static chipBackground(Z)Landroid/graphics/drawable/GradientDrawable;
    .locals 3

    .prologue
    const/high16 v2, 0x41900000    # 18.0f

    .line 247
    if-eqz p0, :cond_0

    .line 248
    const-string v0, "mr_ui_cyan_soft"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v0

    const-string v1, "mr_ui_cyan_line"

    .line 249
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    .line 248
    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrAi;->rounded(IIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    .line 251
    :goto_0
    return-object v0

    :cond_0
    const-string v0, "mr_ui_card"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v0

    const-string v1, "mr_ui_stroke"

    .line 252
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    .line 251
    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrAi;->rounded(IIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    goto :goto_0
.end method

.method private static clean(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 750
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 751
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x2

    if-le v1, v2, :cond_0

    const-string v1, "\""

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "\""

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 752
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 753
    const/4 v1, 0x1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 755
    :cond_0
    return-object v0
.end method

.method private static configured(Landroid/content/Context;)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 545
    const-string v1, "pref_ai_endpoint"

    const-string v2, "https://api.openai.com/v1/chat/completions"

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrAi;->cfg(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 546
    const-string v2, "pref_ai_model"

    const-string v3, "gpt-6.1-terra"

    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/MrAi;->cfg(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 547
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 548
    :cond_0
    :goto_0
    return v0

    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAi;->apiKey(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0
.end method

.method private static copyResult()V
    .locals 3

    .prologue
    .line 799
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    .line 809
    :cond_0
    :goto_0
    return-void

    .line 801
    :cond_1
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "clipboard"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/ClipboardManager;

    .line 802
    if-eqz v0, :cond_0

    .line 803
    const-string v1, "mr_ai"

    sget-object v2, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    invoke-static {v1, v2}, Landroid/content/ClipData;->newPlainText(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/content/ClipData;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/ClipboardManager;->setPrimaryClip(Landroid/content/ClipData;)V

    .line 804
    const-string v0, "mr_ai_copied"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->toast(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 806
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static dialogClosed()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 277
    sget v0, Lcom/mrkeyboard/app/MrAi;->sSeq:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrAi;->sSeq:I

    .line 278
    sput-boolean v2, Lcom/mrkeyboard/app/MrAi;->sOpen:Z

    .line 279
    sput-boolean v2, Lcom/mrkeyboard/app/MrAi;->sBusy:Z

    .line 280
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    .line 281
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sStrip:Landroid/view/ViewGroup;

    .line 282
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    .line 283
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sResult:Landroid/widget/TextView;

    .line 284
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sBtnEmoji:Landroid/view/View;

    .line 285
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sEmojiCheck:Landroid/widget/TextView;

    .line 286
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sEmojiLabel:Landroid/widget/TextView;

    .line 287
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sBtnApply:Landroid/widget/TextView;

    .line 288
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sHandler:Landroid/os/Handler;

    .line 289
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    .line 290
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    .line 291
    return-void
.end method

.method private static dp(F)I
    .locals 1

    .prologue
    .line 168
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr v0, p0

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    return v0
.end method

.method private static emojiCheckBackground(Z)Landroid/graphics/drawable/GradientDrawable;
    .locals 3

    .prologue
    .line 265
    if-eqz p0, :cond_0

    const-string v0, "mr_ui_cyan_soft"

    :goto_0
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    .line 266
    if-eqz p0, :cond_1

    const-string v0, "mr_ui_cyan"

    :goto_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v0

    .line 267
    const/high16 v2, 0x40a00000    # 5.0f

    invoke-static {v1, v0, v2}, Lcom/mrkeyboard/app/MrAi;->rounded(IIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    return-object v0

    .line 265
    :cond_0
    const-string v0, "mr_ui_sunken"

    goto :goto_0

    .line 266
    :cond_1
    const-string v0, "mr_ui_stroke_strong"

    goto :goto_1
.end method

.method private static extract(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    const/4 v2, 0x0

    .line 724
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 725
    const-string v3, "choices"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    .line 726
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v3

    if-nez v3, :cond_1

    .line 745
    :cond_0
    :goto_0
    return-object v2

    .line 727
    :cond_1
    invoke-virtual {v0, v1}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    .line 728
    if-eqz v3, :cond_0

    .line 729
    const-string v0, "message"

    invoke-virtual {v3, v0}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 730
    if-eqz v0, :cond_5

    .line 731
    const-string v4, "content"

    invoke-virtual {v0, v4}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 732
    instance-of v4, v0, Ljava/lang/String;

    if-eqz v4, :cond_2

    check-cast v0, Ljava/lang/String;

    move-object v2, v0

    goto :goto_0

    .line 733
    :cond_2
    instance-of v4, v0, Lorg/json/JSONArray;

    if-eqz v4, :cond_5

    .line 734
    check-cast v0, Lorg/json/JSONArray;

    .line 735
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 736
    :goto_1
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v3

    if-ge v1, v3, :cond_4

    .line 737
    invoke-virtual {v0, v1}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    .line 738
    if-eqz v3, :cond_3

    const-string v4, "text"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 736
    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 739
    :cond_3
    invoke-virtual {v0, v1}, Lorg/json/JSONArray;->optString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_2

    .line 741
    :cond_4
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 744
    :cond_5
    const-string v0, "text"

    invoke-virtual {v3, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 745
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_6

    :goto_3
    move-object v2, v0

    goto :goto_0

    :cond_6
    move-object v0, v2

    goto :goto_3
.end method

.method private static fieldBackground()Landroid/graphics/drawable/GradientDrawable;
    .locals 3

    .prologue
    .line 271
    const-string v0, "mr_ui_sunken"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v0

    const-string v1, "mr_ui_stroke_strong"

    .line 272
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    const/high16 v2, 0x41800000    # 16.0f

    .line 271
    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrAi;->rounded(IIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    return-object v0
.end method

.method private static fire()V
    .locals 7

    .prologue
    const/4 v3, 0x1

    .line 561
    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sOpen:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    if-nez v0, :cond_1

    .line 597
    :cond_0
    :goto_0
    return-void

    .line 562
    :cond_1
    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sBlocked:Z

    if-eqz v0, :cond_2

    .line 563
    const-string v0, "mr_ai_password"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->setStatus(Ljava/lang/String;)V

    goto :goto_0

    .line 566
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    if-eqz v0, :cond_3

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_4

    .line 567
    :cond_3
    const-string v0, "mr_ai_no_text"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->setStatus(Ljava/lang/String;)V

    goto :goto_0

    .line 570
    :cond_4
    sget v0, Lcom/mrkeyboard/app/MrAi;->sSel:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->instructionFor(I)Ljava/lang/String;

    move-result-object v2

    .line 571
    if-nez v2, :cond_5

    .line 572
    const-string v0, "mr_ai_tap_style"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->setStatus(Ljava/lang/String;)V

    goto :goto_0

    .line 575
    :cond_5
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v6

    .line 576
    invoke-static {v6}, Lcom/mrkeyboard/app/MrAi;->configured(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_6

    .line 577
    const-string v0, "mr_ai_no_key"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->setStatus(Ljava/lang/String;)V

    .line 578
    const-string v0, "mr_ai_no_key"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 581
    :cond_6
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0xfa0

    if-le v0, v1, :cond_7

    .line 582
    const-string v0, "mr_tr_long"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 585
    :cond_7
    sget v0, Lcom/mrkeyboard/app/MrAi;->sSel:I

    const/4 v1, 0x2

    if-eq v0, v1, :cond_8

    sget v0, Lcom/mrkeyboard/app/MrAi;->sSel:I

    sget-object v1, Lcom/mrkeyboard/app/MrAi;->BUILTIN_INSTR:[Ljava/lang/String;

    array-length v1, v1

    add-int/lit8 v1, v1, -0x1

    if-ne v0, v1, :cond_9

    :cond_8
    const-wide v4, 0x3fd3333333333333L    # 0.3

    .line 586
    :goto_1
    sget v0, Lcom/mrkeyboard/app/MrAi;->sSeq:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrAi;->sSeq:I

    .line 587
    sput-boolean v3, Lcom/mrkeyboard/app/MrAi;->sBusy:Z

    .line 588
    sput-boolean v3, Lcom/mrkeyboard/app/MrAi;->sFired:Z

    .line 589
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    .line 590
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->updateApply()V

    .line 591
    const-string v0, "mr_ai_working"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->setStatus(Ljava/lang/String;)V

    .line 592
    new-instance v0, Lcom/mrkeyboard/app/MrAi;

    const/16 v1, 0x3e8

    sget v3, Lcom/mrkeyboard/app/MrAi;->sSeq:I

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrAi;-><init>(ILjava/lang/String;ID)V

    .line 593
    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    iput-object v1, v0, Lcom/mrkeyboard/app/MrAi;->mSource:Ljava/lang/String;

    .line 594
    sget-boolean v1, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    iput-boolean v1, v0, Lcom/mrkeyboard/app/MrAi;->mEmojify:Z

    .line 595
    invoke-virtual {v6}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    iput-object v1, v0, Lcom/mrkeyboard/app/MrAi;->mContext:Landroid/content/Context;

    .line 596
    new-instance v1, Ljava/lang/Thread;

    invoke-direct {v1, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto/16 :goto_0

    .line 585
    :cond_9
    const-wide v4, 0x3fe6666666666666L    # 0.7

    goto :goto_1
.end method

.method private static instructionFor(I)Ljava/lang/String;
    .locals 2

    .prologue
    .line 554
    if-ltz p0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->BUILTIN_INSTR:[Ljava/lang/String;

    array-length v0, v0

    if-ge p0, v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->BUILTIN_INSTR:[Ljava/lang/String;

    aget-object v0, v0, p0

    .line 557
    :goto_0
    return-object v0

    .line 555
    :cond_0
    add-int/lit8 v0, p0, -0x64

    .line 556
    if-ltz v0, :cond_1

    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sCustom:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge v0, v1, :cond_1

    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sCustom:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    const/4 v1, 0x2

    aget-object v0, v0, v1

    goto :goto_0

    .line 557
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static isPasswordField()Z
    .locals 5

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 322
    :try_start_0
    sget-object v2, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 323
    if-nez v2, :cond_1

    .line 332
    :cond_0
    :goto_0
    return v0

    .line 324
    :cond_1
    invoke-virtual {v2}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v2

    .line 325
    if-eqz v2, :cond_0

    .line 326
    iget v3, v2, Landroid/view/inputmethod/EditorInfo;->inputType:I

    and-int/lit8 v3, v3, 0xf

    .line 327
    iget v2, v2, Landroid/view/inputmethod/EditorInfo;->inputType:I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    and-int/lit16 v2, v2, 0xff0

    .line 328
    if-ne v3, v1, :cond_3

    const/16 v3, 0x80

    if-eq v2, v3, :cond_2

    const/16 v3, 0x90

    if-eq v2, v3, :cond_2

    const/16 v3, 0xe0

    if-ne v2, v3, :cond_0

    :cond_2
    move v0, v1

    goto :goto_0

    .line 329
    :cond_3
    const/4 v4, 0x2

    if-ne v3, v4, :cond_0

    const/16 v3, 0x10

    if-ne v2, v3, :cond_4

    :goto_1
    move v0, v1

    goto :goto_0

    :cond_4
    move v1, v0

    goto :goto_1

    .line 331
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static loadCustom(Landroid/content/Context;)Ljava/util/ArrayList;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/ArrayList",
            "<[",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 365
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 367
    :try_start_0
    const-string v2, "mr_ai"

    const/4 v3, 0x0

    invoke-virtual {p0, v2, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v2

    const-string v3, "styles"

    const/4 v4, 0x0

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 368
    if-nez v2, :cond_1

    .line 384
    :cond_0
    :goto_0
    return-object v0

    .line 369
    :cond_1
    new-instance v3, Lorg/json/JSONArray;

    invoke-direct {v3, v2}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    move v2, v1

    .line 370
    :goto_1
    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-ge v2, v1, :cond_0

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/16 v4, 0x32

    if-ge v1, v4, :cond_0

    .line 371
    invoke-virtual {v3, v2}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v1

    .line 372
    if-nez v1, :cond_3

    .line 370
    :cond_2
    :goto_2
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    goto :goto_1

    .line 373
    :cond_3
    const-string v4, "n"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 374
    const-string v5, "i"

    invoke-virtual {v1, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 375
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v6

    if-eqz v6, :cond_2

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v6

    if-eqz v6, :cond_2

    .line 376
    const-string v6, "e"

    invoke-virtual {v1, v6}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 377
    const/4 v6, 0x3

    new-array v6, v6, [Ljava/lang/String;

    const/4 v7, 0x0

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v8

    if-lez v8, :cond_4

    :goto_3
    aput-object v1, v6, v7

    const/4 v1, 0x1

    aput-object v4, v6, v1

    const/4 v1, 0x2

    aput-object v5, v6, v1

    invoke-virtual {v0, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 379
    :catch_0
    move-exception v1

    goto :goto_0

    .line 377
    :cond_4
    const-string v1, "\u2728"
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_3

    .line 381
    :catch_1
    move-exception v1

    goto :goto_0
.end method

.method private static loadCustomHere()V
    .locals 1

    .prologue
    .line 405
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->loadCustom(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sCustom:Ljava/util/ArrayList;

    .line 406
    return-void
.end method

.method private static onOpen()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 299
    sget v0, Lcom/mrkeyboard/app/MrAi;->sSeq:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrAi;->sSeq:I

    .line 300
    sput-boolean v1, Lcom/mrkeyboard/app/MrAi;->sBusy:Z

    .line 301
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    .line 302
    const/4 v0, -0x1

    sput v0, Lcom/mrkeyboard/app/MrAi;->sSel:I

    .line 303
    sput-boolean v1, Lcom/mrkeyboard/app/MrAi;->sFired:Z

    .line 304
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResult:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResult:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 305
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 306
    invoke-static {v0}, Lcom/mrkeyboard/app/MrNotice;->aiEditor(Landroid/content/Context;)V

    .line 307
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->loadCustomHere()V

    .line 308
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->rebuildStrip()V

    .line 309
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->refreshChips()V

    .line 310
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->captureSource()V

    .line 311
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->updateApply()V

    .line 312
    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    if-eqz v1, :cond_1

    .line 313
    sget-boolean v1, Lcom/mrkeyboard/app/MrAi;->sBlocked:Z

    if-eqz v1, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    const-string v1, "mr_ai_password"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 318
    :cond_1
    :goto_0
    return-void

    .line 314
    :cond_2
    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    if-eqz v1, :cond_3

    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_4

    :cond_3
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    const-string v1, "mr_ai_no_text"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 315
    :cond_4
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->configured(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_5

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    const-string v1, "mr_ai_no_key"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 316
    :cond_5
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    const-string v1, "mr_ai_tap_style"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0
.end method

.method static openPrefs(Landroid/content/Context;)V
    .locals 2

    .prologue
    .line 814
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->requestReopenOnReturn()V

    .line 815
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    .line 817
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/mrkeyboard/app/MrAiPrefs;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 818
    const/high16 v1, 0x10000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 819
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 824
    :goto_0
    return-void

    .line 820
    :catch_0
    move-exception v0

    .line 821
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->cancelReopenOnReturn()V

    goto :goto_0
.end method

.method static openStyleEditor(Landroid/content/Context;I)V
    .locals 3

    .prologue
    .line 829
    instance-of v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;

    if-nez v0, :cond_2

    const/4 v0, 0x1

    .line 830
    :goto_0
    if-eqz v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->requestReopenOnReturn()V

    .line 831
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    .line 833
    :try_start_0
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/mrkeyboard/app/MrAiStyleActivity;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 834
    const/high16 v2, 0x10000000

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 835
    const-string v2, "mr_ai_style_index"

    invoke-virtual {v1, v2, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 836
    invoke-virtual {p0, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 841
    :cond_1
    :goto_1
    return-void

    .line 829
    :cond_2
    const/4 v0, 0x0

    goto :goto_0

    .line 837
    :catch_0
    move-exception v1

    .line 838
    if-eqz v0, :cond_1

    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->cancelReopenOnReturn()V

    goto :goto_1
.end method

.method private static prefsAi()Landroid/content/SharedPreferences;
    .locals 3

    .prologue
    .line 172
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "mr_ai"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method private static preview(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .prologue
    const/16 v3, 0x5a

    .line 521
    const/16 v0, 0xa

    const/16 v1, 0x20

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 522
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-le v1, v3, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\u2026"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 523
    :cond_0
    return-object v0
.end method

.method private static readAll(Ljava/io/InputStream;)Ljava/lang/String;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 709
    if-nez p0, :cond_0

    const-string v0, ""

    .line 719
    :goto_0
    return-object v0

    .line 710
    :cond_0
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v1, Ljava/io/InputStreamReader;

    const-string v2, "UTF-8"

    invoke-direct {v1, p0, v2}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-direct {v0, v1}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 711
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 712
    const/16 v2, 0x1000

    new-array v2, v2, [C

    .line 714
    :cond_1
    invoke-virtual {v0, v2}, Ljava/io/BufferedReader;->read([C)I

    move-result v3

    const/4 v4, -0x1

    if-eq v3, v4, :cond_2

    .line 715
    const/4 v4, 0x0

    invoke-virtual {v1, v2, v4, v3}, Ljava/lang/StringBuilder;->append([CII)Ljava/lang/StringBuilder;

    .line 716
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->length()I

    move-result v3

    const/high16 v4, 0x40000

    if-le v3, v4, :cond_1

    .line 718
    :cond_2
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V

    .line 719
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private static rebuildStrip()V
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 409
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStrip:Landroid/view/ViewGroup;

    if-nez v0, :cond_0

    .line 418
    :goto_0
    return-void

    .line 410
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStrip:Landroid/view/ViewGroup;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->removeAllViews()V

    .line 411
    const/4 v0, 0x0

    const-string v2, "mr_ai_create"

    invoke-static {v2}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v0, v2}, Lcom/mrkeyboard/app/MrAi;->addChip(ILjava/lang/String;Ljava/lang/String;)V

    move v0, v1

    .line 412
    :goto_1
    sget-object v2, Lcom/mrkeyboard/app/MrAi;->BUILTIN_NAME:[Ljava/lang/String;

    array-length v2, v2

    if-ge v0, v2, :cond_1

    add-int/lit8 v2, v0, 0x1

    sget-object v3, Lcom/mrkeyboard/app/MrAi;->BUILTIN_EMOJI:[Ljava/lang/String;

    aget-object v3, v3, v0

    sget-object v4, Lcom/mrkeyboard/app/MrAi;->BUILTIN_NAME:[Ljava/lang/String;

    aget-object v4, v4, v0

    invoke-static {v4}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v3, v4}, Lcom/mrkeyboard/app/MrAi;->addChip(ILjava/lang/String;Ljava/lang/String;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    move v2, v1

    .line 413
    :goto_2
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sCustom:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v2, v0, :cond_2

    .line 414
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sCustom:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    .line 415
    sget-object v3, Lcom/mrkeyboard/app/MrAi;->BUILTIN_NAME:[Ljava/lang/String;

    array-length v3, v3

    add-int/lit8 v3, v3, 0x1

    add-int/2addr v3, v2

    aget-object v4, v0, v1

    const/4 v5, 0x1

    aget-object v0, v0, v5

    invoke-static {v3, v4, v0}, Lcom/mrkeyboard/app/MrAi;->addChip(ILjava/lang/String;Ljava/lang/String;)V

    .line 413
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_2

    .line 417
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->refreshChips()V

    goto :goto_0
.end method

.method private static refreshChips()V
    .locals 7

    .prologue
    const/4 v5, 0x1

    const/4 v3, 0x0

    .line 485
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStrip:Landroid/view/ViewGroup;

    if-nez v0, :cond_1

    .line 500
    :cond_0
    return-void

    :cond_1
    move v2, v3

    .line 486
    :goto_0
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStrip:Landroid/view/ViewGroup;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    if-ge v2, v0, :cond_0

    .line 487
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStrip:Landroid/view/ViewGroup;

    invoke-virtual {v0, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    .line 488
    instance-of v1, v0, Landroid/widget/LinearLayout;

    if-nez v1, :cond_3

    .line 486
    :cond_2
    :goto_1
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0

    .line 489
    :cond_3
    check-cast v0, Landroid/widget/LinearLayout;

    .line 490
    invoke-static {v2}, Lcom/mrkeyboard/app/MrAi;->styleAt(I)I

    move-result v1

    sget v4, Lcom/mrkeyboard/app/MrAi;->sSel:I

    if-ne v1, v4, :cond_5

    move v4, v5

    .line 491
    :goto_2
    if-eqz v4, :cond_6

    const-string v1, "mr_ui_cyan"

    :goto_3
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v6

    .line 492
    const/high16 v1, 0x3f800000    # 1.0f

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setAlpha(F)V

    .line 493
    invoke-static {v4}, Lcom/mrkeyboard/app/MrAi;->styleChipBackground(Z)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 494
    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    .line 495
    instance-of v4, v1, Landroid/widget/TextView;

    if-eqz v4, :cond_7

    check-cast v1, Landroid/widget/TextView;

    invoke-virtual {v1, v6}, Landroid/widget/TextView;->setTextColor(I)V

    .line 497
    :cond_4
    :goto_4
    invoke-virtual {v0, v5}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    .line 498
    instance-of v1, v0, Landroid/widget/TextView;

    if-eqz v1, :cond_2

    check-cast v0, Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_1

    :cond_5
    move v4, v3

    .line 490
    goto :goto_2

    .line 491
    :cond_6
    const-string v1, "mr_ui_text2"

    goto :goto_3

    .line 496
    :cond_7
    instance-of v4, v1, Landroid/widget/ImageView;

    if-eqz v4, :cond_4

    check-cast v1, Landroid/widget/ImageView;

    invoke-virtual {v1, v6}, Landroid/widget/ImageView;->setColorFilter(I)V

    goto :goto_4
.end method

.method private static refreshEmojiBtn()V
    .locals 2

    .prologue
    .line 503
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sBtnEmoji:Landroid/view/View;

    if-nez v0, :cond_1

    .line 514
    :cond_0
    :goto_0
    return-void

    .line 504
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sBtnEmoji:Landroid/view/View;

    sget-boolean v1, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->chipBackground(Z)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 505
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sEmojiCheck:Landroid/widget/TextView;

    if-eqz v0, :cond_2

    .line 506
    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sEmojiCheck:Landroid/widget/TextView;

    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    if-eqz v0, :cond_3

    const-string v0, "\u2713"

    :goto_1
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 507
    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sEmojiCheck:Landroid/widget/TextView;

    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    if-eqz v0, :cond_4

    const-string v0, "mr_ui_cyan"

    :goto_2
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 508
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sEmojiCheck:Landroid/widget/TextView;

    sget-boolean v1, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->emojiCheckBackground(Z)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 510
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sEmojiLabel:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    .line 511
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sEmojiLabel:Landroid/widget/TextView;

    const-string v1, "mr_ai_emojify"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 512
    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sEmojiLabel:Landroid/widget/TextView;

    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    if-eqz v0, :cond_5

    const-string v0, "mr_ui_cyan"

    :goto_3
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_0

    .line 506
    :cond_3
    const-string v0, ""

    goto :goto_1

    .line 507
    :cond_4
    const-string v0, "mr_ui_text2"

    goto :goto_2

    .line 512
    :cond_5
    const-string v0, "mr_ui_text2"

    goto :goto_3
.end method

.method public static release()V
    .locals 0

    .prologue
    .line 295
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    .line 296
    return-void
.end method

.method static rewrite(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ZD)Ljava/lang/String;
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrAi$AiFail;
        }
    .end annotation

    .prologue
    .line 641
    const-string v0, "pref_ai_endpoint"

    const-string v1, "https://api.openai.com/v1/chat/completions"

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrAi;->cfg(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 642
    const-string v0, "pref_ai_model"

    const-string v1, "gpt-6.1-terra"

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrAi;->cfg(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 643
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAi;->apiKey(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v4

    .line 644
    const-string v0, "https://"

    invoke-virtual {v2, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 645
    new-instance v0, Lcom/mrkeyboard/app/MrAi$AiFail;

    const-string v1, "mr_ai_bad_url"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrAi$AiFail;-><init>(Ljava/lang/String;)V

    throw v0

    .line 647
    :cond_0
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    .line 648
    new-instance v0, Lcom/mrkeyboard/app/MrAi$AiFail;

    const-string v1, "mr_ai_no_key"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrAi$AiFail;-><init>(Ljava/lang/String;)V

    throw v0

    .line 650
    :cond_1
    const/4 v1, 0x0

    .line 652
    :try_start_0
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5}, Lorg/json/JSONObject;-><init>()V

    .line 653
    const-string v0, "role"

    const-string v6, "system"

    invoke-virtual {v5, v0, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 654
    const-string v6, "content"

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "You are a text-rewriting assistant inside a keyboard. Rewrite the text that comes after the separator, following the instruction. Keep the original language of the text unless the instruction clearly asks otherwise. Reply with ONLY the rewritten text: no quotes, no explanations, no preamble, no markdown fences."

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    if-eqz p3, :cond_8

    const-string v0, " Sprinkle a few relevant emojis through the text where they fit naturally; do not overdo it."

    :goto_0
    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v6, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 655
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 656
    const-string v6, "role"

    const-string v7, "user"

    invoke-virtual {v0, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 657
    const-string v6, "content"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "\n\n---\n"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v0, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 658
    new-instance v6, Lorg/json/JSONArray;

    invoke-direct {v6}, Lorg/json/JSONArray;-><init>()V

    .line 659
    invoke-virtual {v6, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 660
    invoke-virtual {v6, v0}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 661
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5}, Lorg/json/JSONObject;-><init>()V

    .line 662
    const-string v0, "model"

    invoke-virtual {v5, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 664
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v3, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    const-string v3, "gpt-6"

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    const-string v0, "temperature"

    invoke-virtual {v5, v0, p4, p5}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 665
    :cond_2
    const-string v0, "messages"

    invoke-virtual {v5, v0, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 667
    new-instance v0, Ljava/net/URL;

    invoke-direct {v0, v2}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    check-cast v0, Ljava/net/HttpURLConnection;
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrAi$AiFail; {:try_start_0 .. :try_end_0} :catch_6
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 668
    const/16 v1, 0x3a98

    :try_start_1
    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 669
    const v1, 0xea60

    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 670
    const-string v1, "POST"

    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 671
    const-string v1, "Content-Type"

    const-string v2, "application/json; charset=utf-8"

    invoke-virtual {v0, v1, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 672
    const-string v1, "User-Agent"

    const-string v2, "MrKeyboard"

    invoke-virtual {v0, v1, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 673
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_3

    const-string v1, "Authorization"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Bearer "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 674
    :cond_3
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 675
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v1

    .line 676
    invoke-virtual {v5}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "UTF-8"

    invoke-virtual {v2, v3}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/OutputStream;->write([B)V

    .line 677
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V

    .line 679
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v3

    .line 680
    const/16 v1, 0xc8

    if-lt v3, v1, :cond_9

    const/16 v1, 0x12c

    if-ge v3, v1, :cond_9

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v1

    .line 681
    :goto_1
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->readAll(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object v2

    .line 682
    const/16 v1, 0xc8

    if-lt v3, v1, :cond_4

    const/16 v1, 0x12c

    if-lt v3, v1, :cond_a

    .line 683
    :cond_4
    const-string v1, ""
    :try_end_1
    .catch Lcom/mrkeyboard/app/MrAi$AiFail; {:try_start_1 .. :try_end_1} :catch_0
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 685
    :try_start_2
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v5, "error"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v4

    .line 686
    if-eqz v4, :cond_5

    const-string v1, "message"

    invoke-virtual {v4, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Lcom/mrkeyboard/app/MrAi$AiFail; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_4
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-result-object v1

    .line 690
    :cond_5
    :goto_2
    :try_start_3
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    const/16 v4, 0xb4

    if-le v2, v4, :cond_e

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v4, 0x0

    const/16 v5, 0xb4

    invoke-virtual {v1, v4, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\u2026"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    move-object v2, v1

    .line 691
    :goto_3
    const-string v1, "mr_ai_http"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v4, v5

    invoke-static {p0, v1, v4}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 692
    new-instance v3, Lcom/mrkeyboard/app/MrAi$AiFail;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v4

    if-lez v4, :cond_6

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, ": "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_6
    invoke-direct {v3, v1}, Lcom/mrkeyboard/app/MrAi$AiFail;-><init>(Ljava/lang/String;)V

    throw v3
    :try_end_3
    .catch Lcom/mrkeyboard/app/MrAi$AiFail; {:try_start_3 .. :try_end_3} :catch_0
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_2
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_4
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 697
    :catch_0
    move-exception v1

    move-object v9, v1

    move-object v1, v0

    move-object v0, v9

    .line 698
    :goto_4
    :try_start_4
    throw v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 704
    :catchall_0
    move-exception v0

    :goto_5
    if-eqz v1, :cond_7

    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 705
    :cond_7
    throw v0

    .line 654
    :cond_8
    :try_start_5
    const-string v0, " Do not add emojis that are not in the original text."
    :try_end_5
    .catch Lcom/mrkeyboard/app/MrAi$AiFail; {:try_start_5 .. :try_end_5} :catch_6
    .catch Lorg/json/JSONException; {:try_start_5 .. :try_end_5} :catch_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_3
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto/16 :goto_0

    .line 680
    :cond_9
    :try_start_6
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getErrorStream()Ljava/io/InputStream;

    move-result-object v1

    goto/16 :goto_1

    .line 687
    :catch_1
    move-exception v1

    .line 688
    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    goto :goto_2

    .line 694
    :cond_a
    invoke-static {v2}, Lcom/mrkeyboard/app/MrAi;->extract(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 695
    if-eqz v1, :cond_b

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_c

    :cond_b
    new-instance v1, Lcom/mrkeyboard/app/MrAi$AiFail;

    const-string v2, "mr_ai_empty"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/mrkeyboard/app/MrAi$AiFail;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_6
    .catch Lcom/mrkeyboard/app/MrAi$AiFail; {:try_start_6 .. :try_end_6} :catch_0
    .catch Lorg/json/JSONException; {:try_start_6 .. :try_end_6} :catch_2
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_4
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    .line 699
    :catch_2
    move-exception v1

    .line 700
    :goto_6
    :try_start_7
    new-instance v1, Lcom/mrkeyboard/app/MrAi$AiFail;

    const-string v2, "mr_ai_empty"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/mrkeyboard/app/MrAi$AiFail;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    .line 704
    :catchall_1
    move-exception v1

    move-object v9, v1

    move-object v1, v0

    move-object v0, v9

    goto :goto_5

    .line 696
    :cond_c
    :try_start_8
    invoke-static {v1, p2}, Lcom/mrkeyboard/app/MrAi;->clean(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_8
    .catch Lcom/mrkeyboard/app/MrAi$AiFail; {:try_start_8 .. :try_end_8} :catch_0
    .catch Lorg/json/JSONException; {:try_start_8 .. :try_end_8} :catch_2
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_4
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    move-result-object v1

    .line 704
    if-eqz v0, :cond_d

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 696
    :cond_d
    return-object v1

    .line 701
    :catch_3
    move-exception v0

    move-object v0, v1

    .line 702
    :goto_7
    :try_start_9
    new-instance v1, Lcom/mrkeyboard/app/MrAi$AiFail;

    const-string v2, "mr_ai_net_fail"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/mrkeyboard/app/MrAi$AiFail;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_1

    .line 701
    :catch_4
    move-exception v1

    goto :goto_7

    .line 699
    :catch_5
    move-exception v0

    move-object v0, v1

    goto :goto_6

    .line 697
    :catch_6
    move-exception v0

    goto :goto_4

    :cond_e
    move-object v2, v1

    goto/16 :goto_3
.end method

.method private static rounded(IIF)Landroid/graphics/drawable/GradientDrawable;
    .locals 3

    .prologue
    .line 238
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 239
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    .line 240
    invoke-virtual {v0, p0}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 241
    const/4 v1, 0x1

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-static {v2}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v2

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-virtual {v0, v1, p1}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 242
    invoke-static {p2}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 243
    return-object v0
.end method

.method static saveCustom(Landroid/content/Context;Ljava/util/ArrayList;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/ArrayList",
            "<[",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 389
    :try_start_0
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 390
    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    .line 391
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 392
    const-string v4, "e"

    const/4 v5, 0x0

    aget-object v5, v0, v5

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 393
    const-string v4, "n"

    const/4 v5, 0x1

    aget-object v5, v0, v5

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 394
    const-string v4, "i"

    const/4 v5, 0x2

    aget-object v0, v0, v5

    invoke-virtual {v3, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 395
    invoke-virtual {v1, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_0

    .line 399
    :catch_0
    move-exception v0

    .line 402
    :goto_1
    return-void

    .line 397
    :cond_0
    const-string v0, "mr_ai"

    const/4 v2, 0x0

    invoke-virtual {p0, v0, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 398
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v2, "styles"

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1
.end method

.method static setApiKey(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 535
    const-string v0, "mr_ai"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "api_key"

    .line 536
    if-nez p1, :cond_0

    const-string v0, ""

    :goto_0
    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 537
    return-void

    .line 536
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private static setStatus(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 600
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 601
    :cond_0
    return-void
.end method

.method static setup(Landroid/view/View;)V
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 179
    if-nez p0, :cond_0

    .line 219
    :goto_0
    return-void

    .line 180
    :cond_0
    sput-object p0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    .line 181
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sHandler:Landroid/os/Handler;

    .line 182
    const-string v0, "ai_strip"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sStrip:Landroid/view/ViewGroup;

    .line 183
    const-string v0, "ai_back"

    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrAi;->btn(Ljava/lang/String;I)Landroid/view/View;

    .line 184
    const-string v0, "ai_gear"

    const/4 v1, 0x2

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAi;->btn(Ljava/lang/String;I)Landroid/view/View;

    .line 185
    const-string v0, "ai_emoji"

    const/4 v1, 0x5

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAi;->btn(Ljava/lang/String;I)Landroid/view/View;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sBtnEmoji:Landroid/view/View;

    .line 186
    const-string v0, "ai_emoji_check"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sEmojiCheck:Landroid/widget/TextView;

    .line 187
    const-string v0, "ai_emoji_label"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sEmojiLabel:Landroid/widget/TextView;

    .line 188
    const-string v0, "ai_copy"

    const/4 v1, 0x6

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAi;->btn(Ljava/lang/String;I)Landroid/view/View;

    .line 189
    const-string v0, "ai_redo"

    const/16 v1, 0x8

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAi;->btn(Ljava/lang/String;I)Landroid/view/View;

    .line 190
    const-string v0, "ai_apply"

    const/4 v1, 0x7

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAi;->btn(Ljava/lang/String;I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sBtnApply:Landroid/widget/TextView;

    .line 192
    const-string v0, "ai_title"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 193
    if-eqz v0, :cond_1

    const-string v1, "mr_ui_text"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 194
    :cond_1
    const-string v0, "ai_hdr_result"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 195
    if-eqz v0, :cond_2

    const-string v1, "mr_ui_text"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 196
    :cond_2
    const-string v0, "ai_status"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    .line 197
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    if-eqz v0, :cond_3

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    const-string v1, "mr_ui_text2"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 198
    :cond_3
    const-string v0, "ai_result"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sResult:Landroid/widget/TextView;

    .line 199
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResult:Landroid/widget/TextView;

    if-eqz v0, :cond_4

    .line 200
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResult:Landroid/widget/TextView;

    const-string v1, "mr_ui_text"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 201
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResult:Landroid/widget/TextView;

    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->fieldBackground()Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 203
    :cond_4
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sBtnApply:Landroid/widget/TextView;

    if-eqz v0, :cond_5

    .line 204
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sBtnApply:Landroid/widget/TextView;

    const-string v1, "mr_text_on_accent"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 207
    :cond_5
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->prefsAi()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 208
    const-string v1, "emojify_default_off_set"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    if-nez v1, :cond_6

    .line 209
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "emojify"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "emojify_default_off_set"

    .line 210
    invoke-interface {v0, v1, v3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 211
    sput-boolean v2, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    .line 215
    :goto_1
    sput-boolean v3, Lcom/mrkeyboard/app/MrAi;->sOpen:Z

    .line 216
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->refreshEmojiBtn()V

    .line 217
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->updateApply()V

    .line 218
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->onOpen()V

    goto/16 :goto_0

    .line 213
    :cond_6
    const-string v1, "emojify"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    sput-boolean v0, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    goto :goto_1
.end method

.method private static styleAt(I)I
    .locals 1

    .prologue
    .line 479
    if-nez p0, :cond_0

    const/4 v0, -0x2

    .line 481
    :goto_0
    return v0

    .line 480
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->BUILTIN_NAME:[Ljava/lang/String;

    array-length v0, v0

    if-gt p0, v0, :cond_1

    add-int/lit8 v0, p0, -0x1

    goto :goto_0

    .line 481
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->BUILTIN_NAME:[Ljava/lang/String;

    array-length v0, v0

    sub-int v0, p0, v0

    add-int/lit8 v0, v0, -0x1

    add-int/lit8 v0, v0, 0x64

    goto :goto_0
.end method

.method private static styleChipBackground(Z)Landroid/graphics/drawable/GradientDrawable;
    .locals 3

    .prologue
    const/high16 v2, 0x41400000    # 12.0f

    .line 256
    if-eqz p0, :cond_0

    .line 257
    const-string v0, "mr_ui_cyan_soft"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v0

    const-string v1, "mr_ui_cyan_line"

    .line 258
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    .line 257
    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrAi;->rounded(IIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    .line 260
    :goto_0
    return-object v0

    :cond_0
    const-string v0, "mr_ui_card"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v0

    const-string v1, "mr_ui_stroke"

    .line 261
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    .line 260
    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrAi;->rounded(IIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    goto :goto_0
.end method

.method private static t(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 156
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    if-eqz v0, :cond_1

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 157
    :goto_0
    if-eqz v0, :cond_2

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, p0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 158
    :goto_1
    if-eqz v0, :cond_0

    move-object p0, v0

    :cond_0
    return-object p0

    .line 156
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    goto :goto_0

    .line 157
    :cond_2
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private static t(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 162
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    if-eqz v0, :cond_1

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 163
    :goto_0
    if-eqz v0, :cond_2

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-static {v0, p0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 164
    :goto_1
    if-eqz v0, :cond_0

    move-object p0, v0

    :cond_0
    return-object p0

    .line 162
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    goto :goto_0

    .line 163
    :cond_2
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private static uiColor(Ljava/lang/String;)I
    .locals 4

    .prologue
    .line 232
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 233
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "color"

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, p0, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 234
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getColor(I)I

    move-result v0

    return v0
.end method

.method private static updateApply()V
    .locals 2

    .prologue
    .line 517
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sBtnApply:Landroid/widget/TextView;

    if-eqz v0, :cond_1

    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sBtnApply:Landroid/widget/TextView;

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_2

    :cond_0
    const v0, 0x3ee66666    # 0.45f

    :goto_0
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setAlpha(F)V

    .line 518
    :cond_1
    return-void

    .line 517
    :cond_2
    const/high16 v0, 0x3f800000    # 1.0f

    goto :goto_0
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 846
    iget v0, p0, Lcom/mrkeyboard/app/MrAi;->mCode:I

    packed-switch v0, :pswitch_data_0

    .line 871
    :pswitch_0
    iget v0, p0, Lcom/mrkeyboard/app/MrAi;->mCode:I

    const/16 v1, 0x64

    if-lt v0, v1, :cond_0

    .line 872
    iget v0, p0, Lcom/mrkeyboard/app/MrAi;->mCode:I

    add-int/lit8 v0, v0, -0x64

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->styleAt(I)I

    move-result v0

    .line 873
    const/4 v1, -0x2

    if-ne v0, v1, :cond_2

    .line 874
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    const/4 v1, -0x1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAi;->openStyleEditor(Landroid/content/Context;I)V

    .line 881
    :cond_0
    :goto_0
    return-void

    .line 848
    :pswitch_1
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    goto :goto_0

    .line 851
    :pswitch_2
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->openPrefs(Landroid/content/Context;)V

    goto :goto_0

    .line 854
    :pswitch_3
    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    if-nez v0, :cond_1

    const/4 v0, 0x1

    :goto_1
    sput-boolean v0, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    .line 855
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->prefsAi()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "emojify"

    sget-boolean v2, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 856
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->refreshEmojiBtn()V

    .line 857
    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sFired:Z

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sBusy:Z

    if-nez v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->fire()V

    goto :goto_0

    .line 854
    :cond_1
    const/4 v0, 0x0

    goto :goto_1

    .line 860
    :pswitch_4
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->copyResult()V

    goto :goto_0

    .line 863
    :pswitch_5
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->applyResult()V

    goto :goto_0

    .line 866
    :pswitch_6
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->fire()V

    goto :goto_0

    .line 877
    :cond_2
    sput v0, Lcom/mrkeyboard/app/MrAi;->sSel:I

    .line 878
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->refreshChips()V

    .line 879
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->fire()V

    goto :goto_0

    .line 846
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
    .end packed-switch
.end method

.method public onLongClick(Landroid/view/View;)Z
    .locals 3

    .prologue
    const/16 v2, 0x64

    const/4 v0, 0x0

    .line 884
    iget v1, p0, Lcom/mrkeyboard/app/MrAi;->mCode:I

    if-ge v1, v2, :cond_1

    .line 890
    :cond_0
    :goto_0
    return v0

    .line 885
    :cond_1
    iget v1, p0, Lcom/mrkeyboard/app/MrAi;->mCode:I

    add-int/lit8 v1, v1, -0x64

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->styleAt(I)I

    move-result v1

    .line 886
    if-lt v1, v2, :cond_0

    .line 887
    add-int/lit8 v1, v1, -0x64

    .line 888
    sget-object v2, Lcom/mrkeyboard/app/MrAi;->sCustom:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_0

    .line 889
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    if-eqz v0, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAi;->openStyleEditor(Landroid/content/Context;I)V

    .line 890
    :cond_2
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public run()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 604
    iget v0, p0, Lcom/mrkeyboard/app/MrAi;->mCode:I

    const/16 v1, 0x3e8

    if-ne v0, v1, :cond_4

    .line 608
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAi;->mContext:Landroid/content/Context;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAi;->mContext:Landroid/content/Context;

    .line 609
    :goto_0
    if-nez v0, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    if-eqz v1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 610
    :cond_0
    if-nez v0, :cond_3

    new-instance v0, Lcom/mrkeyboard/app/MrAi$AiFail;

    const-string v1, "mr_ai_net_fail"

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrAi$AiFail;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrAi$AiFail; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    .line 612
    :catch_0
    move-exception v0

    .line 613
    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrAi$AiFail;->getMessage()Ljava/lang/String;

    move-result-object v0

    move-object v2, v6

    move-object v6, v0

    .line 617
    :goto_1
    new-instance v0, Lcom/mrkeyboard/app/MrAi;

    const/16 v1, 0x3e9

    iget v3, p0, Lcom/mrkeyboard/app/MrAi;->mSeq:I

    const-wide/16 v4, 0x0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrAi;-><init>(ILjava/lang/String;ID)V

    .line 618
    iput-object v6, v0, Lcom/mrkeyboard/app/MrAi;->mError:Ljava/lang/String;

    .line 619
    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sHandler:Landroid/os/Handler;

    if-eqz v1, :cond_1

    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sHandler:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 633
    :cond_1
    :goto_2
    return-void

    .line 608
    :cond_2
    :try_start_1
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    goto :goto_0

    .line 611
    :cond_3
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAi;->mText:Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAi;->mSource:Ljava/lang/String;

    iget-boolean v3, p0, Lcom/mrkeyboard/app/MrAi;->mEmojify:Z

    iget-wide v4, p0, Lcom/mrkeyboard/app/MrAi;->mTemp:D

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrAi;->rewrite(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ZD)Ljava/lang/String;
    :try_end_1
    .catch Lcom/mrkeyboard/app/MrAi$AiFail; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v2

    goto :goto_1

    .line 614
    :catch_1
    move-exception v0

    .line 615
    const-string v0, "mr_ai_net_fail"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    move-object v2, v6

    move-object v6, v0

    goto :goto_1

    .line 623
    :cond_4
    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sOpen:Z

    if-eqz v0, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrAi;->mSeq:I

    sget v1, Lcom/mrkeyboard/app/MrAi;->sSeq:I

    if-ne v0, v1, :cond_1

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResult:Landroid/widget/TextView;

    if-eqz v0, :cond_1

    .line 624
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrAi;->sBusy:Z

    .line 625
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAi;->mError:Ljava/lang/String;

    if-eqz v0, :cond_5

    .line 626
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAi;->mError:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->setStatus(Ljava/lang/String;)V

    goto :goto_2

    .line 629
    :cond_5
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAi;->mText:Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    .line 630
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResult:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAi;->mText:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 631
    const-string v0, "mr_ai_original"

    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->preview(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->setStatus(Ljava/lang/String;)V

    .line 632
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->updateApply()V

    goto :goto_2
.end method
