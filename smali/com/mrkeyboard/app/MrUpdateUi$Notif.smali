.class final Lcom/mrkeyboard/app/MrUpdateUi$Notif;
.super Ljava/lang/Object;
.source "MrUpdateUi.java"

# interfaces
.implements Landroid/preference/Preference$OnPreferenceClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrUpdateUi;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Notif"
.end annotation


# instance fields
.field private final mActivity:Landroid/preference/PreferenceActivity;


# direct methods
.method constructor <init>(Landroid/preference/PreferenceActivity;)V
    .locals 0

    .prologue
    .line 228
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 229
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateUi$Notif;->mActivity:Landroid/preference/PreferenceActivity;

    .line 230
    return-void
.end method


# virtual methods
.method public onPreferenceClick(Landroid/preference/Preference;)Z
    .locals 2

    .prologue
    .line 234
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$Notif;->mActivity:Landroid/preference/PreferenceActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateUi$Notif;->mActivity:Landroid/preference/PreferenceActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrUpdateNotify;->settingsIntent(Landroid/content/Context;)Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 238
    :goto_0
    const/4 v0, 0x1

    return v0

    .line 235
    :catch_0
    move-exception v0

    goto :goto_0
.end method
