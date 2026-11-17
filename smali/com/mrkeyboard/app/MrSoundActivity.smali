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


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/4 v3, 0x4

    const/4 v7, 0x3

    const/4 v6, 0x2

    const/4 v5, 0x1

    const/4 v4, 0x0

    .line 32
    const/16 v0, 0xf

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "mute"

    aput-object v1, v0, v4

    const-string v1, "bubble"

    aput-object v1, v0, v5

    const-string v1, "bell"

    aput-object v1, v0, v6

    const-string v1, "duck"

    aput-object v1, v0, v7

    const-string v1, "keyboard"

    aput-object v1, v0, v3

    const/4 v1, 0x5

    const-string v2, "default"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "bubble2"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "fox"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "pistol"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "wand"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "frog"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "cat"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "drop"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, "rocket"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, "mouse"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrSoundActivity;->TILES:[Ljava/lang/String;

    .line 37
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
    .line 27
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 55
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mTiles:Ljava/util/List;

    return-void
.end method

.method static glyph(Ljava/lang/String;Landroid/graphics/Paint;)Ljava/lang/String;
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 153
    sget-object v2, Lcom/mrkeyboard/app/MrSoundActivity;->GLYPHS:[[Ljava/lang/String;

    array-length v3, v2

    move v0, v1

    :goto_0
    if-ge v0, v3, :cond_3

    aget-object v4, v2, v0

    .line 154
    aget-object v5, v4, v1

    invoke-virtual {v5, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_0

    .line 153
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 155
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

    .line 158
    :goto_2
    return-object v0

    .line 155
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 156
    :cond_2
    array-length v0, v4

    add-int/lit8 v0, v0, -0x1

    aget-object v0, v4, v0

    goto :goto_2

    .line 158
    :cond_3
    const-string v0, ""

    goto :goto_2
.end method

.method private tile(Ljava/lang/String;Landroid/graphics/Paint;)Landroid/widget/LinearLayout;
    .locals 7

    .prologue
    const/4 v6, 0x0

    const/4 v5, -0x2

    .line 131
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 132
    const/16 v0, 0x11

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 133
    const/4 v0, 0x1

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 134
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

    .line 135
    new-instance v0, Lcom/mrkeyboard/app/MrSoundActivity$3;

    invoke-direct {v0, p0, p1}, Lcom/mrkeyboard/app/MrSoundActivity$3;-><init>(Lcom/mrkeyboard/app/MrSoundActivity;Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 140
    const-string v0, "default"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 141
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

    .line 148
    :cond_0
    :goto_1
    return-object v1

    .line 134
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

    .line 143
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

    .line 144
    const-string v0, "bubble"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    const-string v0, "bubble2"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 145
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
    .line 62
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 63
    return-void
.end method

.method choose(Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 169
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mPrefs:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 170
    const-string v1, "mute"

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 171
    const-string v1, "sound_on"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 176
    :goto_0
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 177
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrSoundActivity;->refresh()V

    .line 178
    const-string v0, "mute"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 179
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrKeySound;->preload(Landroid/content/Context;Ljava/lang/String;)V

    .line 180
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrKeySound;->preview(Landroid/content/Context;Ljava/lang/String;)V

    .line 182
    :cond_0
    return-void

    .line 173
    :cond_1
    const-string v1, "sound_on"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 174
    const-string v1, "pref_sound_style"

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    goto :goto_0
.end method

.method current()Ljava/lang/String;
    .locals 3

    .prologue
    .line 163
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mPrefs:Landroid/content/SharedPreferences;

    const-string v1, "sound_on"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "mute"

    .line 164
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
    .line 67
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 68
    new-instance v0, Lcom/mrkeyboard/app/MrKit;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrKit;-><init>(Landroid/app/Activity;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    .line 69
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mPrefs:Landroid/content/SharedPreferences;

    .line 71
    new-instance v4, Landroid/widget/ScrollView;

    invoke-direct {v4, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 72
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v1, v1, Lcom/mrkeyboard/app/MrKit;->bg:I

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v5, 0x0

    invoke-virtual {v0, v1, v2, v3, v5}, Lcom/mrkeyboard/app/MrKit;->round(IIFZ)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {v4, v0}, Landroid/widget/ScrollView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 73
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v5

    .line 74
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v1, 0x41a00000    # 20.0f

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v2, 0x41800000    # 16.0f

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v3, 0x41a00000    # 20.0f

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v6, 0x41c00000    # 24.0f

    invoke-virtual {v3, v6}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v3

    invoke-virtual {v5, v0, v1, v2, v3}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 75
    new-instance v0, Landroid/view/ViewGroup$LayoutParams;

    const/4 v1, -0x1

    const/4 v2, -0x2

    invoke-direct {v0, v1, v2}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v4, v5, v0}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 77
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_sound_title"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrSoundActivity$1;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrSoundActivity$1;-><init>(Lcom/mrkeyboard/app/MrSoundActivity;)V

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrKit;->backHeader(Ljava/lang/String;Landroid/view/View$OnClickListener;)Landroid/widget/LinearLayout;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v2, 0x0

    .line 81
    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    .line 77
    invoke-virtual {v5, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 82
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_sound_styles"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/high16 v2, 0x41800000    # 16.0f

    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v6, 0x1

    invoke-virtual {v0, v1, v2, v3, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0x12

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v5, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 84
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->column()Landroid/widget/LinearLayout;

    move-result-object v6

    .line 85
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v5, v6, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 86
    new-instance v7, Landroid/graphics/Paint;

    const/4 v0, 0x1

    invoke-direct {v7, v0}, Landroid/graphics/Paint;-><init>(I)V

    .line 87
    const/4 v1, 0x0

    .line 88
    const/4 v0, 0x0

    move v3, v0

    move-object v0, v1

    :goto_0
    sget-object v1, Lcom/mrkeyboard/app/MrSoundActivity;->TILES:[Ljava/lang/String;

    array-length v1, v1

    if-ge v3, v1, :cond_4

    .line 89
    rem-int/lit8 v1, v3, 0x5

    if-nez v1, :cond_0

    .line 90
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 91
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    if-nez v3, :cond_1

    const/4 v0, 0x0

    :goto_1
    invoke-virtual {v2, v0}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v0

    invoke-virtual {v6, v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    move-object v0, v1

    .line 93
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrSoundActivity;->TILES:[Ljava/lang/String;

    aget-object v1, v1, v3

    invoke-direct {p0, v1, v7}, Lcom/mrkeyboard/app/MrSoundActivity;->tile(Ljava/lang/String;Landroid/graphics/Paint;)Landroid/widget/LinearLayout;

    move-result-object v8

    .line 94
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mTiles:Ljava/util/List;

    invoke-interface {v1, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 95
    new-instance v9, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, 0x0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v10, 0x42800000    # 64.0f

    invoke-virtual {v2, v10}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    const/high16 v10, 0x3f800000    # 1.0f

    invoke-direct {v9, v1, v2, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 96
    rem-int/lit8 v1, v3, 0x5

    if-nez v1, :cond_2

    const/4 v1, 0x0

    :goto_2
    const/4 v10, 0x0

    rem-int/lit8 v2, v3, 0x5

    const/4 v11, 0x4

    if-ne v2, v11, :cond_3

    const/4 v2, 0x0

    :goto_3
    const/4 v11, 0x0

    invoke-virtual {v9, v1, v10, v2, v11}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 97
    invoke-virtual {v0, v8, v9}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 88
    add-int/lit8 v1, v3, 0x1

    move v3, v1

    goto :goto_0

    .line 91
    :cond_1
    const/16 v0, 0x8

    goto :goto_1

    .line 96
    :cond_2
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v2, 0x40800000    # 4.0f

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v1

    goto :goto_2

    :cond_3
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/high16 v11, 0x40800000    # 4.0f

    invoke-virtual {v2, v11}, Lcom/mrkeyboard/app/MrKit;->dp(F)I

    move-result v2

    goto :goto_3

    .line 100
    :cond_4
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKit;->panel()Landroid/widget/LinearLayout;

    move-result-object v0

    .line 101
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v2, 0x14

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v1

    invoke-virtual {v5, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 102
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKit;->row()Landroid/widget/LinearLayout;

    move-result-object v1

    .line 103
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 104
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_sound_volume"

    const/4 v6, 0x0

    new-array v6, v6, [Ljava/lang/Object;

    invoke-virtual {v3, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/high16 v5, 0x41800000    # 16.0f

    iget-object v6, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v6, v6, Lcom/mrkeyboard/app/MrKit;->text:I

    const/4 v7, 0x1

    invoke-virtual {v2, v3, v5, v6, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, 0x0

    const/4 v6, -0x2

    const/high16 v7, 0x3f800000    # 1.0f

    invoke-direct {v3, v5, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 105
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v3, ""

    const/high16 v5, 0x41800000    # 16.0f

    iget-object v6, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v6, v6, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v7, 0x0

    invoke-virtual {v2, v3, v5, v6, v7}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mPercent:Landroid/widget/TextView;

    .line 106
    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mPercent:Landroid/widget/TextView;

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, -0x2

    const/4 v6, -0x2

    invoke-direct {v3, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 107
    new-instance v1, Landroid/widget/SeekBar;

    invoke-direct {v1, p0}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mSeek:Landroid/widget/SeekBar;

    .line 108
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mSeek:Landroid/widget/SeekBar;

    const/16 v2, 0x64

    invoke-virtual {v1, v2}, Landroid/widget/SeekBar;->setMax(I)V

    .line 109
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mSeek:Landroid/widget/SeekBar;

    new-instance v2, Lcom/mrkeyboard/app/MrSoundActivity$2;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrSoundActivity$2;-><init>(Lcom/mrkeyboard/app/MrSoundActivity;)V

    invoke-virtual {v1, v2}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 121
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mSeek:Landroid/widget/SeekBar;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/16 v3, 0x8

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 122
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, ""

    const/high16 v3, 0x41500000    # 13.0f

    iget-object v5, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v5, v5, Lcom/mrkeyboard/app/MrKit;->text2:I

    const/4 v6, 0x0

    invoke-virtual {v1, v2, v3, v5, v6}, Lcom/mrkeyboard/app/MrKit;->label(Ljava/lang/String;FIZ)Landroid/widget/TextView;

    move-result-object v1

    iput-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mNote:Landroid/widget/TextView;

    .line 123
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mNote:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const/4 v3, 0x6

    invoke-virtual {v2, v3}, Lcom/mrkeyboard/app/MrKit;->wide(I)Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 125
    invoke-virtual {p0, v4}, Lcom/mrkeyboard/app/MrSoundActivity;->setContentView(Landroid/view/View;)V

    .line 126
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrSoundActivity;->refresh()V

    .line 127
    return-void
.end method

.method refresh()V
    .locals 8

    .prologue
    const/4 v2, 0x0

    .line 197
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrSoundActivity;->current()Ljava/lang/String;

    move-result-object v5

    move v1, v2

    .line 198
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mTiles:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_2

    .line 199
    sget-object v0, Lcom/mrkeyboard/app/MrSoundActivity;->TILES:[Ljava/lang/String;

    aget-object v0, v0, v1

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    .line 200
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

    .line 198
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 200
    :cond_0
    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->card:I

    move v4, v3

    goto :goto_1

    :cond_1
    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->k:Lcom/mrkeyboard/app/MrKit;

    iget v3, v3, Lcom/mrkeyboard/app/MrKit;->stroke:I

    goto :goto_2

    .line 202
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mPrefs:Landroid/content/SharedPreferences;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeySound;->volume(Landroid/content/SharedPreferences;)F

    move-result v0

    const/high16 v1, 0x42c80000    # 100.0f

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 203
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mSeek:Landroid/widget/SeekBar;

    invoke-virtual {v1, v0}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 204
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

    .line 205
    const-string v0, "mute"

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    const-string v0, "default"

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    const/4 v0, 0x1

    .line 206
    :goto_3
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mSeek:Landroid/widget/SeekBar;

    invoke-virtual {v1, v0}, Landroid/widget/SeekBar;->setEnabled(Z)V

    .line 207
    iget-object v3, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mSeek:Landroid/widget/SeekBar;

    if-eqz v0, :cond_5

    const/high16 v1, 0x3f800000    # 1.0f

    :goto_4
    invoke-virtual {v3, v1}, Landroid/widget/SeekBar;->setAlpha(F)V

    .line 208
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

    .line 209
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity;->mNote:Landroid/widget/TextView;

    if-eqz v0, :cond_3

    const/16 v2, 0x8

    :cond_3
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 210
    return-void

    :cond_4
    move v0, v2

    .line 205
    goto :goto_3

    .line 207
    :cond_5
    const v1, 0x3ecccccd    # 0.4f

    goto :goto_4

    .line 208
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
    .line 185
    const/4 v0, 0x0

    const/16 v1, 0x64

    invoke-static {v1, p1}, Ljava/lang/Math;->min(II)I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 186
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

    .line 187
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

    .line 188
    return-void
.end method

.method volumeLetGo()V
    .locals 2

    .prologue
    .line 191
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrSoundActivity;->current()Ljava/lang/String;

    move-result-object v0

    .line 192
    const-string v1, "mute"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrKeySound;->preview(Landroid/content/Context;Ljava/lang/String;)V

    .line 193
    :cond_0
    return-void
.end method
