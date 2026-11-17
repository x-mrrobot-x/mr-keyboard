.class public Lcom/mrkeyboard/app/MrSoundActivity;
.super Landroid/app/Activity;
.source "MrSoundActivity.java"


# static fields
.field static final COLUMNS:I = 0x5

.field private static final GLYPHS:[[Ljava/lang/String;

.field static final MUTE:Ljava/lang/String; = "mute"

.field static final SOUND_ON:Ljava/lang/String; = "sound_on"

.field static final TILES:[Ljava/lang/String;


# instance fields
.field k:Lcom/mrkeyboard/app/MrKit;

.field mNote:Landroid/widget/TextView;

.field mOtherIme:Landroid/widget/TextView;

.field mPercent:Landroid/widget/TextView;

.field mPrefs:Landroid/content/SharedPreferences;

.field mSeek:Landroid/widget/SeekBar;

.field final mTiles:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroid/widget/LinearLayout;",
            ">;"
        }
    .end annotation
.end field

.field mTry:Landroid/widget/EditText;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/4 v3, 0x4

    const/4 v7, 0x3

    const/4 v6, 0x2

    const/4 v5, 0x1

    const/4 v4, 0x0

    .line 38
    const/16 v0, 0xf

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "mute"

    aput-object v1, v0, v4

    const-string v1, "default"

    aput-object v1, v0, v5

    const-string v1, "keyboard"

    aput-object v1, v0, v6

    const-string v1, "drop"

    aput-object v1, v0, v7

    const-string v1, "bubble"

    aput-object v1, v0, v3

    const/4 v1, 0x5

    const-string v2, "bubble2"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "bell"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "duck"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "mouse"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "cat"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "frog"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "fox"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "wand"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, "pistol"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, "rocket"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrSoundActivity;->TILES:[Ljava/lang/String;

    .line 43
    const/16 v0, 0xe

    new-array v0, v0, [[Ljava/lang/String;

    new-array v1, v6, [Ljava/lang/String;

    const-string v2, "mute"

    aput-object v2, v1, v4

    const-string v2, "\ud83d\udd07"

    aput-object v2, v1, v5

    aput-object v1, v0, v4

    new-array v1, v7, [Ljava/lang/String;

    const-string v2, "bubble"

    aput-object v2, v1, v4

    const-string v2, "\ud83e\udee7"

    aput-object v2, v1, v5

    const-string v2, "\ud83d\udd35"

    aput-object v2, v1, v6

    aput-object v1, v0, v5

    new-array v1, v7, [Ljava/lang/String;

    const-string v2, "bubble2"

    aput-object v2, v1, v4

    const-string v2, "\ud83e\udee7"

    aput-object v2, v1, v5

    const-string v2, "\ud83d\udd35"

    aput-object v2, v1, v6

    aput-object v1, v0, v6

    new-array v1, v6, [Ljava/lang/String;

    const-string v2, "bell"

    aput-object v2, v1, v4

    const-string v2, "\ud83d\udd14"

    aput-object v2, v1, v5

    aput-object v1, v0, v7

    new-array v1, v7, [Ljava/lang/String;

    const-string v2, "duck"

    aput-object v2, v1, v4

    const-string v2, "\ud83e\udd86"

    aput-object v2, v1, v5

    const-string v2, "\ud83d\udc25"

    aput-object v2, v1, v6

    aput-object v1, v0, v3

    const/4 v1, 0x5

    new-array v2, v6, [Ljava/lang/String;

    const-string v3, "keyboard"

    aput-object v3, v2, v4

    const-string v3, "\u2328\ufe0f"

    aput-object v3, v2, v5

    aput-object v2, v0, v1

    const/4 v1, 0x6

    new-array v2, v7, [Ljava/lang/String;

    const-string v3, "fox"

    aput-object v3, v2, v4

    const-string v3, "\ud83e\udd8a"

    aput-object v3, v2, v5

    const-string v3, "\ud83d\udc3a"

    aput-object v3, v2, v6

    aput-object v2, v0, v1

    const/4 v1, 0x7

    new-array v2, v6, [Ljava/lang/String;

    const-string v3, "pistol"

    aput-object v3, v2, v4

    const-string v3, "\ud83d\udd2b"

    aput-object v3, v2, v5

    aput-object v2, v0, v1

    const/16 v1, 0x8

    new-array v2, v7, [Ljava/lang/String;

    const-string v3, "wand"

    aput-object v3, v2, v4

    const-string v3, "\ud83e\ude84"

    aput-object v3, v2, v5

    const-string v3, "\u2728"

    aput-object v3, v2, v6

    aput-object v2, v0, v1

    const/16 v1, 0x9

    new-array v2, v6, [Ljava/lang/String;

    const-string v3, "frog"

    aput-object v3, v2, v4

    const-string v3, "\ud83d\udc38"

    aput-object v3, v2, v5

    aput-object v2, v0, v1

    const/16 v1, 0xa

    new-array v2, v6, [Ljava/lang/String;

    const-string v3, "cat"

    aput-object v3, v2, v4

    const-string v3, "\ud83d\udc31"

    aput-object v3, v2, v5

    aput-object v2, v0, v1

    const/16 v1, 0xb

    new-array v2, v6, [Ljava/lang/String;

    const-string v3, "drop"

    aput-object v3, v2, v4

    const-string v3, "\ud83d\udca7"

    aput-object v3, v2, v5

    aput-object v2, v0, v1

    const/16 v1, 0xc

    new-array v2, v6, [Ljava/lang/String;

    const-string v3, "rocket"

    aput-object v3, v2, v4

    const-string v3, "\ud83d\ude80"

    aput-object v3, v2, v5

    aput-object v2, v0, v1

    const/16 v1, 0xd

    new-array v2, v7, [Ljava/lang/String;

    const-string v3, "mouse"

    aput-object v3, v2, v4

    const-string v3, "\ud83d\uddb1\ufe0f"

    aput-object v3, v2, v5

    const-string v3, "\ud83d\udc2d"

    aput-object v3, v2, v6

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrSoundActivity;->GLYPHS:[[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 30
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 61
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mTiles:Ljava/util/List;

    return-void
.end method

.method static glyph(Ljava/lang/String;Landroid/graphics/Paint;)Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 198
    sget-object v2, Lcom/mrkeyboard/app/MrSoundActivity;->GLYPHS:[[Ljava/lang/String;

    array-length v3, v2

    move v0, v1

    :goto_0
    if-ge v0, v3, :cond_3

    aget-object v4, v2, v0

    .line 199
    aget-object v5, v4, v1

    invoke-virtual {v5, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_0

    .line 198
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 200
    :cond_0
    const/4 v0, 0x1

    :goto_1
    array-length v1, v4

    add-int/lit8 v1, v1, -0x1

    if-ge v0, v1, :cond_2

    aget-object v1, v4, v0

    invoke-virtual {p1, v1}, Landroid/graphics/Paint;->hasGlyph(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    aget-object v0, v4, v0

    .line 203
    :goto_2
    return-object v0

    .line 200
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 201
    :cond_2
    array-length v0, v4

    add-int/lit8 v0, v0, -0x1

    aget-object v0, v4, v0

    goto :goto_2

    .line 203
    :cond_3
    const-string v0, ""

    goto :goto_2
.end method

.method static keyboardInUse(Landroid/content/Context;)Z
    .locals 4

    .prologue
    const/4 v0, 0x1

    .line 188
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "default_input_method"

    invoke-static {v1, v2}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 189
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    .line 190
    if-eqz v1, :cond_0

    if-eqz v2, :cond_0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "/"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    if-eqz v1, :cond_1

    .line 192
    :cond_0
    :goto_0
    return v0

    .line 190
    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    .line 191
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private tile(Ljava/lang/String;Landroid/graphics/Paint;)Landroid/widget/LinearLayout;
    .locals 7

    .prologue
    const/4 v6, 0x0

    const/4 v5, -0x2

    .line 165
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 166
    const/16 v0, 0x11

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 167
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 168
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v0, "default"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "mr_sound_default"

    :goto_0
    new-array v3, v6, [Ljava/lang/Object;

    invoke-virtual {v2, v0, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 169
    new-instance v0, Lcom/mrkeyboard/app/MrSoundActivity$3;

    invoke-direct {v0, p0, p1}, Lcom/mrkeyboard/app/MrSoundActivity$3;-><init>(Lcom/mrkeyboard/app/MrSoundActivity;Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 174
    const-string v0, "default"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 175
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_sound_default"

    new-array v4, v6, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const/high16 v3, 0x41500000    # 13.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v0, v2, v3, v4, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v5, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 182
    :cond_0
    :goto_1
    return-object v1

    .line 168
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "mr_sound_name_"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 177
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-static {p1, p2}, Lcom/mrkeyboard/app/MrSoundActivity;->glyph(Ljava/lang/String;Landroid/graphics/Paint;)Ljava/lang/String;

    move-result-object v2

    const/high16 v3, 0x41d00000    # 26.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text:I

    invoke-virtual {v0, v2, v3, v4, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v5, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 178
    const-string v0, "bubble"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    const-string v0, "bubble2"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 179
    :cond_3
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v0, "bubble"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    const-string v0, "1"

    :goto_2
    const/high16 v3, 0x41300000    # 11.0f

    iget-object v4, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v4, v4, Lcom/mrkeyboard/app/MrKit;->text2:I

    invoke-virtual {v2, v0, v3, v4, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v2, v5, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_1

    :cond_4
    const-string v0, "2"

    goto :goto_2
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 71
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 72
    return-void
.end method

.method choose(Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 214
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mPrefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 215
    const-string v1, "mute"

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 216
    const-string v1, "sound_on"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 221
    :goto_0
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 222
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrSoundActivity;->refresh()V

    .line 223
    const-string v0, "mute"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 224
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrKeySound;->preload(Landroid/content/Context;Ljava/lang/String;)V

    .line 225
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrKeySound;->preview(Landroid/content/Context;Ljava/lang/String;)V

    .line 227
    :cond_0
    return-void

    .line 218
    :cond_1
    const-string v1, "sound_on"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 219
    const-string v1, "pref_sound_style"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    goto :goto_0
.end method

.method current()Ljava/lang/String;
    .locals 3

    .prologue
    .line 208
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mPrefs:Landroid/content/SharedPreferences;

    const-string v1, "sound_on"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "mute"

    .line 209
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mPrefs:Landroid/content/SharedPreferences;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeySound;->style(Landroid/content/SharedPreferences;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 12

    .prologue
    .line 88
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 89
    new-instance v0, Lcom/mrkeyboard/app/MrKit;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrKit;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 90
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mPrefs:Landroid/content/SharedPreferences;

    .line 92
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 93
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v2, v2, Lcom/mrkeyboard/app/MrKit;->bg:I

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-virtual {v1, v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 94
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 95
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41a00000    # 20.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41800000    # 16.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x41a00000    # 20.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41c00000    # 24.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    invoke-virtual {v1, v2, v3, v4, v5}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 96
    new-instance v2, Landroid/view/ViewGroup$LayoutParams;

    const/4 v3, -0x1

    const/4 v4, -0x2

    invoke-direct {v2, v3, v4}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 98
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41a00000    # 20.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x41800000    # 16.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v5, 0x41a00000    # 20.0f

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41c00000    # 24.0f

    invoke-virtual {v5, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v5

    iget-object v6, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v7, 0x41400000    # 12.0f

    invoke-virtual {v6, v7}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v6

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/MrScreenIme;->keepVisible(Landroid/widget/ScrollView;Landroid/view/View;IIIII)V

    .line 100
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_sound_title"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/MrSoundActivity$1;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrSoundActivity$1;-><init>(Lcom/mrkeyboard/app/MrSoundActivity;)V

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->backHeader(Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v4, 0x0

    .line 104
    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    .line 100
    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 105
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_sound_styles"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/high16 v4, 0x41800000    # 16.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v6, 0x1

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x12

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 107
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v6

    .line 108
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v3, 0x8

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v1, v6, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 109
    new-instance v7, Landroid/graphics/Paint;

    const/4 v2, 0x1

    invoke-direct {v7, v2}, Landroid/graphics/Paint;-><init>(I)V

    .line 110
    const/4 v3, 0x0

    .line 111
    const/4 v2, 0x0

    move v5, v2

    move-object v2, v3

    :goto_0
    sget-object v3, Lcom/mrkeyboard/app/MrSoundActivity;->TILES:[Ljava/lang/String;

    array-length v3, v3

    if-ge v5, v3, :cond_4

    .line 112
    rem-int/lit8 v3, v5, 0x5

    if-nez v3, :cond_0

    .line 113
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v3

    .line 114
    iget-object v4, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    if-nez v5, :cond_1

    const/4 v2, 0x0

    :goto_1
    invoke-virtual {v4, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v6, v3, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    move-object v2, v3

    .line 116
    :cond_0
    sget-object v3, Lcom/mrkeyboard/app/MrSoundActivity;->TILES:[Ljava/lang/String;

    aget-object v3, v3, v5

    invoke-direct {p0, v3, v7}, Lcom/mrkeyboard/app/MrSoundActivity;->tile(Ljava/lang/String;Landroid/graphics/Paint;)Landroid/widget/LinearLayout;

    move-result-object v8

    .line 117
    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mTiles:Ljava/util/List;

    invoke-interface {v3, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 118
    new-instance v9, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, 0x0

    iget-object v4, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v10, 0x42800000    # 64.0f

    invoke-virtual {v4, v10}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    const/high16 v10, 0x3f800000    # 1.0f

    invoke-direct {v9, v3, v4, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 119
    rem-int/lit8 v3, v5, 0x5

    if-nez v3, :cond_2

    const/4 v3, 0x0

    :goto_2
    const/4 v10, 0x0

    rem-int/lit8 v4, v5, 0x5

    const/4 v11, 0x4

    if-ne v4, v11, :cond_3

    const/4 v4, 0x0

    :goto_3
    const/4 v11, 0x0

    invoke-virtual {v9, v3, v10, v4, v11}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 120
    invoke-virtual {v2, v8, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 111
    add-int/lit8 v3, v5, 0x1

    move v5, v3

    goto :goto_0

    .line 114
    :cond_1
    const/16 v2, 0x8

    goto :goto_1

    .line 119
    :cond_2
    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v4, 0x40800000    # 4.0f

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    goto :goto_2

    :cond_3
    iget-object v4, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v11, 0x40800000    # 4.0f

    invoke-virtual {v4, v11}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v4

    goto :goto_3

    .line 123
    :cond_4
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/MrKit;->panel()Landroid/widget/LinearLayout;

    move-result-object v2

    .line 124
    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x14

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 125
    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v3

    .line 126
    iget-object v4, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 127
    iget-object v4, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v6, "mr_sound_volume"

    const/4 v7, 0x0

    new-array v7, v7, [Ljava/lang/Object;

    invoke-virtual {v5, v6, v7}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    const/high16 v6, 0x41800000    # 16.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v8, 0x1

    invoke-virtual {v4, v5, v6, v7, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, 0x0

    const/4 v7, -0x2

    const/high16 v8, 0x3f800000    # 1.0f

    invoke-direct {v5, v6, v7, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 128
    iget-object v4, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, ""

    const/high16 v6, 0x41800000    # 16.0f

    iget-object v7, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v7, v7, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v8, 0x0

    invoke-virtual {v4, v5, v6, v7, v8}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v4

    iput-object v4, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mPercent:Landroid/widget/TextView;

    .line 129
    iget-object v4, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mPercent:Landroid/widget/TextView;

    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x2

    const/4 v7, -0x2

    invoke-direct {v5, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v4, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 130
    new-instance v3, Landroid/widget/SeekBar;

    invoke-direct {v3, p0}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mSeek:Landroid/widget/SeekBar;

    .line 131
    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mSeek:Landroid/widget/SeekBar;

    const/16 v4, 0x64

    invoke-virtual {v3, v4}, Landroid/widget/SeekBar;->setMax(I)V

    .line 132
    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mSeek:Landroid/widget/SeekBar;

    new-instance v4, Lcom/mrkeyboard/app/MrSoundActivity$2;

    invoke-direct {v4, p0}, Lcom/mrkeyboard/app/MrSoundActivity$2;-><init>(Lcom/mrkeyboard/app/MrSoundActivity;)V

    invoke-virtual {v3, v4}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 144
    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mSeek:Landroid/widget/SeekBar;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v5, 0x8

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 145
    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, ""

    const/high16 v5, 0x41500000    # 13.0f

    iget-object v6, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v6, v6, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v7, 0x0

    invoke-virtual {v3, v4, v5, v6, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v3

    iput-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mNote:Landroid/widget/TextView;

    .line 146
    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mNote:Landroid/widget/TextView;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v5, 0x6

    invoke-virtual {v4, v5}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 149
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_sound_try"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const v4, 0xa0001

    invoke-virtual {v2, v3, v4}, Lcom/mrkeyboard/app/MrKit;->field(Ljava/lang/String;I)Landroid/widget/EditText;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mTry:Landroid/widget/EditText;

    .line 150
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mTry:Landroid/widget/EditText;

    const/4 v3, 0x2

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setMinLines(I)V

    .line 151
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mTry:Landroid/widget/EditText;

    const/16 v3, 0x30

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setGravity(I)V

    .line 152
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mTry:Landroid/widget/EditText;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x10

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 153
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_sound_other_ime"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/high16 v4, 0x41500000    # 13.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v4, v5, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mOtherIme:Landroid/widget/TextView;

    .line 154
    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mOtherIme:Landroid/widget/TextView;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrSoundActivity;->keyboardInUse(Landroid/content/Context;)Z

    move-result v2

    if-eqz v2, :cond_5

    const/16 v2, 0x8

    :goto_4
    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 155
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mOtherIme:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v4, 0x8

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 157
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrSoundActivity;->setContentView(Landroid/view/View;)V

    .line 158
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrSoundActivity;->refresh()V

    .line 159
    if-nez p1, :cond_6

    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mTry:Landroid/widget/EditText;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrScreenIme;->show(Landroid/widget/EditText;)V

    .line 161
    :goto_5
    return-void

    .line 154
    :cond_5
    const/4 v2, 0x0

    goto :goto_4

    .line 160
    :cond_6
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mTry:Landroid/widget/EditText;

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrScreenIme;->restore(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V

    goto :goto_5
.end method

.method protected onResume()V
    .locals 2

    .prologue
    .line 82
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 83
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mOtherIme:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mOtherIme:Landroid/widget/TextView;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrSoundActivity;->keyboardInUse(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/16 v0, 0x8

    :goto_0
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    .line 84
    :cond_0
    return-void

    .line 83
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    .prologue
    .line 76
    invoke-super {p0, p1}, Landroid/app/Activity;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 77
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mTry:Landroid/widget/EditText;

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrScreenIme;->save(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V

    .line 78
    return-void
.end method

.method refresh()V
    .locals 8

    .prologue
    const/4 v2, 0x0

    .line 242
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrSoundActivity;->current()Ljava/lang/String;

    move-result-object v5

    move v1, v2

    .line 243
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mTiles:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_2

    .line 244
    sget-object v0, Lcom/mrkeyboard/app/MrSoundActivity;->TILES:[Ljava/lang/String;

    aget-object v0, v0, v1

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    .line 245
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mTiles:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iget-object v7, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    if-eqz v6, :cond_0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->soft:I

    move v4, v3

    :goto_1
    if-eqz v6, :cond_1

    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->accent:I

    :goto_2
    const/high16 v6, 0x41600000    # 14.0f

    invoke-virtual {v7, v4, v3, v6, v2}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 243
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 245
    :cond_0
    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->card:I

    move v4, v3

    goto :goto_1

    :cond_1
    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->stroke:I

    goto :goto_2

    .line 247
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mPrefs:Landroid/content/SharedPreferences;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeySound;->volume(Landroid/content/SharedPreferences;)F

    move-result v0

    const/high16 v1, 0x42c80000    # 100.0f

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 248
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mSeek:Landroid/widget/SeekBar;

    invoke-virtual {v1, v0}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 249
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mPercent:Landroid/widget/TextView;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "%"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 250
    const-string v0, "mute"

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    const-string v0, "default"

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    const/4 v0, 0x1

    .line 251
    :goto_3
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mSeek:Landroid/widget/SeekBar;

    invoke-virtual {v1, v0}, Landroid/widget/SeekBar;->setEnabled(Z)V

    .line 252
    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mSeek:Landroid/widget/SeekBar;

    if-eqz v0, :cond_5

    const/high16 v1, 0x3f800000    # 1.0f

    :goto_4
    invoke-virtual {v3, v1}, Landroid/widget/SeekBar;->setAlpha(F)V

    .line 253
    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mNote:Landroid/widget/TextView;

    const-string v1, "mute"

    invoke-virtual {v1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_6

    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_sound_muted"

    new-array v5, v2, [Ljava/lang/Object;

    invoke-virtual {v1, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    :goto_5
    invoke-virtual {v3, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 254
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mNote:Landroid/widget/TextView;

    if-eqz v0, :cond_3

    const/16 v2, 0x8

    :cond_3
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 255
    return-void

    :cond_4
    move v0, v2

    .line 250
    goto :goto_3

    .line 252
    :cond_5
    const v1, 0x3ecccccd    # 0.4f

    goto :goto_4

    .line 253
    :cond_6
    const-string v1, "default"

    invoke-virtual {v1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_7

    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v4, "mr_sound_default_note"

    new-array v5, v2, [Ljava/lang/Object;

    invoke-virtual {v1, v4, v5}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    goto :goto_5

    :cond_7
    const-string v1, ""

    goto :goto_5
.end method

.method volumeChanged(I)V
    .locals 5

    .prologue
    .line 230
    const/4 v0, 0x0

    const/16 v1, 0x64

    invoke-static {v1, p1}, Ljava/lang/Math;->min(II)I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 231
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mPrefs:Landroid/content/SharedPreferences;

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "pref_click_volume"

    int-to-float v3, v0

    const/high16 v4, 0x42c80000    # 100.0f

    div-float/2addr v3, v4

    invoke-static {v3}, Ljava/lang/Float;->toString(F)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 232
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mPercent:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "%"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 233
    return-void
.end method

.method volumeLetGo()V
    .locals 2

    .prologue
    .line 236
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrSoundActivity;->current()Ljava/lang/String;

    move-result-object v0

    .line 237
    const-string v1, "mute"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrKeySound;->preview(Landroid/content/Context;Ljava/lang/String;)V

    .line 238
    :cond_0
    return-void
.end method
