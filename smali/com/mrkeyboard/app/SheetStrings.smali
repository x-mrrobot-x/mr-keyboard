.class public final Lcom/mrkeyboard/app/SheetStrings;
.super Ljava/lang/Object;
.source "SheetStrings.java"


# static fields
.field public static sEs:Z


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static isPt(Landroid/content/Context;)Z
    .registers 4

    # true para português e para espanhol: o código escolhe o texto em português e, em espanhol,
    # SheetStrings.p() troca esse texto pelo espanhol (MrEs). sEs diz qual dos dois é.
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/SheetStrings;->sEs:Z

    const/4 v0, 0x1

    if-nez p0, :cond_ctx

    return v0

    :cond_ctx
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object p0

    iget-object p0, p0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    if-eqz p0, :cond_end

    invoke-virtual {p0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object p0

    if-eqz p0, :cond_end

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x2

    if-lt v1, v2, :cond_end

    const-string v1, "es"

    invoke-virtual {p0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_not_es

    sput-boolean v0, Lcom/mrkeyboard/app/SheetStrings;->sEs:Z

    return v0

    :cond_not_es
    const-string v1, "pt"

    invoke-virtual {p0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return v0

    :catchall_0
    move-exception v1

    :cond_end
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


# Troca o texto em português pelo espanhol quando o idioma do app é espanhol (isPt() já foi chamado).
.method public static p(Ljava/lang/String;)Ljava/lang/String;
    .registers 2

    sget-boolean v0, Lcom/mrkeyboard/app/SheetStrings;->sEs:Z

    if-eqz v0, :cond_keep

    invoke-static {p0}, Lcom/mrkeyboard/app/MrEs;->es(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    :cond_keep
    return-object p0
.end method

# Texto que o código tinha só em português, no idioma do app (anexos e limpeza de cache).
.method public static a(Ljava/lang/String;)Ljava/lang/String;
    .registers 2

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    if-nez v0, :cond_ctx

    return-object p0

    :cond_ctx
    invoke-static {v0, p0}, Lcom/mrkeyboard/app/MrEs;->app(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method
