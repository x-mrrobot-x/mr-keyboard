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

.field static final KEY_CATALOG:Ljava/lang/String; = "catalog"

.field static final KEY_CHECKED:Ljava/lang/String; = "checked_at"

.field static final KEY_INSTALLED:Ljava/lang/String; = "installed."

.field static final KEY_SERIAL:Ljava/lang/String; = "serial"

.field static final LANGS_KEY:Ljava/lang/String; = "selected_languages"

.field static final MAIN:Ljava/lang/String; = "main.dict"

.field static final MANIFEST:Ljava/lang/String; = "pack.json"

.field static final MAX_CATALOG:I = 0x100000

.field static final MAX_PACK:J = 0x4000000L

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
    .locals 3

    .prologue
    .line 375
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$1;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrPacks$1;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sNet:Lcom/mrkeyboard/app/MrPacks$Net;

    .line 410
    const-string v0, "https://github.com/x-mrrobot-x/mr-keyboard/releases/latest/download/catalog.json"

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sCatalogUrl:Ljava/lang/String;

    .line 512
    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "pt-BR"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "en-US"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "es"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->DEFAULT_IDS:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 55
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static declared-synchronized activate(Ljava/io/File;)V
    .locals 6

    .prologue
    const/4 v1, 0x0

    .line 865
    const-class v4, Lcom/mrkeyboard/app/MrPacks;

    monitor-enter v4

    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrNative;->preload()V

    .line 866
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    move-object v3, v0

    .line 867
    :goto_0
    if-nez v3, :cond_1

    .line 868
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrRules;->set(Lcom/mrkeyboard/app/MrRules;)V

    .line 869
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTrigram;->use(Ljava/io/File;)V

    .line 870
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sActiveDir:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 892
    :goto_1
    monitor-exit v4

    return-void

    :cond_0
    move-object v3, v1

    .line 866
    goto :goto_0

    .line 873
    :cond_1
    :try_start_1
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sActiveDir:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v0

    if-nez v0, :cond_2

    .line 877
    :try_start_2
    new-instance v2, Ljava/io/File;

    const-string v0, "rules.txt"

    invoke-direct {v2, p0, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 878
    invoke-virtual {v2}, Ljava/io/File;->isFile()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 879
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 880
    :try_start_3
    invoke-static {v0}, Lcom/mrkeyboard/app/MrRules;->parse(Ljava/io/InputStream;)Lcom/mrkeyboard/app/MrRules;
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    move-result-object v2

    move-object v5, v0

    move-object v0, v2

    move-object v2, v5

    .line 885
    :goto_2
    :try_start_4
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 887
    :goto_3
    invoke-static {v0}, Lcom/mrkeyboard/app/MrRules;->set(Lcom/mrkeyboard/app/MrRules;)V

    .line 888
    sput-object v3, Lcom/mrkeyboard/app/MrPacks;->sActiveDir:Ljava/lang/String;

    .line 890
    :cond_2
    new-instance v0, Ljava/io/File;

    const-string v2, "trigrams.bin"

    invoke-direct {v0, p0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 891
    invoke-virtual {v0}, Ljava/io/File;->isFile()Z

    move-result v2

    if-eqz v2, :cond_3

    move-object v1, v0

    :cond_3
    invoke-static {v1}, Lcom/mrkeyboard/app/MrTrigram;->use(Ljava/io/File;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_1

    .line 865
    :catchall_0
    move-exception v0

    monitor-exit v4

    throw v0

    .line 882
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 885
    :goto_4
    :try_start_5
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    move-object v0, v1

    .line 886
    goto :goto_3

    .line 885
    :catchall_1
    move-exception v0

    :goto_5
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 886
    throw v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 885
    :catchall_2
    move-exception v1

    move-object v5, v1

    move-object v1, v0

    move-object v0, v5

    goto :goto_5

    .line 882
    :catch_1
    move-exception v2

    goto :goto_4

    :cond_4
    move-object v2, v1

    move-object v0, v1

    goto :goto_2
.end method

.method static appTooOld(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Pack;)Z
    .locals 6

    .prologue
    const/4 v0, 0x1

    .line 580
    iget v1, p1, Lcom/mrkeyboard/app/MrPacks$Pack;->format:I

    if-lt v1, v0, :cond_0

    iget v1, p1, Lcom/mrkeyboard/app/MrPacks$Pack;->format:I

    const/4 v2, 0x2

    if-gt v1, v2, :cond_0

    iget-wide v2, p1, Lcom/mrkeyboard/app/MrPacks$Pack;->minApp:J

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->appVersion(Landroid/content/Context;)J

    move-result-wide v4

    cmp-long v1, v2, v4

    if-lez v1, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static appVersion(Landroid/content/Context;)J
    .locals 3

    .prologue
    .line 573
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

    .line 575
    :goto_0
    return-wide v0

    .line 574
    :catch_0
    move-exception v0

    .line 575
    const-wide/16 v0, 0x0

    goto :goto_0
.end method

.method static declared-synchronized cachedCatalog(Landroid/content/Context;)Lcom/mrkeyboard/app/MrPacks$Catalog;
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 452
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

    .line 453
    if-nez v2, :cond_0

    .line 461
    :goto_0
    monitor-exit v1

    return-object v0

    .line 454
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

    .line 456
    :cond_1
    :try_start_2
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->readData(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Catalog;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sCached:Lcom/mrkeyboard/app/MrPacks$Catalog;
    :try_end_2
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 460
    :goto_1
    :try_start_3
    sput-object v2, Lcom/mrkeyboard/app/MrPacks;->sCachedData:Ljava/lang/String;

    .line 461
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sCached:Lcom/mrkeyboard/app/MrPacks$Catalog;

    goto :goto_0

    .line 457
    :catch_0
    move-exception v0

    .line 458
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sCached:Lcom/mrkeyboard/app/MrPacks$Catalog;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    .line 452
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

    .line 520
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 521
    sget-object v1, Lcom/mrkeyboard/app/MrPacks;->DEFAULT_IDS:[Ljava/lang/String;

    array-length v4, v1

    move v0, v2

    :goto_0
    if-ge v0, v4, :cond_0

    aget-object v5, v1, v0

    invoke-virtual {v3, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 522
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

    .line 523
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

    .line 524
    :cond_4
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .line 525
    if-nez p2, :cond_6

    const-string v0, ""

    move-object v1, v0

    .line 526
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

    .line 525
    :cond_6
    sget-object v0, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {p2, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    goto :goto_3

    .line 527
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

    .line 528
    :cond_9
    return-object v4
.end method

.method static certSha(Ljava/security/cert/X509Certificate;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 994
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

    .line 996
    :goto_0
    return-object v0

    .line 995
    :catch_0
    move-exception v0

    .line 996
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

    .line 958
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sTestCerts:[Ljava/security/cert/X509Certificate;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sTestCerts:[Ljava/security/cert/X509Certificate;

    .line 973
    :goto_0
    return-object v0

    .line 961
    :cond_0
    :try_start_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-lt v0, v1, :cond_2

    .line 962
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks$Api28;->signers(Landroid/content/Context;)[Landroid/content/pm/Signature;

    move-result-object v0

    move-object v4, v0

    .line 967
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

    .line 974
    :catch_0
    move-exception v0

    .line 975
    throw v0

    .line 964
    :cond_2
    :try_start_1
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x40

    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    .line 965
    iget-object v0, v0, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    move-object v4, v0

    goto :goto_1

    .line 968
    :cond_3
    const-string v0, "X.509"

    invoke-static {v0}, Ljava/security/cert/CertificateFactory;->getInstance(Ljava/lang/String;)Ljava/security/cert/CertificateFactory;

    move-result-object v5

    .line 969
    array-length v0, v4

    new-array v1, v0, [Ljava/security/cert/X509Certificate;

    move v2, v3

    .line 970
    :goto_2
    array-length v0, v4

    if-ge v2, v0, :cond_4

    .line 971
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

    .line 970
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_2

    :cond_4
    move-object v0, v1

    .line 973
    goto :goto_0

    .line 976
    :catch_1
    move-exception v0

    .line 977
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
    const/4 v3, 0x1

    const/4 v4, 0x0

    .line 718
    new-instance v0, Ljava/io/File;

    const-string v1, "main.dict"

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 719
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

    .line 720
    :cond_0
    new-instance v0, Ljava/io/File;

    const-string v1, "trigrams.bin"

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 721
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 722
    const/4 v1, 0x4

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacks;->head(Ljava/io/File;I)[B

    move-result-object v0

    .line 723
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

    const/4 v1, 0x3

    aget-byte v0, v0, v1

    const/16 v1, 0x31

    if-eq v0, v1, :cond_2

    .line 724
    :cond_1
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_corrupt"

    new-array v2, v3, [Ljava/lang/Object;

    const-string v3, "trigrams.bin"

    aput-object v3, v2, v4

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 727
    :cond_2
    new-instance v2, Ljava/io/File;

    const-string v0, "rules.txt"

    invoke-direct {v2, p0, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 728
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 729
    const/4 v1, 0x0

    .line 731
    :try_start_0
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 732
    :try_start_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrRules;->parse(Ljava/io/InputStream;)Lcom/mrkeyboard/app/MrRules;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 736
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 739
    :cond_3
    return-void

    .line 733
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 734
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

    .line 736
    :catchall_0
    move-exception v1

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    :goto_1
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 737
    throw v0

    .line 736
    :catchall_1
    move-exception v0

    goto :goto_1

    .line 733
    :catch_1
    move-exception v1

    goto :goto_0
.end method

.method static checkedAt(Landroid/content/Context;)J
    .locals 4

    .prologue
    .line 465
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
    .line 1031
    if-nez p0, :cond_0

    .line 1037
    :goto_0
    return-void

    .line 1033
    :cond_0
    :try_start_0
    invoke-interface {p0}, Ljava/io/Closeable;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1034
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static deleteTree(Ljava/io/File;)V
    .locals 4

    .prologue
    .line 1024
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_1

    .line 1028
    :cond_0
    :goto_0
    return-void

    .line 1025
    :cond_1
    invoke-virtual {p0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v1

    .line 1026
    if-eqz v1, :cond_2

    array-length v2, v1

    const/4 v0, 0x0

    :goto_1
    if-ge v0, v2, :cond_2

    aget-object v3, v1, v0

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 1027
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

    .line 742
    invoke-virtual {p0}, Ljava/io/File;->length()J

    move-result-wide v2

    .line 743
    const-wide/16 v4, 0x400

    cmp-long v4, v2, v4

    if-ltz v4, :cond_0

    const-wide/32 v4, 0x1000000

    cmp-long v4, v2, v4

    if-lez v4, :cond_2

    :cond_0
    move v0, v1

    .line 747
    :cond_1
    :goto_0
    return v0

    .line 744
    :cond_2
    invoke-static {p0, v7}, Lcom/mrkeyboard/app/MrPacks;->head(Ljava/io/File;I)[B

    move-result-object v4

    .line 745
    if-eqz v4, :cond_3

    aget-byte v5, v4, v1

    and-int/lit16 v5, v5, 0xff

    const/16 v6, 0xc8

    if-eq v5, v6, :cond_4

    :cond_3
    move v0, v1

    goto :goto_0

    .line 746
    :cond_4
    aget-byte v5, v4, v0

    if-ne v5, v0, :cond_5

    const-wide/32 v4, 0x400000

    cmp-long v2, v2, v4

    if-lez v2, :cond_1

    move v0, v1

    goto :goto_0

    .line 747
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

    .line 625
    .line 628
    :try_start_0
    const-string v0, "SHA-256"

    invoke-static {v0}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v0

    .line 629
    const/4 v2, 0x1

    new-array v2, v2, [J

    .line 630
    sget-object v3, Lcom/mrkeyboard/app/MrPacks;->sNet:Lcom/mrkeyboard/app/MrPacks$Net;

    invoke-interface {v3, p0, v2}, Lcom/mrkeyboard/app/MrPacks$Net;->open(Ljava/lang/String;[J)Ljava/io/InputStream;
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_0 .. :try_end_0} :catch_b
    .catch Lcom/mrkeyboard/app/MrPacks$HttpError; {:try_start_0 .. :try_end_0} :catch_a
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_9
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_6
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    move-result-object v3

    .line 631
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

    .line 648
    :catch_0
    move-exception v0

    move-object v2, v3

    .line 649
    :goto_0
    :try_start_2
    throw v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 658
    :catchall_0
    move-exception v0

    move-object v3, v2

    :goto_1
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 659
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 660
    throw v0

    .line 632
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

    .line 633
    const/high16 v6, 0x10000

    :try_start_4
    new-array v6, v6, [B

    .line 636
    :goto_2
    invoke-virtual {v3, v6}, Ljava/io/InputStream;->read([B)I

    move-result v7

    if-lez v7, :cond_3

    .line 637
    sget-boolean v8, Lcom/mrkeyboard/app/MrPacks;->sCancel:Z

    if-eqz v8, :cond_1

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_cancel"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-direct {v0, v1, v4}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 648
    :catch_1
    move-exception v0

    move-object v1, v2

    move-object v2, v3

    goto :goto_0

    .line 638
    :cond_1
    int-to-long v8, v7

    add-long/2addr v4, v8

    .line 639
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

    .line 650
    :catch_2
    move-exception v0

    move-object v1, v2

    .line 651
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

    .line 658
    :catchall_1
    move-exception v0

    goto :goto_1

    .line 640
    :cond_2
    const/4 v8, 0x0

    :try_start_6
    invoke-virtual {v0, v6, v8, v7}, Ljava/security/MessageDigest;->update([BII)V

    .line 641
    const/4 v8, 0x0

    invoke-virtual {v2, v6, v8, v7}, Ljava/io/OutputStream;->write([BII)V

    .line 642
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

    .line 652
    :catch_3
    move-exception v0

    move-object v1, v2

    .line 653
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

    .line 644
    :cond_3
    :try_start_8
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_8
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_8 .. :try_end_8} :catch_1
    .catch Lcom/mrkeyboard/app/MrPacks$HttpError; {:try_start_8 .. :try_end_8} :catch_2
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_3
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    .line 646
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

    .line 650
    :catch_4
    move-exception v0

    goto :goto_3

    .line 647
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

    .line 652
    :catch_5
    move-exception v0

    goto :goto_4

    .line 658
    :cond_5
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 659
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 661
    return-void

    .line 654
    :cond_6
    :try_start_a
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_dicts_err_network"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-direct {v0, v2, v4}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 655
    :catch_6
    move-exception v0

    move-object v3, v1

    .line 656
    :goto_5
    new-instance v2, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v4, "mr_dicts_err_io"

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

    .line 658
    :catchall_2
    move-exception v0

    move-object v3, v1

    goto/16 :goto_1

    :catchall_3
    move-exception v0

    move-object v1, v2

    goto/16 :goto_1

    .line 655
    :catch_7
    move-exception v0

    goto :goto_5

    :catch_8
    move-exception v0

    move-object v1, v2

    goto :goto_5

    .line 652
    :catch_9
    move-exception v0

    move-object v3, v1

    goto/16 :goto_4

    .line 650
    :catch_a
    move-exception v0

    move-object v3, v1

    goto/16 :goto_3

    .line 648
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
    .line 665
    invoke-virtual/range {p1 .. p1}, Ljava/io/File;->mkdirs()Z

    move-result v2

    if-nez v2, :cond_0

    invoke-virtual/range {p1 .. p1}, Ljava/io/File;->isDirectory()Z

    move-result v2

    if-nez v2, :cond_0

    new-instance v2, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v3, "mr_dicts_err_io"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    const-string v6, "mkdir"

    aput-object v6, v4, v5

    invoke-direct {v2, v3, v4}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v2

    .line 666
    :cond_0
    new-instance v8, Ljava/util/HashSet;

    invoke-direct {v8}, Ljava/util/HashSet;-><init>()V

    .line 667
    const/4 v4, 0x0

    .line 669
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

    .line 670
    const/high16 v2, 0x10000

    :try_start_1
    new-array v9, v2, [B

    .line 672
    :cond_1
    invoke-virtual {v3}, Ljava/util/zip/ZipInputStream;->getNextEntry()Ljava/util/zip/ZipEntry;

    move-result-object v10

    if-eqz v10, :cond_a

    .line 673
    invoke-virtual {v10}, Ljava/util/zip/ZipEntry;->getName()Ljava/lang/String;

    move-result-object v11

    .line 676
    const-string v2, "pack.json"

    invoke-virtual {v11, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 677
    const-wide/32 v4, 0x10000

    .line 678
    move-object/from16 v0, p2

    iget-object v2, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->manifestSha:Ljava/lang/String;

    move-wide v6, v4

    .line 685
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

    .line 704
    :catch_0
    move-exception v2

    .line 705
    :goto_1
    :try_start_2
    throw v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 709
    :catchall_0
    move-exception v2

    :goto_2
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 710
    throw v2

    .line 680
    :cond_3
    :try_start_3
    move-object/from16 v0, p2

    iget-object v2, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->fileNames:[Ljava/lang/String;

    invoke-static {v2, v11}, Lcom/mrkeyboard/app/MrPacks;->indexOf([Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 681
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

    .line 706
    :catch_1
    move-exception v2

    .line 707
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

    .line 682
    :cond_4
    :try_start_5
    move-object/from16 v0, p2

    iget-object v4, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSizes:[J

    aget-wide v4, v4, v2

    .line 683
    move-object/from16 v0, p2

    iget-object v6, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSha:[Ljava/lang/String;

    aget-object v2, v6, v2

    move-wide v6, v4

    goto :goto_0

    .line 686
    :cond_5
    const-string v4, "SHA-256"

    invoke-static {v4}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v10

    .line 687
    new-instance v12, Ljava/io/FileOutputStream;

    new-instance v4, Ljava/io/File;

    move-object/from16 v0, p1

    invoke-direct {v4, v0, v11}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-direct {v12, v4}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_5
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_5 .. :try_end_5} :catch_0
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 688
    const-wide/16 v4, 0x0

    .line 691
    :goto_4
    :try_start_6
    invoke-virtual {v3, v9}, Ljava/util/zip/ZipInputStream;->read([B)I

    move-result v13

    if-lez v13, :cond_8

    .line 692
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

    .line 699
    :catchall_1
    move-exception v2

    :try_start_7
    invoke-virtual {v12}, Ljava/io/OutputStream;->close()V

    .line 700
    throw v2
    :try_end_7
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_7 .. :try_end_7} :catch_0
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_1
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 693
    :cond_6
    int-to-long v14, v13

    add-long/2addr v4, v14

    .line 694
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

    .line 695
    :cond_7
    const/4 v14, 0x0

    invoke-virtual {v10, v9, v14, v13}, Ljava/security/MessageDigest;->update([BII)V

    .line 696
    const/4 v14, 0x0

    invoke-virtual {v12, v9, v14, v13}, Ljava/io/OutputStream;->write([BII)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    goto :goto_4

    .line 699
    :cond_8
    :try_start_9
    invoke-virtual {v12}, Ljava/io/OutputStream;->close()V

    .line 701
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

    .line 702
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

    .line 709
    :cond_a
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 711
    move-object/from16 v0, p2

    iget-object v3, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->fileNames:[Ljava/lang/String;

    array-length v4, v3

    const/4 v2, 0x0

    :goto_5
    if-ge v2, v4, :cond_c

    aget-object v5, v3, v2

    .line 712
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

    .line 711
    :cond_b
    add-int/lit8 v2, v2, 0x1

    goto :goto_5

    .line 714
    :cond_c
    return-void

    .line 709
    :catchall_2
    move-exception v2

    move-object v3, v4

    goto/16 :goto_2

    .line 706
    :catch_2
    move-exception v2

    move-object v3, v4

    goto/16 :goto_3

    .line 704
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
    .line 415
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

    .line 420
    const/4 v1, 0x0

    .line 422
    const/4 v2, 0x1

    :try_start_0
    new-array v2, v2, [J

    .line 423
    sget-object v3, Lcom/mrkeyboard/app/MrPacks;->sNet:Lcom/mrkeyboard/app/MrPacks$Net;

    invoke-interface {v3, p0, v2}, Lcom/mrkeyboard/app/MrPacks$Net;->open(Ljava/lang/String;[J)Ljava/io/InputStream;

    move-result-object v1

    .line 424
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

    .line 425
    const/16 v0, 0x2000

    new-array v0, v0, [B

    .line 427
    :cond_1
    invoke-virtual {v1, v0}, Ljava/io/InputStream;->read([B)I

    move-result v2

    if-lez v2, :cond_2

    .line 428
    const/4 v4, 0x0

    invoke-virtual {v3, v0, v4, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 429
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

    .line 432
    :catch_0
    move-exception v0

    .line 433
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

    .line 437
    :catchall_0
    move-exception v0

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 438
    throw v0

    .line 431
    :cond_2
    :try_start_2
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B
    :try_end_2
    .catch Lcom/mrkeyboard/app/MrPacks$HttpError; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v0

    .line 437
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 431
    return-object v0

    .line 434
    :catch_1
    move-exception v0

    .line 435
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
    .line 470
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sCatalogUrl:Ljava/lang/String;

    const/high16 v1, 0x100000

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacks;->fetchBytes(Ljava/lang/String;I)[B

    move-result-object v0

    .line 471
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 472
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->certs(Landroid/content/Context;)[Ljava/security/cert/X509Certificate;

    move-result-object v2

    const-string v3, "serial"

    const-wide/16 v4, 0x0

    invoke-interface {v1, v3, v4, v5}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v4

    invoke-static {v0, v2, v4, v5}, Lcom/mrkeyboard/app/MrPacks;->parseCatalog([B[Ljava/security/cert/X509Certificate;J)Lcom/mrkeyboard/app/MrPacks$Catalog;

    move-result-object v0

    .line 473
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

    .line 474
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-interface {v1, v2, v4, v5}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 475
    return-object v0
.end method

.method private static head(Ljava/io/File;I)[B
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 751
    .line 753
    :try_start_0
    new-instance v2, Ljava/io/FileInputStream;

    invoke-direct {v2, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 754
    :try_start_1
    new-array v1, p1, [B

    .line 755
    const/4 v3, 0x0

    .line 756
    :goto_0
    if-ge v3, p1, :cond_1

    .line 757
    sub-int v4, p1, v3

    invoke-virtual {v2, v1, v3, v4}, Ljava/io/InputStream;->read([BII)I
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result v4

    .line 758
    if-gtz v4, :cond_0

    .line 765
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 763
    :goto_1
    return-object v0

    .line 759
    :cond_0
    add-int/2addr v3, v4

    .line 760
    goto :goto_0

    .line 765
    :cond_1
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    move-object v0, v1

    .line 761
    goto :goto_1

    .line 762
    :catch_0
    move-exception v1

    move-object v1, v0

    .line 765
    :goto_2
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    goto :goto_1

    :catchall_0
    move-exception v1

    move-object v2, v0

    move-object v0, v1

    :goto_3
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 766
    throw v0

    .line 765
    :catchall_1
    move-exception v0

    goto :goto_3

    .line 762
    :catch_1
    move-exception v1

    move-object v1, v2

    goto :goto_2
.end method

.method static hex([B)Ljava/lang/String;
    .locals 5

    .prologue
    .line 1009
    array-length v0, p0

    mul-int/lit8 v0, v0, 0x2

    new-array v1, v0, [C

    .line 1010
    const-string v0, "0123456789abcdef"

    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v2

    .line 1011
    const/4 v0, 0x0

    :goto_0
    array-length v3, p0

    if-ge v0, v3, :cond_0

    .line 1012
    mul-int/lit8 v3, v0, 0x2

    aget-byte v4, p0, v0

    shr-int/lit8 v4, v4, 0x4

    and-int/lit8 v4, v4, 0xf

    aget-char v4, v2, v4

    aput-char v4, v1, v3

    .line 1013
    mul-int/lit8 v3, v0, 0x2

    add-int/lit8 v3, v3, 0x1

    aget-byte v4, p0, v0

    and-int/lit8 v4, v4, 0xf

    aget-char v4, v2, v4

    aput-char v4, v1, v3

    .line 1011
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1015
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

    .line 298
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    .line 299
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v0

    if-eq v0, v4, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 300
    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v4, :cond_4

    .line 301
    invoke-virtual {v1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 302
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

    .line 300
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 304
    :cond_4
    return-object v1
.end method

.method private static indexOf([Ljava/lang/String;Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 1019
    const/4 v0, 0x0

    :goto_0
    array-length v1, p0

    if-ge v0, v1, :cond_1

    aget-object v1, p0, v0

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1020
    :goto_1
    return v0

    .line 1019
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1020
    :cond_1
    const/4 v0, -0x1

    goto :goto_1
.end method

.method static install(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Catalog;Lcom/mrkeyboard/app/MrPacks$Pack;)V
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    const/4 v9, 0x0

    const/4 v1, 0x0

    .line 588
    sput-boolean v1, Lcom/mrkeyboard/app/MrPacks;->sCancel:Z

    .line 589
    sput v1, Lcom/mrkeyboard/app/MrPacks;->sJobPercent:I

    .line 590
    sput-boolean v1, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 591
    iget-object v0, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    .line 592
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->root(Landroid/content/Context;)Ljava/io/File;

    move-result-object v0

    .line 593
    new-instance v2, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v3

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

    invoke-direct {v2, v3, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 594
    new-instance v3, Ljava/io/File;

    new-instance v4, Ljava/io/File;

    iget-object v5, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-direct {v4, v0, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

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

    invoke-direct {v3, v4, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 596
    :try_start_0
    invoke-static {p0, p2}, Lcom/mrkeyboard/app/MrPacks;->appTooOld(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Pack;)Z

    move-result v4

    if-eqz v4, :cond_0

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v4, "mr_dicts_err_app_old"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-direct {v0, v4, v5}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 617
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    .line 618
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 619
    sput-object v9, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    .line 620
    sput-boolean v1, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 621
    throw v0

    .line 597
    :cond_0
    :try_start_1
    iget-wide v4, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    iget-wide v6, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->installedSize:J

    add-long/2addr v4, v6

    const-wide/32 v6, 0x200000

    add-long/2addr v4, v6

    .line 598
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v6

    if-nez v6, :cond_1

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    .line 599
    :cond_1
    invoke-virtual {v0}, Ljava/io/File;->getUsableSpace()J

    move-result-wide v6

    cmp-long v6, v6, v4

    if-gez v6, :cond_2

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v6, "mr_dicts_err_space"

    const/4 v7, 0x1

    new-array v7, v7, [Ljava/lang/Object;

    const/4 v8, 0x0

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrPacks;->sizeText(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v7, v8

    invoke-direct {v0, v6, v7}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 600
    :cond_2
    invoke-static {p2}, Lcom/mrkeyboard/app/MrPacks;->zipUrl(Lcom/mrkeyboard/app/MrPacks$Pack;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v2, p2}, Lcom/mrkeyboard/app/MrPacks;->download(Ljava/lang/String;Ljava/io/File;Lcom/mrkeyboard/app/MrPacks$Pack;)V

    .line 601
    const/4 v4, 0x1

    sput-boolean v4, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 602
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 603
    invoke-static {v2, v3, p2}, Lcom/mrkeyboard/app/MrPacks;->extract(Ljava/io/File;Ljava/io/File;Lcom/mrkeyboard/app/MrPacks$Pack;)V

    .line 604
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->checkFiles(Ljava/io/File;)V

    .line 605
    iget-object v4, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    iget v5, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    invoke-static {p0, v4, v5}, Lcom/mrkeyboard/app/MrPacks;->packDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;

    move-result-object v4

    .line 606
    invoke-static {v4}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 607
    invoke-virtual {v3, v4}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    move-result v4

    if-nez v4, :cond_3

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v4, "mr_dicts_err_io"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    const-string v7, "rename"

    aput-object v7, v5, v6

    invoke-direct {v0, v4, v5}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 608
    :cond_3
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v4

    invoke-interface {v4}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "installed."

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    iget v6, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    invoke-interface {v4, v5, v6}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v4

    invoke-interface {v4}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 609
    new-instance v4, Ljava/io/File;

    iget-object v5, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-direct {v4, v0, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v4}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v4

    .line 610
    if-eqz v4, :cond_5

    .line 611
    array-length v5, v4

    move v0, v1

    :goto_0
    if-ge v0, v5, :cond_5

    aget-object v6, v4, v0

    .line 612
    invoke-virtual {v6}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v7

    iget v8, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    invoke-static {v8}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_4

    invoke-static {v6}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 611
    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 615
    :cond_5
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->signal(Landroid/content/Context;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 617
    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    .line 618
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 619
    sput-object v9, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    .line 620
    sput-boolean v1, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 622
    return-void
.end method

.method static installedFor(Landroid/content/Context;Ljava/lang/String;)Ljava/io/File;
    .locals 10

    .prologue
    const/4 v9, 0x0

    const/4 v2, 0x0

    const/4 v8, 0x1

    .line 800
    invoke-static {p1}, Lcom/mrkeyboard/app/MrPacks;->splitLocale(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v3

    .line 801
    aget-object v0, v3, v9

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    .line 810
    :cond_0
    :goto_0
    return-object v2

    .line 803
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

    .line 804
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->splitLocale(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    .line 805
    aget-object v6, v5, v9

    aget-object v7, v3, v9

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 806
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

    .line 807
    goto :goto_1

    .line 808
    :cond_4
    if-eqz v1, :cond_0

    .line 809
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrPacks;->installedVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    invoke-static {p0, v1, v0}, Lcom/mrkeyboard/app/MrPacks;->packDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;

    move-result-object v0

    .line 810
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
    .line 484
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 485
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

    .line 486
    const-string v3, "installed."

    invoke-virtual {v0, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 487
    const-string v3, "installed."

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v0, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 488
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->validId(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 491
    :cond_1
    invoke-static {v1}, Ljava/util/Collections;->sort(Ljava/util/List;)V

    .line 492
    return-object v1
.end method

.method static installedVersion(Landroid/content/Context;Ljava/lang/String;)I
    .locals 3

    .prologue
    .line 479
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
    .line 536
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 537
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

    .line 538
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
    .line 133
    if-nez p0, :cond_1

    .line 140
    :cond_0
    :goto_0
    return-object p2

    .line 134
    :cond_1
    if-eqz p1, :cond_4

    invoke-virtual {p1}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 135
    :goto_1
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_2

    const-string v0, "en"

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 136
    :cond_2
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_5

    .line 137
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

    .line 134
    :cond_4
    const/4 v0, 0x0

    goto :goto_1

    .line 140
    :cond_5
    check-cast v0, Ljava/lang/String;

    move-object p2, v0

    goto :goto_0
.end method

.method private static lowerLetters(Ljava/lang/String;II)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 323
    sub-int v1, p2, p1

    const/4 v2, 0x2

    if-ge v1, v2, :cond_2

    .line 328
    :cond_0
    :goto_0
    return v0

    .line 324
    :cond_1
    add-int/lit8 p1, p1, 0x1

    :cond_2
    if-ge p1, p2, :cond_3

    .line 325
    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 326
    const/16 v2, 0x61

    if-lt v1, v2, :cond_0

    const/16 v2, 0x7a

    if-le v1, v2, :cond_1

    goto :goto_0

    .line 328
    :cond_3
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public static mainDictionary(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/BinaryDictionary;
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 850
    invoke-static {p1}, Lcom/mrkeyboard/app/MrPacks;->splitLocale(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x0

    aget-object v0, v0, v2

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sLastLang:Ljava/lang/String;

    .line 854
    :try_start_0
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->installedFor(Landroid/content/Context;Ljava/lang/String;)Ljava/io/File;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 855
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

    .line 859
    :goto_1
    if-eqz v2, :cond_0

    move-object v1, v0

    :cond_0
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->activate(Ljava/io/File;)V

    .line 860
    if-eqz v2, :cond_1

    move-object v0, v2

    .line 861
    :goto_2
    return-object v0

    .line 856
    :catch_0
    move-exception v0

    move-object v0, v1

    :goto_3
    move-object v2, v1

    .line 857
    goto :goto_1

    .line 861
    :cond_1
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/PluginManager;->getDictionary(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v0

    goto :goto_2

    .line 856
    :catch_1
    move-exception v0

    move-object v0, v2

    goto :goto_3

    :cond_2
    move-object v0, v1

    goto :goto_0
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

    .line 906
    :try_start_0
    sget-object v4, Lcom/mrkeyboard/app/MrPacks;->sLastLang:Ljava/lang/String;

    .line 907
    if-eqz p0, :cond_0

    if-eqz v4, :cond_0

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    move-object v0, v3

    .line 929
    :goto_0
    return-object v0

    .line 908
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->cachedCatalog(Landroid/content/Context;)Lcom/mrkeyboard/app/MrPacks$Catalog;

    move-result-object v0

    .line 909
    if-eqz v0, :cond_3

    .line 911
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

    .line 912
    :cond_2
    if-nez v2, :cond_3

    move-object v0, v3

    goto :goto_0

    .line 914
    :cond_3
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    .line 915
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sOfferLabel:Ljava/lang/String;

    .line 916
    if-eqz v0, :cond_4

    sget-wide v6, Lcom/mrkeyboard/app/MrPacks;->sOfferAt:J

    sub-long v6, v4, v6

    const-wide/16 v8, 0x7530

    cmp-long v1, v6, v8

    if-lez v1, :cond_5

    .line 917
    :cond_4
    const-string v0, "mr_dicts_offer"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 918
    sput-wide v4, Lcom/mrkeyboard/app/MrPacks;->sOfferAt:J

    .line 920
    :cond_5
    if-nez v0, :cond_6

    move-object v0, v3

    goto :goto_0

    .line 921
    :cond_6
    sget-object v1, Lcom/mrkeyboard/app/MrPacks;->sOffer:Ljava/lang/String;

    if-eqz v1, :cond_7

    sget-object v1, Lcom/mrkeyboard/app/MrPacks;->sOfferLabel:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_8

    .line 922
    :cond_7
    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sOfferLabel:Ljava/lang/String;

    .line 923
    new-instance v1, Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>([C)V

    sput-object v1, Lcom/mrkeyboard/app/MrPacks;->sOffer:Ljava/lang/String;

    .line 925
    :cond_8
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 926
    sget-object v1, Lcom/mrkeyboard/app/MrPacks;->sOffer:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 928
    :catch_0
    move-exception v0

    move-object v0, v3

    .line 929
    goto :goto_0

    :cond_9
    move v0, v2

    goto :goto_2
.end method

.method public static onPick(Landroid/content/Context;Ljava/lang/CharSequence;)Z
    .locals 1

    .prologue
    .line 935
    if-eqz p1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sOffer:Ljava/lang/String;

    if-eq p1, v0, :cond_1

    :cond_0
    const/4 v0, 0x0

    .line 941
    :goto_0
    return v0

    .line 937
    :cond_1
    :try_start_0
    const-class v0, Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrNav;->intent(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 941
    :goto_1
    const/4 v0, 0x1

    goto :goto_0

    .line 938
    :catch_0
    move-exception v0

    goto :goto_1
.end method

.method static open(Landroid/content/Context;Ljava/io/File;)Lcom/mrkeyboard/app/BinaryDictionary;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v6, 0x0

    .line 825
    invoke-static {p1}, Lcom/mrkeyboard/app/MrPacks;->dictHeaderOk(Ljava/io/File;)Z

    move-result v0

    if-nez v0, :cond_0

    move-object v0, v6

    .line 835
    :goto_0
    return-object v0

    .line 826
    :cond_0
    new-instance v7, Ljava/io/RandomAccessFile;

    const-string v0, "r"

    invoke-direct {v7, p1, v0}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 828
    :try_start_0
    invoke-virtual {v7}, Ljava/io/RandomAccessFile;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v0

    .line 829
    sget-object v1, Ljava/nio/channels/FileChannel$MapMode;->READ_ONLY:Ljava/nio/channels/FileChannel$MapMode;

    const-wide/16 v2, 0x0

    invoke-virtual {v0}, Ljava/nio/channels/FileChannel;->size()J

    move-result-wide v4

    invoke-virtual/range {v0 .. v5}, Ljava/nio/channels/FileChannel;->map(Ljava/nio/channels/FileChannel$MapMode;JJ)Ljava/nio/MappedByteBuffer;

    move-result-object v1

    .line 830
    new-instance v0, Lcom/mrkeyboard/app/BinaryDictionary;

    const/4 v2, 0x1

    invoke-direct {v0, p0, v1, v2}, Lcom/mrkeyboard/app/BinaryDictionary;-><init>(Landroid/content/Context;Ljava/nio/ByteBuffer;I)V

    .line 831
    invoke-virtual {v0}, Lcom/mrkeyboard/app/BinaryDictionary;->getSize()I

    move-result v1

    const/4 v2, 0x2

    if-gt v1, v2, :cond_1

    .line 832
    invoke-virtual {v0}, Lcom/mrkeyboard/app/BinaryDictionary;->close()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 837
    invoke-virtual {v7}, Ljava/io/RandomAccessFile;->close()V

    move-object v0, v6

    .line 833
    goto :goto_0

    .line 837
    :cond_1
    invoke-virtual {v7}, Ljava/io/RandomAccessFile;->close()V

    goto :goto_0

    :catchall_0
    move-exception v0

    invoke-virtual {v7}, Ljava/io/RandomAccessFile;->close()V

    .line 838
    throw v0
.end method

.method static openDictionary(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/BinaryDictionary;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 816
    if-nez p0, :cond_1

    .line 820
    :cond_0
    :goto_0
    return-object v0

    .line 817
    :cond_1
    :try_start_0
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->installedFor(Landroid/content/Context;Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    .line 818
    if-eqz v1, :cond_0

    new-instance v2, Ljava/io/File;

    const-string v3, "main.dict"

    invoke-direct {v2, v1, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrPacks;->open(Landroid/content/Context;Ljava/io/File;)Lcom/mrkeyboard/app/BinaryDictionary;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 819
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static packDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;
    .locals 3

    .prologue
    .line 560
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
    .line 148
    const/4 v0, 0x1

    const-string v1, "mr-keyboard/catalog/v1\n"

    const-string v2, "catalog.json"

    invoke-static {p0, v0, v1, v2, p1}, Lcom/mrkeyboard/app/MrPacks;->verifySigned([BILjava/lang/String;Ljava/lang/String;[Ljava/security/cert/X509Certificate;)Ljava/lang/String;

    move-result-object v0

    .line 149
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->readData(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Catalog;

    move-result-object v0

    .line 150
    iget-wide v2, v0, Lcom/mrkeyboard/app/MrPacks$Catalog;->serial:J

    cmp-long v1, v2, p2

    if-gez v1, :cond_0

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_old_catalog"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 151
    :cond_0
    return-object v0
.end method

.method static prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .locals 2

    .prologue
    .line 444
    const-string v0, "mr_packs"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method static readData(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Catalog;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    const/4 v6, 0x0

    .line 219
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrJson;->parse(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrJson;->obj(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v0

    .line 220
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

    .line 231
    :catch_0
    move-exception v0

    .line 232
    throw v0

    .line 221
    :cond_0
    :try_start_1
    new-instance v1, Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-direct {v1}, Lcom/mrkeyboard/app/MrPacks$Catalog;-><init>()V

    .line 222
    iput-object p0, v1, Lcom/mrkeyboard/app/MrPacks$Catalog;->data:Ljava/lang/String;

    .line 223
    const-string v2, "serial"

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v2

    iput-wide v2, v1, Lcom/mrkeyboard/app/MrPacks$Catalog;->serial:J

    .line 224
    const-string v2, "generated"

    const-string v3, ""

    invoke-static {v0, v2, v3}, Lcom/mrkeyboard/app/MrJson;->optStr(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/mrkeyboard/app/MrPacks$Catalog;->generated:Ljava/lang/String;

    .line 225
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    .line 226
    const-string v3, "packs"

    invoke-interface {v0, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrJson;->list(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .line 227
    invoke-static {v3}, Lcom/mrkeyboard/app/MrJson;->obj(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->readPack(Ljava/util/Map;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v3

    .line 228
    iget-object v4, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    iget-object v4, v1, Lcom/mrkeyboard/app/MrPacks$Catalog;->packs:Ljava/util/ArrayList;

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 233
    :catch_1
    move-exception v0

    .line 234
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_corrupt"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const-string v3, "catalog.json"

    aput-object v3, v2, v6

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 230
    :cond_2
    return-object v1
.end method

.method private static readPack(Ljava/util/Map;)Lcom/mrkeyboard/app/MrPacks$Pack;
    .locals 13
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)",
            "Lcom/mrkeyboard/app/MrPacks$Pack;"
        }
    .end annotation

    .prologue
    .line 240
    new-instance v2, Lcom/mrkeyboard/app/MrPacks$Pack;

    invoke-direct {v2}, Lcom/mrkeyboard/app/MrPacks$Pack;-><init>()V

    .line 241
    const-string v0, "id"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    .line 242
    iget-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->validId(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "id"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 243
    :cond_0
    const-string v0, "lang"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->lang:Ljava/lang/String;

    .line 244
    const-string v0, "region"

    const-string v1, ""

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrJson;->optStr(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->region:Ljava/lang/String;

    .line 245
    const-string v0, "name"

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 246
    instance-of v1, v0, Ljava/util/Map;

    if-eqz v1, :cond_1

    check-cast v0, Ljava/util/Map;

    :goto_0
    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->name:Ljava/util/Map;

    .line 247
    const-string v0, "description"

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 248
    instance-of v1, v0, Ljava/util/Map;

    if-eqz v1, :cond_2

    check-cast v0, Ljava/util/Map;

    :goto_1
    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->description:Ljava/util/Map;

    .line 249
    const-string v0, "version"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v0

    long-to-int v0, v0

    iput v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    .line 250
    const-string v0, "format"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v0

    long-to-int v0, v0

    iput v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->format:I

    .line 251
    const-string v0, "minApp"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->minApp:J

    .line 252
    const-string v0, "release"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->release:Ljava/lang/String;

    .line 253
    iget-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->release:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->validTag(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "release"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 246
    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    .line 248
    :cond_2
    const/4 v0, 0x0

    goto :goto_1

    .line 254
    :cond_3
    const-string v0, "url"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->url:Ljava/lang/String;

    .line 255
    iget-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->url:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->safeName(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->url:Ljava/lang/String;

    const-string v1, ".zip"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_5

    :cond_4
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "url"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 256
    :cond_5
    const-string v0, "size"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    .line 257
    const-string v0, "installedSize"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->installedSize:J

    .line 258
    iget v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    const/4 v1, 0x1

    if-lt v0, v1, :cond_6

    iget-wide v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    const-wide/16 v4, 0x0

    cmp-long v0, v0, v4

    if-lez v0, :cond_6

    iget-wide v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    const-wide/32 v4, 0x4000000

    cmp-long v0, v0, v4

    if-gtz v0, :cond_6

    iget-wide v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->installedSize:J

    const-wide/16 v4, 0x0

    cmp-long v0, v0, v4

    if-lez v0, :cond_6

    iget-wide v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->installedSize:J

    const-wide/32 v4, 0x4000000

    cmp-long v0, v0, v4

    if-lez v0, :cond_7

    .line 259
    :cond_6
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "size"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 261
    :cond_7
    const-string v0, "sha256"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPacks;->hexField(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->sha256:Ljava/lang/String;

    .line 262
    const-string v0, "manifestSha256"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPacks;->hexField(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->manifestSha:Ljava/lang/String;

    .line 263
    const-string v0, "files"

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrJson;->list(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v3

    .line 264
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v4

    .line 265
    if-eqz v4, :cond_8

    const/16 v0, 0x20

    if-le v4, v0, :cond_9

    :cond_8
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "files"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 266
    :cond_9
    new-array v0, v4, [Ljava/lang/String;

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->fileNames:[Ljava/lang/String;

    .line 267
    new-array v0, v4, [J

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSizes:[J

    .line 268
    new-array v0, v4, [Ljava/lang/String;

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSha:[Ljava/lang/String;

    .line 269
    const/4 v1, 0x0

    .line 270
    new-instance v5, Ljava/util/HashSet;

    invoke-direct {v5}, Ljava/util/HashSet;-><init>()V

    .line 271
    const/4 v0, 0x0

    move v12, v0

    move v0, v1

    move v1, v12

    :goto_2
    if-ge v1, v4, :cond_f

    .line 272
    invoke-interface {v3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    invoke-static {v6}, Lcom/mrkeyboard/app/MrJson;->obj(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v6

    .line 273
    const-string v7, "name"

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 274
    invoke-static {v7}, Lcom/mrkeyboard/app/MrPacks;->safeName(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_a

    const-string v8, "pack.json"

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_a

    invoke-virtual {v5, v7}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_b

    :cond_a
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "name"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 275
    :cond_b
    iget-object v8, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->fileNames:[Ljava/lang/String;

    aput-object v7, v8, v1

    .line 276
    iget-object v8, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSizes:[J

    const-string v9, "size"

    invoke-static {v6, v9}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v10

    aput-wide v10, v8, v1

    .line 277
    iget-object v8, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSizes:[J

    aget-wide v8, v8, v1

    const-wide/16 v10, 0x0

    cmp-long v8, v8, v10

    if-lez v8, :cond_c

    iget-object v8, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSizes:[J

    aget-wide v8, v8, v1

    const-wide/32 v10, 0x4000000

    cmp-long v8, v8, v10

    if-lez v8, :cond_d

    :cond_c
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "size"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 278
    :cond_d
    iget-object v8, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSha:[Ljava/lang/String;

    const-string v9, "sha256"

    invoke-static {v6, v9}, Lcom/mrkeyboard/app/MrPacks;->hexField(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v8, v1

    .line 279
    const-string v6, "main.dict"

    invoke-virtual {v7, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_e

    const/4 v0, 0x1

    .line 271
    :cond_e
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 281
    :cond_f
    if-nez v0, :cond_10

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "no main.dict"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 282
    :cond_10
    const-string v0, "licenses"

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 283
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 284
    instance-of v3, v0, Ljava/util/List;

    if-eqz v3, :cond_13

    .line 285
    check-cast v0, Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_11
    :goto_3
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_13

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    .line 286
    instance-of v4, v0, Ljava/lang/String;

    if-eqz v4, :cond_11

    .line 287
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->length()I

    move-result v4

    if-lez v4, :cond_12

    const-string v4, ", "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 288
    :cond_12
    check-cast v0, Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_3

    .line 292
    :cond_13
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->licenses:Ljava/lang/String;

    .line 293
    const-string v0, "credits"

    const-string v1, ""

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrJson;->optStr(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->credits:Ljava/lang/String;

    .line 294
    return-object v2
.end method

.method static remove(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 771
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

    .line 772
    new-instance v0, Ljava/io/File;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->root(Landroid/content/Context;)Ljava/io/File;

    move-result-object v1

    invoke-direct {v0, v1, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 773
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->signal(Landroid/content/Context;)V

    .line 774
    return-void
.end method

.method static root(Landroid/content/Context;)Ljava/io/File;
    .locals 3

    .prologue
    .line 556
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

    .line 356
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v3, 0x40

    if-le v0, v3, :cond_1

    .line 365
    :cond_0
    :goto_0
    return v1

    .line 357
    :cond_1
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 358
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

    .line 359
    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v0, v3, :cond_a

    .line 360
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 361
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

    .line 363
    :goto_2
    if-eqz v3, :cond_0

    .line 359
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_9
    move v3, v1

    .line 361
    goto :goto_2

    .line 365
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
    .line 778
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "mr_dicts_updated_at"

    .line 779
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 780
    return-void
.end method

.method static sizeText(J)Ljava/lang/String;
    .locals 6

    .prologue
    const-wide v0, 0x3fb999999999999aL    # 0.1

    .line 1003
    long-to-double v2, p0

    const-wide v4, 0x412e848000000000L    # 1000000.0

    div-double/2addr v2, v4

    .line 1004
    cmpg-double v4, v2, v0

    if-gez v4, :cond_0

    .line 1005
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

    .line 786
    if-nez p0, :cond_0

    new-array v0, v6, [Ljava/lang/String;

    const-string v1, ""

    aput-object v1, v0, v4

    const-string v1, ""

    aput-object v1, v0, v5

    .line 795
    :goto_0
    return-object v0

    .line 787
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    .line 788
    invoke-virtual {v1, v8}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    .line 789
    if-gez v0, :cond_5

    invoke-virtual {v1, v7}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    move v2, v0

    .line 790
    :goto_1
    if-gez v2, :cond_3

    move-object v0, v1

    :goto_2
    sget-object v3, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v3

    .line 791
    if-gez v2, :cond_4

    const-string v0, ""

    .line 792
    :goto_3
    invoke-virtual {v0, v8}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    .line 793
    if-gez v1, :cond_1

    invoke-virtual {v0, v7}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    .line 794
    :cond_1
    if-ltz v1, :cond_2

    invoke-virtual {v0, v4, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 795
    :cond_2
    new-array v1, v6, [Ljava/lang/String;

    aput-object v3, v1, v4

    aput-object v0, v1, v5

    move-object v0, v1

    goto :goto_0

    .line 790
    :cond_3
    invoke-virtual {v1, v4, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    .line 791
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
    .line 546
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->installedIds(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrPacks;->languageKeys(Ljava/util/List;Ljava/util/List;)Ljava/lang/String;

    move-result-object v0

    .line 547
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 548
    const-string v2, "selected_languages"

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 549
    if-nez v0, :cond_1

    if-nez v2, :cond_2

    .line 553
    :cond_0
    :goto_0
    return-void

    .line 549
    :cond_1
    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 550
    :cond_2
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    .line 551
    if-nez v0, :cond_3

    const-string v0, "selected_languages"

    invoke-interface {v1, v0}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 552
    :goto_1
    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    goto :goto_0

    .line 551
    :cond_3
    const-string v2, "selected_languages"

    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    goto :goto_1
.end method

.method static varargs text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 946
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v1

    .line 947
    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const-string v3, "string"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, p1, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 948
    if-nez v2, :cond_0

    .line 951
    :goto_0
    return-object v0

    .line 949
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

    .line 950
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static updatesAvailable(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Catalog;)I
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 497
    if-nez p1, :cond_0

    .line 503
    :goto_0
    return v0

    .line 499
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

    .line 500
    iget-object v3, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-static {p0, v3}, Lcom/mrkeyboard/app/MrPacks;->installedVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v3

    .line 501
    if-lez v3, :cond_2

    iget v4, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    if-le v4, v3, :cond_2

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPacks;->appTooOld(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Pack;)Z

    move-result v0

    if-nez v0, :cond_2

    add-int/lit8 v1, v1, 0x1

    move v0, v1

    :goto_2
    move v1, v0

    .line 502
    goto :goto_1

    :cond_1
    move v0, v1

    .line 503
    goto :goto_0

    :cond_2
    move v0, v1

    goto :goto_2
.end method

.method static validId(Ljava/lang/String;)Z
    .locals 5

    .prologue
    const/16 v4, 0x5a

    const/4 v0, 0x0

    .line 309
    if-nez p0, :cond_1

    .line 319
    :cond_0
    :goto_0
    return v0

    .line 310
    :cond_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    .line 311
    const/4 v2, 0x2

    if-eq v1, v2, :cond_2

    const/4 v2, 0x3

    if-ne v1, v2, :cond_3

    :cond_2
    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->lowerLetters(Ljava/lang/String;II)Z

    move-result v0

    goto :goto_0

    .line 312
    :cond_3
    const/4 v2, 0x5

    if-eq v1, v2, :cond_4

    const/4 v2, 0x6

    if-ne v1, v2, :cond_0

    .line 313
    :cond_4
    add-int/lit8 v1, v1, -0x3

    .line 314
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const/16 v3, 0x2d

    if-ne v2, v3, :cond_0

    .line 315
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

    .line 316
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v2

    if-eqz v2, :cond_0

    add-int/lit8 v2, v1, 0x1

    .line 317
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

.method static validTag(Ljava/lang/String;)Z
    .locals 7

    .prologue
    const/4 v1, 0x1

    const/4 v3, 0x0

    .line 333
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

    .line 346
    :cond_0
    :goto_0
    return v3

    :cond_1
    move v0, v1

    move v2, v3

    move v4, v3

    .line 335
    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v5

    if-ge v0, v5, :cond_3

    .line 336
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v5

    .line 337
    const/16 v6, 0x30

    if-lt v5, v6, :cond_2

    const/16 v6, 0x39

    if-gt v5, v6, :cond_2

    .line 338
    add-int/lit8 v2, v2, 0x1

    .line 335
    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 339
    :cond_2
    const/16 v6, 0x2e

    if-ne v5, v6, :cond_0

    if-lez v2, :cond_0

    .line 340
    add-int/lit8 v4, v4, 0x1

    move v2, v3

    .line 341
    goto :goto_2

    .line 346
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
    .line 167
    :try_start_0
    new-instance v0, Ljava/lang/String;

    const-string v1, "UTF-8"

    invoke-direct {v0, p0, v1}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    invoke-static {v0}, Lcom/mrkeyboard/app/MrJson;->parse(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrJson;->obj(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v2

    .line 168
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

    .line 172
    :catch_0
    move-exception v0

    .line 173
    throw v0

    .line 169
    :cond_0
    :try_start_1
    const-string v0, "algorithm"

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 170
    const-string v0, "data"

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 171
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

    .line 177
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

    .line 178
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_signature"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 174
    :catch_1
    move-exception v0

    .line 175
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_corrupt"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p3, v2, v3

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 182
    :cond_1
    :try_start_2
    const-string v0, "UTF-8"

    invoke-virtual {p2, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    .line 183
    const-string v1, "UTF-8"

    invoke-virtual {v4, v1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v1

    .line 184
    array-length v6, v0

    array-length v7, v1

    add-int/2addr v6, v7

    new-array v6, v6, [B

    .line 185
    const/4 v7, 0x0

    const/4 v8, 0x0

    array-length v9, v0

    invoke-static {v0, v7, v6, v8, v9}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 186
    const/4 v7, 0x0

    array-length v0, v0

    array-length v8, v1

    invoke-static {v1, v7, v6, v0, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    .line 190
    const/4 v0, 0x0

    .line 191
    if-eqz p4, :cond_2

    .line 192
    array-length v7, p4

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v7, :cond_2

    aget-object v8, p4, v1

    .line 194
    :try_start_3
    invoke-static {v3}, Ljava/security/Signature;->getInstance(Ljava/lang/String;)Ljava/security/Signature;

    move-result-object v9

    .line 195
    invoke-virtual {v8}, Ljava/security/cert/X509Certificate;->getPublicKey()Ljava/security/PublicKey;

    move-result-object v8

    invoke-virtual {v9, v8}, Ljava/security/Signature;->initVerify(Ljava/security/PublicKey;)V

    .line 196
    invoke-virtual {v9, v6}, Ljava/security/Signature;->update([B)V

    .line 197
    invoke-virtual {v9, v5}, Ljava/security/Signature;->verify([B)Z
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    move-result v8

    if-eqz v8, :cond_3

    .line 198
    const/4 v0, 0x1

    .line 206
    :cond_2
    if-nez v0, :cond_5

    .line 207
    const-string v0, "signer"

    const/4 v1, 0x0

    invoke-static {v2, v0, v1}, Lcom/mrkeyboard/app/MrJson;->optStr(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 208
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

    .line 209
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_other_key"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 187
    :catch_2
    move-exception v0

    .line 188
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_signature"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 201
    :catch_3
    move-exception v8

    .line 192
    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 211
    :cond_4
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_signature"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 213
    :cond_5
    return-object v4
.end method

.method static zipUrl(Lcom/mrkeyboard/app/MrPacks$Pack;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 351
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
