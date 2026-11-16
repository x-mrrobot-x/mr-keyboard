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

.field static final ENDPOINT_DEF:Ljava/lang/String; = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions"

.field static final ENDPOINT_OPENAI:Ljava/lang/String; = "https://api.openai.com/v1/chat/completions"

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

.field static final MODEL_DEF:Ljava/lang/String; = "gemini-3.5-flash-lite"

.field static final MODEL_OPENAI:Ljava/lang/String; = "gpt-6.1-terra"

.field static final PREFS:Ljava/lang/String; = "mr_ai"

.field static final PROVIDER_DEF:Ljava/lang/String; = "gemini"

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

    .line 91
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

    .line 92
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

    .line 95
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

    .line 135
    const/4 v0, -0x1

    sput v0, Lcom/mrkeyboard/app/MrAi;->sSel:I

    .line 138
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sCustom:Ljava/util/ArrayList;

    return-void
.end method

.method private constructor <init>(I)V
    .locals 0

    .prologue
    .line 149
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 150
    iput p1, p0, Lcom/mrkeyboard/app/MrAi;->mCode:I

    .line 151
    return-void
.end method

.method private constructor <init>(ILjava/lang/String;ID)V
    .locals 0

    .prologue
    .line 153
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 154
    iput p1, p0, Lcom/mrkeyboard/app/MrAi;->mCode:I

    .line 155
    iput-object p2, p0, Lcom/mrkeyboard/app/MrAi;->mText:Ljava/lang/String;

    .line 156
    iput p3, p0, Lcom/mrkeyboard/app/MrAi;->mSeq:I

    .line 157
    iput-wide p4, p0, Lcom/mrkeyboard/app/MrAi;->mTemp:D

    .line 158
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

    .line 425
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 426
    const-string v1, "mr_ui_text2"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    .line 427
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 428
    invoke-virtual {v2, v11}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 429
    const/16 v3, 0x11

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 431
    invoke-static {v6}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v3

    invoke-static {v6}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v4

    invoke-static {v6}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v5

    invoke-static {v6}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v6

    invoke-virtual {v2, v3, v4, v5, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 432
    invoke-static {v8}, Lcom/mrkeyboard/app/MrAi;->styleChipBackground(Z)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 435
    if-nez p0, :cond_1

    .line 436
    new-instance v3, Landroid/widget/ImageView;

    invoke-direct {v3, v0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 437
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    const-string v5, "ic_mr_ai_add_edit"

    const-string v6, "drawable"

    .line 438
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v7

    .line 437
    invoke-virtual {v4, v5, v6, v7}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    .line 439
    if-eqz v4, :cond_0

    invoke-virtual {v3, v4}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 440
    :cond_0
    invoke-virtual {v3, v1}, Landroid/widget/ImageView;->setColorFilter(I)V

    .line 441
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v5, 0x41a00000    # 20.0f

    invoke-static {v5}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v5

    const/high16 v6, 0x41a00000    # 20.0f

    invoke-static {v6}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v6

    invoke-direct {v4, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 442
    const/high16 v5, 0x40000000    # 2.0f

    invoke-static {v5}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v5

    invoke-virtual {v4, v8, v8, v8, v5}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 443
    invoke-virtual {v3, v4}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 444
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 459
    :goto_0
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 460
    invoke-virtual {v3, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 461
    invoke-virtual {v3, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 462
    const/high16 v0, 0x41300000    # 11.0f

    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setTextSize(F)V

    .line 463
    const/16 v0, 0x11

    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setGravity(I)V

    .line 464
    invoke-virtual {v3, v11}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 467
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v10, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 469
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 471
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x1

    invoke-direct {v0, v10, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 473
    invoke-static {v9}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v1

    invoke-static {v9}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v3

    invoke-static {v9}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v4

    invoke-static {v9}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v5

    invoke-virtual {v0, v1, v3, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 474
    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 475
    new-instance v0, Lcom/mrkeyboard/app/MrAi;

    add-int/lit8 v1, p0, 0x64

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrAi;-><init>(I)V

    .line 476
    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 477
    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    .line 478
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStrip:Landroid/view/ViewGroup;

    invoke-virtual {v0, v2}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 479
    return-void

    .line 446
    :cond_1
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 447
    invoke-virtual {v3, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 448
    invoke-virtual {v3, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 449
    const/high16 v4, 0x41900000    # 18.0f

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setTextSize(F)V

    .line 450
    const/16 v4, 0x11

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setGravity(I)V

    .line 451
    invoke-virtual {v3, v11}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 452
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v5, 0x41b00000    # 22.0f

    .line 453
    invoke-static {v5}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v5

    invoke-direct {v4, v10, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 454
    const/high16 v5, 0x40000000    # 2.0f

    invoke-static {v5}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v5

    invoke-virtual {v4, v8, v8, v8, v5}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 455
    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 456
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    goto/16 :goto_0
.end method

.method static apiKey(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 534
    const-string v0, "mr_ai"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "api_key"

    const-string v2, ""

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 535
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

    .line 786
    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-eqz v1, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    if-nez v1, :cond_1

    .line 821
    :cond_0
    :goto_0
    return-void

    .line 788
    :cond_1
    :try_start_0
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 789
    if-eqz v1, :cond_0

    .line 790
    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->getAppInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v1

    .line 791
    if-eqz v1, :cond_0

    .line 792
    invoke-interface {v1}, Landroid/view/inputmethod/InputConnection;->beginBatchEdit()Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 795
    :try_start_1
    sget-boolean v2, Lcom/mrkeyboard/app/MrAi;->sIsSel:Z

    if-eqz v2, :cond_3

    .line 796
    const/4 v2, 0x0

    invoke-interface {v1, v2}, Landroid/view/inputmethod/InputConnection;->getSelectedText(I)Ljava/lang/CharSequence;

    move-result-object v2

    .line 797
    if-eqz v2, :cond_2

    sget-object v3, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 798
    invoke-interface {v1}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z

    .line 799
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    const/4 v2, 0x1

    invoke-interface {v1, v0, v2}, Landroid/view/inputmethod/InputConnection;->commitText(Ljava/lang/CharSequence;I)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v0

    .line 810
    :cond_2
    :goto_1
    :try_start_2
    invoke-interface {v1}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 812
    if-eqz v0, :cond_4

    .line 813
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    .line 818
    :catch_0
    move-exception v0

    .line 819
    const-string v0, "mr_ai_changed"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->setStatus(Ljava/lang/String;)V

    goto :goto_0

    .line 802
    :cond_3
    :try_start_3
    sget-object v2, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v2

    .line 803
    if-eqz v2, :cond_2

    sget-object v3, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 804
    invoke-interface {v1}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z

    .line 805
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v2, 0x0

    invoke-interface {v1, v0, v2}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z

    .line 806
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    const/4 v2, 0x1

    invoke-interface {v1, v0, v2}, Landroid/view/inputmethod/InputConnection;->commitText(Ljava/lang/CharSequence;I)Z
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-result v0

    goto :goto_1

    .line 810
    :catchall_0
    move-exception v0

    :try_start_4
    invoke-interface {v1}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z

    .line 811
    throw v0

    .line 815
    :cond_4
    const-string v0, "mr_ai_changed"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->setStatus(Ljava/lang/String;)V

    .line 816
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
    .line 227
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    .line 228
    if-nez v1, :cond_0

    const/4 v1, 0x0

    .line 233
    :goto_0
    return-object v1

    .line 229
    :cond_0
    instance-of v0, v1, Landroid/widget/TextView;

    if-eqz v0, :cond_1

    move-object v0, v1

    .line 230
    check-cast v0, Landroid/widget/TextView;

    const-string v2, "mr_ui_text2"

    invoke-static {v2}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 232
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

    .line 342
    sput-object v3, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    .line 343
    sput-boolean v0, Lcom/mrkeyboard/app/MrAi;->sIsSel:Z

    .line 344
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->isPasswordField()Z

    move-result v0

    sput-boolean v0, Lcom/mrkeyboard/app/MrAi;->sBlocked:Z

    .line 345
    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sBlocked:Z

    if-eqz v0, :cond_1

    .line 363
    :cond_0
    :goto_0
    return-void

    .line 347
    :cond_1
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 348
    if-eqz v0, :cond_0

    .line 349
    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->mrCommit()V

    .line 350
    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getAppInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v0

    .line 351
    if-eqz v0, :cond_0

    .line 352
    const/4 v1, 0x0

    invoke-interface {v0, v1}, Landroid/view/inputmethod/InputConnection;->getSelectedText(I)Ljava/lang/CharSequence;

    move-result-object v1

    .line 353
    if-eqz v1, :cond_2

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-lez v2, :cond_2

    .line 354
    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    .line 355
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrAi;->sIsSel:Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 360
    :catch_0
    move-exception v0

    .line 361
    sput-object v3, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    goto :goto_0

    .line 358
    :cond_2
    const/16 v1, 0xfa0

    const/4 v2, 0x0

    :try_start_1
    invoke-interface {v0, v1, v2}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;

    move-result-object v0

    .line 359
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
    .line 544
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 545
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

    .line 252
    if-eqz p0, :cond_0

    .line 253
    const-string v0, "mr_ui_cyan_soft"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v0

    const-string v1, "mr_ui_cyan_line"

    .line 254
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    .line 253
    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrAi;->rounded(IIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    .line 256
    :goto_0
    return-object v0

    :cond_0
    const-string v0, "mr_ui_card"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v0

    const-string v1, "mr_ui_stroke"

    .line 257
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    .line 256
    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrAi;->rounded(IIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    goto :goto_0
.end method

.method private static clean(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 775
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 776
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

    .line 777
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 778
    const/4 v1, 0x1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 780
    :cond_0
    return-object v0
.end method

.method static complete(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;D)Ljava/lang/String;
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrAi$AiFail;
        }
    .end annotation

    .prologue
    .line 666
    const-string v0, "pref_ai_endpoint"

    const-string v1, "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions"

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrAi;->cfg(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 667
    const-string v1, "pref_ai_model"

    const-string v2, "gemini-3.5-flash-lite"

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrAi;->cfg(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 668
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAi;->apiKey(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    .line 669
    const-string v1, "https://"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 670
    new-instance v0, Lcom/mrkeyboard/app/MrAi$AiFail;

    const-string v1, "mr_ai_bad_url"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrAi$AiFail;-><init>(Ljava/lang/String;)V

    throw v0

    .line 672
    :cond_0
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 673
    new-instance v0, Lcom/mrkeyboard/app/MrAi$AiFail;

    const-string v1, "mr_ai_no_key"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrAi$AiFail;-><init>(Ljava/lang/String;)V

    throw v0

    .line 675
    :cond_1
    const/4 v1, 0x0

    .line 677
    :try_start_0
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 678
    const-string v5, "role"

    const-string v6, "system"

    invoke-virtual {v4, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 679
    const-string v5, "content"

    invoke-virtual {v4, v5, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 680
    new-instance v5, Lorg/json/JSONObject;

    invoke-direct {v5}, Lorg/json/JSONObject;-><init>()V

    .line 681
    const-string v6, "role"

    const-string v7, "user"

    invoke-virtual {v5, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 682
    const-string v6, "content"

    invoke-virtual {v5, v6, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 683
    new-instance v6, Lorg/json/JSONArray;

    invoke-direct {v6}, Lorg/json/JSONArray;-><init>()V

    .line 684
    invoke-virtual {v6, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 685
    invoke-virtual {v6, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 686
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 687
    const-string v5, "model"

    invoke-virtual {v4, v5, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 689
    sget-object v5, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v2, v5}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v2

    const-string v5, "gpt-6"

    invoke-virtual {v2, v5}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "temperature"

    invoke-virtual {v4, v2, p3, p4}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 690
    :cond_2
    const-string v2, "messages"

    invoke-virtual {v4, v2, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 692
    new-instance v2, Ljava/net/URL;

    invoke-direct {v2, v0}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    check-cast v0, Ljava/net/HttpURLConnection;
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrAi$AiFail; {:try_start_0 .. :try_end_0} :catch_6
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 693
    const/16 v1, 0x3a98

    :try_start_1
    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 694
    const v1, 0xea60

    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    .line 695
    const-string v1, "POST"

    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 696
    const-string v1, "Content-Type"

    const-string v2, "application/json; charset=utf-8"

    invoke-virtual {v0, v1, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 697
    const-string v1, "User-Agent"

    const-string v2, "MrKeyboard"

    invoke-virtual {v0, v1, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 698
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_3

    const-string v1, "Authorization"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Bearer "

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 699
    :cond_3
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 700
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v1

    .line 701
    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "UTF-8"

    invoke-virtual {v2, v3}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/OutputStream;->write([B)V

    .line 702
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V

    .line 704
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v3

    .line 705
    const/16 v1, 0xc8

    if-lt v3, v1, :cond_8

    const/16 v1, 0x12c

    if-ge v3, v1, :cond_8

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v1

    .line 706
    :goto_0
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->readAll(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object v2

    .line 707
    const/16 v1, 0xc8

    if-lt v3, v1, :cond_4

    const/16 v1, 0x12c

    if-lt v3, v1, :cond_9

    .line 708
    :cond_4
    const-string v1, ""
    :try_end_1
    .catch Lcom/mrkeyboard/app/MrAi$AiFail; {:try_start_1 .. :try_end_1} :catch_0
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 710
    :try_start_2
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v5, "error"

    invoke-virtual {v4, v5}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v4

    .line 711
    if-eqz v4, :cond_5

    const-string v1, "message"

    invoke-virtual {v4, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Lcom/mrkeyboard/app/MrAi$AiFail; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_4
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-result-object v1

    .line 715
    :cond_5
    :goto_1
    :try_start_3
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    const/16 v4, 0xb4

    if-le v2, v4, :cond_d

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

    .line 716
    :goto_2
    const-string v1, "mr_ai_http"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v4, v5

    invoke-static {p0, v1, v4}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 717
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

    .line 722
    :catch_0
    move-exception v1

    move-object v8, v1

    move-object v1, v0

    move-object v0, v8

    .line 723
    :goto_3
    :try_start_4
    throw v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 729
    :catchall_0
    move-exception v0

    :goto_4
    if-eqz v1, :cond_7

    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 730
    :cond_7
    throw v0

    .line 705
    :cond_8
    :try_start_5
    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->getErrorStream()Ljava/io/InputStream;

    move-result-object v1

    goto/16 :goto_0

    .line 712
    :catch_1
    move-exception v1

    .line 713
    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    .line 719
    :cond_9
    invoke-static {v2}, Lcom/mrkeyboard/app/MrAi;->extract(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 720
    if-eqz v1, :cond_a

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_b

    :cond_a
    new-instance v1, Lcom/mrkeyboard/app/MrAi$AiFail;

    const-string v2, "mr_ai_empty"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/mrkeyboard/app/MrAi$AiFail;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_5
    .catch Lcom/mrkeyboard/app/MrAi$AiFail; {:try_start_5 .. :try_end_5} :catch_0
    .catch Lorg/json/JSONException; {:try_start_5 .. :try_end_5} :catch_2
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_4
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 724
    :catch_2
    move-exception v1

    .line 725
    :goto_5
    :try_start_6
    new-instance v1, Lcom/mrkeyboard/app/MrAi$AiFail;

    const-string v2, "mr_ai_empty"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/mrkeyboard/app/MrAi$AiFail;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    .line 729
    :catchall_1
    move-exception v1

    move-object v8, v1

    move-object v1, v0

    move-object v0, v8

    goto :goto_4

    :cond_b
    if-eqz v0, :cond_c

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 721
    :cond_c
    return-object v1

    .line 726
    :catch_3
    move-exception v0

    move-object v0, v1

    .line 727
    :goto_6
    :try_start_7
    new-instance v1, Lcom/mrkeyboard/app/MrAi$AiFail;

    const-string v2, "mr_ai_net_fail"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/mrkeyboard/app/MrAi$AiFail;-><init>(Ljava/lang/String;)V

    throw v1
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    .line 726
    :catch_4
    move-exception v1

    goto :goto_6

    .line 724
    :catch_5
    move-exception v0

    move-object v0, v1

    goto :goto_5

    .line 722
    :catch_6
    move-exception v0

    goto :goto_3

    :cond_d
    move-object v2, v1

    goto/16 :goto_2
.end method

.method static configured(Landroid/content/Context;)Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 550
    const-string v1, "pref_ai_endpoint"

    const-string v2, "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions"

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrAi;->cfg(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 551
    const-string v2, "pref_ai_model"

    const-string v3, "gemini-3.5-flash-lite"

    invoke-static {p0, v2, v3}, Lcom/mrkeyboard/app/MrAi;->cfg(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 552
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 553
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
    .line 824
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    .line 834
    :cond_0
    :goto_0
    return-void

    .line 826
    :cond_1
    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "clipboard"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/ClipboardManager;

    .line 827
    if-eqz v0, :cond_0

    .line 828
    const-string v1, "mr_ai"

    sget-object v2, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    invoke-static {v1, v2}, Landroid/content/ClipData;->newPlainText(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/content/ClipData;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/ClipboardManager;->setPrimaryClip(Landroid/content/ClipData;)V

    .line 829
    const-string v0, "mr_ai_copied"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->toast(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 831
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static dialogClosed()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 282
    sget v0, Lcom/mrkeyboard/app/MrAi;->sSeq:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrAi;->sSeq:I

    .line 283
    sput-boolean v2, Lcom/mrkeyboard/app/MrAi;->sOpen:Z

    .line 284
    sput-boolean v2, Lcom/mrkeyboard/app/MrAi;->sBusy:Z

    .line 285
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    .line 286
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sStrip:Landroid/view/ViewGroup;

    .line 287
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    .line 288
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sResult:Landroid/widget/TextView;

    .line 289
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sBtnEmoji:Landroid/view/View;

    .line 290
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sEmojiCheck:Landroid/widget/TextView;

    .line 291
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sEmojiLabel:Landroid/widget/TextView;

    .line 292
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sBtnApply:Landroid/widget/TextView;

    .line 293
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sHandler:Landroid/os/Handler;

    .line 294
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    .line 295
    sput-object v1, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    .line 296
    return-void
.end method

.method private static dp(F)I
    .locals 1

    .prologue
    .line 173
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
    .line 270
    if-eqz p0, :cond_0

    const-string v0, "mr_ui_cyan_soft"

    :goto_0
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    .line 271
    if-eqz p0, :cond_1

    const-string v0, "mr_ui_cyan"

    :goto_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v0

    .line 272
    const/high16 v2, 0x40a00000    # 5.0f

    invoke-static {v1, v0, v2}, Lcom/mrkeyboard/app/MrAi;->rounded(IIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    return-object v0

    .line 270
    :cond_0
    const-string v0, "mr_ui_field"

    goto :goto_0

    .line 271
    :cond_1
    const-string v0, "mr_ui_field_line"

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

    .line 749
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 750
    const-string v3, "choices"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->optJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v0

    .line 751
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v3

    if-nez v3, :cond_1

    .line 770
    :cond_0
    :goto_0
    return-object v2

    .line 752
    :cond_1
    invoke-virtual {v0, v1}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    .line 753
    if-eqz v3, :cond_0

    .line 754
    const-string v0, "message"

    invoke-virtual {v3, v0}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 755
    if-eqz v0, :cond_5

    .line 756
    const-string v4, "content"

    invoke-virtual {v0, v4}, Lorg/json/JSONObject;->opt(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 757
    instance-of v4, v0, Ljava/lang/String;

    if-eqz v4, :cond_2

    check-cast v0, Ljava/lang/String;

    move-object v2, v0

    goto :goto_0

    .line 758
    :cond_2
    instance-of v4, v0, Lorg/json/JSONArray;

    if-eqz v4, :cond_5

    .line 759
    check-cast v0, Lorg/json/JSONArray;

    .line 760
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 761
    :goto_1
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v3

    if-ge v1, v3, :cond_4

    .line 762
    invoke-virtual {v0, v1}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    .line 763
    if-eqz v3, :cond_3

    const-string v4, "text"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 761
    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 764
    :cond_3
    invoke-virtual {v0, v1}, Lorg/json/JSONArray;->optString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_2

    .line 766
    :cond_4
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 769
    :cond_5
    const-string v0, "text"

    invoke-virtual {v3, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 770
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
    .line 276
    const-string v0, "mr_ui_field"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v0

    const-string v1, "mr_ui_field_line"

    .line 277
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    const/high16 v2, 0x41800000    # 16.0f

    .line 276
    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrAi;->rounded(IIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    return-object v0
.end method

.method private static fire()V
    .locals 7

    .prologue
    const/4 v3, 0x1

    .line 576
    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sOpen:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    if-nez v0, :cond_1

    .line 612
    :cond_0
    :goto_0
    return-void

    .line 577
    :cond_1
    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sBlocked:Z

    if-eqz v0, :cond_2

    .line 578
    const-string v0, "mr_ai_password"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->setStatus(Ljava/lang/String;)V

    goto :goto_0

    .line 581
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    if-eqz v0, :cond_3

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_4

    .line 582
    :cond_3
    const-string v0, "mr_ai_no_text"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->setStatus(Ljava/lang/String;)V

    goto :goto_0

    .line 585
    :cond_4
    sget v0, Lcom/mrkeyboard/app/MrAi;->sSel:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->instructionFor(I)Ljava/lang/String;

    move-result-object v2

    .line 586
    if-nez v2, :cond_5

    .line 587
    const-string v0, "mr_ai_tap_style"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->setStatus(Ljava/lang/String;)V

    goto :goto_0

    .line 590
    :cond_5
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v6

    .line 591
    invoke-static {v6}, Lcom/mrkeyboard/app/MrAi;->configured(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_6

    .line 592
    const-string v0, "mr_ai_no_key"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->setStatus(Ljava/lang/String;)V

    .line 593
    const-string v0, "mr_ai_no_key"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 596
    :cond_6
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0xfa0

    if-le v0, v1, :cond_7

    .line 597
    const-string v0, "mr_tr_long"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->toast(Ljava/lang/String;)V

    goto :goto_0

    .line 600
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

    .line 601
    :goto_1
    sget v0, Lcom/mrkeyboard/app/MrAi;->sSeq:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrAi;->sSeq:I

    .line 602
    sput-boolean v3, Lcom/mrkeyboard/app/MrAi;->sBusy:Z

    .line 603
    sput-boolean v3, Lcom/mrkeyboard/app/MrAi;->sFired:Z

    .line 604
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    .line 605
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->updateApply()V

    .line 606
    const-string v0, "mr_ai_working"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->setStatus(Ljava/lang/String;)V

    .line 607
    new-instance v0, Lcom/mrkeyboard/app/MrAi;

    const/16 v1, 0x3e8

    sget v3, Lcom/mrkeyboard/app/MrAi;->sSeq:I

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrAi;-><init>(ILjava/lang/String;ID)V

    .line 608
    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    iput-object v1, v0, Lcom/mrkeyboard/app/MrAi;->mSource:Ljava/lang/String;

    .line 609
    sget-boolean v1, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    iput-boolean v1, v0, Lcom/mrkeyboard/app/MrAi;->mEmojify:Z

    .line 610
    invoke-virtual {v6}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    iput-object v1, v0, Lcom/mrkeyboard/app/MrAi;->mContext:Landroid/content/Context;

    .line 611
    new-instance v1, Ljava/lang/Thread;

    invoke-direct {v1, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto/16 :goto_0

    .line 600
    :cond_9
    const-wide v4, 0x3fe6666666666666L    # 0.7

    goto :goto_1
.end method

.method private static instructionFor(I)Ljava/lang/String;
    .locals 2

    .prologue
    .line 569
    if-ltz p0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->BUILTIN_INSTR:[Ljava/lang/String;

    array-length v0, v0

    if-ge p0, v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->BUILTIN_INSTR:[Ljava/lang/String;

    aget-object v0, v0, p0

    .line 572
    :goto_0
    return-object v0

    .line 570
    :cond_0
    add-int/lit8 v0, p0, -0x64

    .line 571
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

    .line 572
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static isPasswordField()Z
    .locals 5

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 326
    :try_start_0
    sget-object v2, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 327
    if-nez v2, :cond_1

    .line 336
    :cond_0
    :goto_0
    return v0

    .line 328
    :cond_1
    invoke-virtual {v2}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v2

    .line 329
    if-eqz v2, :cond_0

    .line 330
    iget v3, v2, Landroid/view/inputmethod/EditorInfo;->inputType:I

    and-int/lit8 v3, v3, 0xf

    .line 331
    iget v2, v2, Landroid/view/inputmethod/EditorInfo;->inputType:I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    and-int/lit16 v2, v2, 0xff0

    .line 332
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

    .line 333
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

    .line 335
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

    .line 369
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 371
    :try_start_0
    const-string v2, "mr_ai"

    const/4 v3, 0x0

    invoke-virtual {p0, v2, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v2

    const-string v3, "styles"

    const/4 v4, 0x0

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 372
    if-nez v2, :cond_1

    .line 388
    :cond_0
    :goto_0
    return-object v0

    .line 373
    :cond_1
    new-instance v3, Lorg/json/JSONArray;

    invoke-direct {v3, v2}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V

    move v2, v1

    .line 374
    :goto_1
    invoke-virtual {v3}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-ge v2, v1, :cond_0

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/16 v4, 0x32

    if-ge v1, v4, :cond_0

    .line 375
    invoke-virtual {v3, v2}, Lorg/json/JSONArray;->optJSONObject(I)Lorg/json/JSONObject;

    move-result-object v1

    .line 376
    if-nez v1, :cond_3

    .line 374
    :cond_2
    :goto_2
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    goto :goto_1

    .line 377
    :cond_3
    const-string v4, "n"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 378
    const-string v5, "i"

    invoke-virtual {v1, v5}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 379
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v6

    if-eqz v6, :cond_2

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v6

    if-eqz v6, :cond_2

    .line 380
    const-string v6, "e"

    invoke-virtual {v1, v6}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 381
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

    .line 383
    :catch_0
    move-exception v1

    goto :goto_0

    .line 381
    :cond_4
    const-string v1, "\u2728"
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_3

    .line 385
    :catch_1
    move-exception v1

    goto :goto_0
.end method

.method private static loadCustomHere()V
    .locals 1

    .prologue
    .line 409
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->loadCustom(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sCustom:Ljava/util/ArrayList;

    .line 410
    return-void
.end method

.method private static onOpen()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 304
    sget v0, Lcom/mrkeyboard/app/MrAi;->sSeq:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lcom/mrkeyboard/app/MrAi;->sSeq:I

    .line 305
    sput-boolean v1, Lcom/mrkeyboard/app/MrAi;->sBusy:Z

    .line 306
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    .line 307
    const/4 v0, -0x1

    sput v0, Lcom/mrkeyboard/app/MrAi;->sSel:I

    .line 308
    sput-boolean v1, Lcom/mrkeyboard/app/MrAi;->sFired:Z

    .line 309
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResult:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResult:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 310
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 311
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->loadCustomHere()V

    .line 312
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->rebuildStrip()V

    .line 313
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->refreshChips()V

    .line 314
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->captureSource()V

    .line 315
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->updateApply()V

    .line 316
    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    if-eqz v1, :cond_1

    .line 317
    sget-boolean v1, Lcom/mrkeyboard/app/MrAi;->sBlocked:Z

    if-eqz v1, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    const-string v1, "mr_ai_password"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 322
    :cond_1
    :goto_0
    return-void

    .line 318
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

    .line 319
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

    .line 320
    :cond_5
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    const-string v1, "mr_ai_tap_style"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0
.end method

.method static openPrefs(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 839
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->requestReopenOnReturn()V

    .line 840
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    .line 842
    :try_start_0
    const-class v0, Lcom/mrkeyboard/app/MrAiPrefs;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrNav;->intent(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 847
    :goto_0
    return-void

    .line 843
    :catch_0
    move-exception v0

    .line 844
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->cancelReopenOnReturn()V

    goto :goto_0
.end method

.method static openStyleEditor(Landroid/content/Context;I)V
    .locals 3

    .prologue
    .line 852
    instance-of v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;

    if-nez v0, :cond_2

    const/4 v0, 0x1

    .line 853
    :goto_0
    if-eqz v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->requestReopenOnReturn()V

    .line 854
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    .line 856
    :try_start_0
    const-class v1, Lcom/mrkeyboard/app/MrAiStyleActivity;

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrNav;->intent(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;

    move-result-object v1

    .line 857
    const-string v2, "mr_ai_style_index"

    invoke-virtual {v1, v2, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 858
    invoke-virtual {p0, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 863
    :cond_1
    :goto_1
    return-void

    .line 852
    :cond_2
    const/4 v0, 0x0

    goto :goto_0

    .line 859
    :catch_0
    move-exception v1

    .line 860
    if-eqz v0, :cond_1

    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->cancelReopenOnReturn()V

    goto :goto_1
.end method

.method private static prefsAi()Landroid/content/SharedPreferences;
    .locals 3

    .prologue
    .line 177
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

    .line 525
    const/16 v0, 0xa

    const/16 v1, 0x20

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 526
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

    .line 527
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
    .line 734
    if-nez p0, :cond_0

    const-string v0, ""

    .line 744
    :goto_0
    return-object v0

    .line 735
    :cond_0
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v1, Ljava/io/InputStreamReader;

    const-string v2, "UTF-8"

    invoke-direct {v1, p0, v2}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-direct {v0, v1}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 736
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 737
    const/16 v2, 0x1000

    new-array v2, v2, [C

    .line 739
    :cond_1
    invoke-virtual {v0, v2}, Ljava/io/BufferedReader;->read([C)I

    move-result v3

    const/4 v4, -0x1

    if-eq v3, v4, :cond_2

    .line 740
    const/4 v4, 0x0

    invoke-virtual {v1, v2, v4, v3}, Ljava/lang/StringBuilder;->append([CII)Ljava/lang/StringBuilder;

    .line 741
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->length()I

    move-result v3

    const/high16 v4, 0x40000

    if-le v3, v4, :cond_1

    .line 743
    :cond_2
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V

    .line 744
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private static rebuildStrip()V
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 413
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStrip:Landroid/view/ViewGroup;

    if-nez v0, :cond_0

    .line 422
    :goto_0
    return-void

    .line 414
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStrip:Landroid/view/ViewGroup;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->removeAllViews()V

    .line 415
    const/4 v0, 0x0

    const-string v2, "mr_ai_create"

    invoke-static {v2}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v0, v2}, Lcom/mrkeyboard/app/MrAi;->addChip(ILjava/lang/String;Ljava/lang/String;)V

    move v0, v1

    .line 416
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

    .line 417
    :goto_2
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sCustom:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v2, v0, :cond_2

    .line 418
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sCustom:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    .line 419
    sget-object v3, Lcom/mrkeyboard/app/MrAi;->BUILTIN_NAME:[Ljava/lang/String;

    array-length v3, v3

    add-int/lit8 v3, v3, 0x1

    add-int/2addr v3, v2

    aget-object v4, v0, v1

    const/4 v5, 0x1

    aget-object v0, v0, v5

    invoke-static {v3, v4, v0}, Lcom/mrkeyboard/app/MrAi;->addChip(ILjava/lang/String;Ljava/lang/String;)V

    .line 417
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_2

    .line 421
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->refreshChips()V

    goto :goto_0
.end method

.method private static refreshChips()V
    .locals 7

    .prologue
    const/4 v5, 0x1

    const/4 v3, 0x0

    .line 489
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStrip:Landroid/view/ViewGroup;

    if-nez v0, :cond_1

    .line 504
    :cond_0
    return-void

    :cond_1
    move v2, v3

    .line 490
    :goto_0
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStrip:Landroid/view/ViewGroup;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    if-ge v2, v0, :cond_0

    .line 491
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStrip:Landroid/view/ViewGroup;

    invoke-virtual {v0, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    .line 492
    instance-of v1, v0, Landroid/widget/LinearLayout;

    if-nez v1, :cond_3

    .line 490
    :cond_2
    :goto_1
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_0

    .line 493
    :cond_3
    check-cast v0, Landroid/widget/LinearLayout;

    .line 494
    invoke-static {v2}, Lcom/mrkeyboard/app/MrAi;->styleAt(I)I

    move-result v1

    sget v4, Lcom/mrkeyboard/app/MrAi;->sSel:I

    if-ne v1, v4, :cond_5

    move v4, v5

    .line 495
    :goto_2
    if-eqz v4, :cond_6

    const-string v1, "mr_ui_cyan"

    :goto_3
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v6

    .line 496
    const/high16 v1, 0x3f800000    # 1.0f

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setAlpha(F)V

    .line 497
    invoke-static {v4}, Lcom/mrkeyboard/app/MrAi;->styleChipBackground(Z)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 498
    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    .line 499
    instance-of v4, v1, Landroid/widget/TextView;

    if-eqz v4, :cond_7

    check-cast v1, Landroid/widget/TextView;

    invoke-virtual {v1, v6}, Landroid/widget/TextView;->setTextColor(I)V

    .line 501
    :cond_4
    :goto_4
    invoke-virtual {v0, v5}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    .line 502
    instance-of v1, v0, Landroid/widget/TextView;

    if-eqz v1, :cond_2

    check-cast v0, Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_1

    :cond_5
    move v4, v3

    .line 494
    goto :goto_2

    .line 495
    :cond_6
    const-string v1, "mr_ui_text2"

    goto :goto_3

    .line 500
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
    .line 507
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sBtnEmoji:Landroid/view/View;

    if-nez v0, :cond_1

    .line 518
    :cond_0
    :goto_0
    return-void

    .line 508
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sBtnEmoji:Landroid/view/View;

    sget-boolean v1, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->chipBackground(Z)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 509
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sEmojiCheck:Landroid/widget/TextView;

    if-eqz v0, :cond_2

    .line 510
    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sEmojiCheck:Landroid/widget/TextView;

    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    if-eqz v0, :cond_3

    const-string v0, "\u2713"

    :goto_1
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 511
    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sEmojiCheck:Landroid/widget/TextView;

    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    if-eqz v0, :cond_4

    const-string v0, "mr_ui_cyan"

    :goto_2
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 512
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sEmojiCheck:Landroid/widget/TextView;

    sget-boolean v1, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->emojiCheckBackground(Z)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 514
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sEmojiLabel:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    .line 515
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sEmojiLabel:Landroid/widget/TextView;

    const-string v1, "mr_ai_emojify"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 516
    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sEmojiLabel:Landroid/widget/TextView;

    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    if-eqz v0, :cond_5

    const-string v0, "mr_ui_cyan"

    :goto_3
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_0

    .line 510
    :cond_3
    const-string v0, ""

    goto :goto_1

    .line 511
    :cond_4
    const-string v0, "mr_ui_text2"

    goto :goto_2

    .line 516
    :cond_5
    const-string v0, "mr_ui_text2"

    goto :goto_3
.end method

.method public static release()V
    .locals 0

    .prologue
    .line 300
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    .line 301
    return-void
.end method

.method static rewrite(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ZD)Ljava/lang/String;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrAi$AiFail;
        }
    .end annotation

    .prologue
    .line 656
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "You are a text-rewriting assistant inside a keyboard. Rewrite the text that comes after the separator, following the instruction. Keep the original language of the text unless the instruction clearly asks otherwise. Reply with ONLY the rewritten text: no quotes, no explanations, no preamble, no markdown fences."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    if-eqz p3, :cond_0

    const-string v0, " Sprinkle a few relevant emojis through the text where they fit naturally; do not overdo it."

    :goto_0
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\n\n---\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v0, v1, p4, p5}, Lcom/mrkeyboard/app/MrAi;->complete(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;D)Ljava/lang/String;

    move-result-object v0

    .line 657
    invoke-static {v0, p2}, Lcom/mrkeyboard/app/MrAi;->clean(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 656
    :cond_0
    const-string v0, " Do not add emojis that are not in the original text."

    goto :goto_0
.end method

.method private static rounded(IIF)Landroid/graphics/drawable/GradientDrawable;
    .locals 3

    .prologue
    .line 243
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 244
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    .line 245
    invoke-virtual {v0, p0}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 246
    const/4 v1, 0x1

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-static {v2}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v2

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-virtual {v0, v1, p1}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 247
    invoke-static {p2}, Lcom/mrkeyboard/app/MrAi;->dp(F)I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 248
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
    .line 393
    :try_start_0
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 394
    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    .line 395
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 396
    const-string v4, "e"

    const/4 v5, 0x0

    aget-object v5, v0, v5

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 397
    const-string v4, "n"

    const/4 v5, 0x1

    aget-object v5, v0, v5

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 398
    const-string v4, "i"

    const/4 v5, 0x2

    aget-object v0, v0, v5

    invoke-virtual {v3, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 399
    invoke-virtual {v1, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_0

    .line 403
    :catch_0
    move-exception v0

    .line 406
    :goto_1
    return-void

    .line 401
    :cond_0
    const-string v0, "mr_ai"

    const/4 v2, 0x0

    invoke-virtual {p0, v0, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 402
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

.method static serviceHost(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 559
    :try_start_0
    new-instance v0, Ljava/net/URL;

    const-string v1, "pref_ai_endpoint"

    const-string v2, "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions"

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/MrAi;->cfg(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/net/URL;->getHost()Ljava/lang/String;

    move-result-object v0

    .line 560
    if-nez v0, :cond_0

    const-string v0, ""
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 562
    :cond_0
    :goto_0
    return-object v0

    .line 561
    :catch_0
    move-exception v0

    .line 562
    const-string v0, ""

    goto :goto_0
.end method

.method static setApiKey(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 539
    const-string v0, "mr_ai"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "api_key"

    .line 540
    if-nez p1, :cond_0

    const-string v0, ""

    :goto_0
    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 541
    return-void

    .line 540
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private static setStatus(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 615
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 616
    :cond_0
    return-void
.end method

.method static setup(Landroid/view/View;)V
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 184
    if-nez p0, :cond_0

    .line 224
    :goto_0
    return-void

    .line 185
    :cond_0
    sput-object p0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    .line 186
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sHandler:Landroid/os/Handler;

    .line 187
    const-string v0, "ai_strip"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sStrip:Landroid/view/ViewGroup;

    .line 188
    const-string v0, "ai_back"

    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrAi;->btn(Ljava/lang/String;I)Landroid/view/View;

    .line 189
    const-string v0, "ai_gear"

    const/4 v1, 0x2

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAi;->btn(Ljava/lang/String;I)Landroid/view/View;

    .line 190
    const-string v0, "ai_emoji"

    const/4 v1, 0x5

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAi;->btn(Ljava/lang/String;I)Landroid/view/View;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sBtnEmoji:Landroid/view/View;

    .line 191
    const-string v0, "ai_emoji_check"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sEmojiCheck:Landroid/widget/TextView;

    .line 192
    const-string v0, "ai_emoji_label"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sEmojiLabel:Landroid/widget/TextView;

    .line 193
    const-string v0, "ai_copy"

    const/4 v1, 0x6

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAi;->btn(Ljava/lang/String;I)Landroid/view/View;

    .line 194
    const-string v0, "ai_redo"

    const/16 v1, 0x8

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAi;->btn(Ljava/lang/String;I)Landroid/view/View;

    .line 195
    const-string v0, "ai_apply"

    const/4 v1, 0x7

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAi;->btn(Ljava/lang/String;I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sBtnApply:Landroid/widget/TextView;

    .line 197
    const-string v0, "ai_title"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 198
    if-eqz v0, :cond_1

    const-string v1, "mr_ui_text"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 199
    :cond_1
    const-string v0, "ai_hdr_result"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 200
    if-eqz v0, :cond_2

    const-string v1, "mr_ui_text"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 201
    :cond_2
    const-string v0, "ai_status"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    .line 202
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    if-eqz v0, :cond_3

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sStatus:Landroid/widget/TextView;

    const-string v1, "mr_ui_text2"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 203
    :cond_3
    const-string v0, "ai_result"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sResult:Landroid/widget/TextView;

    .line 204
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResult:Landroid/widget/TextView;

    if-eqz v0, :cond_4

    .line 205
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResult:Landroid/widget/TextView;

    const-string v1, "mr_ui_text"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 206
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResult:Landroid/widget/TextView;

    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->fieldBackground()Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 208
    :cond_4
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sBtnApply:Landroid/widget/TextView;

    if-eqz v0, :cond_5

    .line 209
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sBtnApply:Landroid/widget/TextView;

    const-string v1, "mr_text_on_accent"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 212
    :cond_5
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->prefsAi()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 213
    const-string v1, "emojify_default_off_set"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    if-nez v1, :cond_6

    .line 214
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "emojify"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "emojify_default_off_set"

    .line 215
    invoke-interface {v0, v1, v3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 216
    sput-boolean v2, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    .line 220
    :goto_1
    sput-boolean v3, Lcom/mrkeyboard/app/MrAi;->sOpen:Z

    .line 221
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->refreshEmojiBtn()V

    .line 222
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->updateApply()V

    .line 223
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->onOpen()V

    goto/16 :goto_0

    .line 218
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
    .line 483
    if-nez p0, :cond_0

    const/4 v0, -0x2

    .line 485
    :goto_0
    return v0

    .line 484
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->BUILTIN_NAME:[Ljava/lang/String;

    array-length v0, v0

    if-gt p0, v0, :cond_1

    add-int/lit8 v0, p0, -0x1

    goto :goto_0

    .line 485
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

    .line 261
    if-eqz p0, :cond_0

    .line 262
    const-string v0, "mr_ui_cyan_soft"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v0

    const-string v1, "mr_ui_cyan_line"

    .line 263
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    .line 262
    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrAi;->rounded(IIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    .line 265
    :goto_0
    return-object v0

    :cond_0
    const-string v0, "mr_ui_field"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v0

    const-string v1, "mr_ui_field_line"

    .line 266
    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->uiColor(Ljava/lang/String;)I

    move-result v1

    .line 265
    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrAi;->rounded(IIF)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    goto :goto_0
.end method

.method private static t(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 161
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    if-eqz v0, :cond_1

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 162
    :goto_0
    if-eqz v0, :cond_2

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, p0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 163
    :goto_1
    if-eqz v0, :cond_0

    move-object p0, v0

    :cond_0
    return-object p0

    .line 161
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    goto :goto_0

    .line 162
    :cond_2
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private static t(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 167
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    if-eqz v0, :cond_1

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 168
    :goto_0
    if-eqz v0, :cond_2

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-static {v0, p0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 169
    :goto_1
    if-eqz v0, :cond_0

    move-object p0, v0

    :cond_0
    return-object p0

    .line 167
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    goto :goto_0

    .line 168
    :cond_2
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private static uiColor(Ljava/lang/String;)I
    .locals 4

    .prologue
    .line 237
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 238
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "color"

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, p0, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 239
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getColor(I)I

    move-result v0

    return v0
.end method

.method private static updateApply()V
    .locals 2

    .prologue
    .line 521
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

    .line 522
    :cond_1
    return-void

    .line 521
    :cond_2
    const/high16 v0, 0x3f800000    # 1.0f

    goto :goto_0
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 868
    iget v0, p0, Lcom/mrkeyboard/app/MrAi;->mCode:I

    packed-switch v0, :pswitch_data_0

    .line 893
    :pswitch_0
    iget v0, p0, Lcom/mrkeyboard/app/MrAi;->mCode:I

    const/16 v1, 0x64

    if-lt v0, v1, :cond_0

    .line 894
    iget v0, p0, Lcom/mrkeyboard/app/MrAi;->mCode:I

    add-int/lit8 v0, v0, -0x64

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->styleAt(I)I

    move-result v0

    .line 895
    const/4 v1, -0x2

    if-ne v0, v1, :cond_2

    .line 896
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    const/4 v1, -0x1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAi;->openStyleEditor(Landroid/content/Context;I)V

    .line 903
    :cond_0
    :goto_0
    return-void

    .line 870
    :pswitch_1
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    goto :goto_0

    .line 873
    :pswitch_2
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->openPrefs(Landroid/content/Context;)V

    goto :goto_0

    .line 876
    :pswitch_3
    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    if-nez v0, :cond_1

    const/4 v0, 0x1

    :goto_1
    sput-boolean v0, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    .line 877
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->prefsAi()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "emojify"

    sget-boolean v2, Lcom/mrkeyboard/app/MrAi;->sEmojify:Z

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 878
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->refreshEmojiBtn()V

    .line 879
    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sFired:Z

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sBusy:Z

    if-nez v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->fire()V

    goto :goto_0

    .line 876
    :cond_1
    const/4 v0, 0x0

    goto :goto_1

    .line 882
    :pswitch_4
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->copyResult()V

    goto :goto_0

    .line 885
    :pswitch_5
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->applyResult()V

    goto :goto_0

    .line 888
    :pswitch_6
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->fire()V

    goto :goto_0

    .line 899
    :cond_2
    sput v0, Lcom/mrkeyboard/app/MrAi;->sSel:I

    .line 900
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->refreshChips()V

    .line 901
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->fire()V

    goto :goto_0

    .line 868
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

    .line 906
    iget v1, p0, Lcom/mrkeyboard/app/MrAi;->mCode:I

    if-ge v1, v2, :cond_1

    .line 912
    :cond_0
    :goto_0
    return v0

    .line 907
    :cond_1
    iget v1, p0, Lcom/mrkeyboard/app/MrAi;->mCode:I

    add-int/lit8 v1, v1, -0x64

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->styleAt(I)I

    move-result v1

    .line 908
    if-lt v1, v2, :cond_0

    .line 909
    add-int/lit8 v1, v1, -0x64

    .line 910
    sget-object v2, Lcom/mrkeyboard/app/MrAi;->sCustom:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_0

    .line 911
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    if-eqz v0, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAi;->openStyleEditor(Landroid/content/Context;I)V

    .line 912
    :cond_2
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public run()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 619
    iget v0, p0, Lcom/mrkeyboard/app/MrAi;->mCode:I

    const/16 v1, 0x3e8

    if-ne v0, v1, :cond_4

    .line 623
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAi;->mContext:Landroid/content/Context;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAi;->mContext:Landroid/content/Context;

    .line 624
    :goto_0
    if-nez v0, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    if-eqz v1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sRoot:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 625
    :cond_0
    if-nez v0, :cond_3

    new-instance v0, Lcom/mrkeyboard/app/MrAi$AiFail;

    const-string v1, "mr_ai_net_fail"

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrAi$AiFail;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrAi$AiFail; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    .line 627
    :catch_0
    move-exception v0

    .line 628
    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrAi$AiFail;->getMessage()Ljava/lang/String;

    move-result-object v0

    move-object v2, v6

    move-object v6, v0

    .line 632
    :goto_1
    new-instance v0, Lcom/mrkeyboard/app/MrAi;

    const/16 v1, 0x3e9

    iget v3, p0, Lcom/mrkeyboard/app/MrAi;->mSeq:I

    const-wide/16 v4, 0x0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrAi;-><init>(ILjava/lang/String;ID)V

    .line 633
    iput-object v6, v0, Lcom/mrkeyboard/app/MrAi;->mError:Ljava/lang/String;

    .line 634
    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sHandler:Landroid/os/Handler;

    if-eqz v1, :cond_1

    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sHandler:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 648
    :cond_1
    :goto_2
    return-void

    .line 623
    :cond_2
    :try_start_1
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    goto :goto_0

    .line 626
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

    .line 629
    :catch_1
    move-exception v0

    .line 630
    const-string v0, "mr_ai_net_fail"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    move-object v2, v6

    move-object v6, v0

    goto :goto_1

    .line 638
    :cond_4
    sget-boolean v0, Lcom/mrkeyboard/app/MrAi;->sOpen:Z

    if-eqz v0, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrAi;->mSeq:I

    sget v1, Lcom/mrkeyboard/app/MrAi;->sSeq:I

    if-ne v0, v1, :cond_1

    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResult:Landroid/widget/TextView;

    if-eqz v0, :cond_1

    .line 639
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrAi;->sBusy:Z

    .line 640
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAi;->mError:Ljava/lang/String;

    if-eqz v0, :cond_5

    .line 641
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAi;->mError:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->setStatus(Ljava/lang/String;)V

    goto :goto_2

    .line 644
    :cond_5
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAi;->mText:Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrAi;->sResultText:Ljava/lang/String;

    .line 645
    sget-object v0, Lcom/mrkeyboard/app/MrAi;->sResult:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAi;->mText:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 646
    const-string v0, "mr_ai_original"

    sget-object v1, Lcom/mrkeyboard/app/MrAi;->sSource:Ljava/lang/String;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAi;->preview(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAi;->t(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAi;->setStatus(Ljava/lang/String;)V

    .line 647
    invoke-static {}, Lcom/mrkeyboard/app/MrAi;->updateApply()V

    goto :goto_2
.end method
