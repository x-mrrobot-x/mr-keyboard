.class public Lcom/mrkeyboard/app/VibratePreference;
.super Lcom/mrkeyboard/app/SeekBarPreferenceString;
.source "VibratePreference.java"


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    .line 8
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/SeekBarPreferenceString;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method


# virtual methods
.method public onChange(F)V
    .locals 2

    .line 13
    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    if-eqz v0, :cond_0

    # the slider value is a fraction (0.05..1.0): the strength is in per cent (5..100)
    const/high16 v1, 0x42c80000    # 100.0f

    mul-float/2addr p1, v1

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    .line 14
    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/LatinIME;->vibrate(I)V

    :cond_0
    return-void
.end method
