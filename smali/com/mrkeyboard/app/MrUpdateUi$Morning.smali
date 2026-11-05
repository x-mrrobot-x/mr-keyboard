.class final Lcom/mrkeyboard/app/MrUpdateUi$Morning;
.super Ljava/lang/Object;
.source "MrUpdateUi.java"

# interfaces
.implements Landroid/preference/Preference$OnPreferenceChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrUpdateUi;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Morning"
.end annotation


# instance fields
.field private final mActivity:Landroid/preference/PreferenceActivity;


# direct methods
.method constructor <init>(Landroid/preference/PreferenceActivity;)V
    .locals 0

    .prologue
    .line 206
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 207
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateUi$Morning;->mActivity:Landroid/preference/PreferenceActivity;

    .line 208
    return-void
.end method


# virtual methods
.method public onPreferenceChange(Landroid/preference/Preference;Ljava/lang/Object;)Z
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 211
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v0, p2}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    .line 212
    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateUi$Morning;->mActivity:Landroid/preference/PreferenceActivity;

    invoke-virtual {v1}, Landroid/preference/PreferenceActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    .line 213
    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrUpdateSchedule;->setMorning(Landroid/content/Context;Z)V

    .line 214
    invoke-static {v1}, Lcom/mrkeyboard/app/MrUpdateSchedule;->arm(Landroid/content/Context;)V

    .line 215
    if-eqz v0, :cond_0

    .line 216
    invoke-static {v1}, Lcom/mrkeyboard/app/MrUpdateNotify;->ensureChannel(Landroid/content/Context;)V

    .line 217
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$Morning;->mActivity:Landroid/preference/PreferenceActivity;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrUpdateUi;->askNotifications(Landroid/app/Activity;Z)Z

    .line 219
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$Morning;->mActivity:Landroid/preference/PreferenceActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateUi;->access$300(Landroid/app/Activity;)V

    .line 220
    return v2
.end method
