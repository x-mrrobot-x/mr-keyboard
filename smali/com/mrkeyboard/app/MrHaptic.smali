.class public final Lcom/mrkeyboard/app/MrHaptic;
.super Ljava/lang/Object;
.source "MrHaptic.java"

# The vibration of a key press. The user sets a STRENGTH (1..100 %, "vibrate_strength"), not a duration in milliseconds: a one-shot pulse
# of 1 ms is only the start and the stop of the motor (the actuator keeps ringing after it), which is what felt rough. The phone
# is asked for a short, clear click and plays it with its own tuning. Each device takes the first of these it can do:
#
#   1. primitives (API 30+, when the device supports TICK and CLICK): TICK scaled by strength/50 up to 50 %, CLICK scaled by strength/100 above
#   2. predefined effect (API 29+): TICK up to 50 %, CLICK up to 80 %, HEAVY_CLICK above
#   3. the system haptic of the keyboard (View.performHapticFeedback KEYBOARD_TAP): no strength, but the device's own tuning
#   4. a short one-shot (15 ms), with the amplitude from the strength when the motor has amplitude control. Only with no keyboard view
#      (nothing to ask the system haptic of) or on a phone that has none.
#
# The effect of a strength is built once (sStrength, sEffect: null when the device has none for it) and reused at every key press.
# From API 33 the vibration is played with the usage "touch" (VibrationAttributes), as before. See docs/haptics.md.

# static fields
# VibrationAttributes (API 33) of the usage "touch", made at the first use.
.field private static sAttrs:Landroid/os/VibrationAttributes;

# The effect built for sStrength (1..100), or null when the device has no effect for it (tiers 3 and 4 then).
.field private static sEffect:Landroid/os/VibrationEffect;

# The strength sEffect was built for; 0 = nothing built yet.
.field private static sStrength:I

# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

# Tier 1 (API 30): a primitive of the composition, or null when the device does not support both TICK (7) and CLICK (1).
.method private static composed(Landroid/os/Vibrator;I)Landroid/os/VibrationEffect;
    .locals 4

    const/4 v0, 0x2

    new-array v0, v0, [I

    const/4 v1, 0x0

    const/4 v2, 0x7

    aput v2, v0, v1

    const/4 v1, 0x1

    aput v1, v0, v1

    invoke-virtual {p0, v0}, Landroid/os/Vibrator;->areAllPrimitivesSupported([I)Z

    move-result v0

    if-nez v0, :cond_supported

    const/4 v0, 0x0

    return-object v0

    :cond_supported
    const/16 v0, 0x32

    if-gt p1, v0, :cond_click

    # up to 50 %: TICK at strength / 50
    const/4 v1, 0x7

    int-to-float v2, p1

    int-to-float v3, v0

    div-float/2addr v2, v3

    goto :goto_compose

    # above 50 %: CLICK at strength / 100
    :cond_click
    const/4 v1, 0x1

    int-to-float v2, p1

    const/high16 v3, 0x42c80000    # 100.0f

    div-float/2addr v2, v3

    :goto_compose
    invoke-static {}, Landroid/os/VibrationEffect;->startComposition()Landroid/os/VibrationEffect$Composition;

    move-result-object v0

    invoke-virtual {v0, v1, v2}, Landroid/os/VibrationEffect$Composition;->addPrimitive(IF)Landroid/os/VibrationEffect$Composition;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/VibrationEffect$Composition;->compose()Landroid/os/VibrationEffect;

    move-result-object v0

    return-object v0
.end method

# The effect for a strength: the cached one, or built now (tier 1, then tier 2). Null when the device has none.
.method private static effect(Landroid/os/Vibrator;I)Landroid/os/VibrationEffect;
    .locals 3

    sget v0, Lcom/mrkeyboard/app/MrHaptic;->sStrength:I

    if-ne v0, p1, :cond_build

    sget-object v0, Lcom/mrkeyboard/app/MrHaptic;->sEffect:Landroid/os/VibrationEffect;

    return-object v0

    :cond_build
    const/4 v0, 0x0

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1d

    if-lt v1, v2, :goto_store

    const/16 v2, 0x1e

    if-lt v1, v2, :cond_predefined

    :try_start_0
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrHaptic;->composed(Landroid/os/Vibrator;I)Landroid/os/VibrationEffect;

    move-result-object v0

    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_check
    if-nez v0, :goto_store

    :cond_predefined
    :try_start_1
    invoke-static {p1}, Lcom/mrkeyboard/app/MrHaptic;->predefined(I)Landroid/os/VibrationEffect;

    move-result-object v0

    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :goto_store
    sput-object v0, Lcom/mrkeyboard/app/MrHaptic;->sEffect:Landroid/os/VibrationEffect;

    sput p1, Lcom/mrkeyboard/app/MrHaptic;->sStrength:I

    return-object v0

    # the composition threw: the predefined effect is tried
    :catch_0
    const/4 v0, 0x0

    goto :goto_check

    # the predefined effect threw: this device has no effect (the system haptic or the one-shot)
    :catch_1
    const/4 v0, 0x0

    goto :goto_store
.end method

# Tier 4: a short one-shot. The amplitude follows the strength when the motor has amplitude control.
.method private static legacy(Landroid/os/Vibrator;I)V
    .locals 4

    const/4 v0, -0x1

    invoke-virtual {p0}, Landroid/os/Vibrator;->hasAmplitudeControl()Z

    move-result v1

    if-eqz v1, :goto_go

    mul-int/lit16 v0, p1, 0xff

    div-int/lit8 v0, v0, 0x64

    if-gtz v0, :goto_go

    const/4 v0, 0x1

    :goto_go
    const-wide/16 v2, 0xf

    invoke-static {v2, v3, v0}, Landroid/os/VibrationEffect;->createOneShot(JI)Landroid/os/VibrationEffect;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrHaptic;->send(Landroid/os/Vibrator;Landroid/os/VibrationEffect;)V

    return-void
.end method

# The strength saved in the settings: the slider keeps a fraction as text ("0.5"), 1..100 here. 50 when it is missing or unreadable.
.method public static level(Landroid/content/SharedPreferences;)I
    .locals 3

    const-string v0, "vibrate_strength"

    const-string v1, "0.5"

    invoke-interface {p0, v0, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :try_start_0
    invoke-static {v0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v0

    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/high16 v1, 0x42c80000    # 100.0f

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    const/4 v1, 0x1

    if-ge v0, v1, :goto_low

    move v0, v1

    :goto_low
    const/16 v1, 0x64

    if-le v0, v1, :goto_high

    move v0, v1

    :goto_high
    return v0

    :catch_0
    const/16 v0, 0x32

    return v0
.end method

# Called for every key press (LatinIME.vibrate): strength 1..100, the keyboard view for the system haptic (may be null).
.method public static play(Landroid/content/Context;ILandroid/view/View;)V
    .locals 4

    const/4 v0, 0x1

    if-ge p1, v0, :goto_min

    move p1, v0

    :goto_min
    const/16 v0, 0x64

    if-le p1, v0, :goto_max

    move p1, v0

    :goto_max
    const-string v0, "vibrator"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/Vibrator;

    if-eqz v0, :cond_system

    invoke-virtual {v0}, Landroid/os/Vibrator;->hasVibrator()Z

    move-result v1

    if-nez v1, :cond_has

    # no motor: v0 = null, so that tier 4 is skipped
    const/4 v0, 0x0

    goto :cond_system

    :cond_has
    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrHaptic;->effect(Landroid/os/Vibrator;I)Landroid/os/VibrationEffect;

    move-result-object v1

    if-eqz v1, :cond_system

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrHaptic;->send(Landroid/os/Vibrator;Landroid/os/VibrationEffect;)V

    return-void

    # tier 3: KEYBOARD_TAP (3); before API 33 with FLAG_IGNORE_GLOBAL_SETTING (2), as the keyboard always did
    :cond_system
    if-eqz p2, :cond_legacy

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x21

    const/4 v3, 0x3

    if-lt v1, v2, :cond_flag

    invoke-virtual {p2, v3}, Landroid/view/View;->performHapticFeedback(I)Z

    return-void

    :cond_flag
    const/4 v1, 0x2

    invoke-virtual {p2, v3, v1}, Landroid/view/View;->performHapticFeedback(II)Z

    return-void

    :cond_legacy
    if-eqz v0, :cond_end

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrHaptic;->legacy(Landroid/os/Vibrator;I)V

    :cond_end
    return-void
.end method

# Tier 2 (API 29): TICK (2) up to 50 %, CLICK (0) up to 80 %, HEAVY_CLICK (5) above.
.method private static predefined(I)Landroid/os/VibrationEffect;
    .locals 2

    const/16 v0, 0x32

    if-gt p0, v0, :cond_click

    const/4 v0, 0x2

    goto :goto_make

    :cond_click
    const/16 v0, 0x50

    if-gt p0, v0, :cond_heavy

    const/4 v0, 0x0

    goto :goto_make

    :cond_heavy
    const/4 v0, 0x5

    :goto_make
    invoke-static {v0}, Landroid/os/VibrationEffect;->createPredefined(I)Landroid/os/VibrationEffect;

    move-result-object v0

    return-object v0
.end method

# Plays the effect: from API 33 with the usage "touch" (0x12), as the keyboard did.
.method private static send(Landroid/os/Vibrator;Landroid/os/VibrationEffect;)V
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x21

    if-lt v0, v1, :cond_plain

    sget-object v0, Lcom/mrkeyboard/app/MrHaptic;->sAttrs:Landroid/os/VibrationAttributes;

    if-nez v0, :goto_have

    const/16 v0, 0x12

    invoke-static {v0}, Landroid/os/VibrationAttributes;->createForUsage(I)Landroid/os/VibrationAttributes;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrHaptic;->sAttrs:Landroid/os/VibrationAttributes;

    :goto_have
    invoke-virtual {p0, p1, v0}, Landroid/os/Vibrator;->vibrate(Landroid/os/VibrationEffect;Landroid/os/VibrationAttributes;)V

    return-void

    :cond_plain
    invoke-virtual {p0, p1}, Landroid/os/Vibrator;->vibrate(Landroid/os/VibrationEffect;)V

    return-void
.end method
