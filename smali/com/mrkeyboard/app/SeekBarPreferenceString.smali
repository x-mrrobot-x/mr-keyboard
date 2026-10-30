.class public Lcom/mrkeyboard/app/SeekBarPreferenceString;
.super Lcom/mrkeyboard/app/SeekBarPreference;
.source "SeekBarPreferenceString.java"


# static fields
.field private static FLOAT_RE:Ljava/util/regex/Pattern;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "(\\d+\\.?\\d*).*"

    .line 18
    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/SeekBarPreferenceString;->FLOAT_RE:Ljava/util/regex/Pattern;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    .line 21
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/SeekBarPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 22
    invoke-virtual {p0, p1, p2}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->init(Landroid/content/Context;Landroid/util/AttributeSet;)V

    invoke-direct {p0}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->isLive()Z

    move-result p1

    if-eqz p1, :cond_live

    const p1, 0x7f0a003c

    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->setDialogLayoutResource(I)V

    :cond_live
    return-void
.end method

.method private floatFromString(Ljava/lang/String;)F
    .locals 1

    .line 27
    sget-object v0, Lcom/mrkeyboard/app/SeekBarPreferenceString;->FLOAT_RE:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p1

    .line 28
    invoke-virtual {p1}, Ljava/util/regex/Matcher;->matches()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    const/4 v0, 0x1

    .line 29
    invoke-virtual {p1, v0}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Float;->valueOf(Ljava/lang/String;)Ljava/lang/Float;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Float;->floatValue()F

    move-result p1

    return p1
.end method


# virtual methods
.method private isLive()Z
    .locals 2

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->getKey()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    const-string v1, "settings_height"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_end

    const-string v1, "pref_top_row_scale"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_end

    const-string v1, "pref_label_scale_v2"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_end

    const-string v1, "pref_candidate_scale"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_end

    const-string v1, "pref_key_spacing"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_end

    const-string v1, "pref_key_radius"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    :cond_end
    return v1
.end method

.method protected needInputMethod()Z
    .locals 1

    invoke-direct {p0}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->isLive()Z

    move-result v0

    return v0
.end method

.method public onChange(F)V
    .locals 1

    invoke-direct {p0}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->isLive()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p1}, Ljava/lang/Float;->toString(F)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->persistString(Ljava/lang/String;)Z

    :cond_0
    return-void
.end method

.method protected onDialogClosed(Z)V
    .locals 0

    if-nez p1, :cond_0

    .line 50
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->restoreVal()V

    invoke-direct {p0}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->isLive()Z

    move-result p1

    if-eqz p1, :cond_end

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->getValString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->persistString(Ljava/lang/String;)Z

    :cond_end
    return-void

    .line 53
    :cond_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->shouldPersist()Z

    move-result p1

    if-eqz p1, :cond_1

    .line 54
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->savePrevVal()V

    .line 55
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->getValString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->persistString(Ljava/lang/String;)Z

    .line 57
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->notifyChanged()V

    return-void
.end method

.method protected onGetDefaultValue(Landroid/content/res/TypedArray;I)Ljava/lang/Float;
    .locals 0

    .line 34
    invoke-virtual {p1, p2}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->floatFromString(Ljava/lang/String;)F

    move-result p1

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p1

    return-object p1
.end method

.method protected bridge synthetic onGetDefaultValue(Landroid/content/res/TypedArray;I)Ljava/lang/Object;
    .locals 0

    .line 16
    invoke-virtual {p0, p1, p2}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->onGetDefaultValue(Landroid/content/res/TypedArray;I)Ljava/lang/Float;

    move-result-object p1

    return-object p1
.end method

.method protected onSetInitialValue(ZLjava/lang/Object;)V
    .locals 0

    if-eqz p1, :cond_0

    const-string p1, "0.0"

    .line 40
    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->getPersistedString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->floatFromString(Ljava/lang/String;)F

    move-result p1

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->setVal(Ljava/lang/Float;)V

    goto :goto_0

    .line 42
    :cond_0
    check-cast p2, Ljava/lang/Float;

    invoke-virtual {p2}, Ljava/lang/Float;->floatValue()F

    move-result p1

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->setVal(Ljava/lang/Float;)V

    .line 44
    :goto_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SeekBarPreferenceString;->savePrevVal()V

    return-void
.end method
