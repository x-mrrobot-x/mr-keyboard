.class public final Lcom/mrkeyboard/app/MrPacks;
.super Ljava/lang/Object;
.source "MrPacks.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrPacks$Catalog;,
        Lcom/mrkeyboard/app/MrPacks$PackException;,
        Lcom/mrkeyboard/app/MrPacks$Pack;,
        Lcom/mrkeyboard/app/MrPacks$Net;,
        Lcom/mrkeyboard/app/MrPacks$HttpError;,
        Lcom/mrkeyboard/app/MrPacks$Api28;
    }
.end annotation


# static fields
.field static final CATALOG_FORMAT:I = 0x1

.field static final CATALOG_URL:Ljava/lang/String; = "https://github.com/x-mrrobot-x/mr-keyboard/releases/latest/download/catalog.json"

.field static final DEFAULT_IDS:[Ljava/lang/String;

.field static final DICT_MAX_V1:J = 0x400000L

.field static final DICT_MAX_V2:J = 0x1000000L

.field static final DICT_TYPE:I = 0x1

.field static final ENCODER:Ljava/lang/String; = "encoder.bin"

.field static final KEY_CATALOG:Ljava/lang/String; = "catalog"

.field static final KEY_CHECKED:Ljava/lang/String; = "checked_at"

.field static final KEY_INSTALLED:Ljava/lang/String; = "installed."

.field static final KEY_MODEL:Ljava/lang/String; = "model."

.field static final KEY_SERIAL:Ljava/lang/String; = "serial"

.field static final LANGS_KEY:Ljava/lang/String; = "selected_languages"

.field static final MAIN:Ljava/lang/String; = "main.dict"

.field static final MANIFEST:Ljava/lang/String; = "pack.json"

.field static final MAX_CATALOG:I = 0x100000

.field static final MAX_PACK:J = 0x4000000L

.field static final MODEL_FILES:[[Ljava/lang/String;

.field static final MODEL_FILE_MAX:I = 0x1000000

.field static final MODEL_FORMAT:I = 0x1

.field static final MODEL_GESTURE:Ljava/lang/String; = "gesture"

.field static final MODEL_LICENSE:Ljava/lang/String; = "LICENSE-FUTO-Model-Weights.md"

.field static final MODEL_LICENSE_RAW:Ljava/lang/String; = "mr_futo_license"

.field static final MODEL_MAGIC:Ljava/lang/String; = "MRSWENC1"

.field static final NOTICE:Ljava/lang/String; = "NOTICE.txt"

.field static final PACK_FORMAT:I = 0x2

.field static final PREFS:Ljava/lang/String; = "mr_packs"

.field static final RELEASES_URL:Ljava/lang/String; = "https://github.com/x-mrrobot-x/mr-keyboard/releases/download/"

.field static final RULES:Ljava/lang/String; = "rules.txt"

.field static final SIGNAL_KEY:Ljava/lang/String; = "mr_dicts_updated_at"

.field static final SIG_PREFIX:Ljava/lang/String; = "mr-keyboard/catalog/v1\n"

.field static final TRIGRAMS:Ljava/lang/String; = "trigrams.bin"

.field private static sActiveDir:Ljava/lang/String;

.field private static sCached:Lcom/mrkeyboard/app/MrPacks$Catalog;

.field private static sCachedData:Ljava/lang/String;

.field static volatile sCancel:Z

.field static sCatalogUrl:Ljava/lang/String;

.field static volatile sJobId:Ljava/lang/String;

.field static volatile sJobInstalling:Z

.field static volatile sJobPercent:I

.field private static volatile sLastLang:Ljava/lang/String;

.field static sNet:Lcom/mrkeyboard/app/MrPacks$Net;

.field private static sOffer:Ljava/lang/String;

.field private static sOfferAt:J

.field private static sOfferLabel:Ljava/lang/String;

.field static sTestCerts:[Ljava/security/cert/X509Certificate;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .prologue
    const/4 v5, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 104
    new-array v0, v4, [[Ljava/lang/String;

    new-array v1, v5, [Ljava/lang/String;

    const-string v2, "c05090fefa7200f3ff381c8fee6a5e16415d50ec14e59df9abd29dd85802da6c"

    aput-object v2, v1, v3

    const-string v2, "1"

    aput-object v2, v1, v4

    aput-object v1, v0, v3

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->MODEL_FILES:[[Ljava/lang/String;

    .line 432
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$1;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrPacks$1;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sNet:Lcom/mrkeyboard/app/MrPacks$Net;

    .line 467
    const-string v0, "https://github.com/x-mrrobot-x/mr-keyboard/releases/latest/download/catalog.json"

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sCatalogUrl:Ljava/lang/String;

    .line 700
    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "pt-BR"

    aput-object v1, v0, v3

    const-string v1, "en-US"

    aput-object v1, v0, v4

    const-string v1, "es"

    aput-object v1, v0, v5

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->DEFAULT_IDS:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 64
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static declared-synchronized activate(Ljava/io/File;)V
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 1069
    const-class v4, Lcom/mrkeyboard/app/MrPacks;

    monitor-enter v4

    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->preload()V

    .line 1070
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    move-object v3, v0

    .line 1071
    :goto_0
    if-nez v3, :cond_1

    .line 1072
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrRules;->set(Lcom/mrkeyboard/app/MrRules;)V

    .line 1073
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTrigram;->use(Ljava/io/File;)V

    .line 1074
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sActiveDir:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1096
    :goto_1
    monitor-exit v4

    return-void

    :cond_0
    move-object v3, v1

    .line 1070
    goto :goto_0

    .line 1077
    :cond_1
    :try_start_1
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sActiveDir:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v0

    if-nez v0, :cond_2

    .line 1081
    :try_start_2
    new-instance v2, Ljava/io/File;

    const-string v0, "rules.txt"

    invoke-direct {v2, p0, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 1082
    invoke-virtual {v2}, Ljava/io/File;->isFile()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 1083
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1084
    :try_start_3
    invoke-static {v0}, Lcom/mrkeyboard/app/MrRules;->parse(Ljava/io/InputStream;)Lcom/mrkeyboard/app/MrRules;
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    move-result-object v2

    move-object v5, v0

    move-object v0, v2

    move-object v2, v5

    .line 1089
    :goto_2
    :try_start_4
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 1091
    :goto_3
    invoke-static {v0}, Lcom/mrkeyboard/app/MrRules;->set(Lcom/mrkeyboard/app/MrRules;)V

    .line 1092
    sput-object v3, Lcom/mrkeyboard/app/MrPacks;->sActiveDir:Ljava/lang/String;

    .line 1094
    :cond_2
    new-instance v0, Ljava/io/File;

    const-string v2, "trigrams.bin"

    invoke-direct {v0, p0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 1095
    invoke-virtual {v0}, Ljava/io/File;->isFile()Z

    move-result v2

    if-eqz v2, :cond_3

    move-object v1, v0

    :cond_3
    invoke-static {v1}, Lcom/mrkeyboard/app/MrTrigram;->use(Ljava/io/File;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_1

    .line 1069
    :catchall_0
    move-exception v0

    monitor-exit v4

    throw v0

    .line 1086
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 1089
    :goto_4
    :try_start_5
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    move-object v0, v1

    .line 1090
    goto :goto_3

    .line 1089
    :catchall_1
    move-exception v0

    :goto_5
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 1090
    throw v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 1089
    :catchall_2
    move-exception v1

    move-object v5, v1

    move-object v1, v0

    move-object v0, v5

    goto :goto_5

    .line 1086
    :catch_1
    move-exception v2

    goto :goto_4

    :cond_4
    move-object v2, v1

    move-object v0, v1

    goto :goto_2
.end method

.method static declared-synchronized activeDir()Ljava/io/File;
    .locals 3

    .prologue
    .line 1043
    const-class v1, Lcom/mrkeyboard/app/MrPacks;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sActiveDir:Ljava/lang/String;

    if-eqz v0, :cond_0

    new-instance v0, Ljava/io/File;

    sget-object v2, Lcom/mrkeyboard/app/MrPacks;->sActiveDir:Ljava/lang/String;

    invoke-direct {v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    monitor-exit v1

    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static appTooOld(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Pack;)Z
    .locals 6

    .prologue
    const/4 v0, 0x1

    .line 768
    iget v1, p1, Lcom/mrkeyboard/app/MrPacks$Pack;->format:I

    if-lt v1, v0, :cond_0

    iget v2, p1, Lcom/mrkeyboard/app/MrPacks$Pack;->format:I

    iget-boolean v1, p1, Lcom/mrkeyboard/app/MrPacks$Pack;->model:Z

    if-eqz v1, :cond_1

    move v1, v0

    :goto_0
    if-gt v2, v1, :cond_0

    iget-wide v2, p1, Lcom/mrkeyboard/app/MrPacks$Pack;->minApp:J

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->appVersion(Landroid/content/Context;)J

    move-result-wide v4

    cmp-long v1, v2, v4

    if-lez v1, :cond_2

    :cond_0
    :goto_1
    return v0

    :cond_1
    const/4 v1, 0x2

    goto :goto_0

    :cond_2
    const/4 v0, 0x0

    goto :goto_1
.end method

.method static appVersion(Landroid/content/Context;)J
    .locals 3

    .prologue
    .line 761
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    iget v0, v0, Landroid/content/pm/PackageInfo;->versionCode:I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    int-to-long v0, v0

    .line 763
    :goto_0
    return-wide v0

    .line 762
    :catch_0
    move-exception v0

    .line 763
    const-wide/16 v0, 0x0

    goto :goto_0
.end method

.method static declared-synchronized cachedCatalog(Landroid/content/Context;)Lcom/mrkeyboard/app/MrPacks$Catalog;
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 509
    const-class v1, Lcom/mrkeyboard/app/MrPacks;

    monitor-enter v1

    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    const-string v3, "catalog"

    const/4 v4, 0x0

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v2

    .line 510
    if-nez v2, :cond_0

    .line 518
    :goto_0
    monitor-exit v1

    return-object v0

    .line 511
    :cond_0
    :try_start_1
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sCachedData:Ljava/lang/String;

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sCached:Lcom/mrkeyboard/app/MrPacks$Catalog;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 513
    :cond_1
    :try_start_2
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->readData(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Catalog;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sCached:Lcom/mrkeyboard/app/MrPacks$Catalog;
    :try_end_2
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 517
    :goto_1
    :try_start_3
    sput-object v2, Lcom/mrkeyboard/app/MrPacks;->sCachedData:Ljava/lang/String;

    .line 518
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sCached:Lcom/mrkeyboard/app/MrPacks$Catalog;

    goto :goto_0

    .line 514
    :catch_0
    move-exception v0

    .line 515
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sCached:Lcom/mrkeyboard/app/MrPacks$Catalog;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    .line 509
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static cardIds(Ljava/util/List;Ljava/util/List;Ljava/lang/String;)Ljava/util/ArrayList;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 708
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 709
    sget-object v1, Lcom/mrkeyboard/app/MrPacks;->DEFAULT_IDS:[Ljava/lang/String;

    array-length v4, v1

    move v0, v2

    :goto_0
    if-ge v0, v4, :cond_0

    aget-object v5, v1, v0

    invoke-virtual {v3, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 710
    :cond_0
    if-eqz p0, :cond_2

    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->validId(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 711
    :cond_2
    if-eqz p1, :cond_4

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_3
    :goto_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_3

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 712
    :cond_4
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .line 713
    if-nez p2, :cond_6

    const-string v0, ""

    move-object v1, v0

    .line 714
    :goto_3
    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :cond_5
    :goto_4
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_7

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->splitLocale(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v6

    aget-object v6, v6, v2

    invoke-virtual {v6, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_5

    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_4

    .line 713
    :cond_6
    sget-object v0, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {p2, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    goto :goto_3

    .line 715
    :cond_7
    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_8
    :goto_5
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_9

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_8

    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_5

    .line 716
    :cond_9
    return-object v4
.end method

.method static certSha(Ljava/security/cert/X509Certificate;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 1198
    :try_start_0
    const-string v0, "SHA-256"

    invoke-static {v0}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v0

    invoke-virtual {p0}, Ljava/security/cert/X509Certificate;->getEncoded()[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/security/MessageDigest;->digest([B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->hex([B)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 1200
    :goto_0
    return-object v0

    .line 1199
    :catch_0
    move-exception v0

    .line 1200
    const-string v0, ""

    goto :goto_0
.end method

.method static certs(Landroid/content/Context;)[Ljava/security/cert/X509Certificate;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    const/4 v3, 0x0

    .line 1162
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sTestCerts:[Ljava/security/cert/X509Certificate;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sTestCerts:[Ljava/security/cert/X509Certificate;

    .line 1177
    :goto_0
    return-object v0

    .line 1165
    :cond_0
    :try_start_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-lt v0, v1, :cond_2

    .line 1166
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks$Api28;->signers(Landroid/content/Context;)[Landroid/content/pm/Signature;

    move-result-object v0

    move-object v4, v0

    .line 1171
    :goto_1
    if-eqz v4, :cond_1

    array-length v0, v4

    if-nez v0, :cond_3

    :cond_1
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_signature"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 1178
    :catch_0
    move-exception v0

    .line 1179
    throw v0

    .line 1168
    :cond_2
    :try_start_1
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x40

    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    .line 1169
    iget-object v0, v0, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    move-object v4, v0

    goto :goto_1

    .line 1172
    :cond_3
    const-string v0, "X.509"

    invoke-static {v0}, Ljava/security/cert/CertificateFactory;->getInstance(Ljava/lang/String;)Ljava/security/cert/CertificateFactory;

    move-result-object v5

    .line 1173
    array-length v0, v4

    new-array v1, v0, [Ljava/security/cert/X509Certificate;

    move v2, v3

    .line 1174
    :goto_2
    array-length v0, v4

    if-ge v2, v0, :cond_4

    .line 1175
    new-instance v0, Ljava/io/ByteArrayInputStream;

    aget-object v6, v4, v2

    invoke-virtual {v6}, Landroid/content/pm/Signature;->toByteArray()[B

    move-result-object v6

    invoke-direct {v0, v6}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-virtual {v5, v0}, Ljava/security/cert/CertificateFactory;->generateCertificate(Ljava/io/InputStream;)Ljava/security/cert/Certificate;

    move-result-object v0

    check-cast v0, Ljava/security/cert/X509Certificate;

    aput-object v0, v1, v2
    :try_end_1
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 1174
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_2

    :cond_4
    move-object v0, v1

    .line 1177
    goto :goto_0

    .line 1180
    :catch_1
    move-exception v0

    .line 1181
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_signature"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0
.end method

.method static checkFiles(Ljava/io/File;)V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    const/4 v5, 0x3

    const/4 v3, 0x1

    const/4 v4, 0x0

    .line 912
    new-instance v0, Ljava/io/File;

    const-string v1, "main.dict"

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 913
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->dictHeaderOk(Ljava/io/File;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_corrupt"

    new-array v2, v3, [Ljava/lang/Object;

    const-string v3, "main.dict"

    aput-object v3, v2, v4

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 914
    :cond_0
    new-instance v0, Ljava/io/File;

    const-string v1, "trigrams.bin"

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 915
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 916
    const/4 v1, 0x4

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacks;->head(Ljava/io/File;I)[B

    move-result-object v0

    .line 918
    if-eqz v0, :cond_1

    aget-byte v1, v0, v4

    const/16 v2, 0x4d

    if-ne v1, v2, :cond_1

    aget-byte v1, v0, v3

    const/16 v2, 0x52

    if-ne v1, v2, :cond_1

    const/4 v1, 0x2

    aget-byte v1, v0, v1

    const/16 v2, 0x54

    if-ne v1, v2, :cond_1

    aget-byte v1, v0, v5

    const/16 v2, 0x31

    if-eq v1, v2, :cond_2

    aget-byte v0, v0, v5

    const/16 v1, 0x32

    if-eq v0, v1, :cond_2

    .line 919
    :cond_1
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_corrupt"

    new-array v2, v3, [Ljava/lang/Object;

    const-string v3, "trigrams.bin"

    aput-object v3, v2, v4

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 922
    :cond_2
    new-instance v2, Ljava/io/File;

    const-string v0, "rules.txt"

    invoke-direct {v2, p0, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 923
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 924
    const/4 v1, 0x0

    .line 926
    :try_start_0
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 927
    :try_start_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrRules;->parse(Ljava/io/InputStream;)Lcom/mrkeyboard/app/MrRules;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 931
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 934
    :cond_3
    return-void

    .line 928
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 929
    :goto_0
    :try_start_2
    new-instance v1, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_dicts_err_corrupt"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    const-string v5, "rules.txt"

    aput-object v5, v3, v4

    invoke-direct {v1, v2, v3}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 931
    :catchall_0
    move-exception v1

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    :goto_1
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 932
    throw v0

    .line 931
    :catchall_1
    move-exception v0

    goto :goto_1

    .line 928
    :catch_1
    move-exception v1

    goto :goto_0
.end method

.method static checkModel(Ljava/io/File;)V
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    const-wide/16 v8, 0x400

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 686
    new-instance v0, Ljava/io/File;

    const-string v3, "encoder.bin"

    invoke-direct {v0, p0, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 687
    const-string v3, "MRSWENC1"

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrPacks;->head(Ljava/io/File;I)[B

    move-result-object v4

    .line 688
    if-eqz v4, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v6

    cmp-long v0, v6, v8

    if-ltz v0, :cond_0

    move v0, v1

    :goto_0
    move v3, v2

    .line 689
    :goto_1
    if-eqz v0, :cond_2

    array-length v5, v4

    if-ge v3, v5, :cond_2

    aget-byte v0, v4, v3

    const-string v5, "MRSWENC1"

    invoke-virtual {v5, v3}, Ljava/lang/String;->charAt(I)C

    move-result v5

    if-ne v0, v5, :cond_1

    move v0, v1

    :goto_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_0
    move v0, v2

    .line 688
    goto :goto_0

    :cond_1
    move v0, v2

    .line 689
    goto :goto_2

    .line 690
    :cond_2
    if-nez v0, :cond_3

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v3, "mr_dicts_err_corrupt"

    new-array v1, v1, [Ljava/lang/Object;

    const-string v4, "encoder.bin"

    aput-object v4, v1, v2

    invoke-direct {v0, v3, v1}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 691
    :cond_3
    new-instance v0, Ljava/io/File;

    const-string v3, "LICENSE-FUTO-Model-Weights.md"

    invoke-direct {v0, p0, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v4

    cmp-long v0, v4, v8

    if-gez v0, :cond_4

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v3, "mr_dicts_err_corrupt"

    new-array v1, v1, [Ljava/lang/Object;

    const-string v4, "LICENSE-FUTO-Model-Weights.md"

    aput-object v4, v1, v2

    invoke-direct {v0, v3, v1}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 692
    :cond_4
    return-void
.end method

.method static checkedAt(Landroid/content/Context;)J
    .locals 4

    .prologue
    .line 522
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "checked_at"

    const-wide/16 v2, 0x0

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    return-wide v0
.end method

.method static closeQuietly(Ljava/io/Closeable;)V
    .locals 1

    .prologue
    .line 1235
    if-nez p0, :cond_0

    .line 1241
    :goto_0
    return-void

    .line 1237
    :cond_0
    :try_start_0
    invoke-interface {p0}, Ljava/io/Closeable;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1238
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static deleteTree(Ljava/io/File;)V
    .locals 4

    .prologue
    .line 1228
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_1

    .line 1232
    :cond_0
    :goto_0
    return-void

    .line 1229
    :cond_1
    invoke-virtual {p0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v1

    .line 1230
    if-eqz v1, :cond_2

    array-length v2, v1

    const/4 v0, 0x0

    :goto_1
    if-ge v0, v2, :cond_2

    aget-object v3, v1, v0

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 1231
    :cond_2
    invoke-virtual {p0}, Ljava/io/File;->delete()Z

    goto :goto_0
.end method

.method static dictHeaderOk(Ljava/io/File;)Z
    .locals 8

    .prologue
    const/4 v7, 0x2

    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 937
    invoke-virtual {p0}, Ljava/io/File;->length()J

    move-result-wide v2

    .line 938
    const-wide/16 v4, 0x400

    cmp-long v4, v2, v4

    if-ltz v4, :cond_0

    const-wide/32 v4, 0x1000000

    cmp-long v4, v2, v4

    if-lez v4, :cond_2

    :cond_0
    move v0, v1

    .line 942
    :cond_1
    :goto_0
    return v0

    .line 939
    :cond_2
    invoke-static {p0, v7}, Lcom/mrkeyboard/app/MrPacks;->head(Ljava/io/File;I)[B

    move-result-object v4

    .line 940
    if-eqz v4, :cond_3

    aget-byte v5, v4, v1

    and-int/lit16 v5, v5, 0xff

    const/16 v6, 0xc8

    if-eq v5, v6, :cond_4

    :cond_3
    move v0, v1

    goto :goto_0

    .line 941
    :cond_4
    aget-byte v5, v4, v0

    if-ne v5, v0, :cond_5

    const-wide/32 v4, 0x400000

    cmp-long v2, v2, v4

    if-lez v2, :cond_1

    move v0, v1

    goto :goto_0

    .line 942
    :cond_5
    aget-byte v2, v4, v0

    if-eq v2, v7, :cond_1

    move v0, v1

    goto :goto_0
.end method

.method private static download(Ljava/lang/String;Ljava/io/File;Lcom/mrkeyboard/app/MrPacks$Pack;)V
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    const-wide/16 v4, 0x0

    const/4 v1, 0x0

    .line 819
    .line 822
    :try_start_0
    const-string v0, "SHA-256"

    invoke-static {v0}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v0

    .line 823
    const/4 v2, 0x1

    new-array v2, v2, [J

    .line 824
    sget-object v3, Lcom/mrkeyboard/app/MrPacks;->sNet:Lcom/mrkeyboard/app/MrPacks$Net;

    invoke-interface {v3, p0, v2}, Lcom/mrkeyboard/app/MrPacks$Net;->open(Ljava/lang/String;[J)Ljava/io/InputStream;
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_0 .. :try_end_0} :catch_b
    .catch Lcom/mrkeyboard/app/MrPacks$HttpError; {:try_start_0 .. :try_end_0} :catch_a
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_9
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_6
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    move-result-object v3

    .line 825
    const/4 v6, 0x0

    :try_start_1
    aget-wide v6, v2, v6

    cmp-long v6, v6, v4

    if-lez v6, :cond_0

    const/4 v6, 0x0

    aget-wide v6, v2, v6

    iget-wide v8, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    cmp-long v2, v6, v8

    if-eqz v2, :cond_0

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_dicts_err_corrupt"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const-string v6, "size"

    aput-object v6, v4, v5

    invoke-direct {v0, v2, v4}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0
    :try_end_1
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Lcom/mrkeyboard/app/MrPacks$HttpError; {:try_start_1 .. :try_end_1} :catch_4
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_5
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_7
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 842
    :catch_0
    move-exception v0

    move-object v2, v3

    .line 843
    :goto_0
    :try_start_2
    throw v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 852
    :catchall_0
    move-exception v0

    move-object v3, v2

    :goto_1
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 853
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 854
    throw v0

    .line 826
    :cond_0
    :try_start_3
    new-instance v2, Ljava/io/FileOutputStream;

    invoke-direct {v2, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_3
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Lcom/mrkeyboard/app/MrPacks$HttpError; {:try_start_3 .. :try_end_3} :catch_4
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_5
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_7
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 827
    const/high16 v6, 0x10000

    :try_start_4
    new-array v6, v6, [B

    .line 830
    :goto_2
    invoke-virtual {v3, v6}, Ljava/io/InputStream;->read([B)I

    move-result v7

    if-lez v7, :cond_3

    .line 831
    sget-boolean v8, Lcom/mrkeyboard/app/MrPacks;->sCancel:Z

    if-eqz v8, :cond_1

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_cancel"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-direct {v0, v1, v4}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 842
    :catch_1
    move-exception v0

    move-object v1, v2

    move-object v2, v3

    goto :goto_0

    .line 832
    :cond_1
    int-to-long v8, v7

    add-long/2addr v4, v8

    .line 833
    iget-wide v8, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    cmp-long v8, v4, v8

    if-lez v8, :cond_2

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_corrupt"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const-string v6, "size"

    aput-object v6, v4, v5

    invoke-direct {v0, v1, v4}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0
    :try_end_4
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Lcom/mrkeyboard/app/MrPacks$HttpError; {:try_start_4 .. :try_end_4} :catch_2
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_8
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    .line 844
    :catch_2
    move-exception v0

    move-object v1, v2

    .line 845
    :goto_3
    :try_start_5
    new-instance v2, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v4, "mr_dicts_err_http"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    iget v0, v0, Lcom/mrkeyboard/app/MrPacks$HttpError;->code:I

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v5, v6

    invoke-direct {v2, v4, v5}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v2
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 852
    :catchall_1
    move-exception v0

    goto :goto_1

    .line 834
    :cond_2
    const/4 v8, 0x0

    :try_start_6
    invoke-virtual {v0, v6, v8, v7}, Ljava/security/MessageDigest;->update([BII)V

    .line 835
    const/4 v8, 0x0

    invoke-virtual {v2, v6, v8, v7}, Ljava/io/OutputStream;->write([BII)V

    .line 836
    const-wide/16 v8, 0x64

    mul-long/2addr v8, v4

    iget-wide v10, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    div-long/2addr v8, v10

    long-to-int v7, v8

    sput v7, Lcom/mrkeyboard/app/MrPacks;->sJobPercent:I
    :try_end_6
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_6 .. :try_end_6} :catch_1
    .catch Lcom/mrkeyboard/app/MrPacks$HttpError; {:try_start_6 .. :try_end_6} :catch_2
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_3
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_8
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    goto :goto_2

    .line 846
    :catch_3
    move-exception v0

    move-object v1, v2

    .line 847
    :goto_4
    :try_start_7
    sget-boolean v0, Lcom/mrkeyboard/app/MrPacks;->sCancel:Z

    if-eqz v0, :cond_6

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_dicts_err_cancel"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-direct {v0, v2, v4}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    .line 838
    :cond_3
    :try_start_8
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_8
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_8 .. :try_end_8} :catch_1
    .catch Lcom/mrkeyboard/app/MrPacks$HttpError; {:try_start_8 .. :try_end_8} :catch_2
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_3
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    .line 840
    :try_start_9
    iget-wide v6, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    cmp-long v2, v4, v6

    if-eqz v2, :cond_4

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_dicts_err_corrupt"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const-string v6, "size"

    aput-object v6, v4, v5

    invoke-direct {v0, v2, v4}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 844
    :catch_4
    move-exception v0

    goto :goto_3

    .line 841
    :cond_4
    invoke-virtual {v0}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->hex([B)Ljava/lang/String;

    move-result-object v0

    iget-object v2, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->sha256:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_dicts_err_corrupt"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const-string v6, "sha256"

    aput-object v6, v4, v5

    invoke-direct {v0, v2, v4}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0
    :try_end_9
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_9 .. :try_end_9} :catch_0
    .catch Lcom/mrkeyboard/app/MrPacks$HttpError; {:try_start_9 .. :try_end_9} :catch_4
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_5
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_7
    .catchall {:try_start_9 .. :try_end_9} :catchall_1

    .line 846
    :catch_5
    move-exception v0

    goto :goto_4

    .line 852
    :cond_5
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 853
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 855
    return-void

    .line 848
    :cond_6
    :try_start_a
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_dicts_err_network"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-direct {v0, v2, v4}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 849
    :catch_6
    move-exception v0

    move-object v3, v1

    .line 850
    :goto_5
    new-instance v2, Lcom/mrkeyboard/app/MrPacks$PackException;

    invoke-static {p2}, Lcom/mrkeyboard/app/MrPacks;->ioKey(Lcom/mrkeyboard/app/MrPacks$Pack;)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v5, v6

    invoke-direct {v2, v4, v5}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v2
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_1

    .line 852
    :catchall_2
    move-exception v0

    move-object v3, v1

    goto/16 :goto_1

    :catchall_3
    move-exception v0

    move-object v1, v2

    goto/16 :goto_1

    .line 849
    :catch_7
    move-exception v0

    goto :goto_5

    :catch_8
    move-exception v0

    move-object v1, v2

    goto :goto_5

    .line 846
    :catch_9
    move-exception v0

    move-object v3, v1

    goto/16 :goto_4

    .line 844
    :catch_a
    move-exception v0

    move-object v3, v1

    goto/16 :goto_3

    .line 842
    :catch_b
    move-exception v0

    move-object v2, v1

    goto/16 :goto_0
.end method

.method private static extract(Ljava/io/File;Ljava/io/File;Lcom/mrkeyboard/app/MrPacks$Pack;)V
    .locals 16
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    .line 859
    invoke-virtual/range {p1 .. p1}, Ljava/io/File;->mkdirs()Z

    move-result v2

    if-nez v2, :cond_0

    invoke-virtual/range {p1 .. p1}, Ljava/io/File;->isDirectory()Z

    move-result v2

    if-nez v2, :cond_0

    new-instance v2, Lcom/mrkeyboard/app/MrPacks$PackException;

    invoke-static/range {p2 .. p2}, Lcom/mrkeyboard/app/MrPacks;->ioKey(Lcom/mrkeyboard/app/MrPacks$Pack;)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const-string v6, "mkdir"

    aput-object v6, v4, v5

    invoke-direct {v2, v3, v4}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v2

    .line 860
    :cond_0
    new-instance v8, Ljava/util/HashSet;

    invoke-direct {v8}, Ljava/util/HashSet;-><init>()V

    .line 861
    const/4 v4, 0x0

    .line 863
    :try_start_0
    new-instance v3, Ljava/util/zip/ZipInputStream;

    new-instance v2, Ljava/io/FileInputStream;

    move-object/from16 v0, p0

    invoke-direct {v2, v0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v3, v2}, Ljava/util/zip/ZipInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 864
    const/high16 v2, 0x10000

    :try_start_1
    new-array v9, v2, [B

    .line 866
    :cond_1
    invoke-virtual {v3}, Ljava/util/zip/ZipInputStream;->getNextEntry()Ljava/util/zip/ZipEntry;

    move-result-object v10

    if-eqz v10, :cond_a

    .line 867
    invoke-virtual {v10}, Ljava/util/zip/ZipEntry;->getName()Ljava/lang/String;

    move-result-object v11

    .line 870
    const-string v2, "pack.json"

    invoke-virtual {v11, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 871
    const-wide/32 v4, 0x10000

    .line 872
    move-object/from16 v0, p2

    iget-object v2, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->manifestSha:Ljava/lang/String;

    move-wide v6, v4

    .line 879
    :goto_0
    invoke-virtual {v10}, Ljava/util/zip/ZipEntry;->isDirectory()Z

    move-result v4

    if-nez v4, :cond_2

    invoke-virtual {v8, v11}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_5

    :cond_2
    new-instance v2, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v4, "mr_dicts_err_corrupt"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    aput-object v11, v5, v6

    invoke-direct {v2, v4, v5}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v2
    :try_end_1
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 898
    :catch_0
    move-exception v2

    .line 899
    :goto_1
    :try_start_2
    throw v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 903
    :catchall_0
    move-exception v2

    :goto_2
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 904
    throw v2

    .line 874
    :cond_3
    :try_start_3
    move-object/from16 v0, p2

    iget-object v2, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->fileNames:[Ljava/lang/String;

    invoke-static {v2, v11}, Lcom/mrkeyboard/app/MrPacks;->indexOf([Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 875
    if-gez v2, :cond_4

    new-instance v2, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v4, "mr_dicts_err_corrupt"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    aput-object v11, v5, v6

    invoke-direct {v2, v4, v5}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v2
    :try_end_3
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_3 .. :try_end_3} :catch_0
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 900
    :catch_1
    move-exception v2

    .line 901
    :goto_3
    :try_start_4
    new-instance v2, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v4, "mr_dicts_err_corrupt"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    const-string v7, "zip"

    aput-object v7, v5, v6

    invoke-direct {v2, v4, v5}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v2
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 876
    :cond_4
    :try_start_5
    move-object/from16 v0, p2

    iget-object v4, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSizes:[J

    aget-wide v4, v4, v2

    .line 877
    move-object/from16 v0, p2

    iget-object v6, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSha:[Ljava/lang/String;

    aget-object v2, v6, v2

    move-wide v6, v4

    goto :goto_0

    .line 880
    :cond_5
    const-string v4, "SHA-256"

    invoke-static {v4}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v10

    .line 881
    new-instance v12, Ljava/io/FileOutputStream;

    new-instance v4, Ljava/io/File;

    move-object/from16 v0, p1

    invoke-direct {v4, v0, v11}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-direct {v12, v4}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_5
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_5 .. :try_end_5} :catch_0
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 882
    const-wide/16 v4, 0x0

    .line 885
    :goto_4
    :try_start_6
    invoke-virtual {v3, v9}, Ljava/util/zip/ZipInputStream;->read([B)I

    move-result v13

    if-lez v13, :cond_8

    .line 886
    sget-boolean v14, Lcom/mrkeyboard/app/MrPacks;->sCancel:Z

    if-eqz v14, :cond_6

    new-instance v2, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v4, "mr_dicts_err_cancel"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-direct {v2, v4, v5}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v2
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    .line 893
    :catchall_1
    move-exception v2

    :try_start_7
    invoke-virtual {v12}, Ljava/io/OutputStream;->close()V

    .line 894
    throw v2
    :try_end_7
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_7 .. :try_end_7} :catch_0
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_1
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 887
    :cond_6
    int-to-long v14, v13

    add-long/2addr v4, v14

    .line 888
    cmp-long v14, v4, v6

    if-lez v14, :cond_7

    :try_start_8
    new-instance v2, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v4, "mr_dicts_err_corrupt"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    aput-object v11, v5, v6

    invoke-direct {v2, v4, v5}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v2

    .line 889
    :cond_7
    const/4 v14, 0x0

    invoke-virtual {v10, v9, v14, v13}, Ljava/security/MessageDigest;->update([BII)V

    .line 890
    const/4 v14, 0x0

    invoke-virtual {v12, v9, v14, v13}, Ljava/io/OutputStream;->write([BII)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    goto :goto_4

    .line 893
    :cond_8
    :try_start_9
    invoke-virtual {v12}, Ljava/io/OutputStream;->close()V

    .line 895
    const-string v12, "pack.json"

    invoke-virtual {v11, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    if-nez v12, :cond_9

    cmp-long v4, v4, v6

    if-eqz v4, :cond_9

    new-instance v2, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v4, "mr_dicts_err_corrupt"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    aput-object v11, v5, v6

    invoke-direct {v2, v4, v5}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v2

    .line 896
    :cond_9
    invoke-virtual {v10}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v4

    invoke-static {v4}, Lcom/mrkeyboard/app/MrPacks;->hex([B)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    new-instance v2, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v4, "mr_dicts_err_corrupt"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    aput-object v11, v5, v6

    invoke-direct {v2, v4, v5}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v2
    :try_end_9
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_9 .. :try_end_9} :catch_0
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_1
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    .line 903
    :cond_a
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 905
    move-object/from16 v0, p2

    iget-object v3, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->fileNames:[Ljava/lang/String;

    array-length v4, v3

    const/4 v2, 0x0

    :goto_5
    if-ge v2, v4, :cond_c

    aget-object v5, v3, v2

    .line 906
    invoke-virtual {v8, v5}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_b

    new-instance v2, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v3, "mr_dicts_err_corrupt"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v6, 0x0

    aput-object v5, v4, v6

    invoke-direct {v2, v3, v4}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v2

    .line 905
    :cond_b
    add-int/lit8 v2, v2, 0x1

    goto :goto_5

    .line 908
    :cond_c
    return-void

    .line 903
    :catchall_2
    move-exception v2

    move-object v3, v4

    goto/16 :goto_2

    .line 900
    :catch_2
    move-exception v2

    move-object v3, v4

    goto/16 :goto_3

    .line 898
    :catch_3
    move-exception v2

    move-object v3, v4

    goto/16 :goto_1
.end method

.method static fetchBytes(Ljava/lang/String;I)[B
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    .line 472
    const-string v0, "catalog.json"

    invoke-static {p0, p1, v0}, Lcom/mrkeyboard/app/MrPacks;->fetchBytes(Ljava/lang/String;ILjava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method static fetchBytes(Ljava/lang/String;ILjava/lang/String;)[B
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    const/16 v0, 0x2000

    .line 477
    const/4 v1, 0x0

    .line 479
    const/4 v2, 0x1

    :try_start_0
    new-array v2, v2, [J

    .line 480
    sget-object v3, Lcom/mrkeyboard/app/MrPacks;->sNet:Lcom/mrkeyboard/app/MrPacks$Net;

    invoke-interface {v3, p0, v2}, Lcom/mrkeyboard/app/MrPacks$Net;->open(Ljava/lang/String;[J)Ljava/io/InputStream;

    move-result-object v1

    .line 481
    new-instance v3, Ljava/io/ByteArrayOutputStream;

    const/4 v4, 0x0

    aget-wide v4, v2, v4

    const-wide/16 v6, 0x0

    cmp-long v4, v4, v6

    if-lez v4, :cond_0

    const/4 v4, 0x0

    aget-wide v4, v2, v4

    int-to-long v6, p1

    cmp-long v4, v4, v6

    if-gtz v4, :cond_0

    const/4 v0, 0x0

    aget-wide v4, v2, v0

    long-to-int v0, v4

    :cond_0
    invoke-direct {v3, v0}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 482
    const/16 v0, 0x2000

    new-array v0, v0, [B

    .line 484
    :cond_1
    invoke-virtual {v1, v0}, Ljava/io/InputStream;->read([B)I

    move-result v2

    if-lez v2, :cond_2

    .line 485
    const/4 v4, 0x0

    invoke-virtual {v3, v0, v4, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 486
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v2

    if-le v2, p1, :cond_1

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_dicts_err_corrupt"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object p2, v3, v4

    invoke-direct {v0, v2, v3}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrPacks$HttpError; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 489
    :catch_0
    move-exception v0

    .line 490
    :try_start_1
    new-instance v2, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v3, "mr_dicts_err_http"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    iget v0, v0, Lcom/mrkeyboard/app/MrPacks$HttpError;->code:I

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v4, v5

    invoke-direct {v2, v3, v4}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 494
    :catchall_0
    move-exception v0

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 495
    throw v0

    .line 488
    :cond_2
    :try_start_2
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B
    :try_end_2
    .catch Lcom/mrkeyboard/app/MrPacks$HttpError; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v0

    .line 494
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 488
    return-object v0

    .line 491
    :catch_1
    move-exception v0

    .line 492
    :try_start_3
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_dicts_err_network"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-direct {v0, v2, v3}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0
.end method

.method static fetchCatalog(Landroid/content/Context;)Lcom/mrkeyboard/app/MrPacks$Catalog;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    .line 527
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sCatalogUrl:Ljava/lang/String;

    const/high16 v1, 0x100000

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacks;->fetchBytes(Ljava/lang/String;I)[B

    move-result-object v0

    .line 528
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 529
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->certs(Landroid/content/Context;)[Ljava/security/cert/X509Certificate;

    move-result-object v2

    const-string v3, "serial"

    const-wide/16 v4, 0x0

    invoke-interface {v1, v3, v4, v5}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v4

    invoke-static {v0, v2, v4, v5}, Lcom/mrkeyboard/app/MrPacks;->parseCatalog([B[Ljava/security/cert/X509Certificate;J)Lcom/mrkeyboard/app/MrPacks$Catalog;

    move-result-object v0

    .line 530
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "serial"

    iget-wide v4, v0, Lcom/mrkeyboard/app/MrPacks$Catalog;->serial:J

    invoke-interface {v1, v2, v4, v5}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "catalog"

    iget-object v3, v0, Lcom/mrkeyboard/app/MrPacks$Catalog;->data:Ljava/lang/String;

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "checked_at"

    .line 531
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-interface {v1, v2, v4, v5}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 532
    return-object v0
.end method

.method private static head(Ljava/io/File;I)[B
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 946
    .line 948
    :try_start_0
    new-instance v2, Ljava/io/FileInputStream;

    invoke-direct {v2, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 949
    :try_start_1
    new-array v1, p1, [B

    .line 950
    const/4 v3, 0x0

    .line 951
    :goto_0
    if-ge v3, p1, :cond_1

    .line 952
    sub-int v4, p1, v3

    invoke-virtual {v2, v1, v3, v4}, Ljava/io/InputStream;->read([BII)I
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result v4

    .line 953
    if-gtz v4, :cond_0

    .line 960
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 958
    :goto_1
    return-object v0

    .line 954
    :cond_0
    add-int/2addr v3, v4

    .line 955
    goto :goto_0

    .line 960
    :cond_1
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    move-object v0, v1

    .line 956
    goto :goto_1

    .line 957
    :catch_0
    move-exception v1

    move-object v1, v0

    .line 960
    :goto_2
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    goto :goto_1

    :catchall_0
    move-exception v1

    move-object v2, v0

    move-object v0, v1

    :goto_3
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 961
    throw v0

    .line 960
    :catchall_1
    move-exception v0

    goto :goto_3

    .line 957
    :catch_1
    move-exception v1

    move-object v1, v2

    goto :goto_2
.end method

.method static hex([B)Ljava/lang/String;
    .locals 5

    .prologue
    .line 1213
    array-length v0, p0

    mul-int/lit8 v0, v0, 0x2

    new-array v1, v0, [C

    .line 1214
    const-string v0, "0123456789abcdef"

    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v2

    .line 1215
    const/4 v0, 0x0

    :goto_0
    array-length v3, p0

    if-ge v0, v3, :cond_0

    .line 1216
    mul-int/lit8 v3, v0, 0x2

    aget-byte v4, p0, v0

    shr-int/lit8 v4, v4, 0x4

    and-int/lit8 v4, v4, 0xf

    aget-char v4, v2, v4

    aput-char v4, v1, v3

    .line 1217
    mul-int/lit8 v3, v0, 0x2

    add-int/lit8 v3, v3, 0x1

    aget-byte v4, p0, v0

    and-int/lit8 v4, v4, 0xf

    aget-char v4, v2, v4

    aput-char v4, v1, v3

    .line 1215
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1219
    :cond_0
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/String;-><init>([C)V

    return-object v0
.end method

.method static hexField(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/String;"
        }
    .end annotation

    .prologue
    const/16 v4, 0x40

    .line 350
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    .line 351
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v0

    if-eq v0, v4, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 352
    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v4, :cond_4

    .line 353
    invoke-virtual {v1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 354
    const/16 v3, 0x30

    if-lt v2, v3, :cond_1

    const/16 v3, 0x39

    if-le v2, v3, :cond_3

    :cond_1
    const/16 v3, 0x61

    if-lt v2, v3, :cond_2

    const/16 v3, 0x66

    if-le v2, v3, :cond_3

    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 352
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 356
    :cond_4
    return-object v1
.end method

.method private static indexOf([Ljava/lang/String;Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 1223
    const/4 v0, 0x0

    :goto_0
    array-length v1, p0

    if-ge v0, v1, :cond_1

    aget-object v1, p0, v0

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1224
    :goto_1
    return v0

    .line 1223
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1224
    :cond_1
    const/4 v0, -0x1

    goto :goto_1
.end method

.method static install(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Catalog;Lcom/mrkeyboard/app/MrPacks$Pack;)V
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    const/4 v10, 0x0

    const/4 v1, 0x0

    .line 776
    sput-boolean v1, Lcom/mrkeyboard/app/MrPacks;->sCancel:Z

    .line 777
    sput v1, Lcom/mrkeyboard/app/MrPacks;->sJobPercent:I

    .line 778
    sput-boolean v1, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 779
    iget-object v0, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    .line 780
    iget-boolean v0, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->model:Z

    if-eqz v0, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->modelsRoot(Landroid/content/Context;)Ljava/io/File;

    move-result-object v0

    .line 781
    :goto_0
    new-instance v3, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v5, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "-"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ".zip.part"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v2, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 782
    new-instance v4, Ljava/io/File;

    new-instance v2, Ljava/io/File;

    iget-object v5, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-direct {v2, v0, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    iget v6, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ".tmp"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v2, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 784
    :try_start_0
    invoke-static {p0, p2}, Lcom/mrkeyboard/app/MrPacks;->appTooOld(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Pack;)Z

    move-result v2

    if-eqz v2, :cond_2

    new-instance v2, Lcom/mrkeyboard/app/MrPacks$PackException;

    iget-boolean v0, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->model:Z

    if-eqz v0, :cond_1

    const-string v0, "mr_gesture_err_app_old"

    :goto_1
    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-direct {v2, v0, v5}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 806
    :catchall_0
    move-exception v0

    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    .line 807
    invoke-static {v4}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 808
    sput-object v10, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    .line 809
    sput-boolean v1, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 810
    throw v0

    .line 780
    :cond_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->root(Landroid/content/Context;)Ljava/io/File;

    move-result-object v0

    goto :goto_0

    .line 784
    :cond_1
    :try_start_1
    const-string v0, "mr_dicts_err_app_old"

    goto :goto_1

    .line 785
    :cond_2
    iget-wide v6, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    iget-wide v8, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->installedSize:J

    add-long/2addr v6, v8

    const-wide/32 v8, 0x200000

    add-long/2addr v6, v8

    .line 786
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_3

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    .line 787
    :cond_3
    invoke-virtual {v0}, Ljava/io/File;->getUsableSpace()J

    move-result-wide v8

    cmp-long v2, v8, v6

    if-gez v2, :cond_4

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_dicts_err_space"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v8, 0x0

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v8

    invoke-direct {v0, v2, v5}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 788
    :cond_4
    invoke-static {p2}, Lcom/mrkeyboard/app/MrPacks;->zipUrl(Lcom/mrkeyboard/app/MrPacks$Pack;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v3, p2}, Lcom/mrkeyboard/app/MrPacks;->download(Ljava/lang/String;Ljava/io/File;Lcom/mrkeyboard/app/MrPacks$Pack;)V

    .line 789
    const/4 v2, 0x1

    sput-boolean v2, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 790
    invoke-static {v4}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 791
    invoke-static {v3, v4, p2}, Lcom/mrkeyboard/app/MrPacks;->extract(Ljava/io/File;Ljava/io/File;Lcom/mrkeyboard/app/MrPacks$Pack;)V

    .line 792
    iget-boolean v2, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->model:Z

    if-eqz v2, :cond_5

    invoke-static {v4}, Lcom/mrkeyboard/app/MrPacks;->checkModel(Ljava/io/File;)V

    .line 793
    :goto_2
    iget-boolean v2, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->model:Z

    if-eqz v2, :cond_6

    iget-object v2, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    iget v5, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    invoke-static {p0, v2, v5}, Lcom/mrkeyboard/app/MrPacks;->modelDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;

    move-result-object v2

    .line 794
    :goto_3
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 795
    invoke-virtual {v4, v2}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    move-result v2

    if-nez v2, :cond_7

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    invoke-static {p2}, Lcom/mrkeyboard/app/MrPacks;->ioKey(Lcom/mrkeyboard/app/MrPacks$Pack;)Ljava/lang/String;

    move-result-object v2

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    const-string v7, "rename"

    aput-object v7, v5, v6

    invoke-direct {v0, v2, v5}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 792
    :cond_5
    invoke-static {v4}, Lcom/mrkeyboard/app/MrPacks;->checkFiles(Ljava/io/File;)V

    goto :goto_2

    .line 793
    :cond_6
    iget-object v2, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    iget v5, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    invoke-static {p0, v2, v5}, Lcom/mrkeyboard/app/MrPacks;->packDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;

    move-result-object v2

    goto :goto_3

    .line 796
    :cond_7
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    iget-boolean v2, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->model:Z

    if-eqz v2, :cond_9

    const-string v2, "model."

    :goto_4
    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v6, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    iget v6, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    invoke-interface {v5, v2, v6}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 797
    new-instance v2, Ljava/io/File;

    iget-object v5, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-direct {v2, v0, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v2

    .line 798
    if-eqz v2, :cond_a

    .line 799
    array-length v5, v2

    move v0, v1

    :goto_5
    if-ge v0, v5, :cond_a

    aget-object v6, v2, v0

    .line 800
    invoke-virtual {v6}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v7

    iget v8, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    invoke-static {v8}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_8

    invoke-static {v6}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 799
    :cond_8
    add-int/lit8 v0, v0, 0x1

    goto :goto_5

    .line 796
    :cond_9
    const-string v2, "installed."

    goto :goto_4

    .line 804
    :cond_a
    iget-boolean v0, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->model:Z

    if-eqz v0, :cond_b

    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->reload(Landroid/content/Context;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 806
    :goto_6
    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    .line 807
    invoke-static {v4}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 808
    sput-object v10, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    .line 809
    sput-boolean v1, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 811
    return-void

    .line 804
    :cond_b
    :try_start_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->signal(Landroid/content/Context;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_6
.end method

.method static installModelFile(Landroid/content/Context;Ljava/io/InputStream;)V
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    .line 635
    new-instance v3, Ljava/io/File;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->modelsRoot(Landroid/content/Context;)Ljava/io/File;

    move-result-object v2

    const-string v4, "gesture"

    invoke-direct {v3, v2, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 636
    new-instance v6, Ljava/io/File;

    const-string v2, "file.tmp"

    invoke-direct {v6, v3, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 639
    :try_start_0
    invoke-static {v6}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 640
    invoke-virtual {v6}, Ljava/io/File;->mkdirs()Z

    move-result v2

    if-nez v2, :cond_0

    invoke-virtual {v6}, Ljava/io/File;->isDirectory()Z

    move-result v2

    if-nez v2, :cond_0

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_gesture_err_io"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    const-string v5, "mkdir"

    aput-object v5, v3, v4

    invoke-direct {v0, v2, v3}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 674
    :catch_0
    move-exception v0

    .line 675
    :goto_0
    :try_start_1
    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 679
    :catchall_0
    move-exception v0

    :goto_1
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 680
    invoke-static {v6}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 681
    throw v0

    .line 641
    :cond_0
    :try_start_2
    const-string v2, "SHA-256"

    invoke-static {v2}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v7

    .line 642
    new-instance v2, Ljava/io/FileOutputStream;

    new-instance v4, Ljava/io/File;

    const-string v5, "encoder.bin"

    invoke-direct {v4, v6, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-direct {v2, v4}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_2
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_3
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 643
    const/high16 v4, 0x10000

    :try_start_3
    new-array v8, v4, [B

    .line 644
    const-wide/16 v4, 0x0

    .line 646
    :goto_2
    invoke-virtual {p1, v8}, Ljava/io/InputStream;->read([B)I

    move-result v9

    if-lez v9, :cond_2

    .line 647
    int-to-long v10, v9

    add-long/2addr v4, v10

    .line 648
    const-wide/32 v10, 0x1000000

    cmp-long v10, v4, v10

    if-lez v10, :cond_1

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_gesture_err_file"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-direct {v0, v1, v3}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 674
    :catch_1
    move-exception v0

    move-object v1, v2

    goto :goto_0

    .line 649
    :cond_1
    const/4 v10, 0x0

    invoke-virtual {v7, v8, v10, v9}, Ljava/security/MessageDigest;->update([BII)V

    .line 650
    const/4 v10, 0x0

    invoke-virtual {v2, v8, v10, v9}, Ljava/io/OutputStream;->write([BII)V
    :try_end_3
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_2

    .line 676
    :catch_2
    move-exception v0

    move-object v1, v2

    .line 677
    :goto_3
    :try_start_4
    new-instance v2, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v3, "mr_gesture_err_io"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v4, v5

    invoke-direct {v2, v3, v4}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v2
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 652
    :cond_2
    :try_start_5
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_5
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_5 .. :try_end_5} :catch_1
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_2
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 654
    :try_start_6
    invoke-virtual {v7}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->hex([B)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->knownModelFile(Ljava/lang/String;)I

    move-result v4

    .line 655
    if-gtz v4, :cond_3

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_gesture_err_file"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-direct {v0, v2, v3}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 676
    :catch_3
    move-exception v0

    goto :goto_3

    .line 656
    :cond_3
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->modelLicense(Landroid/content/Context;)[B

    move-result-object v5

    .line 657
    if-nez v5, :cond_4

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_gesture_err_io"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    const-string v5, "LICENSE-FUTO-Model-Weights.md"

    aput-object v5, v3, v4

    invoke-direct {v0, v2, v3}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 658
    :cond_4
    new-instance v2, Ljava/io/FileOutputStream;

    new-instance v7, Ljava/io/File;

    const-string v8, "LICENSE-FUTO-Model-Weights.md"

    invoke-direct {v7, v6, v8}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-direct {v2, v7}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_6
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_6 .. :try_end_6} :catch_0
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_3
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 659
    :try_start_7
    invoke-virtual {v2, v5}, Ljava/io/OutputStream;->write([B)V

    .line 660
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_7
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_7 .. :try_end_7} :catch_5
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_4
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    .line 662
    :try_start_8
    invoke-static {v6}, Lcom/mrkeyboard/app/MrPacks;->checkModel(Ljava/io/File;)V

    .line 663
    const-string v2, "gesture"

    invoke-static {p0, v2, v4}, Lcom/mrkeyboard/app/MrPacks;->modelDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;

    move-result-object v2

    .line 664
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 665
    invoke-virtual {v6, v2}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    move-result v2

    if-nez v2, :cond_5

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_gesture_err_io"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    const-string v5, "rename"

    aput-object v5, v3, v4

    invoke-direct {v0, v2, v3}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 666
    :cond_5
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    const-string v5, "model.gesture"

    invoke-interface {v2, v5, v4}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 667
    invoke-virtual {v3}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v2

    .line 668
    if-eqz v2, :cond_7

    .line 669
    array-length v3, v2

    :goto_4
    if-ge v0, v3, :cond_7

    aget-object v5, v2, v0

    .line 670
    invoke-virtual {v5}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_6

    invoke-static {v5}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 669
    :cond_6
    add-int/lit8 v0, v0, 0x1

    goto :goto_4

    .line 673
    :cond_7
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->reload(Landroid/content/Context;)V
    :try_end_8
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_8 .. :try_end_8} :catch_0
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_3
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    .line 679
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 680
    invoke-static {v6}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 682
    return-void

    .line 679
    :catchall_1
    move-exception v0

    move-object v1, v2

    goto/16 :goto_1

    :catchall_2
    move-exception v0

    move-object v1, v2

    goto/16 :goto_1

    .line 676
    :catch_4
    move-exception v0

    move-object v1, v2

    goto/16 :goto_3

    .line 674
    :catch_5
    move-exception v0

    move-object v1, v2

    goto/16 :goto_0
.end method

.method static installedFor(Landroid/content/Context;Ljava/lang/String;)Ljava/io/File;
    .locals 10

    .prologue
    const/4 v9, 0x0

    const/4 v2, 0x0

    const/4 v8, 0x1

    .line 995
    invoke-static {p1}, Lcom/mrkeyboard/app/MrPacks;->splitLocale(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v3

    .line 996
    aget-object v0, v3, v9

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    .line 1005
    :cond_0
    :goto_0
    return-object v2

    .line 998
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->installedIds(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    move-object v1, v2

    :cond_2
    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 999
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->splitLocale(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    .line 1000
    aget-object v6, v5, v9

    aget-object v7, v3, v9

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 1001
    if-eqz v1, :cond_3

    aget-object v5, v5, v8

    aget-object v6, v3, v8

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_5

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->splitLocale(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    aget-object v5, v5, v8

    aget-object v6, v3, v8

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_5

    :cond_3
    :goto_2
    move-object v1, v0

    .line 1002
    goto :goto_1

    .line 1003
    :cond_4
    if-eqz v1, :cond_0

    .line 1004
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrPacks;->installedVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    invoke-static {p0, v1, v0}, Lcom/mrkeyboard/app/MrPacks;->packDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;

    move-result-object v0

    .line 1005
    new-instance v1, Ljava/io/File;

    const-string v3, "main.dict"

    invoke-direct {v1, v0, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->isFile()Z

    move-result v1

    if-eqz v1, :cond_0

    move-object v2, v0

    goto :goto_0

    :cond_5
    move-object v0, v1

    goto :goto_2
.end method

.method static installedIds(Landroid/content/Context;)Ljava/util/ArrayList;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 541
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 542
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->getAll()Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 543
    const-string v3, "installed."

    invoke-virtual {v0, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 544
    const-string v3, "installed."

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v0, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 545
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->validId(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 548
    :cond_1
    invoke-static {v1}, Ljava/util/Collections;->sort(Ljava/util/List;)V

    .line 549
    return-object v1
.end method

.method static installedVersion(Landroid/content/Context;Ljava/lang/String;)I
    .locals 3

    .prologue
    .line 536
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "installed."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method private static ioKey(Lcom/mrkeyboard/app/MrPacks$Pack;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 815
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrPacks$Pack;->model:Z

    if-eqz v0, :cond_0

    const-string v0, "mr_gesture_err_io"

    :goto_0
    return-object v0

    :cond_0
    const-string v0, "mr_dicts_err_io"

    goto :goto_0
.end method

.method static knownModelFile(Ljava/lang/String;)I
    .locals 6

    .prologue
    const/4 v0, 0x0

    .line 599
    sget-object v2, Lcom/mrkeyboard/app/MrPacks;->MODEL_FILES:[[Ljava/lang/String;

    array-length v3, v2

    move v1, v0

    :goto_0
    if-ge v1, v3, :cond_0

    aget-object v4, v2, v1

    .line 600
    aget-object v5, v4, v0

    invoke-virtual {v5, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/4 v0, 0x1

    aget-object v0, v4, v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    .line 602
    :cond_0
    return v0

    .line 599
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0
.end method

.method static languageKeys(Ljava/util/List;Ljava/util/List;)Ljava/lang/String;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .prologue
    .line 724
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 725
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-interface {p1, v0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    const/16 v3, 0x2d

    const/16 v4, 0x5f

    invoke-virtual {v0, v3, v4}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v3, 0x2c

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 726
    :cond_1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x0

    :goto_1
    return-object v0

    :cond_2
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method static localized(Ljava/util/Map;Ljava/util/Locale;Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;",
            "Ljava/util/Locale;",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/String;"
        }
    .end annotation

    .prologue
    .line 171
    if-nez p0, :cond_1

    .line 178
    :cond_0
    :goto_0
    return-object p2

    .line 172
    :cond_1
    if-eqz p1, :cond_4

    invoke-virtual {p1}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 173
    :goto_1
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_2

    const-string v0, "en"

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 174
    :cond_2
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_5

    .line 175
    invoke-interface {p0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_3
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    instance-of v2, v0, Ljava/lang/String;

    if-eqz v2, :cond_3

    check-cast v0, Ljava/lang/String;

    move-object p2, v0

    goto :goto_0

    .line 172
    :cond_4
    const/4 v0, 0x0

    goto :goto_1

    .line 178
    :cond_5
    check-cast v0, Ljava/lang/String;

    move-object p2, v0

    goto :goto_0
.end method

.method private static lowerLetters(Ljava/lang/String;II)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 380
    sub-int v1, p2, p1

    const/4 v2, 0x2

    if-ge v1, v2, :cond_2

    .line 385
    :cond_0
    :goto_0
    return v0

    .line 381
    :cond_1
    add-int/lit8 p1, p1, 0x1

    :cond_2
    if-ge p1, p2, :cond_3

    .line 382
    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 383
    const/16 v2, 0x61

    if-lt v1, v2, :cond_0

    const/16 v2, 0x7a

    if-le v1, v2, :cond_1

    goto :goto_0

    .line 385
    :cond_3
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public static mainDictionary(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/BinaryDictionary;
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 1053
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->init(Landroid/content/Context;)V

    .line 1054
    invoke-static {p1}, Lcom/mrkeyboard/app/MrPacks;->splitLocale(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x0

    aget-object v0, v0, v2

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sLastLang:Ljava/lang/String;

    .line 1058
    :try_start_0
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->installedFor(Landroid/content/Context;Ljava/lang/String;)Ljava/io/File;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 1059
    if-eqz v2, :cond_2

    :try_start_1
    new-instance v0, Ljava/io/File;

    const-string v3, "main.dict"

    invoke-direct {v0, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPacks;->open(Landroid/content/Context;Ljava/io/File;)Lcom/mrkeyboard/app/BinaryDictionary;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v0

    :goto_0
    move-object v4, v2

    move-object v2, v0

    move-object v0, v4

    .line 1063
    :goto_1
    if-eqz v2, :cond_0

    move-object v1, v0

    :cond_0
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->activate(Ljava/io/File;)V

    .line 1064
    if-eqz v2, :cond_1

    move-object v0, v2

    .line 1065
    :goto_2
    return-object v0

    .line 1060
    :catch_0
    move-exception v0

    move-object v0, v1

    :goto_3
    move-object v2, v1

    .line 1061
    goto :goto_1

    .line 1065
    :cond_1
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/PluginManager;->getDictionary(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v0

    goto :goto_2

    .line 1060
    :catch_1
    move-exception v0

    move-object v0, v2

    goto :goto_3

    :cond_2
    move-object v0, v1

    goto :goto_0
.end method

.method static modelDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;
    .locals 3

    .prologue
    .line 574
    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/io/File;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->modelsRoot(Landroid/content/Context;)Ljava/io/File;

    move-result-object v2

    invoke-direct {v1, v2, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {p2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method static modelFile(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 584
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->modelVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v2

    .line 585
    if-gtz v2, :cond_0

    .line 587
    :goto_0
    return-object v1

    .line 586
    :cond_0
    new-instance v0, Ljava/io/File;

    invoke-static {p0, p1, v2}, Lcom/mrkeyboard/app/MrPacks;->modelDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;

    move-result-object v2

    invoke-direct {v0, v2, p2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 587
    invoke-virtual {v0}, Ljava/io/File;->isFile()Z

    move-result v2

    if-eqz v2, :cond_1

    :goto_1
    move-object v1, v0

    goto :goto_0

    :cond_1
    move-object v0, v1

    goto :goto_1
.end method

.method static modelLicense(Landroid/content/Context;)[B
    .locals 8

    .prologue
    const/4 v0, 0x0

    .line 607
    .line 609
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "mr_futo_license"

    const-string v3, "raw"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v1

    .line 610
    if-nez v1, :cond_0

    .line 624
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 622
    :goto_0
    return-object v0

    .line 611
    :cond_0
    :try_start_1
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/content/res/Resources;->openRawResource(I)Ljava/io/InputStream;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v1

    .line 612
    if-nez v1, :cond_1

    .line 624
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    goto :goto_0

    .line 613
    :cond_1
    :try_start_2
    new-instance v2, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v2}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 614
    const/16 v3, 0x2000

    new-array v3, v3, [B

    .line 616
    :goto_1
    invoke-virtual {v1, v3}, Ljava/io/InputStream;->read([B)I

    move-result v4

    if-lez v4, :cond_3

    .line 617
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->size()I
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-result v5

    add-int/2addr v5, v4

    const/high16 v6, 0x100000

    if-le v5, v6, :cond_2

    .line 624
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    goto :goto_0

    .line 618
    :cond_2
    const/4 v5, 0x0

    :try_start_3
    invoke-virtual {v2, v3, v5, v4}, Ljava/io/ByteArrayOutputStream;->write([BII)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_1

    .line 621
    :catch_0
    move-exception v2

    .line 624
    :goto_2
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    goto :goto_0

    .line 620
    :cond_3
    :try_start_4
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    move-result-object v0

    .line 624
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    goto :goto_0

    :catchall_0
    move-exception v1

    move-object v7, v1

    move-object v1, v0

    move-object v0, v7

    :goto_3
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 625
    throw v0

    .line 624
    :catchall_1
    move-exception v0

    goto :goto_3

    .line 621
    :catch_1
    move-exception v1

    move-object v1, v0

    goto :goto_2
.end method

.method static modelVersion(Landroid/content/Context;Ljava/lang/String;)I
    .locals 3

    .prologue
    .line 579
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "model."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method static modelsRoot(Landroid/content/Context;)Ljava/io/File;
    .locals 3

    .prologue
    .line 570
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "models"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method static offerList(Landroid/content/Context;)Ljava/util/List;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/List",
            "<",
            "Ljava/lang/CharSequence;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    const/4 v3, 0x0

    .line 1110
    :try_start_0
    sget-object v4, Lcom/mrkeyboard/app/MrPacks;->sLastLang:Ljava/lang/String;

    .line 1111
    if-eqz p0, :cond_0

    if-eqz v4, :cond_0

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    move-object v0, v3

    .line 1133
    :goto_0
    return-object v0

    .line 1112
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->cachedCatalog(Landroid/content/Context;)Lcom/mrkeyboard/app/MrPacks$Catalog;

    move-result-object v0

    .line 1113
    if-eqz v0, :cond_3

    .line 1115
    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacks$Catalog;->packs:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrPacks$Pack;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->lang:Ljava/lang/String;

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_9

    move v0, v1

    :goto_2
    move v2, v0

    goto :goto_1

    .line 1116
    :cond_2
    if-nez v2, :cond_3

    move-object v0, v3

    goto :goto_0

    .line 1118
    :cond_3
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    .line 1119
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sOfferLabel:Ljava/lang/String;

    .line 1120
    if-eqz v0, :cond_4

    sget-wide v6, Lcom/mrkeyboard/app/MrPacks;->sOfferAt:J

    sub-long v6, v4, v6

    const-wide/16 v8, 0x7530

    cmp-long v1, v6, v8

    if-lez v1, :cond_5

    .line 1121
    :cond_4
    const-string v0, "mr_dicts_offer"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 1122
    sput-wide v4, Lcom/mrkeyboard/app/MrPacks;->sOfferAt:J

    .line 1124
    :cond_5
    if-nez v0, :cond_6

    move-object v0, v3

    goto :goto_0

    .line 1125
    :cond_6
    sget-object v1, Lcom/mrkeyboard/app/MrPacks;->sOffer:Ljava/lang/String;

    if-eqz v1, :cond_7

    sget-object v1, Lcom/mrkeyboard/app/MrPacks;->sOfferLabel:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_8

    .line 1126
    :cond_7
    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sOfferLabel:Ljava/lang/String;

    .line 1127
    new-instance v1, Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>([C)V

    sput-object v1, Lcom/mrkeyboard/app/MrPacks;->sOffer:Ljava/lang/String;

    .line 1129
    :cond_8
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 1130
    sget-object v1, Lcom/mrkeyboard/app/MrPacks;->sOffer:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1132
    :catch_0
    move-exception v0

    move-object v0, v3

    .line 1133
    goto :goto_0

    :cond_9
    move v0, v2

    goto :goto_2
.end method

.method public static onPick(Landroid/content/Context;Ljava/lang/CharSequence;)Z
    .locals 1

    .prologue
    .line 1139
    if-eqz p1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sOffer:Ljava/lang/String;

    if-eq p1, v0, :cond_1

    :cond_0
    const/4 v0, 0x0

    .line 1145
    :goto_0
    return v0

    .line 1141
    :cond_1
    :try_start_0
    const-class v0, Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrNav;->intent(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1145
    :goto_1
    const/4 v0, 0x1

    goto :goto_0

    .line 1142
    :catch_0
    move-exception v0

    goto :goto_1
.end method

.method static open(Landroid/content/Context;Ljava/io/File;)Lcom/mrkeyboard/app/BinaryDictionary;
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v6, 0x0

    .line 1020
    invoke-static {p1}, Lcom/mrkeyboard/app/MrPacks;->dictHeaderOk(Ljava/io/File;)Z

    move-result v0

    if-nez v0, :cond_0

    move-object v0, v6

    .line 1033
    :goto_0
    return-object v0

    .line 1021
    :cond_0
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v8

    .line 1022
    new-instance v7, Ljava/io/RandomAccessFile;

    const-string v0, "r"

    invoke-direct {v7, p1, v0}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 1024
    :try_start_0
    invoke-virtual {v7}, Ljava/io/RandomAccessFile;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v0

    .line 1025
    sget-object v1, Ljava/nio/channels/FileChannel$MapMode;->READ_ONLY:Ljava/nio/channels/FileChannel$MapMode;

    const-wide/16 v2, 0x0

    invoke-virtual {v0}, Ljava/nio/channels/FileChannel;->size()J

    move-result-wide v4

    invoke-virtual/range {v0 .. v5}, Ljava/nio/channels/FileChannel;->map(Ljava/nio/channels/FileChannel$MapMode;JJ)Ljava/nio/MappedByteBuffer;

    move-result-object v1

    .line 1026
    new-instance v0, Lcom/mrkeyboard/app/BinaryDictionary;

    const/4 v2, 0x1

    invoke-direct {v0, p0, v1, v2}, Lcom/mrkeyboard/app/BinaryDictionary;-><init>(Landroid/content/Context;Ljava/nio/ByteBuffer;I)V

    .line 1027
    invoke-virtual {v0}, Lcom/mrkeyboard/app/BinaryDictionary;->getSize()I

    move-result v1

    const/4 v2, 0x2

    if-gt v1, v2, :cond_1

    .line 1028
    invoke-virtual {v0}, Lcom/mrkeyboard/app/BinaryDictionary;->close()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1035
    invoke-virtual {v7}, Ljava/io/RandomAccessFile;->close()V

    move-object v0, v6

    .line 1029
    goto :goto_0

    .line 1031
    :cond_1
    :try_start_1
    invoke-virtual {p1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/mrkeyboard/app/MrDiag;->sDictPath:Ljava/lang/String;

    .line 1032
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v2

    sub-long/2addr v2, v8

    sput-wide v2, Lcom/mrkeyboard/app/MrDiag;->sDictNs:J
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1035
    invoke-virtual {v7}, Ljava/io/RandomAccessFile;->close()V

    goto :goto_0

    :catchall_0
    move-exception v0

    invoke-virtual {v7}, Ljava/io/RandomAccessFile;->close()V

    .line 1036
    throw v0
.end method

.method static openDictionary(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/BinaryDictionary;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 1011
    if-nez p0, :cond_1

    .line 1015
    :cond_0
    :goto_0
    return-object v0

    .line 1012
    :cond_1
    :try_start_0
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->installedFor(Landroid/content/Context;Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    .line 1013
    if-eqz v1, :cond_0

    new-instance v2, Ljava/io/File;

    const-string v3, "main.dict"

    invoke-direct {v2, v1, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrPacks;->open(Landroid/content/Context;Ljava/io/File;)Lcom/mrkeyboard/app/BinaryDictionary;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 1014
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static packDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;
    .locals 3

    .prologue
    .line 748
    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/io/File;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->root(Landroid/content/Context;)Ljava/io/File;

    move-result-object v2

    invoke-direct {v1, v2, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {p2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method static parseCatalog([B[Ljava/security/cert/X509Certificate;J)Lcom/mrkeyboard/app/MrPacks$Catalog;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    .line 186
    const/4 v0, 0x1

    const-string v1, "mr-keyboard/catalog/v1\n"

    const-string v2, "catalog.json"

    invoke-static {p0, v0, v1, v2, p1}, Lcom/mrkeyboard/app/MrPacks;->verifySigned([BILjava/lang/String;Ljava/lang/String;[Ljava/security/cert/X509Certificate;)Ljava/lang/String;

    move-result-object v0

    .line 187
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->readData(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Catalog;

    move-result-object v0

    .line 188
    iget-wide v2, v0, Lcom/mrkeyboard/app/MrPacks$Catalog;->serial:J

    cmp-long v1, v2, p2

    if-gez v1, :cond_0

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_old_catalog"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 189
    :cond_0
    return-object v0
.end method

.method static prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .locals 2

    .prologue
    .line 501
    const-string v0, "mr_packs"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method static readData(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Catalog;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    const/4 v7, 0x1

    const/4 v6, 0x0

    .line 258
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrJson;->parse(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrJson;->obj(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v0

    .line 259
    const-string v1, "format"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v2

    const-wide/16 v4, 0x1

    cmp-long v1, v2, v4

    if-eqz v1, :cond_0

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_new_format"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1

    .line 281
    :catch_0
    move-exception v0

    .line 282
    throw v0

    .line 260
    :cond_0
    :try_start_1
    new-instance v1, Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-direct {v1}, Lcom/mrkeyboard/app/MrPacks$Catalog;-><init>()V

    .line 261
    iput-object p0, v1, Lcom/mrkeyboard/app/MrPacks$Catalog;->data:Ljava/lang/String;

    .line 262
    const-string v2, "serial"

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v2

    iput-wide v2, v1, Lcom/mrkeyboard/app/MrPacks$Catalog;->serial:J

    .line 263
    const-string v2, "generated"

    const-string v3, ""

    invoke-static {v0, v2, v3}, Lcom/mrkeyboard/app/MrJson;->optStr(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/mrkeyboard/app/MrPacks$Catalog;->generated:Ljava/lang/String;

    .line 264
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    .line 265
    const-string v3, "packs"

    invoke-interface {v0, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrJson;->list(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_1
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .line 266
    invoke-static {v4}, Lcom/mrkeyboard/app/MrJson;->obj(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v4

    const/4 v5, 0x0

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrPacks;->readPack(Ljava/util/Map;Z)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v4

    .line 267
    iget-object v5, v4, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-virtual {v2, v5}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    iget-object v5, v1, Lcom/mrkeyboard/app/MrPacks$Catalog;->packs:Ljava/util/ArrayList;

    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 283
    :catch_1
    move-exception v0

    .line 284
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_corrupt"

    new-array v2, v7, [Ljava/lang/Object;

    const-string v3, "catalog.json"

    aput-object v3, v2, v6

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 269
    :cond_2
    :try_start_2
    const-string v2, "models"

    invoke-interface {v0, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 270
    instance-of v2, v0, Ljava/util/List;

    if-eqz v2, :cond_4

    .line 271
    check-cast v0, Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_3
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    :try_end_2
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_1

    move-result-object v2

    .line 273
    :try_start_3
    invoke-static {v2}, Lcom/mrkeyboard/app/MrJson;->obj(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v2

    const/4 v3, 0x1

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrPacks;->readPack(Ljava/util/Map;Z)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v2

    .line 274
    iget-object v3, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-virtual {v1, v3}, Lcom/mrkeyboard/app/MrPacks$Catalog;->model(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v3

    if-nez v3, :cond_3

    iget-object v3, v1, Lcom/mrkeyboard/app/MrPacks$Catalog;->models:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_3
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_2
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_1

    .line 275
    :catch_2
    move-exception v2

    goto :goto_1

    .line 280
    :cond_4
    return-object v1
.end method

.method private static readPack(Ljava/util/Map;Z)Lcom/mrkeyboard/app/MrPacks$Pack;
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;Z)",
            "Lcom/mrkeyboard/app/MrPacks$Pack;"
        }
    .end annotation

    .prologue
    .line 291
    new-instance v3, Lcom/mrkeyboard/app/MrPacks$Pack;

    invoke-direct {v3}, Lcom/mrkeyboard/app/MrPacks$Pack;-><init>()V

    .line 292
    iput-boolean p1, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->model:Z

    .line 293
    const-string v0, "id"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    .line 294
    if-eqz p1, :cond_1

    iget-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->validModelId(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "id"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    iget-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->validId(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 295
    :cond_2
    if-eqz p1, :cond_3

    const-string v0, ""

    :goto_0
    iput-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->lang:Ljava/lang/String;

    .line 296
    if-eqz p1, :cond_4

    const-string v0, ""

    :goto_1
    iput-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->region:Ljava/lang/String;

    .line 297
    const-string v0, "name"

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 298
    instance-of v1, v0, Ljava/util/Map;

    if-eqz v1, :cond_5

    check-cast v0, Ljava/util/Map;

    :goto_2
    iput-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->name:Ljava/util/Map;

    .line 299
    const-string v0, "description"

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 300
    instance-of v1, v0, Ljava/util/Map;

    if-eqz v1, :cond_6

    check-cast v0, Ljava/util/Map;

    :goto_3
    iput-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->description:Ljava/util/Map;

    .line 301
    const-string v0, "version"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v0

    long-to-int v0, v0

    iput v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    .line 302
    const-string v0, "format"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v0

    long-to-int v0, v0

    iput v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->format:I

    .line 303
    const-string v0, "minApp"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->minApp:J

    .line 304
    const-string v0, "release"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->release:Ljava/lang/String;

    .line 305
    iget-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->release:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->validTag(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_7

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "release"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 295
    :cond_3
    const-string v0, "lang"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 296
    :cond_4
    const-string v0, "region"

    const-string v1, ""

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrJson;->optStr(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 298
    :cond_5
    const/4 v0, 0x0

    goto :goto_2

    .line 300
    :cond_6
    const/4 v0, 0x0

    goto :goto_3

    .line 306
    :cond_7
    const-string v0, "url"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->url:Ljava/lang/String;

    .line 307
    iget-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->url:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->safeName(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_8

    iget-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->url:Ljava/lang/String;

    const-string v1, ".zip"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_9

    :cond_8
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "url"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 308
    :cond_9
    const-string v0, "size"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    .line 309
    const-string v0, "installedSize"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->installedSize:J

    .line 310
    iget v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    const/4 v1, 0x1

    if-lt v0, v1, :cond_a

    iget-wide v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    const-wide/16 v4, 0x0

    cmp-long v0, v0, v4

    if-lez v0, :cond_a

    iget-wide v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    const-wide/32 v4, 0x4000000

    cmp-long v0, v0, v4

    if-gtz v0, :cond_a

    iget-wide v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->installedSize:J

    const-wide/16 v4, 0x0

    cmp-long v0, v0, v4

    if-lez v0, :cond_a

    iget-wide v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->installedSize:J

    const-wide/32 v4, 0x4000000

    cmp-long v0, v0, v4

    if-lez v0, :cond_b

    .line 311
    :cond_a
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "size"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 313
    :cond_b
    const-string v0, "sha256"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPacks;->hexField(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->sha256:Ljava/lang/String;

    .line 314
    const-string v0, "manifestSha256"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPacks;->hexField(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->manifestSha:Ljava/lang/String;

    .line 315
    const-string v0, "files"

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrJson;->list(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v4

    .line 316
    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v5

    .line 317
    if-eqz v5, :cond_c

    const/16 v0, 0x20

    if-le v5, v0, :cond_d

    :cond_c
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "files"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 318
    :cond_d
    new-array v0, v5, [Ljava/lang/String;

    iput-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->fileNames:[Ljava/lang/String;

    .line 319
    new-array v0, v5, [J

    iput-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSizes:[J

    .line 320
    new-array v0, v5, [Ljava/lang/String;

    iput-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSha:[Ljava/lang/String;

    .line 321
    const/4 v1, 0x0

    .line 322
    new-instance v6, Ljava/util/HashSet;

    invoke-direct {v6}, Ljava/util/HashSet;-><init>()V

    .line 323
    const/4 v0, 0x0

    move v2, v0

    :goto_4
    if-ge v2, v5, :cond_13

    .line 324
    invoke-interface {v4, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrJson;->obj(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v0

    .line 325
    const-string v7, "name"

    invoke-static {v0, v7}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 326
    invoke-static {v7}, Lcom/mrkeyboard/app/MrPacks;->safeName(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_e

    const-string v8, "pack.json"

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_e

    invoke-virtual {v6, v7}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_f

    :cond_e
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "name"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 327
    :cond_f
    iget-object v8, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->fileNames:[Ljava/lang/String;

    aput-object v7, v8, v2

    .line 328
    iget-object v8, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSizes:[J

    const-string v9, "size"

    invoke-static {v0, v9}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v10

    aput-wide v10, v8, v2

    .line 329
    iget-object v8, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSizes:[J

    aget-wide v8, v8, v2

    const-wide/16 v10, 0x0

    cmp-long v8, v8, v10

    if-lez v8, :cond_10

    iget-object v8, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSizes:[J

    aget-wide v8, v8, v2

    const-wide/32 v10, 0x4000000

    cmp-long v8, v8, v10

    if-lez v8, :cond_11

    :cond_10
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "size"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 330
    :cond_11
    iget-object v8, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSha:[Ljava/lang/String;

    const-string v9, "sha256"

    invoke-static {v0, v9}, Lcom/mrkeyboard/app/MrPacks;->hexField(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v8, v2

    .line 331
    if-eqz p1, :cond_12

    const-string v0, "encoder.bin"

    :goto_5
    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_19

    const/4 v0, 0x1

    .line 323
    :goto_6
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    move v1, v0

    goto :goto_4

    .line 331
    :cond_12
    const-string v0, "main.dict"

    goto :goto_5

    .line 333
    :cond_13
    if-nez v1, :cond_15

    new-instance v1, Ljava/lang/IllegalArgumentException;

    if-eqz p1, :cond_14

    const-string v0, "no encoder.bin"

    :goto_7
    invoke-direct {v1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_14
    const-string v0, "no main.dict"

    goto :goto_7

    .line 334
    :cond_15
    const-string v0, "licenses"

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 335
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 336
    instance-of v2, v0, Ljava/util/List;

    if-eqz v2, :cond_18

    .line 337
    check-cast v0, Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_16
    :goto_8
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_18

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    .line 338
    instance-of v4, v0, Ljava/lang/String;

    if-eqz v4, :cond_16

    .line 339
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->length()I

    move-result v4

    if-lez v4, :cond_17

    const-string v4, ", "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 340
    :cond_17
    check-cast v0, Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_8

    .line 344
    :cond_18
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->licenses:Ljava/lang/String;

    .line 345
    const-string v0, "credits"

    const-string v1, ""

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrJson;->optStr(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->credits:Ljava/lang/String;

    .line 346
    return-object v3

    :cond_19
    move v0, v1

    goto :goto_6
.end method

.method static remove(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 966
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "installed."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 967
    new-instance v0, Ljava/io/File;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->root(Landroid/content/Context;)Ljava/io/File;

    move-result-object v1

    invoke-direct {v0, v1, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 968
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->signal(Landroid/content/Context;)V

    .line 969
    return-void
.end method

.method static removeModel(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 592
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "model."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 593
    new-instance v0, Ljava/io/File;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->modelsRoot(Landroid/content/Context;)Ljava/io/File;

    move-result-object v1

    invoke-direct {v0, v1, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 594
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGestureInput;->reload(Landroid/content/Context;)V

    .line 595
    return-void
.end method

.method static root(Landroid/content/Context;)Ljava/io/File;
    .locals 3

    .prologue
    .line 744
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "dicts"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method static safeName(Ljava/lang/String;)Z
    .locals 8

    .prologue
    const/16 v7, 0x41

    const/16 v6, 0x39

    const/16 v5, 0x30

    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 413
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v3, 0x40

    if-le v0, v3, :cond_1

    .line 422
    :cond_0
    :goto_0
    return v1

    .line 414
    :cond_1
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 415
    const/16 v3, 0x61

    if-lt v0, v3, :cond_2

    const/16 v3, 0x7a

    if-le v0, v3, :cond_4

    :cond_2
    if-lt v0, v7, :cond_3

    const/16 v3, 0x5a

    if-le v0, v3, :cond_4

    :cond_3
    if-lt v0, v5, :cond_0

    if-gt v0, v6, :cond_0

    :cond_4
    move v0, v1

    .line 416
    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v0, v3, :cond_a

    .line 417
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 418
    const/16 v4, 0x61

    if-lt v3, v4, :cond_5

    const/16 v4, 0x7a

    if-le v3, v4, :cond_8

    :cond_5
    if-lt v3, v7, :cond_6

    const/16 v4, 0x5a

    if-le v3, v4, :cond_8

    :cond_6
    if-lt v3, v5, :cond_7

    if-le v3, v6, :cond_8

    :cond_7
    const/16 v4, 0x2e

    if-eq v3, v4, :cond_8

    const/16 v4, 0x5f

    if-eq v3, v4, :cond_8

    const/16 v4, 0x2d

    if-ne v3, v4, :cond_9

    :cond_8
    move v3, v2

    .line 420
    :goto_2
    if-eqz v3, :cond_0

    .line 416
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_9
    move v3, v1

    .line 418
    goto :goto_2

    .line 422
    :cond_a
    const-string v0, ".."

    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    move v1, v2

    goto :goto_0
.end method

.method static signal(Landroid/content/Context;)V
    .locals 4

    .prologue
    .line 973
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "mr_dicts_updated_at"

    .line 974
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 975
    return-void
.end method

.method static sizeText(J)Ljava/lang/String;
    .locals 6

    .prologue
    const-wide v0, 0x3fb999999999999aL    # 0.1

    .line 1207
    long-to-double v2, p0

    const-wide v4, 0x412e848000000000L    # 1000000.0

    div-double/2addr v2, v4

    .line 1208
    cmpg-double v4, v2, v0

    if-gez v4, :cond_0

    .line 1209
    :goto_0
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v2

    const-string v3, "%.1f MB"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    invoke-static {v0, v1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v0

    aput-object v0, v4, v5

    invoke-static {v2, v3, v4}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    move-wide v0, v2

    goto :goto_0
.end method

.method static splitLocale(Ljava/lang/String;)[Ljava/lang/String;
    .locals 9

    .prologue
    const/16 v8, 0x5f

    const/16 v7, 0x2d

    const/4 v6, 0x2

    const/4 v5, 0x1

    const/4 v4, 0x0

    .line 981
    if-nez p0, :cond_0

    new-array v0, v6, [Ljava/lang/String;

    const-string v1, ""

    aput-object v1, v0, v4

    const-string v1, ""

    aput-object v1, v0, v5

    .line 990
    :goto_0
    return-object v0

    .line 982
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    .line 983
    invoke-virtual {v1, v8}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    .line 984
    if-gez v0, :cond_5

    invoke-virtual {v1, v7}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    move v2, v0

    .line 985
    :goto_1
    if-gez v2, :cond_3

    move-object v0, v1

    :goto_2
    sget-object v3, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v3

    .line 986
    if-gez v2, :cond_4

    const-string v0, ""

    .line 987
    :goto_3
    invoke-virtual {v0, v8}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    .line 988
    if-gez v1, :cond_1

    invoke-virtual {v0, v7}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    .line 989
    :cond_1
    if-ltz v1, :cond_2

    invoke-virtual {v0, v4, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 990
    :cond_2
    new-array v1, v6, [Ljava/lang/String;

    aput-object v3, v1, v4

    aput-object v0, v1, v5

    move-object v0, v1

    goto :goto_0

    .line 985
    :cond_3
    invoke-virtual {v1, v4, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    .line 986
    :cond_4
    add-int/lit8 v0, v2, 0x1

    invoke-virtual {v1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    goto :goto_3

    :cond_5
    move v2, v0

    goto :goto_1
.end method

.method static syncLanguages(Landroid/content/Context;Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 734
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->installedIds(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrPacks;->languageKeys(Ljava/util/List;Ljava/util/List;)Ljava/lang/String;

    move-result-object v0

    .line 735
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 736
    const-string v2, "selected_languages"

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 737
    if-nez v0, :cond_1

    if-nez v2, :cond_2

    .line 741
    :cond_0
    :goto_0
    return-void

    .line 737
    :cond_1
    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 738
    :cond_2
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    .line 739
    if-nez v0, :cond_3

    const-string v0, "selected_languages"

    invoke-interface {v1, v0}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 740
    :goto_1
    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    goto :goto_0

    .line 739
    :cond_3
    const-string v2, "selected_languages"

    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    goto :goto_1
.end method

.method static varargs text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 1150
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v1

    .line 1151
    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const-string v3, "string"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, p1, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 1152
    if-nez v2, :cond_0

    .line 1155
    :goto_0
    return-object v0

    .line 1153
    :cond_0
    array-length v3, p2

    if-nez v3, :cond_1

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v2, p2}, Landroid/content/res/Resources;->getString(I[Ljava/lang/Object;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 1154
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static updatesAvailable(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Catalog;)I
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 554
    if-nez p1, :cond_0

    .line 564
    :goto_0
    return v0

    .line 556
    :cond_0
    iget-object v1, p1, Lcom/mrkeyboard/app/MrPacks$Catalog;->packs:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    move v1, v0

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrPacks$Pack;

    .line 557
    iget-object v3, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-static {p0, v3}, Lcom/mrkeyboard/app/MrPacks;->installedVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v3

    .line 558
    if-lez v3, :cond_4

    iget v4, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    if-le v4, v3, :cond_4

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPacks;->appTooOld(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Pack;)Z

    move-result v0

    if-nez v0, :cond_4

    add-int/lit8 v1, v1, 0x1

    move v0, v1

    :goto_2
    move v1, v0

    .line 559
    goto :goto_1

    .line 560
    :cond_1
    iget-object v0, p1, Lcom/mrkeyboard/app/MrPacks$Catalog;->models:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_2
    :goto_3
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrPacks$Pack;

    .line 561
    iget-object v3, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-static {p0, v3}, Lcom/mrkeyboard/app/MrPacks;->modelVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v3

    .line 562
    if-lez v3, :cond_2

    iget v4, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    if-le v4, v3, :cond_2

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPacks;->appTooOld(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Pack;)Z

    move-result v0

    if-nez v0, :cond_2

    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    :cond_3
    move v0, v1

    .line 564
    goto :goto_0

    :cond_4
    move v0, v1

    goto :goto_2
.end method

.method static validId(Ljava/lang/String;)Z
    .locals 5

    .prologue
    const/16 v4, 0x5a

    const/4 v0, 0x0

    .line 361
    if-nez p0, :cond_1

    .line 371
    :cond_0
    :goto_0
    return v0

    .line 362
    :cond_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    .line 363
    const/4 v2, 0x2

    if-eq v1, v2, :cond_2

    const/4 v2, 0x3

    if-ne v1, v2, :cond_3

    :cond_2
    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->lowerLetters(Ljava/lang/String;II)Z

    move-result v0

    goto :goto_0

    .line 364
    :cond_3
    const/4 v2, 0x5

    if-eq v1, v2, :cond_4

    const/4 v2, 0x6

    if-ne v1, v2, :cond_0

    .line 365
    :cond_4
    add-int/lit8 v1, v1, -0x3

    .line 366
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const/16 v3, 0x2d

    if-ne v2, v3, :cond_0

    .line 367
    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->lowerLetters(Ljava/lang/String;II)Z

    move-result v2

    if-eqz v2, :cond_0

    add-int/lit8 v2, v1, 0x1

    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v2

    if-eqz v2, :cond_0

    add-int/lit8 v2, v1, 0x2

    .line 368
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v2

    if-eqz v2, :cond_0

    add-int/lit8 v2, v1, 0x1

    .line 369
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    if-gt v2, v4, :cond_0

    add-int/lit8 v1, v1, 0x2

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    if-gt v1, v4, :cond_0

    const/4 v0, 0x1

    goto :goto_0
.end method

.method static validModelId(Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 376
    const-string v0, "gesture"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method static validTag(Ljava/lang/String;)Z
    .locals 7

    .prologue
    const/4 v1, 0x1

    const/4 v3, 0x0

    .line 390
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v2, 0x6

    if-lt v0, v2, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v2, 0x10

    if-gt v0, v2, :cond_0

    invoke-virtual {p0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v2, 0x76

    if-eq v0, v2, :cond_1

    .line 403
    :cond_0
    :goto_0
    return v3

    :cond_1
    move v0, v1

    move v2, v3

    move v4, v3

    .line 392
    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v5

    if-ge v0, v5, :cond_3

    .line 393
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v5

    .line 394
    const/16 v6, 0x30

    if-lt v5, v6, :cond_2

    const/16 v6, 0x39

    if-gt v5, v6, :cond_2

    .line 395
    add-int/lit8 v2, v2, 0x1

    .line 392
    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 396
    :cond_2
    const/16 v6, 0x2e

    if-ne v5, v6, :cond_0

    if-lez v2, :cond_0

    .line 397
    add-int/lit8 v4, v4, 0x1

    move v2, v3

    .line 398
    goto :goto_2

    .line 403
    :cond_3
    const/4 v0, 0x2

    if-ne v4, v0, :cond_4

    if-lez v2, :cond_4

    :goto_3
    move v3, v1

    goto :goto_0

    :cond_4
    move v1, v3

    goto :goto_3
.end method

.method static verifySigned([BILjava/lang/String;Ljava/lang/String;[Ljava/security/cert/X509Certificate;)Ljava/lang/String;
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    .line 205
    :try_start_0
    new-instance v0, Ljava/lang/String;

    const-string v1, "UTF-8"

    invoke-direct {v0, p0, v1}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    invoke-static {v0}, Lcom/mrkeyboard/app/MrJson;->parse(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrJson;->obj(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v2

    .line 206
    const-string v0, "format"

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v0

    int-to-long v4, p1

    cmp-long v0, v0, v4

    if-eqz v0, :cond_0

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_new_format"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 210
    :catch_0
    move-exception v0

    .line 211
    throw v0

    .line 207
    :cond_0
    :try_start_1
    const-string v0, "algorithm"

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 208
    const-string v0, "data"

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 209
    invoke-static {}, Ljava/util/Base64;->getDecoder()Ljava/util/Base64$Decoder;

    move-result-object v0

    const-string v1, "signature"

    invoke-static {v2, v1}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Base64$Decoder;->decode(Ljava/lang/String;)[B
    :try_end_1
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v5

    .line 215
    const-string v0, "SHA256withRSA"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "SHA256withECDSA"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "SHA256withDSA"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 216
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_signature"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 212
    :catch_1
    move-exception v0

    .line 213
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_corrupt"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p3, v2, v3

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 220
    :cond_1
    :try_start_2
    const-string v0, "UTF-8"

    invoke-virtual {p2, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    .line 221
    const-string v1, "UTF-8"

    invoke-virtual {v4, v1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v1

    .line 222
    array-length v6, v0

    array-length v7, v1

    add-int/2addr v6, v7

    new-array v6, v6, [B

    .line 223
    const/4 v7, 0x0

    const/4 v8, 0x0

    array-length v9, v0

    invoke-static {v0, v7, v6, v8, v9}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 224
    const/4 v7, 0x0

    array-length v0, v0

    array-length v8, v1

    invoke-static {v1, v7, v6, v0, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    .line 228
    const/4 v0, 0x0

    .line 229
    if-eqz p4, :cond_2

    .line 230
    array-length v7, p4

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v7, :cond_2

    aget-object v8, p4, v1

    .line 232
    :try_start_3
    invoke-static {v3}, Ljava/security/Signature;->getInstance(Ljava/lang/String;)Ljava/security/Signature;

    move-result-object v9

    .line 233
    invoke-virtual {v8}, Ljava/security/cert/X509Certificate;->getPublicKey()Ljava/security/PublicKey;

    move-result-object v8

    invoke-virtual {v9, v8}, Ljava/security/Signature;->initVerify(Ljava/security/PublicKey;)V

    .line 234
    invoke-virtual {v9, v6}, Ljava/security/Signature;->update([B)V

    .line 235
    invoke-virtual {v9, v5}, Ljava/security/Signature;->verify([B)Z
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    move-result v8

    if-eqz v8, :cond_3

    .line 236
    const/4 v0, 0x1

    .line 244
    :cond_2
    if-nez v0, :cond_5

    .line 245
    const-string v0, "signer"

    const/4 v1, 0x0

    invoke-static {v2, v0, v1}, Lcom/mrkeyboard/app/MrJson;->optStr(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 246
    if-eqz v0, :cond_4

    if-eqz p4, :cond_4

    array-length v1, p4

    if-lez v1, :cond_4

    const/4 v1, 0x0

    aget-object v1, p4, v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->certSha(Ljava/security/cert/X509Certificate;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    .line 247
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_other_key"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 225
    :catch_2
    move-exception v0

    .line 226
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_signature"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 239
    :catch_3
    move-exception v8

    .line 230
    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 249
    :cond_4
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_signature"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 251
    :cond_5
    return-object v4
.end method

.method static zipUrl(Lcom/mrkeyboard/app/MrPacks$Pack;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 408
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "https://github.com/x-mrrobot-x/mr-keyboard/releases/download/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacks$Pack;->release:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacks$Pack;->url:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
