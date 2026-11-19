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
    .locals 5

    .prologue
    .line 30
    :try_start_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 31
    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemeColors;->names(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v1

    .line 32
    invoke-static {p0}, Lcom/mrkeyboard/app/MrThemeColors;->values(Landroid/content/Context;)[Ljava/lang/String;

    move-result-object v2

    if-nez v0, :cond_0

    const-string v0, "0"

    :goto_0
    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrThemeColors;->indexOf([Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 33
    array-length v2, v1

    if-ge v0, v2, :cond_1

    aget-object v0, v1, v0

    .line 34
    :goto_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrBackdrop$Spec;

    move-result-object v1

    .line 35
    iget v2, v1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-nez v2, :cond_2

    .line 37
    :goto_2
    return-object v0

    .line 32
    :cond_0
    const-string v3, "pref_keyboard_layout"

    const-string v4, "0"

    invoke-interface {v0, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 33
    :cond_1
    const-string v0, ""

    goto :goto_1

    .line 35
    :cond_2
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " \u00b7 "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->backgroundName(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_2

    .line 36
    :catch_0
    move-exception v0

    .line 37
    const-string v0, ""

    goto :goto_2
.end method

.method private watch(Z)V
    .locals 1

    .prologue
    .line 54
    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemeRow;->mWatched:Landroid/content/SharedPreferences;

    if-nez v0, :cond_1

    .line 55
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemeRow;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemeRow;->mWatched:Landroid/content/SharedPreferences;

    .line 56
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemeRow;->mWatched:Landroid/content/SharedPreferences;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemeRow;->mWatched:Landroid/content/SharedPreferences;

    invoke-interface {v0, p0}, Landroid/content/SharedPreferences;->registerOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 61
    :cond_0
    :goto_0
    return-void

    .line 57
    :cond_1
    if-nez p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemeRow;->mWatched:Landroid/content/SharedPreferences;

    if-eqz v0, :cond_0

    .line 58
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemeRow;->mWatched:Landroid/content/SharedPreferences;

    invoke-interface {v0, p0}, Landroid/content/SharedPreferences;->unregisterOnSharedPreferenceChangeListener(Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;)V

    .line 59
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
    .line 43
    invoke-super {p0, p1}, Landroid/preference/Preference;->onAttachedToHierarchy(Landroid/preference/PreferenceManager;)V

    .line 44
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrThemeRow;->watch(Z)V

    .line 45
    return-void
.end method

.method protected onPrepareForRemoval()V
    .locals 1

    .prologue
    .line 49
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrThemeRow;->watch(Z)V

    .line 50
    invoke-super {p0}, Landroid/preference/Preference;->onPrepareForRemoval()V

    .line 51
    return-void
.end method

.method public onSharedPreferenceChanged(Landroid/content/SharedPreferences;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 64
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

    .line 65
    :cond_1
    return-void
.end method
