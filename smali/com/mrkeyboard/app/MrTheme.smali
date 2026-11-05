.class final Lcom/mrkeyboard/app/MrTheme;

.super Ljava/lang/Object;

.source "MrTheme.java"

# Single detection of the keyboard theme. Each theme layout carries a tag on the LatinKeyboardView
# (mr_neon, mr_soft, mr_slate, mr_midnight, mr_glass) and this class converts it into capability
# flags, read from mr_theme_tags and mr_theme_flags (res/values/mr_themes.xml). No other place in the code should compare text color or tag to find out the theme.
#
# Flags (bits):
#   INIT              0x01  flags already computed (value 0 = not computed yet)
#   FLAT_BAR          0x02  flat toolbar and panels (Midnight, Glass)
#   ACCENT_KEYS       0x04  accent keys painted by the drawable btn_keyboard_key_<theme>_accent (every theme
#                           with a tag; a view without a tag, like the variants popup, has no accent)
#   ACCENT_WIDE       0x08  extended accent group: besides the keys of the fixed list, every isModifier key,
#                           the Tasker keys (text "tskcmd:"), 123/TSK, Space and Enter come in (all themes turn it on;
#                           turning it off removes only this group)
#   TRANSLUCENT       0x10  translucent theme, with background blur (Glass)
#   TECH_PALETTE      0x20  dark "tech" palette with text #e7eef7 (Slate, Midnight, Glass)
#   PLAIN_ACCENT_TEXT 0x40  accent keys use the theme's default text (Slate, Midnight, Glass); without the flag
#                           the text and icon come from the color mr_<theme>_accent_text (Neon, Soft)
.field static final INIT:I = 0x1

.field static final FLAT_BAR:I = 0x2

.field static final ACCENT_KEYS:I = 0x4

.field static final ACCENT_WIDE:I = 0x8

.field static final TRANSLUCENT:I = 0x10

.field static final TECH_PALETTE:I = 0x20

.field static final PLAIN_ACCENT_TEXT:I = 0x40

# Flags of the current keyboard (same as MrTools.sKbd), for the bar and the panels.
.field private static sFlags:I

# Tag of the current keyboard layout (mr_glass, mr_midnight...); null when there is no keyboard.
.field private static sTag:Ljava/lang/String;


# p0 = context, p1 = layout tag (String or null). Looks the tag up in mr_theme_tags and returns the flag at the same position
# in mr_theme_flags. Always returns with the INIT bit on; an unknown tag or missing resource returns only INIT.
.method static flags(Landroid/content/Context;Ljava/lang/Object;)I
    .locals 8

    const/4 v0, 0x1

    if-eqz p0, :cond_done

    if-eqz p1, :cond_done

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const-string v4, "array"

    const-string v3, "mr_theme_tags"

    invoke-virtual {v1, v3, v4, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v1, v3}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v3

    const-string v5, "mr_theme_flags"

    invoke-virtual {v1, v5, v4, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    invoke-virtual {v1, v5}, Landroid/content/res/Resources;->getIntArray(I)[I

    move-result-object v5

    const/4 v6, 0x0

    array-length v7, v3

    :goto_loop
    if-ge v6, v7, :cond_done

    aget-object v2, v3, v6

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_next

    aget v2, v5, v6

    or-int/lit8 v0, v2, 0x1

    goto :cond_done

    :cond_next
    add-int/lit8 v6, v6, 0x1

    goto :goto_loop
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_done
    return v0

    :catch_0
    move-exception v1

    const/4 v0, 0x1

    return v0
.end method

# Stores the flags and tag of the keyboard that was just created (MrTools.wrap). null clears.
.method static attach(Landroid/view/View;)V
    .locals 2

    if-nez p0, :cond_have

    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->clear()V

    return-void

    :cond_have
    invoke-virtual {p0}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrTheme;->flags(Landroid/content/Context;Ljava/lang/Object;)I

    move-result v1

    sput v1, Lcom/mrkeyboard/app/MrTheme;->sFlags:I

    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_nostr

    check-cast v0, Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrTheme;->sTag:Ljava/lang/String;

    return-void

    :cond_nostr
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrTheme;->sTag:Ljava/lang/String;

    return-void
.end method

.method static clear()V
    .locals 1

    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrTheme;->sFlags:I

    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrTheme;->sTag:Ljava/lang/String;

    return-void
.end method

# Color of a role (e.g. "panel_btn") read from colors.xml by name: first <theme tag>_<role>
# (mr_glass_panel_btn), then mr_<role> (mr_panel_btn). Without the color, returns opaque magenta so the error
# shows up on screen instead of crashing the keyboard.
.method static color(Ljava/lang/String;)I
    .locals 6

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    if-nez v0, :cond_ctx

    const v0, -0xff01

    return v0

    :cond_ctx
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "color"

    sget-object v4, Lcom/mrkeyboard/app/MrTheme;->sTag:Ljava/lang/String;

    if-eqz v4, :cond_default

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, "_"

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4, v3, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    if-eqz v4, :cond_default

    invoke-virtual {v1, v4}, Landroid/content/res/Resources;->getColor(I)I

    move-result v4

    return v4

    :cond_default
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "mr_"

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4, v3, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    if-nez v4, :cond_found

    const v0, -0xff01

    return v0

    :cond_found
    invoke-virtual {v1, v4}, Landroid/content/res/Resources;->getColor(I)I

    move-result v4

    return v4
.end method

# Flat toolbar and panels (formerly MrTools.isMidnight, which already applied to Glass).
.method static flatBar()Z
    .locals 1

    sget v0, Lcom/mrkeyboard/app/MrTheme;->sFlags:I

    and-int/lit8 v0, v0, 0x2

    if-eqz v0, :cond_no

    const/4 v0, 0x1

    return v0

    :cond_no
    const/4 v0, 0x0

    return v0
.end method

# Translucent theme with background blur (formerly MrTools.isGlass).
.method static translucent()Z
    .locals 1

    sget v0, Lcom/mrkeyboard/app/MrTheme;->sFlags:I

    and-int/lit8 v0, v0, 0x10

    if-eqz v0, :cond_no

    const/4 v0, 0x1

    return v0

    :cond_no
    const/4 v0, 0x0

    return v0
.end method

# Dark "tech" palette (text #e7eef7): Slate, Midnight and Glass. It used to be a sTextColor comparison.
.method static techPalette()Z
    .locals 1

    sget v0, Lcom/mrkeyboard/app/MrTheme;->sFlags:I

    and-int/lit8 v0, v0, 0x20

    if-eqz v0, :cond_no

    const/4 v0, 0x1

    return v0

    :cond_no
    const/4 v0, 0x0

    return v0
.end method
