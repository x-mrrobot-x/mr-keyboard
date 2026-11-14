.class public final Lcom/mrkeyboard/app/MrReset;
.super Ljava/lang/Object;
.source "MrReset.java"

# interfaces
.implements Landroid/preference/Preference$OnPreferenceClickListener;


# static fields
.field static final KEYS:[Ljava/lang/String;


# instance fields
.field private final mContext:Landroid/content/Context;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 25
    const/16 v0, 0x3c

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "pref_keyboard_layout"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "settings_height_portrait"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "settings_height_landscape"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "pref_bar_scale"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "pref_keyboard_mode_portrait"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "pref_keyboard_mode_landscape"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "show_settings_key"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "auto_cap"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "voice_mode"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "pref_long_press_duration"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "pref_popup_content"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "pref_ui_language"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "keyboard_notification"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, "pref_key_spacing"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, "pref_key_radius"

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, "pref_hint_mode"

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, "pref_label_scale_v2"

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, "vibrate_on"

    aput-object v2, v0, v1

    const/16 v1, 0x12

    const-string v2, "vibrate_strength"

    aput-object v2, v0, v1

    const/16 v1, 0x13

    const-string v2, "sound_on"

    aput-object v2, v0, v1

    const/16 v1, 0x14

    const-string v2, "pref_click_volume"

    aput-object v2, v0, v1

    const/16 v1, 0x15

    const-string v2, "popup_on"

    aput-object v2, v0, v1

    const/16 v1, 0x16

    const-string v2, "pref_swipe_up"

    aput-object v2, v0, v1

    const/16 v1, 0x17

    const-string v2, "pref_swipe_down"

    aput-object v2, v0, v1

    const/16 v1, 0x18

    const-string v2, "pref_swipe_left"

    aput-object v2, v0, v1

    const/16 v1, 0x19

    const-string v2, "pref_swipe_right"

    aput-object v2, v0, v1

    const/16 v1, 0x1a

    const-string v2, "pref_vol_up"

    aput-object v2, v0, v1

    const/16 v1, 0x1b

    const-string v2, "pref_vol_down"

    aput-object v2, v0, v1

    const/16 v1, 0x1c

    const-string v2, "pref_ctrl_a_override"

    aput-object v2, v0, v1

    const/16 v1, 0x1d

    const-string v2, "pref_chording_ctrl_key"

    aput-object v2, v0, v1

    const/16 v1, 0x1e

    const-string v2, "pref_chording_alt_key"

    aput-object v2, v0, v1

    const/16 v1, 0x1f

    const-string v2, "fullscreen_override"

    aput-object v2, v0, v1

    const/16 v1, 0x20

    const-string v2, "force_keyboard_on"

    aput-object v2, v0, v1

    const/16 v1, 0x21

    const-string v2, "pref_ui_hw_accel"

    aput-object v2, v0, v1

    const/16 v1, 0x22

    const-string v2, "pref_mr_echo_defer"

    aput-object v2, v0, v1

    const/16 v1, 0x23

    const-string v2, "show_suggestions"

    aput-object v2, v0, v1

    const/16 v1, 0x24

    const-string v2, "auto_complete"

    aput-object v2, v0, v1

    const/16 v1, 0x25

    const-string v2, "quick_fixes"

    aput-object v2, v0, v1

    const/16 v1, 0x26

    const-string v2, "recorrection_enabled"

    aput-object v2, v0, v1

    const/16 v1, 0x27

    const-string v2, "suggestions_in_landscape"

    aput-object v2, v0, v1

    const/16 v1, 0x28

    const-string v2, "pref_ai_provider"

    aput-object v2, v0, v1

    const/16 v1, 0x29

    const-string v2, "pref_ai_endpoint"

    aput-object v2, v0, v1

    const/16 v1, 0x2a

    const-string v2, "pref_ai_model"

    aput-object v2, v0, v1

    const/16 v1, 0x2b

    const-string v2, "pref_ai_key"

    aput-object v2, v0, v1

    const/16 v1, 0x2c

    const-string v2, "pref_candidate_scale"

    aput-object v2, v0, v1

    const/16 v1, 0x2d

    const-string v2, "pref_gesture_typing"

    aput-object v2, v0, v1

    const/16 v1, 0x2e

    const-string v2, "pref_gesture_trail"

    aput-object v2, v0, v1

    const/16 v1, 0x2f

    const-string v2, "pref_gesture_preview"

    aput-object v2, v0, v1

    const/16 v1, 0x30

    const-string v2, "pref_sugg_idle"

    aput-object v2, v0, v1

    const/16 v1, 0x31

    const-string v2, "pref_sheet_return"

    aput-object v2, v0, v1

    const/16 v1, 0x32

    const-string v2, "pref_render_mode"

    aput-object v2, v0, v1

    const/16 v1, 0x33

    const-string v2, "pref_slide_keys_int"

    aput-object v2, v0, v1

    const/16 v1, 0x34

    const-string v2, "connectbot_tab_hack"

    aput-object v2, v0, v1

    const/16 v1, 0x35

    const-string v2, "pref_touch_pos"

    aput-object v2, v0, v1

    const/16 v1, 0x36

    const-string v2, "pref_click_method"

    aput-object v2, v0, v1

    const/16 v1, 0x37

    const-string v2, "pref_top_row_scale"

    aput-object v2, v0, v1

    const/16 v1, 0x38

    const-string v2, "pref_caps_lock"

    aput-object v2, v0, v1

    const/16 v1, 0x39

    const-string v2, "pref_shift_lock_modifiers"

    aput-object v2, v0, v1

    const/16 v1, 0x3a

    const-string v2, "pref_chording_meta_key"

    aput-object v2, v0, v1

    const/16 v1, 0x3b

    const-string v2, "settings_key"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrReset;->KEYS:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    .prologue
    .line 90
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 91
    iput-object p1, p0, Lcom/mrkeyboard/app/MrReset;->mContext:Landroid/content/Context;

    .line 92
    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/MrReset;)Landroid/content/Context;
    .locals 1

    .prologue
    .line 24
    iget-object v0, p0, Lcom/mrkeyboard/app/MrReset;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method static apply(Landroid/content/Context;)V
    .locals 5

    .prologue
    .line 112
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    .line 113
    sget-object v2, Lcom/mrkeyboard/app/MrReset;->KEYS:[Ljava/lang/String;

    array-length v3, v2

    const/4 v0, 0x0

    :goto_0
    if-ge v0, v3, :cond_0

    aget-object v4, v2, v0

    invoke-interface {v1, v4}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 114
    :cond_0
    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 115
    const-string v0, ""

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrAi;->setApiKey(Landroid/content/Context;Ljava/lang/String;)V

    .line 116
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget-object v0, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 117
    const/4 v1, 0x0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->installedIds(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v2

    invoke-virtual {v0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v2, v0}, Lcom/mrkeyboard/app/MrPacks;->cardIds(Ljava/util/List;Ljava/util/List;Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPacks;->syncLanguages(Landroid/content/Context;Ljava/util/List;)V

    .line 118
    return-void
.end method


# virtual methods
.method public onPreferenceClick(Landroid/preference/Preference;)Z
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 95
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrReset;->mContext:Landroid/content/Context;

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 96
    iget-object v1, p0, Lcom/mrkeyboard/app/MrReset;->mContext:Landroid/content/Context;

    const-string v2, "mr_reset_title"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 97
    iget-object v1, p0, Lcom/mrkeyboard/app/MrReset;->mContext:Landroid/content/Context;

    const-string v2, "mr_reset_confirm"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 98
    iget-object v1, p0, Lcom/mrkeyboard/app/MrReset;->mContext:Landroid/content/Context;

    const-string v2, "mr_reset_do"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrReset$1;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/MrReset$1;-><init>(Lcom/mrkeyboard/app/MrReset;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 105
    iget-object v1, p0, Lcom/mrkeyboard/app/MrReset;->mContext:Landroid/content/Context;

    const-string v2, "mr_reset_cancel"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 106
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 107
    const/4 v0, 0x1

    return v0
.end method
