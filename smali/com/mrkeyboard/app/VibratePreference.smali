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
    .locals 1

    .line 13
    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;

    if-eqz v0, :cond_0

    float-to-int p1, p1

    .line 14
    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/LatinIME;->vibrate(I)V

    :cond_0
    return-void
.end method
