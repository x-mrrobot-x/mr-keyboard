.class final Lcom/mrkeyboard/app/MrThemeColors;
.super Ljava/lang/Object;
.source "MrThemeColors.java"


# static fields
.field static final NONE:I = -0xff01


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static array(Landroid/content/Context;Ljava/lang/String;)[Ljava/lang/String;
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 50
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 51
    const-string v1, "array"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 52
    if-nez v1, :cond_1

    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/String;

    .line 56
    :cond_0
    :goto_0
    return-object v0

    .line 53
    :cond_1
    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v0

    .line 54
    if-nez v0, :cond_0

    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 55
    :catch_0
    move-exception v0

    .line 56
    new-array v0, v3, [Ljava/lang/String;

    goto :goto_0
.end method

.method static color(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I
    .locals 5

    .prologue
    const v0, -0xff01

    .line 63
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    .line 64
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    .line 65
    if-eqz p1, :cond_1

    .line 66
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v4, "color"

    invoke-virtual {v1, v3, v4, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    .line 67
    if-eqz v3, :cond_1

    invoke-virtual {v1, v3}, Landroid/content/res/Resources;->getColor(I)I

    move-result v0

    .line 72
    :cond_0
    :goto_0
    return v0

    .line 69
    :cond_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "mr_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v4, "color"

    invoke-virtual {v1, v3, v4, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 70
    if-eqz v2, :cond_0

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getColor(I)I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_0

    .line 71
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I
    .locals 2

    .prologue
    .line 78
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrThemeColors;->color(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 79
    const v1, -0xff01

    if-ne v0, v1, :cond_0

    :goto_0
    return p3

    :cond_0
    move p3, v0

    goto :goto_0
.end method

.method static dark(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 3

    .prologue
    .line 104
    const/high16 v0, -0x1000000

    const-string v1, "kbd_bg"

    const v2, -0xdfdfe0

    invoke-static {p0, p1, v1, v2}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v1

    or-int/2addr v0, v1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrThemeColors;->luminance(I)F

    move-result v0

    const/high16 v1, 0x3f000000    # 0.5f

    cmpg-float v0, v0, v1

    if-gez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static declared(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 87
    invoke-static {p0, p1, p2}, Lcom/mrkeyboard/app/MrThemeColors;->color(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 88
    const v1, -0xff01

    if-ne v0, v1, :cond_0

    const/4 v0, 0x0

    :cond_0
    return v0
.end method

.method static indexOf([Ljava/lang/String;Ljava/lang/String;)I
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 42
    move v0, v1

    :goto_0
    array-length v2, p0

    if-ge v0, v2, :cond_1

    .line 43
    aget-object v2, p0, v0

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 45
    :goto_1
    return v0

    .line 42
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    move v0, v1

    .line 45
    goto :goto_1
.end method

.method static ink(Landroid/content/Context;Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 93
    const-string v0, "tool_ink"

    invoke-static {p0, p1, v0}, Lcom/mrkeyboard/app/MrThemeColors;->declared(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 94
    if-eqz v0, :cond_0

    const/high16 v1, -0x1000000

    or-int/2addr v0, v1

    .line 95
    :goto_0
    return v0

    :cond_0
    const-string v0, "text"

    const/4 v1, -0x1

    invoke-static {p0, p1, v0, v1}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    goto :goto_0
.end method

.method static keyDrawable(Landroid/content/Context;Ljava/lang/String;Z)I
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 117
    if-nez p1, :cond_0

    .line 122
    :goto_0
    return v0

    .line 119
    :cond_0
    :try_start_0
    const-string v1, "mr_"

    invoke-virtual {p1, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    const/4 v1, 0x3

    invoke-virtual {p1, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    .line 120
    :cond_1
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "btn_keyboard_key_"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    if-eqz p2, :cond_2

    const-string v1, "_accent"

    :goto_1
    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v3, "drawable"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v1, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    :cond_2
    const-string v1, ""
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 121
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static luminance(I)F
    .locals 4

    .prologue
    const/high16 v3, 0x437f0000    # 255.0f

    .line 109
    shr-int/lit8 v0, p0, 0x10

    and-int/lit16 v0, v0, 0xff

    int-to-float v0, v0

    div-float/2addr v0, v3

    .line 110
    shr-int/lit8 v1, p0, 0x8

    and-int/lit16 v1, v1, 0xff

    int-to-float v1, v1

    div-float/2addr v1, v3

    .line 111
    and-int/lit16 v2, p0, 0xff

    int-to-float v2, v2

    div-float/2addr v2, v3

    .line 112
    const v3, 0x3e59b3d0    # 0.2126f

    mul-float/2addr v0, v3

    const v3, 0x3f371759    # 0.7152f

    mul-float/2addr v1, v3

    add-float/2addr v0, v1

    const v1, 0x3d93dd98    # 0.0722f

    mul-float/2addr v1, v2

    add-float/2addr v0, v1

    return v0
.end method

.method static names(Landroid/content/Context;)[Ljava/lang/String;
    .locals 1

    .prologue
    .line 24
    const-string v0, "keyboard_layout_modes"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrThemeColors;->array(Landroid/content/Context;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static tags(Landroid/content/Context;)[Ljava/lang/String;
    .locals 1

    .prologue
    .line 19
    const-string v0, "mr_theme_tags"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrThemeColors;->array(Landroid/content/Context;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static values(Landroid/content/Context;)[Ljava/lang/String;
    .locals 4

    .prologue
    .line 32
    const-string v0, "keyboard_layout_modes_values"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrThemeColors;->array(Landroid/content/Context;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 33
    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemeColors;->tags(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v1

    array-length v2, v1

    .line 34
    array-length v1, v0

    if-ne v1, v2, :cond_1

    .line 37
    :cond_0
    return-object v0

    .line 35
    :cond_1
    new-array v0, v2, [Ljava/lang/String;

    .line 36
    const/4 v1, 0x0

    :goto_0
    if-ge v1, v2, :cond_0

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method
