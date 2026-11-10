.class public Lcom/mrkeyboard/app/KeyboardSwitcher;
.super Ljava/lang/Object;
.source "KeyboardSwitcher.java"

# interfaces
.implements Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;
    }
.end annotation


# static fields
.field private static final ALPHABET_MODES:[I

.field private static final AUTO_MODE_SWITCH_STATE_ALPHA:I = 0x0

.field private static final AUTO_MODE_SWITCH_STATE_CHORDING:I = 0x4

.field private static final AUTO_MODE_SWITCH_STATE_MOMENTARY:I = 0x3

.field private static final AUTO_MODE_SWITCH_STATE_SYMBOL:I = 0x2

.field private static final AUTO_MODE_SWITCH_STATE_SYMBOL_BEGIN:I = 0x1

.field public static final DEFAULT_LAYOUT_ID:Ljava/lang/String; = "0"

.field private static final KBD_COMPACT:I = 0x7f0f0001

.field private static final KBD_COMPACT_FN:I = 0x7f0f0002

.field private static final KBD_FULL:I = 0x7f0f0005

.field private static final KBD_FULL_FN:I = 0x7f0f0006

.field private static final KBD_PHONE:I = 0x7f0f0007

.field private static final KBD_PHONE_SYMBOLS:I = 0x7f0f0008

.field private static final KBD_QWERTY:I = 0x7f0f000b

.field private static final KBD_SYMBOLS:I = 0x7f0f000c

.field private static final KBD_SYMBOLS_SHIFT:I = 0x7f0f000d

.field public static final KEYBOARDMODE_EMAIL:I = 0x7f080057

.field public static final KEYBOARDMODE_EMAIL_WITH_SETTINGS_KEY:I = 0x7f080058

.field public static final KEYBOARDMODE_IM:I = 0x7f080059

.field public static final KEYBOARDMODE_IM_WITH_SETTINGS_KEY:I = 0x7f08005a

.field public static final KEYBOARDMODE_NORMAL:I = 0x7f08005b

.field public static final KEYBOARDMODE_NORMAL_WITH_SETTINGS_KEY:I = 0x7f08005c

.field public static final KEYBOARDMODE_SYMBOLS:I = 0x7f08005d

.field public static final KEYBOARDMODE_SYMBOLS_WITH_SETTINGS_KEY:I = 0x7f08005e

.field public static final KEYBOARDMODE_URL:I = 0x7f08005f

.field public static final KEYBOARDMODE_URL_WITH_SETTINGS_KEY:I = 0x7f080060

.field public static final KEYBOARDMODE_WEB:I = 0x7f080061

.field public static final KEYBOARDMODE_WEB_WITH_SETTINGS_KEY:I = 0x7f080062

.field public static final MODE_EMAIL:I = 0x5

.field public static final MODE_IM:I = 0x6

.field public static final MODE_NONE:I = 0x0

.field public static final MODE_PHONE:I = 0x3

.field public static final MODE_SYMBOLS:I = 0x2

.field public static final MODE_TEXT:I = 0x1

.field public static final MODE_URL:I = 0x4

.field public static final MODE_WEB:I = 0x7

.field public static final PREF_KEYBOARD_LAYOUT:Ljava/lang/String; = "pref_keyboard_layout"

.field private static TAG:Ljava/lang/String; = "PCKeyboardKbSw"

.field private static THEMES:[I

.field private static final sInstance:Lcom/mrkeyboard/app/KeyboardSwitcher;


# instance fields
.field private mAutoModeSwitchState:I

.field private mCurrentId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

.field private mFullMode:I

.field private mHasSettingsKey:Z

.field private mHasVoice:Z

.field private mImeOptions:I

.field private mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

.field private mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

.field private mIsAutoCompletionActive:Z

.field private mIsSymbols:Z

.field private final mKeyboards:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;",
            "Ljava/lang/ref/SoftReference<",
            "Lcom/mrkeyboard/app/LatinKeyboard;",
            ">;>;"
        }
    .end annotation
.end field

.field private mLanguageSwitcher:Lcom/mrkeyboard/app/LanguageSwitcher;

.field private mLastDisplayWidth:I

.field private mLayoutId:I

.field private mMode:I

.field private mPreferSymbols:Z

.field private mSheet:I

.field private mSymbolsId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

.field private mSymbolsShiftedId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

.field private mVoiceOnPrimary:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/16 v0, 0xa

    .line 86
    new-array v0, v0, [I

    fill-array-data v0, :array_1

    sput-object v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->ALPHABET_MODES:[I

    .line 140
    new-instance v0, Lcom/mrkeyboard/app/KeyboardSwitcher;

    invoke-direct {v0}, Lcom/mrkeyboard/app/KeyboardSwitcher;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->sInstance:Lcom/mrkeyboard/app/KeyboardSwitcher;

    return-void

    nop

    :array_1
    .array-data 4
        0x7f08005b
        0x7f08005f
        0x7f080057
        0x7f080059
        0x7f080061
        0x7f08005c
        0x7f080060
        0x7f080058
        0x7f08005a
        0x7f080062
    .end array-data
.end method

.method private constructor <init>()V
    .locals 1

    .line 146
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 100
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mKeyboards:Ljava/util/HashMap;

    const/4 v0, 0x0

    .line 102
    iput v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mMode:I

    .line 123
    iput v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mAutoModeSwitchState:I

    return-void
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/KeyboardSwitcher;)Lcom/mrkeyboard/app/LatinKeyboardView;
    .locals 0

    .line 31
    iget-object p0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    return-object p0
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/KeyboardSwitcher;)Lcom/mrkeyboard/app/LatinIME;
    .locals 0

    .line 31
    iget-object p0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    return-object p0
.end method

# Theme layouts, read once from the mr_theme_layouts array (res/values/mr_themes.xml); the index is the
# value of the pref_keyboard_layout preference. New theme = layout + 1 line in the array, without touching this.
.method private ensureThemes()V
    .locals 6

    sget-object v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->THEMES:[I

    if-eqz v0, :cond_load

    return-void

    :cond_load
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    const-string v2, "mr_theme_layouts"

    const-string v3, "array"

    invoke-virtual {v1, v2, v3, v0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->obtainTypedArray(I)Landroid/content/res/TypedArray;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/TypedArray;->length()I

    move-result v1

    new-array v2, v1, [I

    const/4 v3, 0x0

    :goto_loop
    if-ge v3, v1, :cond_done

    const/4 v4, 0x0

    invoke-virtual {v0, v3, v4}, Landroid/content/res/TypedArray;->getResourceId(II)I

    move-result v4

    aput v4, v2, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_loop

    :cond_done
    invoke-virtual {v0}, Landroid/content/res/TypedArray;->recycle()V

    sput-object v2, Lcom/mrkeyboard/app/KeyboardSwitcher;->THEMES:[I

    return-void
.end method

.method private changeLatinKeyboardView(IZ)V
    .locals 5

    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->ensureThemes()V

    .line 614
    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mLayoutId:I

    if-ne v0, p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    if-eqz v0, :cond_0

    if-eqz p2, :cond_4

    .line 615
    :cond_0
    iget-object p2, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    if-eqz p2, :cond_1

    .line 616
    iget-object p2, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    invoke-virtual {p2}, Lcom/mrkeyboard/app/LatinKeyboardView;->closing()V

    .line 618
    :cond_1
    sget-object p2, Lcom/mrkeyboard/app/KeyboardSwitcher;->THEMES:[I

    array-length p2, p2

    if-gt p2, p1, :cond_2

    const-string p1, "9"

    .line 619
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    .line 622
    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;->getInstance()Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;

    move-result-object p2

    invoke-virtual {p2}, Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;->reset()V

    const/4 p2, 0x1

    const/4 v0, 0x0

    const/4 p2, 0x0

    const/4 v1, 0x1

    :goto_0
    const/4 v2, 0x5

    if-ge p2, v2, :cond_3

    if-eqz v1, :cond_3

    .line 626
    :try_start_0
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    .line 627
    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v1

    sget-object v2, Lcom/mrkeyboard/app/KeyboardSwitcher;->THEMES:[I

    aget v2, v2, p1

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/LatinKeyboardView;

    iput-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;
    :try_end_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_1
    .catch Landroid/view/InflateException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v1, 0x0

    goto :goto_1

    :catch_0
    move-exception v1

    .line 634
    invoke-static {}, Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;->getInstance()Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget v4, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mLayoutId:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v4, ","

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3, v1}, Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;->tryGCOrWait(Ljava/lang/String;Ljava/lang/Throwable;)Z

    move-result v1

    goto :goto_1

    :catch_1
    move-exception v1

    .line 631
    invoke-static {}, Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;->getInstance()Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget v4, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mLayoutId:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v4, ","

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3, v1}, Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;->tryGCOrWait(Ljava/lang/String;Ljava/lang/Throwable;)Z

    move-result v1

    :goto_1
    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    .line 638
    :cond_3
    iget-object p2, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    sget-object v1, Lcom/mrkeyboard/app/KeyboardSwitcher;->THEMES:[I

    aget v1, v1, p1

    invoke-virtual {p2, v1}, Lcom/mrkeyboard/app/LatinKeyboardView;->setExtensionLayoutResId(I)V

    .line 639
    iget-object p2, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {p2, v1}, Lcom/mrkeyboard/app/LatinKeyboardView;->setOnKeyboardActionListener(Lcom/mrkeyboard/app/LatinKeyboardBaseView$OnKeyboardActionListener;)V

    .line 640
    iget-object p2, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    invoke-virtual {p2, v0, v0, v0, v0}, Lcom/mrkeyboard/app/LatinKeyboardView;->setPadding(IIII)V

    .line 641
    iput p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mLayoutId:I

    .line 643
    :cond_4
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    iget-object p1, p1, Lcom/mrkeyboard/app/LatinIME;->mHandler:Landroid/os/Handler;

    new-instance p2, Lcom/mrkeyboard/app/KeyboardSwitcher$1;

    invoke-direct {p2, p0}, Lcom/mrkeyboard/app/KeyboardSwitcher$1;-><init>(Lcom/mrkeyboard/app/KeyboardSwitcher;)V

    invoke-virtual {p1, p2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public static getInstance()Lcom/mrkeyboard/app/KeyboardSwitcher;
    .locals 1

    .line 143
    sget-object v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->sInstance:Lcom/mrkeyboard/app/KeyboardSwitcher;

    return-object v0
.end method

.method private getKeyboard(Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;)Lcom/mrkeyboard/app/LatinKeyboard;
    .locals 9

    .line 324
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mKeyboards:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/SoftReference;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    move-object v0, v1

    goto :goto_0

    .line 325
    :cond_0
    invoke-virtual {v0}, Ljava/lang/ref/SoftReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/LatinKeyboard;

    :goto_0
    if-nez v0, :cond_3

    .line 327
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 328
    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v2

    .line 329
    iget-object v3, v2, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 330
    sget-object v4, Lcom/mrkeyboard/app/LatinIME;->sKeyboardSettings:Lcom/mrkeyboard/app/GlobalKeyboardSettings;

    iget-object v4, v4, Lcom/mrkeyboard/app/GlobalKeyboardSettings;->inputLocale:Ljava/util/Locale;

    iput-object v4, v2, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 331
    invoke-virtual {v0, v2, v1}, Landroid/content/res/Resources;->updateConfiguration(Landroid/content/res/Configuration;Landroid/util/DisplayMetrics;)V

    .line 332
    iget v6, p1, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;->mXml:I

    const/16 v5, -0x3e8

    if-gt v6, v5, :cond_xml_kbd

    neg-int v6, v6

    add-int/lit16 v6, v6, -0x3e8

    iget-object v5, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    iget v7, p1, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;->mKeyboardMode:I

    iget v8, p1, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;->mKeyboardHeightPercent:F

    invoke-static {v5, v6, v7, v8}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->buildKeyboard(Landroid/content/Context;IIF)Lcom/mrkeyboard/app/LatinKeyboard;

    move-result-object v4

    goto :goto_after_kbd

    :cond_xml_kbd
    new-instance v4, Lcom/mrkeyboard/app/LatinKeyboard;

    iget-object v5, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    iget v7, p1, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;->mKeyboardMode:I

    iget v8, p1, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;->mKeyboardHeightPercent:F

    invoke-direct {v4, v5, v6, v7, v8}, Lcom/mrkeyboard/app/LatinKeyboard;-><init>(Landroid/content/Context;IIF)V

    :goto_after_kbd
    .line 334
    iget v5, p1, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;->mXml:I

    const/16 v6, -0x3e8

    if-gt v5, v6, :cond_chk_old_sym

    const/4 v5, 0x1

    goto :goto_1

    :cond_chk_old_sym
    const v6, 0x7f0f000c

    if-ne v5, v6, :cond_1

    const/4 v5, 0x1

    goto :goto_1

    :cond_1
    const/4 v5, 0x0

    :goto_1
    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/KeyboardSwitcher;->hasVoiceButton(Z)Z

    move-result v5

    iget-boolean v6, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasVoice:Z

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/LatinKeyboard;->setVoiceMode(ZZ)V

    .line 335
    iget-object v5, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mLanguageSwitcher:Lcom/mrkeyboard/app/LanguageSwitcher;

    iget-boolean v6, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mIsAutoCompletionActive:Z

    invoke-virtual {v4, v5, v6}, Lcom/mrkeyboard/app/LatinKeyboard;->setLanguageSwitcher(Lcom/mrkeyboard/app/LanguageSwitcher;Z)V

    .line 344
    iget-boolean v5, p1, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;->mEnableShiftLock:Z

    if-eqz v5, :cond_2

    .line 345
    invoke-virtual {v4}, Lcom/mrkeyboard/app/LatinKeyboard;->enableShiftLock()V

    .line 347
    :cond_2
    iget-object v5, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mKeyboards:Ljava/util/HashMap;

    new-instance v6, Ljava/lang/ref/SoftReference;

    invoke-direct {v6, v4}, Ljava/lang/ref/SoftReference;-><init>(Ljava/lang/Object;)V

    invoke-virtual {v5, p1, v6}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 349
    iput-object v3, v2, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 350
    invoke-virtual {v0, v2, v1}, Landroid/content/res/Resources;->updateConfiguration(Landroid/content/res/Configuration;Landroid/util/DisplayMetrics;)V

    move-object v0, v4

    :cond_3
    if-eqz v0, :cond_ret_kbd

    iget v1, p1, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;->mXml:I

    const v2, 0x7f0f000b

    if-ne v1, v2, :cond_ret_kbd

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    invoke-static {v1}, Lcom/mrkeyboard/app/SheetStore;->getFirstBadge(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/LatinKeyboard;->updateSheetCycleKeyLabel(Ljava/lang/String;)V

    :cond_ret_kbd
    return-object v0
.end method

.method private getKeyboardId(IIZ)Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;
    .locals 7

    .line 360
    invoke-direct {p0, p3}, Lcom/mrkeyboard/app/KeyboardSwitcher;->hasVoiceButton(Z)Z

    move-result p2

    .line 361
    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mFullMode:I

    const v1, 0x7f08005b

    const/4 v2, 0x1

    if-lez v0, :cond_2

    if-eq p1, v2, :cond_0

    packed-switch p1, :pswitch_data_0

    goto :goto_1

    .line 368
    :cond_0
    :pswitch_0
    new-instance p1, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    iget p3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mFullMode:I

    if-ne p3, v2, :cond_1

    const p3, 0x7f0f0001

    goto :goto_0

    :cond_1
    const p3, 0x7f0f0005

    :goto_0
    invoke-direct {p1, p3, v1, v2, p2}, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;-><init>(IIZZ)V

    return-object p1

    :cond_2
    :goto_1
    const v0, 0x7f0f000b

    const v3, 0x7f08005d

    const v4, 0x7f08005e

    const v5, 0x7f0f000c

    const/4 v6, 0x0

    if-eqz p3, :cond_5

    const/4 p3, 0x3

    if-ne p1, p3, :cond_3

    .line 376
    new-instance p1, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    const p3, 0x7f0f0008

    invoke-direct {p1, p3, v6, v6, p2}, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;-><init>(IIZZ)V

    return-object p1

    .line 378
    :cond_3
    new-instance p1, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    iget-boolean p3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasSettingsKey:Z

    if-eqz p3, :cond_4

    const v3, 0x7f08005e

    :cond_4
    iget-object p3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSheet:I

    invoke-static {p3, v0}, Lcom/mrkeyboard/app/SheetStore;->resolveKeyboardXmlId(Landroid/content/Context;I)I

    move-result v5

    invoke-direct {p1, v5, v3, v6, p2}, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;-><init>(IIZZ)V

    return-object p1

    :cond_5
    packed-switch p1, :pswitch_data_1

    const/4 p1, 0x0

    return-object p1

    .line 410
    :pswitch_1
    new-instance p1, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    iget-boolean p3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasSettingsKey:Z

    if-eqz p3, :cond_6

    const p3, 0x7f080062

    goto :goto_2

    :cond_6
    const p3, 0x7f080061

    :goto_2
    invoke-direct {p1, v0, p3, v2, p2}, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;-><init>(IIZZ)V

    return-object p1

    .line 406
    :pswitch_2
    new-instance p1, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    iget-boolean p3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasSettingsKey:Z

    if-eqz p3, :cond_7

    const p3, 0x7f08005a

    goto :goto_3

    :cond_7
    const p3, 0x7f080059

    :goto_3
    invoke-direct {p1, v0, p3, v2, p2}, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;-><init>(IIZZ)V

    return-object p1

    .line 402
    :pswitch_3
    new-instance p1, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    iget-boolean p3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasSettingsKey:Z

    if-eqz p3, :cond_8

    const p3, 0x7f080058

    goto :goto_4

    :cond_8
    const p3, 0x7f080057

    :goto_4
    invoke-direct {p1, v0, p3, v2, p2}, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;-><init>(IIZZ)V

    return-object p1

    .line 398
    :pswitch_4
    new-instance p1, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    iget-boolean p3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasSettingsKey:Z

    if-eqz p3, :cond_9

    const p3, 0x7f080060

    goto :goto_5

    :cond_9
    const p3, 0x7f08005f

    :goto_5
    invoke-direct {p1, v0, p3, v2, p2}, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;-><init>(IIZZ)V

    return-object p1

    .line 396
    :pswitch_5
    new-instance p1, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    const p3, 0x7f0f0007

    invoke-direct {p1, p3, v6, v6, p2}, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;-><init>(IIZZ)V

    return-object p1

    .line 392
    :pswitch_6
    new-instance p1, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    iget-boolean p3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasSettingsKey:Z

    if-eqz p3, :cond_a

    const v3, 0x7f08005e

    :cond_a
    iget-object p3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    const/4 v0, 0x1

    invoke-static {p3, v0}, Lcom/mrkeyboard/app/SheetStore;->resolveKeyboardXmlId(Landroid/content/Context;I)I

    move-result v5

    invoke-direct {p1, v5, v3, v6, p2}, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;-><init>(IIZZ)V

    return-object p1

    .line 388
    :pswitch_7
    new-instance p1, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    iget-boolean p3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasSettingsKey:Z

    if-eqz p3, :cond_b

    const v1, 0x7f08005c

    :cond_b
    invoke-direct {p1, v0, v1, v2, p2}, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;-><init>(IIZZ)V

    return-object p1

    nop

    :pswitch_data_0
    .packed-switch 0x4
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_7
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method private getPointerCount()I
    .locals 1

    .line 542
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinKeyboardView;->getPointerCount()I

    move-result v0

    :goto_0
    return v0
.end method

.method private hasVoiceButton(Z)Z
    .locals 1

    .line 276
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasVoice:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mVoiceOnPrimary:Z

    if-eq p1, v0, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method

.method public static init(Lcom/mrkeyboard/app/LatinIME;)V
    .locals 3

    .line 151
    sget-object v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->sInstance:Lcom/mrkeyboard/app/KeyboardSwitcher;

    iput-object p0, v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    .line 154
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object p0

    .line 155
    sget-object v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->sInstance:Lcom/mrkeyboard/app/KeyboardSwitcher;

    const-string v1, "pref_keyboard_layout"

    const-string v2, "9"

    invoke-interface {p0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    iput v1, v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mLayoutId:I

    .line 158
    sget-object v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->sInstance:Lcom/mrkeyboard/app/KeyboardSwitcher;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->updateSettingsKeyState(Landroid/content/SharedPreferences;)V

    .line 159
    sget-object v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->sInstance:Lcom/mrkeyboard/app/KeyboardSwitcher;

    invoke-interface {p0, v0}, Landroid/content/SharedPreferences;->registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 161
    sget-object p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->sInstance:Lcom/mrkeyboard/app/KeyboardSwitcher;

    sget-object v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->sInstance:Lcom/mrkeyboard/app/KeyboardSwitcher;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/KeyboardSwitcher;->makeSymbolsId(Z)Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSymbolsId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    .line 162
    sget-object p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->sInstance:Lcom/mrkeyboard/app/KeyboardSwitcher;

    sget-object v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->sInstance:Lcom/mrkeyboard/app/KeyboardSwitcher;

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/KeyboardSwitcher;->makeSymbolsShiftedId(Z)Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSymbolsShiftedId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    return-void
.end method

.method private makeSymbolsId(Z)Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;
    .locals 4

    .line 179
    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mFullMode:I

    const v1, 0x7f08005d

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    .line 180
    new-instance v0, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    const v3, 0x7f0f0002

    invoke-direct {v0, v3, v1, v2, p1}, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;-><init>(IIZZ)V

    return-object v0

    .line 181
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mFullMode:I

    const/4 v3, 0x2

    if-ne v0, v3, :cond_1

    .line 182
    new-instance v0, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    const v3, 0x7f0f0006

    invoke-direct {v0, v3, v1, v2, p1}, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;-><init>(IIZZ)V

    return-object v0

    .line 184
    :cond_1
    new-instance v0, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    const/4 v3, 0x1

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/SheetStore;->resolveKeyboardXmlId(Landroid/content/Context;I)I

    move-result v2

    iget-boolean v3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasSettingsKey:Z

    if-eqz v3, :cond_2

    const v1, 0x7f08005e

    :cond_2
    const/4 v3, 0x0

    invoke-direct {v0, v2, v1, v3, p1}, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;-><init>(IIZZ)V

    return-object v0
.end method

.method private makeSymbolsShiftedId(Z)Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;
    .locals 4

    .line 190
    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mFullMode:I

    if-lez v0, :cond_0

    const/4 p1, 0x0

    return-object p1

    .line 192
    :cond_0
    new-instance v0, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    const v1, 0x7f0f000d

    iget-boolean v2, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasSettingsKey:Z

    if-eqz v2, :cond_1

    const v2, 0x7f08005e

    goto :goto_0

    :cond_1
    const v2, 0x7f08005d

    :goto_0
    const/4 v3, 0x0

    invoke-direct {v0, v1, v2, v3, p1}, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;-><init>(IIZZ)V

    return-object v0
.end method

.method private setKeyboardMode(IIZZ)V
    .locals 1

    .line 295
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    if-nez v0, :cond_0

    return-void

    .line 297
    :cond_0
    iput p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mMode:I

    .line 298
    iput p2, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mImeOptions:I

    .line 299
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasVoice:Z

    if-eq p3, v0, :cond_1

    .line 301
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mVoiceOnPrimary:Z

    invoke-virtual {p0, p3, v0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->setVoiceMode(ZZ)V

    .line 303
    :cond_1
    if-eqz p4, :cond_keep_sym

    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mFullMode:I

    if-gtz v0, :cond_keep_sym

    const/4 v0, 0x3

    if-eq p1, v0, :cond_keep_sym

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetStore;->getSheetCount(Landroid/content/Context;)I

    move-result v0

    if-gtz v0, :cond_keep_sym

    const/4 p4, 0x0

    iput p4, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSheet:I

    :cond_keep_sym
    iput-boolean p4, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mIsSymbols:Z

    .line 305
    iget-object p3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getPopupOn()Z

    move-result v0

    invoke-virtual {p3, v0}, Lcom/mrkeyboard/app/LatinKeyboardView;->setPreviewEnabled(Z)V

    .line 307
    invoke-direct {p0, p1, p2, p4}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getKeyboardId(IIZ)Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    move-result-object p3

    .line 309
    invoke-direct {p0, p3}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getKeyboard(Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;)Lcom/mrkeyboard/app/LatinKeyboard;

    move-result-object p4

    const/4 v0, 0x3

    if-ne p1, v0, :cond_2

    .line 312
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    invoke-virtual {p1, p4}, Lcom/mrkeyboard/app/LatinKeyboardView;->setPhoneKeyboard(Lcom/mrkeyboard/app/Keyboard;)V

    .line 315
    :cond_2
    iput-object p3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mCurrentId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    .line 316
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    invoke-virtual {p1, p4}, Lcom/mrkeyboard/app/LatinKeyboardView;->setKeyboard(Lcom/mrkeyboard/app/Keyboard;)V

    const/4 p1, 0x0

    .line 317
    invoke-virtual {p4, p1}, Lcom/mrkeyboard/app/LatinKeyboard;->setShiftState(I)Z

    .line 318
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {p1}, Lcom/mrkeyboard/app/LatinIME;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    iget p3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mMode:I

    invoke-virtual {p4, p1, p3, p2}, Lcom/mrkeyboard/app/LatinKeyboard;->setImeOptions(Landroid/content/res/Resources;II)V

    .line 320
    iget-boolean p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mIsAutoCompletionActive:Z

    invoke-virtual {p4, p1}, Lcom/mrkeyboard/app/LatinKeyboard;->updateSymbolIcons(Z)V

    return-void
.end method

.method private updateSettingsKeyState(Landroid/content/SharedPreferences;)V
    .locals 2

    # v1.69: "Show settings key" switch (before, a list with 3 values)
    const-string v0, "show_settings_key"

    const/4 v1, 0x1

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasSettingsKey:Z

    return-void
.end method


# virtual methods
.method public getInputView()Lcom/mrkeyboard/app/LatinKeyboardView;
    .locals 1

    .line 606
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    return-object v0
.end method

.method public getKeyboardMode()I
    .locals 1

    .line 418
    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mMode:I

    return v0
.end method

.method public hasDistinctMultitouch()Z
    .locals 1

    .line 522
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinKeyboardView;->hasDistinctMultitouch()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isAlphabetMode()Z
    .locals 7

    .line 422
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mCurrentId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    .line 425
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mCurrentId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    iget v0, v0, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;->mKeyboardMode:I

    .line 426
    iget v2, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mFullMode:I

    const/4 v3, 0x1

    if-lez v2, :cond_1

    const v2, 0x7f08005b

    if-ne v0, v2, :cond_1

    return v3

    .line 428
    :cond_1
    sget-object v2, Lcom/mrkeyboard/app/KeyboardSwitcher;->ALPHABET_MODES:[I

    array-length v4, v2

    const/4 v5, 0x0

    :goto_0
    if-ge v5, v4, :cond_3

    aget v6, v2, v5

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    .line 429
    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v6

    if-ne v0, v6, :cond_2

    return v3

    :cond_2
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_3
    return v1
.end method

.method public isFullMode()Z
    .locals 1

    .line 356
    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mFullMode:I

    if-lez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isInChordingAutoModeSwitchState()Z
    .locals 2

    .line 534
    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mAutoModeSwitchState:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isInMomentaryAutoModeSwitchState()Z
    .locals 2

    .line 530
    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mAutoModeSwitchState:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isVibrateAndSoundFeedbackRequired()Z
    .locals 1

    .line 538
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinKeyboardView;->isInSlidingKeyInput()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public makeKeyboards(Z)V
    .locals 3

    .line 198
    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sKeyboardSettings:Lcom/mrkeyboard/app/GlobalKeyboardSettings;

    iget v0, v0, Lcom/mrkeyboard/app/GlobalKeyboardSettings;->keyboardMode:I

    iput v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mFullMode:I

    .line 199
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasVoice:Z

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mVoiceOnPrimary:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->makeSymbolsId(Z)Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSymbolsId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    .line 200
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasVoice:Z

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mVoiceOnPrimary:Z

    if-nez v0, :cond_1

    goto :goto_1

    :cond_1
    const/4 v1, 0x0

    :goto_1
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/KeyboardSwitcher;->makeSymbolsShiftedId(Z)Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSymbolsShiftedId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    if-eqz p1, :cond_2

    .line 203
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mKeyboards:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    .line 209
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->getMaxWidth()I

    move-result v0

    .line 210
    iget v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mLastDisplayWidth:I

    if-ne v0, v1, :cond_3

    return-void

    .line 212
    :cond_3
    iput v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mLastDisplayWidth:I

    if-nez p1, :cond_4

    .line 214
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mKeyboards:Ljava/util/HashMap;

    invoke-virtual {p1}, Ljava/util/HashMap;->clear()V

    :cond_4
    return-void
.end method

.method public onAutoCompletionStateChanged(Z)V
    .locals 2

    .line 665
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mIsAutoCompletionActive:Z

    if-eq p1, v0, :cond_0

    .line 666
    invoke-virtual {p0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInputView()Lcom/mrkeyboard/app/LatinKeyboardView;

    move-result-object v0

    .line 667
    iput-boolean p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mIsAutoCompletionActive:Z

    .line 669
    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinKeyboardView;->getKeyboard()Lcom/mrkeyboard/app/Keyboard;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/LatinKeyboard;

    .line 670
    invoke-virtual {v1, p1}, Lcom/mrkeyboard/app/LatinKeyboard;->onAutoCompletionStateChanged(Z)Lcom/mrkeyboard/app/Keyboard$Key;

    move-result-object p1

    .line 668
    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/LatinKeyboardView;->invalidateKey(Lcom/mrkeyboard/app/Keyboard$Key;)V

    :cond_0
    return-void
.end method

.method public onCancelInput()V
    .locals 2

    .line 507
    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mAutoModeSwitchState:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    .line 508
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getPointerCount()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 509
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinIME;->changeKeyboardMode()V

    :cond_0
    return-void
.end method

.method public onKey(I)V
    .locals 3

    .line 553
    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mAutoModeSwitchState:I

    const/16 v1, 0xa

    const/16 v2, 0x20

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    const/4 v0, -0x2

    const/4 v1, 0x1

    if-ne p1, v0, :cond_1

    .line 567
    iget-boolean p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mIsSymbols:Z

    if-eqz p1, :cond_0

    .line 568
    iput v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mAutoModeSwitchState:I

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    .line 570
    iput p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mAutoModeSwitchState:I

    goto :goto_0

    .line 572
    :cond_1
    invoke-direct {p0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getPointerCount()I

    move-result p1

    if-ne p1, v1, :cond_2

    .line 579
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {p1}, Lcom/mrkeyboard/app/LatinIME;->changeKeyboardMode()V

    goto :goto_0

    :cond_2
    const/4 p1, 0x4

    .line 585
    iput p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mAutoModeSwitchState:I

    goto :goto_0

    :pswitch_1
    if-eq p1, v1, :cond_3

    if-ne p1, v2, :cond_4

    .line 599
    :cond_3
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {p1}, Lcom/mrkeyboard/app/LatinIME;->changeKeyboardMode()V

    goto :goto_0

    :pswitch_2
    if-eq p1, v2, :cond_4

    if-eq p1, v1, :cond_4

    if-ltz p1, :cond_4

    const/4 p1, 0x2

    .line 591
    iput p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mAutoModeSwitchState:I

    :cond_4
    :goto_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public onSharedPreferenceChanged(Landroid/content/SharedPreferences;Ljava/lang/String;)V
    .locals 1

    const-string v0, "pref_keyboard_layout"

    .line 655
    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "9"

    .line 657
    invoke-interface {p1, p2, v0}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 656
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    const/4 p2, 0x1

    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/KeyboardSwitcher;->changeLatinKeyboardView(IZ)V

    # theme changed: discards the cached keyboards to reapply the pad (Dark Tech = 0)
    invoke-virtual {p0, p2}, Lcom/mrkeyboard/app/KeyboardSwitcher;->makeKeyboards(Z)V

    goto :goto_0

    :cond_0
    const-string v0, "show_settings_key"

    .line 658
    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_1

    .line 659
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/KeyboardSwitcher;->updateSettingsKeyState(Landroid/content/SharedPreferences;)V

    .line 660
    invoke-virtual {p0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->recreateInputView()V

    :cond_1
    :goto_0
    return-void
.end method

.method public recreateInputView()V
    .locals 2

    .line 610
    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mLayoutId:I

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/KeyboardSwitcher;->changeLatinKeyboardView(IZ)V

    return-void
.end method

.method public setAltIndicator(Z)V
    .locals 1

    .line 464
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    if-nez v0, :cond_0

    return-void

    .line 465
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/LatinKeyboardView;->setAltIndicator(Z)V

    return-void
.end method

.method public setAutoModeSwitchStateMomentary()V
    .locals 1

    const/4 v0, 0x3

    .line 526
    iput v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mAutoModeSwitchState:I

    return-void
.end method

.method public setCtrlIndicator(Z)V
    .locals 1

    .line 459
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    if-nez v0, :cond_0

    return-void

    .line 460
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/LatinKeyboardView;->setCtrlIndicator(Z)V

    return-void
.end method

.method public setFn(Z)V
    .locals 4

    .line 443
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    if-nez v0, :cond_0

    return-void

    .line 444
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinKeyboardView;->getShiftState()I

    move-result v0

    if-eqz p1, :cond_1

    .line 446
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSymbolsId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getKeyboard(Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;)Lcom/mrkeyboard/app/LatinKeyboard;

    move-result-object p1

    .line 447
    invoke-virtual {p1}, Lcom/mrkeyboard/app/LatinKeyboard;->enableShiftLock()V

    .line 448
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSymbolsId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    iput-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mCurrentId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    .line 449
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    invoke-virtual {v1, p1}, Lcom/mrkeyboard/app/LatinKeyboardView;->setKeyboard(Lcom/mrkeyboard/app/Keyboard;)V

    .line 450
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    invoke-virtual {p1, v0}, Lcom/mrkeyboard/app/LatinKeyboardView;->setShiftState(I)Z

    goto :goto_0

    .line 453
    :cond_1
    iget p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mMode:I

    iget v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mImeOptions:I

    iget-boolean v2, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasVoice:Z

    const/4 v3, 0x0

    invoke-direct {p0, p1, v1, v2, v3}, Lcom/mrkeyboard/app/KeyboardSwitcher;->setKeyboardMode(IIZZ)V

    .line 454
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    invoke-virtual {p1, v0}, Lcom/mrkeyboard/app/LatinKeyboardView;->setShiftState(I)Z

    :goto_0
    return-void
.end method

.method public setKeyboardMode(IIZ)V
    .locals 3

    const/4 v0, 0x0

    .line 280
    iput v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mAutoModeSwitchState:I

    const/4 v1, 0x1

    const/4 v2, 0x2

    if-ne p1, v2, :cond_0

    const/4 v0, 0x1

    .line 281
    :cond_0
    iput-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mPreferSymbols:Z

    iput v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSheet:I

    if-ne p1, v2, :cond_1

    const/4 p1, 0x1

    .line 286
    :cond_1
    :try_start_0
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mPreferSymbols:Z

    invoke-direct {p0, p1, p2, p3, v0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->setKeyboardMode(IIZZ)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p3

    .line 288
    sget-object v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Got exception: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, ","

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, ","

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mPreferSymbols:Z

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string p1, " msg="

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 289
    invoke-virtual {p3}, Ljava/lang/RuntimeException;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 288
    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void
.end method

.method public setLanguageSwitcher(Lcom/mrkeyboard/app/LanguageSwitcher;)V
    .locals 0

    .line 174
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mLanguageSwitcher:Lcom/mrkeyboard/app/LanguageSwitcher;

    .line 175
    invoke-virtual {p1}, Lcom/mrkeyboard/app/LanguageSwitcher;->getInputLocale()Ljava/util/Locale;

    return-void
.end method

.method public setMetaIndicator(Z)V
    .locals 1

    .line 469
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    if-nez v0, :cond_0

    return-void

    .line 470
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/LatinKeyboardView;->setMetaIndicator(Z)V

    return-void
.end method

.method public setShiftState(I)V
    .locals 1

    .line 437
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    if-eqz v0, :cond_0

    .line 438
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/LatinKeyboardView;->setShiftState(I)Z

    :cond_0
    return-void
.end method

.method public setVoiceMode(ZZ)V
    .locals 2

    .line 267
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasVoice:Z

    if-ne p1, v0, :cond_0

    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mVoiceOnPrimary:Z

    if-eq p2, v0, :cond_1

    .line 268
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mKeyboards:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    .line 270
    :cond_1
    iput-boolean p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasVoice:Z

    .line 271
    iput-boolean p2, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mVoiceOnPrimary:Z

    .line 272
    iget p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mMode:I

    iget p2, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mImeOptions:I

    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasVoice:Z

    iget-boolean v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mIsSymbols:Z

    invoke-direct {p0, p1, p2, v0, v1}, Lcom/mrkeyboard/app/KeyboardSwitcher;->setKeyboardMode(IIZZ)V

    return-void
.end method

.method public toggleShift()V
    .locals 4

    .line 475
    invoke-virtual {p0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->isAlphabetMode()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    .line 477
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mFullMode:I

    if-lez v0, :cond_1

    .line 478
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinKeyboardView;->isShiftAll()Z

    move-result v0

    .line 479
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    xor-int/lit8 v0, v0, 0x1

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/LatinKeyboardView;->setShiftState(I)Z

    return-void

    .line 482
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mCurrentId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSymbolsId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;->access$000(Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;)Z

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mCurrentId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSymbolsShiftedId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    .line 483
    invoke-static {v0, v1}, Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;->access$000(Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;)Z

    move-result v0

    if-nez v0, :cond_2

    goto :goto_0

    .line 494
    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mMode:I

    iget v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mImeOptions:I

    const/4 v2, 0x1

    invoke-direct {p0, v0, v1, v2}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getKeyboardId(IIZ)Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getKeyboard(Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;)Lcom/mrkeyboard/app/LatinKeyboard;

    move-result-object v0

    .line 495
    iput-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mCurrentId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    .line 496
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/LatinKeyboardView;->setKeyboard(Lcom/mrkeyboard/app/Keyboard;)V

    .line 497
    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinKeyboard;->enableShiftLock()V

    const/4 v1, 0x0

    .line 498
    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/LatinKeyboard;->setShiftState(I)Z

    .line 499
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    iget v2, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mMode:I

    iget v3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mImeOptions:I

    invoke-virtual {v0, v1, v2, v3}, Lcom/mrkeyboard/app/LatinKeyboard;->setImeOptions(Landroid/content/res/Resources;II)V

    goto :goto_1

    .line 484
    :cond_3
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSymbolsShiftedId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getKeyboard(Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;)Lcom/mrkeyboard/app/LatinKeyboard;

    move-result-object v0

    .line 485
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSymbolsShiftedId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    iput-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mCurrentId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    .line 486
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/LatinKeyboardView;->setKeyboard(Lcom/mrkeyboard/app/Keyboard;)V

    .line 489
    invoke-virtual {v0}, Lcom/mrkeyboard/app/LatinKeyboard;->enableShiftLock()V

    const/4 v1, 0x2

    .line 490
    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/LatinKeyboard;->setShiftState(I)Z

    .line 491
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    .line 492
    invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinIME;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    iget v2, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mMode:I

    iget v3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mImeOptions:I

    .line 491
    invoke-virtual {v0, v1, v2, v3}, Lcom/mrkeyboard/app/LatinKeyboard;->setImeOptions(Landroid/content/res/Resources;II)V

    :goto_1
    return-void
.end method

.method public toggleSymbols()V
    .locals 5

    .line 513
    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mMode:I

    iget v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mImeOptions:I

    iget-boolean v2, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasVoice:Z

    iget-boolean v3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mIsSymbols:Z

    const/4 v4, 0x1

    xor-int/2addr v3, v4

    iput v3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSheet:I

    invoke-direct {p0, v0, v1, v2, v3}, Lcom/mrkeyboard/app/KeyboardSwitcher;->setKeyboardMode(IIZZ)V

    .line 514
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mIsSymbols:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mPreferSymbols:Z

    if-nez v0, :cond_0

    .line 515
    iput v4, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mAutoModeSwitchState:I

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 517
    iput v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mAutoModeSwitchState:I

    :goto_0
    return-void
.end method

.method private applySheet(I)V
    .locals 4

    iput p1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSheet:I

    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mMode:I

    iget v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mImeOptions:I

    iget-boolean v2, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasVoice:Z

    if-eqz p1, :cond_letters

    const/4 v3, 0x1

    goto :goto_apply

    :cond_letters
    const/4 v3, 0x0

    :goto_apply
    invoke-direct {p0, v0, v1, v2, v3}, Lcom/mrkeyboard/app/KeyboardSwitcher;->setKeyboardMode(IIZZ)V

    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mAutoModeSwitchState:I

    return-void
.end method

# p1 = 0 -> next sheet (cycle); -1 -> previous sheet (cycle); 1..5 -> go directly to ABC, 123, TSK, HTML, FRS
.method public onSheetKey(I)V
    .locals 2

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    iget v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSheet:I

    invoke-static {v0, v1, p1}, Lcom/mrkeyboard/app/SheetStore;->computeNextSheet(Landroid/content/Context;II)I

    move-result v0

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->applySheet(I)V

    return-void
.end method

.method public getSheet()I
    .locals 1

    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSheet:I

    return v0
.end method

.method public onSheetsChanged()V
    .locals 4

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;

    if-nez v0, :cond_has_ims

    return-void

    :cond_has_ims
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mKeyboards:Ljava/util/HashMap;

    invoke-virtual {v1}, Ljava/util/HashMap;->clear()V

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetStore;->getSheetCount(Landroid/content/Context;)I

    move-result v0

    iget v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSheet:I

    if-le v1, v0, :cond_sheet_ok

    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSheet:I

    iput-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mIsSymbols:Z

    :cond_sheet_ok
    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasVoice:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_no_voice_sym

    iget-boolean v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mVoiceOnPrimary:Z

    if-nez v0, :cond_no_voice_sym

    const/4 v1, 0x1

    :cond_no_voice_sym
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/KeyboardSwitcher;->makeSymbolsId(Z)Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mSymbolsId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;

    if-eqz v0, :cond_done

    iget v0, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mMode:I

    iget v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mImeOptions:I

    iget-boolean v2, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mHasVoice:Z

    iget-boolean v3, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mIsSymbols:Z

    invoke-direct {p0, v0, v1, v2, v3}, Lcom/mrkeyboard/app/KeyboardSwitcher;->setKeyboardMode(IIZZ)V

    :cond_done
    return-void
.end method

.method public static release(Lcom/mrkeyboard/app/LatinIME;)V
 .locals 3
 sget-object v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->sInstance:Lcom/mrkeyboard/app/KeyboardSwitcher;
 iget-object v1, v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;
 if-ne v1, p0, :done
 invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;
 move-result-object v1
 invoke-interface {v1, v0}, Landroid/content/SharedPreferences;->unregisterOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V
 iget-object v1, v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;
 if-eqz v1, :clear
 invoke-virtual {v1}, Lcom/mrkeyboard/app/LatinKeyboardBaseView;->closing()V
 :clear
 iget-object v1, v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mKeyboards:Ljava/util/HashMap;
 invoke-virtual {v1}, Ljava/util/HashMap;->clear()V
 const/4 v1, 0x0
 iput-object v1, v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputMethodService:Lcom/mrkeyboard/app/LatinIME;
 iput-object v1, v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;
 iput-object v1, v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mLanguageSwitcher:Lcom/mrkeyboard/app/LanguageSwitcher;
 iput-object v1, v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mCurrentId:Lcom/mrkeyboard/app/KeyboardSwitcher$KeyboardId;
 const/4 v1, 0x0
 iput v1, v0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mLastDisplayWidth:I
 :done
 return-void
.end method
