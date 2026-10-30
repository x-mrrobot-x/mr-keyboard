.class Lcom/mrkeyboard/app/KeyStyle$1;
.super Ljava/lang/Object;
.source "KeyStyle.java"

# interfaces
.implements Landroid/content/SharedPreferences$OnSharedPreferenceChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/KeyStyle;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .registers 1

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSharedPreferenceChanged(Landroid/content/SharedPreferences;Ljava/lang/String;)V
    .registers 3

    .line 25
    if-eqz p2, :cond_1a

    .line 26
    const-string p1, "pref_keyboard_layout"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_1a

    .line 27
    const-string p1, "pref_key_spacing"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_1a

    .line 28
    const-string p1, "pref_key_radius"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1e

    .line 29
    :cond_1a
    const/4 p1, 0x0

    # setter for: Lcom/mrkeyboard/app/KeyStyle;->sLoaded:Z
    invoke-static {p1}, Lcom/mrkeyboard/app/KeyStyle;->access$002(Z)Z

    .line 31
    :cond_1e
    return-void
.end method
