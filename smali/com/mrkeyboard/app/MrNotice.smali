.class public final Lcom/mrkeyboard/app/MrNotice;
.super Ljava/lang/Object;
.source "MrNotice.java"


# static fields
.field static final KEY_AI:Ljava/lang/String; = "ai_seen"

.field static final KEY_TRANSLATE:Ljava/lang/String; = "translate_seen"

.field static final PREFS:Ljava/lang/String; = "mr_notices"


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static aiEditor(Landroid/content/Context;)V
    .locals 2

    .prologue
    .line 26
    const-string v0, "ai_seen"

    const-string v1, "mr_ai_notice"

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrNotice;->once(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 27
    return-void
.end method

.method private static once(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 31
    if-nez p0, :cond_1

    .line 41
    :cond_0
    :goto_0
    return-void

    .line 32
    :cond_1
    :try_start_0
    const-string v0, "mr_notices"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 33
    const/4 v1, 0x0

    invoke-interface {v0, p1, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    if-nez v1, :cond_0

    .line 34
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, p2, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 35
    if-eqz v1, :cond_0

    .line 36
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const/4 v2, 0x1

    invoke-interface {v0, p1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 37
    const/4 v0, 0x1

    invoke-static {p0, v1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 38
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static translate(Landroid/content/Context;)V
    .locals 2

    .prologue
    .line 21
    const-string v0, "translate_seen"

    const-string v1, "mr_tr_notice"

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrNotice;->once(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    .line 22
    return-void
.end method
