.class public Lcom/mrkeyboard/app/MrThemeRow;
.super Landroid/preference/Preference;
.source "MrThemeRow.java"

# interfaces
.implements Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;


# instance fields
.field private mWatched:Landroid/content/SharedPreferences;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0, p1, p2}, Landroid/preference/Preference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 20
    return-void
.end method

.method static summary(Landroid/content/Context;)Ljava/lang/String;
    .locals 6

    .prologue
    .line 33
    :try_start_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 34
    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemeColors;->tags(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v1

    .line 35
    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemeColors;->names(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v2

    .line 36
    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemeColors;->values(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v3

    if-nez v0, :cond_0

    const-string v0, "0"

    :goto_0
    invoke-static {v3, v0}, Lcom/mrkeyboard/app/MrThemeColors;->indexOf([Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 37
    array-length v3, v1

    if-ge v0, v3, :cond_1

    aget-object v1, v1, v0

    invoke-static {v1}, Lcom/mrkeyboard/app/MrThemeColors;->hidden(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 38
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrThemesActivity;->backgroundName(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;

    move-result-object v0

    .line 42
    :goto_1
    return-object v0

    .line 36
    :cond_0
    const-string v4, "pref_keyboard_layout"

    const-string v5, "0"

    invoke-interface {v0, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 40
    :cond_1
    array-length v1, v2

    if-ge v0, v1, :cond_2

    aget-object v0, v2, v0

    goto :goto_1

    :cond_2
    const-string v0, ""
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 41
    :catch_0
    move-exception v0

    .line 42
    const-string v0, ""

    goto :goto_1
.end method

.method private watch(Z)V
    .locals 1

    .prologue
    .line 59
    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemeRow;->mWatched:Landroid/content/SharedPreferences;

    if-nez v0, :cond_1

    .line 60
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemeRow;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemeRow;->mWatched:Landroid/content/SharedPreferences;

    .line 61
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemeRow;->mWatched:Landroid/content/SharedPreferences;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemeRow;->mWatched:Landroid/content/SharedPreferences;

    invoke-interface {v0, p0}, Landroid/content/SharedPreferences;->registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 66
    :cond_0
    :goto_0
    return-void

    .line 62
    :cond_1
    if-nez p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemeRow;->mWatched:Landroid/content/SharedPreferences;

    if-eqz v0, :cond_0

    .line 63
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemeRow;->mWatched:Landroid/content/SharedPreferences;

    invoke-interface {v0, p0}, Landroid/content/SharedPreferences;->unregisterOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 64
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemeRow;->mWatched:Landroid/content/SharedPreferences;

    goto :goto_0
.end method


# virtual methods
.method public getSummary()Ljava/lang/CharSequence;
    .locals 1

    .prologue
    .line 24
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemeRow;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrThemeRow;->summary(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected onAttachedToHierarchy(Landroid/preference/PreferenceManager;)V
    .locals 1

    .prologue
    .line 48
    invoke-super {p0, p1}, Landroid/preference/Preference;->onAttachedToHierarchy(Landroid/preference/PreferenceManager;)V

    .line 49
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrThemeRow;->watch(Z)V

    .line 50
    return-void
.end method

.method protected onPrepareForRemoval()V
    .locals 1

    .prologue
    .line 54
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrThemeRow;->watch(Z)V

    .line 55
    invoke-super {p0}, Landroid/preference/Preference;->onPrepareForRemoval()V

    .line 56
    return-void
.end method

.method public onSharedPreferenceChanged(Landroid/content/SharedPreferences;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 69
    const-string v0, "pref_keyboard_layout"

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "pref_kbd_bg"

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemeRow;->notifyChanged()V

    .line 70
    :cond_1
    return-void
.end method
