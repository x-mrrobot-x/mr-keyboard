.class final Lcom/mrkeyboard/app/MrEmojiSearch;
.super Ljava/lang/Object;
.source "MrEmojiSearch.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrEmojiSearch$DeleteTouch;
    }
.end annotation


# static fields
.field private static final CELL_DP:I = 0x2c

.field private static final CELL_SP:I = 0x1a

.field private static final DELETE:I = -0x5

.field private static final EMOJI_MODE:I = 0x4

.field static final MAX_RESULTS:I = 0x3c

.field static final MODE:I = 0x7

.field static final REPEAT_EVERY:I = 0x32

.field static final REPEAT_START:I = 0x190

.field private static sBar:Landroid/view/View;

.field private static final sCells:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/widget/TextView;",
            ">;"
        }
    .end annotation
.end field

.field private static sCtx:Landroid/content/Context;

.field private static sEmpty:Landroid/widget/TextView;

.field private static sField:Landroid/widget/EditText;

.field private static sGrid:Landroid/widget/LinearLayout;

.field private static sHandler:Landroid/os/Handler;

.field private static sIndex:Lcom/mrkeyboard/app/MrEmojiIndex;

.field private static sLoading:Z

.field private static sMainBar:Landroid/view/View;

.field private static sOpen:Z

.field private static final sPick:Landroid/view/View$OnClickListener;

.field private static sPrevField:Landroid/widget/TextView;

.field private static final sRepeat:Ljava/lang/Runnable;

.field private static sRows:I

.field private static sScroll:Landroid/view/View;

.field private static sWanted:Z

.field private static final sWatcher:Landroid/text/TextWatcher;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 66
    const/4 v0, 0x2

    sput v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sRows:I

    .line 68
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sCells:Ljava/util/ArrayList;

    .line 75
    new-instance v0, Lcom/mrkeyboard/app/MrEmojiSearch$1;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrEmojiSearch$1;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sPick:Landroid/view/View$OnClickListener;

    .line 80
    new-instance v0, Lcom/mrkeyboard/app/MrEmojiSearch$2;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrEmojiSearch$2;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sRepeat:Ljava/lang/Runnable;

    .line 86
    new-instance v0, Lcom/mrkeyboard/app/MrEmojiSearch$3;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrEmojiSearch$3;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sWatcher:Landroid/text/TextWatcher;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 94
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()V
    .locals 0

    .prologue
    .line 44
    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->deleteKey()V

    return-void
.end method

.method static synthetic access$100()Landroid/os/Handler;
    .locals 1

    .prologue
    .line 44
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sHandler:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$200()V
    .locals 0

    .prologue
    .line 44
    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->update()V

    return-void
.end method

.method static synthetic access$400()Ljava/lang/Runnable;
    .locals 1

    .prologue
    .line 44
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sRepeat:Ljava/lang/Runnable;

    return-object v0
.end method

.method static synthetic access$500()V
    .locals 0

    .prologue
    .line 44
    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->stopRepeat()V

    return-void
.end method

.method static afterPanel(I)V
    .locals 2

    .prologue
    .line 206
    const/4 v0, 0x7

    if-ne p0, v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sBar:Landroid/view/View;

    if-nez v0, :cond_1

    .line 210
    :cond_0
    :goto_0
    return-void

    .line 207
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sMainBar:Landroid/view/View;

    if-eqz v0, :cond_2

    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sMainBar:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 208
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sKbd:Landroid/view/View;

    .line 209
    if-eqz v0, :cond_0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0
.end method

.method private static close()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 229
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sOpen:Z

    .line 230
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 231
    sget-object v1, Lcom/mrkeyboard/app/MrTools;->sRedirect:Landroid/view/inputmethod/InputConnection;

    if-eqz v1, :cond_0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->mrCommit()V

    .line 232
    :cond_0
    sput-object v2, Lcom/mrkeyboard/app/MrTools;->sRedirect:Landroid/view/inputmethod/InputConnection;

    .line 233
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sPrevField:Landroid/widget/TextView;

    sput-object v0, Lcom/mrkeyboard/app/MrTools;->sField:Landroid/widget/TextView;

    .line 234
    sput-object v2, Lcom/mrkeyboard/app/MrEmojiSearch;->sPrevField:Landroid/widget/TextView;

    .line 235
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sField:Landroid/widget/EditText;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 236
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sBar:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 237
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sBar:Landroid/view/View;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBar;->restore(Landroid/view/View;)V

    .line 238
    return-void
.end method

.method private static deleteKey()V
    .locals 5

    .prologue
    const/4 v4, -0x1

    const/4 v3, -0x5

    .line 369
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 370
    if-eqz v0, :cond_0

    const/4 v1, 0x1

    new-array v1, v1, [I

    const/4 v2, 0x0

    aput v3, v1, v2

    invoke-virtual {v0, v3, v1, v4, v4}, Lcom/mrkeyboard/app/LatinIME;->onKey(I[III)V

    .line 371
    :cond_0
    return-void
.end method

.method private static dp(I)I
    .locals 2

    .prologue
    .line 417
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sCtx:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    .line 418
    int-to-float v1, p0

    mul-float/2addr v0, v1

    const/high16 v1, 0x3f000000    # 0.5f

    add-float/2addr v0, v1

    float-to-int v0, v0

    return v0
.end method

.method private static ensureLoaded()V
    .locals 5

    .prologue
    const/4 v4, 0x1

    .line 318
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sIndex:Lcom/mrkeyboard/app/MrEmojiIndex;

    if-nez v0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sLoading:Z

    if-nez v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sCtx:Landroid/content/Context;

    if-nez v0, :cond_1

    .line 347
    :cond_0
    :goto_0
    return-void

    .line 319
    :cond_1
    sput-boolean v4, Lcom/mrkeyboard/app/MrEmojiSearch;->sLoading:Z

    .line 320
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sCtx:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 321
    sget-object v1, Lcom/mrkeyboard/app/MrEmojiSearch;->sCtx:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    .line 322
    new-instance v2, Ljava/lang/Thread;

    new-instance v3, Lcom/mrkeyboard/app/MrEmojiSearch$7;

    invoke-direct {v3, v0, v1}, Lcom/mrkeyboard/app/MrEmojiSearch$7;-><init>(Landroid/content/res/Resources;Ljava/lang/String;)V

    invoke-direct {v2, v3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 345
    invoke-virtual {v2, v4}, Ljava/lang/Thread;->setPriority(I)V

    .line 346
    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method private static heightPx()I
    .locals 4

    .prologue
    .line 405
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sCtx:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 406
    const-string v1, "mr_es_height"

    const-string v2, "dimen"

    sget-object v3, Lcom/mrkeyboard/app/MrEmojiSearch;->sCtx:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 407
    if-nez v1, :cond_0

    const/16 v0, 0xb8

    invoke-static {v0}, Lcom/mrkeyboard/app/MrEmojiSearch;->dp(I)I

    move-result v0

    :goto_0
    return v0

    :cond_0
    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v0

    const/high16 v1, 0x3f000000    # 0.5f

    add-float/2addr v0, v1

    float-to-int v0, v0

    goto :goto_0
.end method

.method static insert(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 306
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    .line 313
    :cond_0
    :goto_0
    return-void

    .line 307
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 308
    if-nez v0, :cond_2

    const/4 v0, 0x0

    .line 309
    :goto_1
    if-eqz v0, :cond_0

    .line 310
    invoke-interface {v0}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z

    .line 311
    const/4 v1, 0x1

    invoke-interface {v0, p0, v1}, Landroid/view/inputmethod/InputConnection;->commitText(Ljava/lang/CharSequence;I)Z

    .line 312
    invoke-static {p0}, Lcom/mrkeyboard/app/MrEmotes;->addRecent(Ljava/lang/String;)V

    goto :goto_0

    .line 308
    :cond_2
    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getAppInputConnection()Landroid/view/inputmethod/InputConnection;

    move-result-object v0

    goto :goto_1
.end method

.method private static intRes(Ljava/lang/String;I)I
    .locals 3

    .prologue
    .line 411
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sCtx:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 412
    const-string v1, "integer"

    sget-object v2, Lcom/mrkeyboard/app/MrEmojiSearch;->sCtx:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p0, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 413
    if-nez v1, :cond_0

    :goto_0
    return p1

    :cond_0
    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getInteger(I)I

    move-result p1

    goto :goto_0
.end method

.method private static language()Ljava/lang/String;
    .locals 1

    .prologue
    .line 359
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sCtx:Landroid/content/Context;

    if-nez v0, :cond_0

    const-string v0, ""

    .line 362
    :goto_0
    return-object v0

    .line 360
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sCtx:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    .line 361
    if-nez v0, :cond_1

    const/4 v0, 0x0

    .line 362
    :goto_1
    if-nez v0, :cond_2

    const-string v0, ""

    goto :goto_0

    .line 361
    :cond_1
    iget-object v0, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    goto :goto_1

    .line 362
    :cond_2
    invoke-virtual {v0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method static loaded(Lcom/mrkeyboard/app/MrEmojiIndex;)V
    .locals 1

    .prologue
    .line 351
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sLoading:Z

    .line 352
    sget-boolean v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sWanted:Z

    if-nez v0, :cond_1

    .line 355
    :cond_0
    :goto_0
    return-void

    .line 353
    :cond_1
    sput-object p0, Lcom/mrkeyboard/app/MrEmojiSearch;->sIndex:Lcom/mrkeyboard/app/MrEmojiIndex;

    .line 354
    sget-boolean v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sOpen:Z

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->update()V

    goto :goto_0
.end method

.method private static newCell(I)Landroid/widget/TextView;
    .locals 5

    .prologue
    .line 278
    new-instance v1, Landroid/widget/TextView;

    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sCtx:Landroid/content/Context;

    invoke-direct {v1, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 279
    const/high16 v0, 0x41d00000    # 26.0f

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setTextSize(F)V

    .line 280
    const/16 v0, 0x11

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setGravity(I)V

    .line 281
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 282
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sPick:Landroid/view/View$OnClickListener;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 283
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sGrid:Landroid/widget/LinearLayout;

    sget v2, Lcom/mrkeyboard/app/MrEmojiSearch;->sRows:I

    rem-int v2, p0, v2

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/16 v3, 0x2c

    invoke-static {v3}, Lcom/mrkeyboard/app/MrEmojiSearch;->dp(I)I

    move-result v3

    const/4 v4, -0x1

    invoke-direct {v2, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 284
    return-object v1
.end method

.method static onPanel(I)V
    .locals 1

    .prologue
    .line 191
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sBar:Landroid/view/View;

    if-nez v0, :cond_1

    .line 199
    :cond_0
    :goto_0
    return-void

    .line 192
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->stopRepeat()V

    .line 193
    const/4 v0, 0x7

    if-ne p0, v0, :cond_2

    .line 194
    sget-boolean v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sOpen:Z

    if-nez v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->open()V

    goto :goto_0

    .line 197
    :cond_2
    sget-boolean v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sOpen:Z

    if-eqz v0, :cond_3

    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->close()V

    .line 198
    :cond_3
    const/4 v0, 0x4

    if-eq p0, v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->release()V

    goto :goto_0
.end method

.method private static open()V
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 213
    sput-boolean v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sOpen:Z

    .line 214
    sput-boolean v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sWanted:Z

    .line 215
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;

    .line 216
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->mrCommit()V

    .line 217
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sField:Landroid/widget/TextView;

    sput-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sPrevField:Landroid/widget/TextView;

    .line 218
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sField:Landroid/widget/EditText;

    sput-object v0, Lcom/mrkeyboard/app/MrTools;->sField:Landroid/widget/TextView;

    .line 219
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sField:Landroid/widget/EditText;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 220
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sBar:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 221
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sBar:Landroid/view/View;

    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->heightPx()I

    move-result v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrBar;->expand(Landroid/view/View;I)V

    .line 222
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sField:Landroid/widget/EditText;

    new-instance v1, Landroid/view/inputmethod/EditorInfo;

    invoke-direct {v1}, Landroid/view/inputmethod/EditorInfo;-><init>()V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->onCreateInputConnection(Landroid/view/inputmethod/EditorInfo;)Landroid/view/inputmethod/InputConnection;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrTools;->sRedirect:Landroid/view/inputmethod/InputConnection;

    .line 223
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sField:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->requestFocus()Z

    .line 224
    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->ensureLoaded()V

    .line 225
    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->update()V

    .line 226
    return-void
.end method

.method private static paint(Landroid/view/View;)V
    .locals 7

    .prologue
    const/4 v2, 0x0

    .line 162
    const-string v0, "es_back"

    const/4 v1, -0x1

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrTools;->btn(Landroid/view/View;Ljava/lang/String;I)Landroid/widget/TextView;

    .line 163
    const-string v0, "es_card"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 164
    if-eqz v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->cardBg()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 165
    :cond_0
    const-string v0, "es_div"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 166
    if-eqz v0, :cond_1

    const-string v1, "panel_divider"

    invoke-static {v1}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundColor(I)V

    .line 167
    :cond_1
    const-string v0, "es_title"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 168
    instance-of v1, v0, Landroid/widget/TextView;

    if-eqz v1, :cond_2

    check-cast v0, Landroid/widget/TextView;

    sget v1, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 169
    :cond_2
    const-string v0, "es_icon"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 170
    instance-of v1, v0, Landroid/widget/TextView;

    if-eqz v1, :cond_3

    check-cast v0, Landroid/widget/TextView;

    sget v1, Lcom/mrkeyboard/app/MrTools;->sHint:I

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTools;->tintColor(Landroid/widget/TextView;I)V

    .line 171
    :cond_3
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sField:Landroid/widget/EditText;

    sget v1, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTextColor(I)V

    .line 172
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sField:Landroid/widget/EditText;

    sget v1, Lcom/mrkeyboard/app/MrTools;->sHint:I

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setHintTextColor(I)V

    .line 173
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sEmpty:Landroid/widget/TextView;

    if-eqz v0, :cond_4

    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sEmpty:Landroid/widget/TextView;

    sget v1, Lcom/mrkeyboard/app/MrTools;->sHint:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 175
    :cond_4
    const-string v0, "emote_fab"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 176
    if-eqz v0, :cond_5

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->fabBg()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 177
    :cond_5
    const-string v0, "attach_fab_icon"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v3

    .line 178
    const/4 v0, 0x2

    new-array v4, v0, [Ljava/lang/String;

    const-string v0, "emote_search"

    aput-object v0, v4, v2

    const/4 v0, 0x1

    const-string v1, "emote_del"

    aput-object v1, v4, v0

    .line 179
    array-length v5, v4

    move v1, v2

    :goto_0
    if-ge v1, v5, :cond_8

    aget-object v0, v4, v1

    .line 180
    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 181
    if-nez v0, :cond_7

    .line 179
    :cond_6
    :goto_1
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 182
    :cond_7
    invoke-virtual {v0, v2}, Landroid/view/View;->setBackgroundColor(I)V

    .line 183
    instance-of v6, v0, Landroid/widget/TextView;

    if-eqz v6, :cond_6

    check-cast v0, Landroid/widget/TextView;

    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrTools;->tintColor(Landroid/widget/TextView;I)V

    goto :goto_1

    .line 185
    :cond_8
    return-void
.end method

.method private static recents()[Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v2, 0x0

    .line 289
    sget-object v3, Lcom/mrkeyboard/app/MrEmotes;->sRecent:Ljava/util/ArrayList;

    .line 290
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .line 291
    if-eqz v3, :cond_0

    move v1, v2

    .line 292
    :goto_0
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_0

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v5, 0x3c

    if-ge v0, v5, :cond_0

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 294
    :cond_0
    invoke-virtual {v4}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 295
    invoke-static {v2}, Lcom/mrkeyboard/app/MrEmotes;->data(I)Ljava/lang/String;

    move-result-object v0

    .line 296
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_1

    .line 297
    const-string v1, "[|]"

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 298
    :goto_1
    array-length v1, v0

    if-ge v2, v1, :cond_1

    const/16 v1, 0x18

    if-ge v2, v1, :cond_1

    aget-object v1, v0, v2

    invoke-virtual {v4, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 301
    :cond_1
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    return-object v0
.end method

.method private static release()V
    .locals 1

    .prologue
    .line 241
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sWanted:Z

    .line 242
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sIndex:Lcom/mrkeyboard/app/MrEmojiIndex;

    .line 243
    return-void
.end method

.method static setup(Landroid/view/View;)V
    .locals 8

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x0

    .line 100
    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->stopRepeat()V

    .line 101
    sput-object v2, Lcom/mrkeyboard/app/MrEmojiSearch;->sBar:Landroid/view/View;

    .line 102
    sput-object v2, Lcom/mrkeyboard/app/MrEmojiSearch;->sMainBar:Landroid/view/View;

    .line 103
    sput-object v2, Lcom/mrkeyboard/app/MrEmojiSearch;->sField:Landroid/widget/EditText;

    .line 104
    sput-object v2, Lcom/mrkeyboard/app/MrEmojiSearch;->sGrid:Landroid/widget/LinearLayout;

    .line 105
    sput-object v2, Lcom/mrkeyboard/app/MrEmojiSearch;->sScroll:Landroid/view/View;

    .line 106
    sput-object v2, Lcom/mrkeyboard/app/MrEmojiSearch;->sEmpty:Landroid/widget/TextView;

    .line 107
    sput-object v2, Lcom/mrkeyboard/app/MrEmojiSearch;->sCtx:Landroid/content/Context;

    .line 108
    sput-object v2, Lcom/mrkeyboard/app/MrEmojiSearch;->sHandler:Landroid/os/Handler;

    .line 109
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sCells:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 110
    sput-object v2, Lcom/mrkeyboard/app/MrEmojiSearch;->sIndex:Lcom/mrkeyboard/app/MrEmojiIndex;

    .line 111
    sput-boolean v3, Lcom/mrkeyboard/app/MrEmojiSearch;->sLoading:Z

    .line 112
    sput-boolean v3, Lcom/mrkeyboard/app/MrEmojiSearch;->sWanted:Z

    .line 113
    sput-boolean v3, Lcom/mrkeyboard/app/MrEmojiSearch;->sOpen:Z

    .line 114
    sput-object v2, Lcom/mrkeyboard/app/MrEmojiSearch;->sPrevField:Landroid/widget/TextView;

    .line 115
    if-nez p0, :cond_1

    .line 158
    :cond_0
    :goto_0
    return-void

    .line 116
    :cond_1
    const-string v0, "bar_es"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v4

    .line 117
    const-string v0, "es_field"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 118
    const-string v1, "es_grid"

    invoke-virtual {p0, v1}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    .line 119
    if-eqz v4, :cond_0

    instance-of v5, v0, Landroid/widget/EditText;

    if-eqz v5, :cond_0

    instance-of v5, v1, Landroid/widget/LinearLayout;

    if-eqz v5, :cond_0

    .line 120
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v5

    sput-object v5, Lcom/mrkeyboard/app/MrEmojiSearch;->sCtx:Landroid/content/Context;

    .line 121
    new-instance v5, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v6

    invoke-direct {v5, v6}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v5, Lcom/mrkeyboard/app/MrEmojiSearch;->sHandler:Landroid/os/Handler;

    .line 122
    sput-object v4, Lcom/mrkeyboard/app/MrEmojiSearch;->sBar:Landroid/view/View;

    .line 123
    const-string v4, "bar_main"

    invoke-virtual {p0, v4}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v4

    sput-object v4, Lcom/mrkeyboard/app/MrEmojiSearch;->sMainBar:Landroid/view/View;

    .line 124
    check-cast v0, Landroid/widget/EditText;

    sput-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sField:Landroid/widget/EditText;

    move-object v0, v1

    .line 125
    check-cast v0, Landroid/widget/LinearLayout;

    sput-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sGrid:Landroid/widget/LinearLayout;

    .line 126
    const-string v0, "es_scroll"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sScroll:Landroid/view/View;

    .line 127
    const-string v0, "es_empty"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    instance-of v0, v0, Landroid/widget/TextView;

    if-eqz v0, :cond_2

    const-string v0, "es_empty"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    :goto_1
    sput-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sEmpty:Landroid/widget/TextView;

    .line 128
    const/4 v0, 0x1

    const-string v1, "mr_es_rows"

    const/4 v4, 0x2

    invoke-static {v1, v4}, Lcom/mrkeyboard/app/MrEmojiSearch;->intRes(Ljava/lang/String;I)I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sRows:I

    move v0, v3

    .line 129
    :goto_2
    sget v1, Lcom/mrkeyboard/app/MrEmojiSearch;->sRows:I

    if-ge v0, v1, :cond_3

    .line 130
    new-instance v1, Landroid/widget/LinearLayout;

    sget-object v4, Lcom/mrkeyboard/app/MrEmojiSearch;->sCtx:Landroid/content/Context;

    invoke-direct {v1, v4}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 131
    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 132
    sget-object v4, Lcom/mrkeyboard/app/MrEmojiSearch;->sGrid:Landroid/widget/LinearLayout;

    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x2

    const/high16 v7, 0x3f800000    # 1.0f

    invoke-direct {v5, v6, v3, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v4, v1, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 129
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    :cond_2
    move-object v0, v2

    .line 127
    goto :goto_1

    .line 134
    :cond_3
    invoke-static {p0}, Lcom/mrkeyboard/app/MrEmojiSearch;->paint(Landroid/view/View;)V

    .line 135
    const-string v0, "es_back"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 136
    if-eqz v0, :cond_4

    new-instance v1, Lcom/mrkeyboard/app/MrEmojiSearch$4;

    invoke-direct {v1}, Lcom/mrkeyboard/app/MrEmojiSearch$4;-><init>()V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 141
    :cond_4
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sField:Landroid/widget/EditText;

    sget-object v1, Lcom/mrkeyboard/app/MrEmojiSearch;->sWatcher:Landroid/text/TextWatcher;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 142
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sBar:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 143
    const-string v0, "emote_search"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 144
    if-eqz v0, :cond_5

    new-instance v1, Lcom/mrkeyboard/app/MrEmojiSearch$5;

    invoke-direct {v1}, Lcom/mrkeyboard/app/MrEmojiSearch$5;-><init>()V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 149
    :cond_5
    const-string v0, "emote_del"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 150
    if-eqz v0, :cond_0

    .line 151
    new-instance v1, Lcom/mrkeyboard/app/MrEmojiSearch$DeleteTouch;

    invoke-direct {v1, v2}, Lcom/mrkeyboard/app/MrEmojiSearch$DeleteTouch;-><init>(Lcom/mrkeyboard/app/MrEmojiSearch$1;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 152
    new-instance v1, Lcom/mrkeyboard/app/MrEmojiSearch$6;

    invoke-direct {v1}, Lcom/mrkeyboard/app/MrEmojiSearch$6;-><init>()V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    goto/16 :goto_0
.end method

.method private static show([Ljava/lang/String;Z)V
    .locals 5

    .prologue
    const/16 v3, 0x8

    const/4 v2, 0x0

    .line 263
    :goto_0
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sCells:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    array-length v1, p0

    if-ge v0, v1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sCells:Ljava/util/ArrayList;

    sget-object v1, Lcom/mrkeyboard/app/MrEmojiSearch;->sCells:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrEmojiSearch;->newCell(I)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    move v1, v2

    .line 264
    :goto_1
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sCells:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_2

    .line 265
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sCells:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 266
    array-length v4, p0

    if-ge v1, v4, :cond_1

    .line 267
    aget-object v4, p0, v1

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 268
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 264
    :goto_2
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 270
    :cond_1
    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_2

    .line 273
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sScroll:Landroid/view/View;

    if-eqz v0, :cond_3

    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sScroll:Landroid/view/View;

    invoke-virtual {v0, v2, v2}, Landroid/view/View;->scrollTo(II)V

    .line 274
    :cond_3
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sEmpty:Landroid/widget/TextView;

    if-eqz v0, :cond_4

    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sEmpty:Landroid/widget/TextView;

    if-eqz p1, :cond_5

    array-length v1, p0

    if-nez v1, :cond_5

    :goto_3
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 275
    :cond_4
    return-void

    :cond_5
    move v2, v3

    .line 274
    goto :goto_3
.end method

.method private static stopRepeat()V
    .locals 2

    .prologue
    .line 374
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sHandler:Landroid/os/Handler;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sHandler:Landroid/os/Handler;

    sget-object v1, Lcom/mrkeyboard/app/MrEmojiSearch;->sRepeat:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 375
    :cond_0
    return-void
.end method

.method private static update()V
    .locals 4

    .prologue
    const/4 v2, 0x0

    .line 249
    sget-boolean v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sOpen:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sField:Landroid/widget/EditText;

    if-nez v0, :cond_1

    .line 260
    :cond_0
    :goto_0
    return-void

    .line 250
    :cond_1
    sget-object v0, Lcom/mrkeyboard/app/MrEmojiSearch;->sField:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    .line 251
    invoke-static {v0}, Lcom/mrkeyboard/app/MrEmojiIndex;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_2

    .line 252
    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->recents()[Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrEmojiSearch;->show([Ljava/lang/String;Z)V

    goto :goto_0

    .line 255
    :cond_2
    sget-object v1, Lcom/mrkeyboard/app/MrEmojiSearch;->sIndex:Lcom/mrkeyboard/app/MrEmojiIndex;

    if-nez v1, :cond_3

    .line 256
    new-array v0, v2, [Ljava/lang/String;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrEmojiSearch;->show([Ljava/lang/String;Z)V

    goto :goto_0

    .line 259
    :cond_3
    sget-object v1, Lcom/mrkeyboard/app/MrEmojiSearch;->sIndex:Lcom/mrkeyboard/app/MrEmojiIndex;

    invoke-static {}, Lcom/mrkeyboard/app/MrEmojiSearch;->language()Ljava/lang/String;

    move-result-object v2

    const/16 v3, 0x3c

    invoke-virtual {v1, v0, v2, v3}, Lcom/mrkeyboard/app/MrEmojiIndex;->search(Ljava/lang/String;Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrEmojiNew;->filter([Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrEmojiSearch;->show([Ljava/lang/String;Z)V

    goto :goto_0
.end method
