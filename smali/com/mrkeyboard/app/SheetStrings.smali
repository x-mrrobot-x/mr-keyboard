.class public final Lcom/mrkeyboard/app/SheetStrings;
.super Ljava/lang/Object;
.source "SheetStrings.java"


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static isPt(Landroid/content/Context;)Z
    .registers 8

    .line 10
    const/4 v0, 0x1

    if-nez p0, :cond_4

    .line 11
    return v0

    .line 14
    :cond_4
    :try_start_4
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object p0

    iget-object p0, p0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    .line 15
    if-eqz p0, :cond_29

    .line 16
    invoke-virtual {p0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v1

    .line 17
    if-eqz v1, :cond_29

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result p0

    const/4 v2, 0x2

    if-lt p0, v2, :cond_29

    .line 18
    const-string v4, "pt"

    const/4 v5, 0x0

    const/4 v6, 0x2

    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-virtual/range {v1 .. v6}, Ljava/lang/String;->regionMatches(ZILjava/lang/String;II)Z

    move-result p0
    :try_end_27
    .catchall {:try_start_4 .. :try_end_27} :catchall_28

    return p0

    .line 21
    :catchall_28
    move-exception p0

    :cond_29
    nop

    .line 22
    return v0
.end method

.method public static tr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .registers 3

    .line 26
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result p0

    if-eqz p0, :cond_7

    goto :goto_8

    :cond_7
    move-object p1, p2

    :goto_8
    return-object p1
.end method
