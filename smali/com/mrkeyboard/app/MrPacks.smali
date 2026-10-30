.class public final Lcom/mrkeyboard/app/MrPacks;
.super Ljava/lang/Object;
.source "MrPacks.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrPacks$PackException;,
        Lcom/mrkeyboard/app/MrPacks$Catalog;,
        Lcom/mrkeyboard/app/MrPacks$Pack;,
        Lcom/mrkeyboard/app/MrPacks$Net;,
        Lcom/mrkeyboard/app/MrPacks$HttpError;,
        Lcom/mrkeyboard/app/MrPacks$Api28;
    }
.end annotation


# static fields
.field static final CATALOG_FORMAT:I = 0x1

.field static final CATALOG_URL:Ljava/lang/String; = "https://github.com/x-mrrobot-x/mr-keyboard/releases/download/dicionarios/catalogo.json"

.field static final DICT_TYPE:I = 0x1

.field static final KEY_AUTO:Ljava/lang/String; = "auto_check"

.field static final KEY_CATALOG:Ljava/lang/String; = "catalog"

.field static final KEY_CHECKED:Ljava/lang/String; = "checked_at"

.field static final KEY_INSTALLED:Ljava/lang/String; = "installed."

.field static final KEY_SERIAL:Ljava/lang/String; = "serial"

.field static final KEY_WIFI:Ljava/lang/String; = "wifi_only"

.field static final MAIN:Ljava/lang/String; = "main.dict"

.field static final MANIFEST:Ljava/lang/String; = "pack.json"

.field static final MAX_CATALOG:I = 0x100000

.field static final MAX_PACK:J = 0x4000000L

.field static final NOTICE:Ljava/lang/String; = "NOTICE.txt"

.field static final PACK_FORMAT:I = 0x1

.field static final PREFS:Ljava/lang/String; = "mr_packs"

.field static final RULES:Ljava/lang/String; = "rules.txt"

.field static final SIGNAL_KEY:Ljava/lang/String; = "mr_dicts_updated_at"

.field static final SIG_PREFIX:Ljava/lang/String; = "mr-keyboard/catalogo/v1\n"

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
    .locals 1

    .prologue
    .line 334
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$1;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrPacks$1;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sNet:Lcom/mrkeyboard/app/MrPacks$Net;

    .line 369
    const-string v0, "https://github.com/x-mrrobot-x/mr-keyboard/releases/download/dicionarios/catalogo.json"

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sCatalogUrl:Ljava/lang/String;

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

    .line 777
    const-class v4, Lcom/mrkeyboard/app/MrPacks;

    monitor-enter v4

    if-eqz p0, :cond_0

    :try_start_0
    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v0

    move-object v3, v0

    .line 778
    :goto_0
    if-nez v3, :cond_1

    .line 779
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrRules;->set(Lcom/mrkeyboard/app/MrRules;)V

    .line 780
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTrigram;->use(Ljava/io/File;)V

    .line 781
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sActiveDir:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 803
    :goto_1
    monitor-exit v4

    return-void

    :cond_0
    move-object v3, v1

    .line 777
    goto :goto_0

    .line 784
    :cond_1
    :try_start_1
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sActiveDir:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v0

    if-nez v0, :cond_2

    .line 788
    :try_start_2
    new-instance v2, Ljava/io/File;

    const-string v0, "rules.txt"

    invoke-direct {v2, p0, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 789
    invoke-virtual {v2}, Ljava/io/File;->isFile()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 790
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 791
    :try_start_3
    invoke-static {v0}, Lcom/mrkeyboard/app/MrRules;->parse(Ljava/io/InputStream;)Lcom/mrkeyboard/app/MrRules;
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    move-result-object v2

    move-object v5, v0

    move-object v0, v2

    move-object v2, v5

    .line 796
    :goto_2
    :try_start_4
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 798
    :goto_3
    invoke-static {v0}, Lcom/mrkeyboard/app/MrRules;->set(Lcom/mrkeyboard/app/MrRules;)V

    .line 799
    sput-object v3, Lcom/mrkeyboard/app/MrPacks;->sActiveDir:Ljava/lang/String;

    .line 801
    :cond_2
    new-instance v0, Ljava/io/File;

    const-string v2, "trigrams.bin"

    invoke-direct {v0, p0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 802
    invoke-virtual {v0}, Ljava/io/File;->isFile()Z

    move-result v2

    if-eqz v2, :cond_3

    move-object v1, v0

    :cond_3
    invoke-static {v1}, Lcom/mrkeyboard/app/MrTrigram;->use(Ljava/io/File;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_1

    .line 777
    :catchall_0
    move-exception v0

    monitor-exit v4

    throw v0

    .line 793
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 796
    :goto_4
    :try_start_5
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    move-object v0, v1

    .line 797
    goto :goto_3

    .line 796
    :catchall_1
    move-exception v0

    :goto_5
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 797
    throw v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 796
    :catchall_2
    move-exception v1

    move-object v5, v1

    move-object v1, v0

    move-object v0, v5

    goto :goto_5

    .line 793
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

    .line 493
    iget v1, p1, Lcom/mrkeyboard/app/MrPacks$Pack;->format:I

    if-ne v1, v0, :cond_0

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
    .line 486
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

    .line 488
    :goto_0
    return-wide v0

    .line 487
    :catch_0
    move-exception v0

    .line 488
    const-wide/16 v0, 0x0

    goto :goto_0
.end method

.method static autoCheck(Landroid/content/Context;)Z
    .locals 3

    .prologue
    .line 406
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "auto_check"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method static declared-synchronized cachedCatalog(Landroid/content/Context;)Lcom/mrkeyboard/app/MrPacks$Catalog;
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 414
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

    .line 415
    if-nez v2, :cond_0

    .line 423
    :goto_0
    monitor-exit v1

    return-object v0

    .line 416
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

    .line 418
    :cond_1
    :try_start_2
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->readData(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Catalog;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sCached:Lcom/mrkeyboard/app/MrPacks$Catalog;
    :try_end_2
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 422
    :goto_1
    :try_start_3
    sput-object v2, Lcom/mrkeyboard/app/MrPacks;->sCachedData:Ljava/lang/String;

    .line 423
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sCached:Lcom/mrkeyboard/app/MrPacks$Catalog;

    goto :goto_0

    .line 419
    :catch_0
    move-exception v0

    .line 420
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sCached:Lcom/mrkeyboard/app/MrPacks$Catalog;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    .line 414
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static certSha(Ljava/security/cert/X509Certificate;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 907
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

    .line 909
    :goto_0
    return-object v0

    .line 908
    :catch_0
    move-exception v0

    .line 909
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

    .line 871
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sTestCerts:[Ljava/security/cert/X509Certificate;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sTestCerts:[Ljava/security/cert/X509Certificate;

    .line 886
    :goto_0
    return-object v0

    .line 877
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x40

    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    .line 878
    iget-object v4, v0, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    .line 880
    if-eqz v4, :cond_1

    array-length v0, v4

    if-nez v0, :cond_2

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

    .line 887
    :catch_0
    move-exception v0

    .line 888
    throw v0

    .line 881
    :cond_2
    :try_start_1
    const-string v0, "X.509"

    invoke-static {v0}, Ljava/security/cert/CertificateFactory;->getInstance(Ljava/lang/String;)Ljava/security/cert/CertificateFactory;

    move-result-object v5

    .line 882
    array-length v0, v4

    new-array v1, v0, [Ljava/security/cert/X509Certificate;

    move v2, v3

    .line 883
    :goto_1
    array-length v0, v4

    if-ge v2, v0, :cond_3

    .line 884
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

    .line 883
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_1

    :cond_3
    move-object v0, v1

    .line 886
    goto :goto_0

    .line 889
    :catch_1
    move-exception v0

    .line 890
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

    .line 632
    new-instance v0, Ljava/io/File;

    const-string v1, "main.dict"

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 633
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

    .line 634
    :cond_0
    new-instance v0, Ljava/io/File;

    const-string v1, "trigrams.bin"

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 635
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 636
    const/4 v1, 0x4

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacks;->head(Ljava/io/File;I)[B

    move-result-object v0

    .line 637
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

    .line 638
    :cond_1
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_corrupt"

    new-array v2, v3, [Ljava/lang/Object;

    const-string v3, "trigrams.bin"

    aput-object v3, v2, v4

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 641
    :cond_2
    new-instance v2, Ljava/io/File;

    const-string v0, "rules.txt"

    invoke-direct {v2, p0, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 642
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 643
    const/4 v1, 0x0

    .line 645
    :try_start_0
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 646
    :try_start_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrRules;->parse(Ljava/io/InputStream;)Lcom/mrkeyboard/app/MrRules;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 650
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 653
    :cond_3
    return-void

    .line 647
    :catch_0
    move-exception v0

    move-object v0, v1

    .line 648
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

    .line 650
    :catchall_0
    move-exception v1

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    :goto_1
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 651
    throw v0

    .line 650
    :catchall_1
    move-exception v0

    goto :goto_1

    .line 647
    :catch_1
    move-exception v1

    goto :goto_0
.end method

.method static checkedAt(Landroid/content/Context;)J
    .locals 4

    .prologue
    .line 427
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
    .line 944
    if-nez p0, :cond_0

    .line 950
    :goto_0
    return-void

    .line 946
    :cond_0
    :try_start_0
    invoke-interface {p0}, Ljava/io/Closeable;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 947
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static deleteTree(Ljava/io/File;)V
    .locals 4

    .prologue
    .line 937
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_1

    .line 941
    :cond_0
    :goto_0
    return-void

    .line 938
    :cond_1
    invoke-virtual {p0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v1

    .line 939
    if-eqz v1, :cond_2

    array-length v2, v1

    const/4 v0, 0x0

    :goto_1
    if-ge v0, v2, :cond_2

    aget-object v3, v1, v0

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 940
    :cond_2
    invoke-virtual {p0}, Ljava/io/File;->delete()Z

    goto :goto_0
.end method

.method static dictHeaderOk(Ljava/io/File;)Z
    .locals 6

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 656
    invoke-virtual {p0}, Ljava/io/File;->length()J

    move-result-wide v2

    .line 657
    const-wide/16 v4, 0x400

    cmp-long v4, v2, v4

    if-ltz v4, :cond_0

    const-wide/32 v4, 0x400000

    cmp-long v2, v2, v4

    if-lez v2, :cond_2

    :cond_0
    move v0, v1

    .line 659
    :cond_1
    :goto_0
    return v0

    .line 658
    :cond_2
    const/4 v2, 0x2

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrPacks;->head(Ljava/io/File;I)[B

    move-result-object v2

    .line 659
    if-eqz v2, :cond_3

    aget-byte v3, v2, v1

    and-int/lit16 v3, v3, 0xff

    const/16 v4, 0xc8

    if-ne v3, v4, :cond_3

    aget-byte v2, v2, v0

    if-eq v2, v0, :cond_1

    :cond_3
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

    .line 539
    .line 542
    :try_start_0
    const-string v0, "SHA-256"

    invoke-static {v0}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v0

    .line 543
    const/4 v2, 0x1

    new-array v2, v2, [J

    .line 544
    sget-object v3, Lcom/mrkeyboard/app/MrPacks;->sNet:Lcom/mrkeyboard/app/MrPacks$Net;

    invoke-interface {v3, p0, v2}, Lcom/mrkeyboard/app/MrPacks$Net;->open(Ljava/lang/String;[J)Ljava/io/InputStream;
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_0 .. :try_end_0} :catch_b
    .catch Lcom/mrkeyboard/app/MrPacks$HttpError; {:try_start_0 .. :try_end_0} :catch_a
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_9
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_6
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    move-result-object v3

    .line 545
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

    .line 562
    :catch_0
    move-exception v0

    move-object v2, v3

    .line 563
    :goto_0
    :try_start_2
    throw v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 572
    :catchall_0
    move-exception v0

    move-object v3, v2

    :goto_1
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 573
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 574
    throw v0

    .line 546
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

    .line 547
    const/high16 v6, 0x10000

    :try_start_4
    new-array v6, v6, [B

    .line 550
    :goto_2
    invoke-virtual {v3, v6}, Ljava/io/InputStream;->read([B)I

    move-result v7

    if-lez v7, :cond_3

    .line 551
    sget-boolean v8, Lcom/mrkeyboard/app/MrPacks;->sCancel:Z

    if-eqz v8, :cond_1

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_cancel"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-direct {v0, v1, v4}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 562
    :catch_1
    move-exception v0

    move-object v1, v2

    move-object v2, v3

    goto :goto_0

    .line 552
    :cond_1
    int-to-long v8, v7

    add-long/2addr v4, v8

    .line 553
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

    .line 564
    :catch_2
    move-exception v0

    move-object v1, v2

    .line 565
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

    .line 572
    :catchall_1
    move-exception v0

    goto :goto_1

    .line 554
    :cond_2
    const/4 v8, 0x0

    :try_start_6
    invoke-virtual {v0, v6, v8, v7}, Ljava/security/MessageDigest;->update([BII)V

    .line 555
    const/4 v8, 0x0

    invoke-virtual {v2, v6, v8, v7}, Ljava/io/OutputStream;->write([BII)V

    .line 556
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

    .line 566
    :catch_3
    move-exception v0

    move-object v1, v2

    .line 567
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

    .line 558
    :cond_3
    :try_start_8
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_8
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_8 .. :try_end_8} :catch_1
    .catch Lcom/mrkeyboard/app/MrPacks$HttpError; {:try_start_8 .. :try_end_8} :catch_2
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_3
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    .line 560
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

    .line 564
    :catch_4
    move-exception v0

    goto :goto_3

    .line 561
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

    .line 566
    :catch_5
    move-exception v0

    goto :goto_4

    .line 572
    :cond_5
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 573
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 575
    return-void

    .line 568
    :cond_6
    :try_start_a
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_dicts_err_network"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-direct {v0, v2, v4}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 569
    :catch_6
    move-exception v0

    move-object v3, v1

    .line 570
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

    .line 572
    :catchall_2
    move-exception v0

    move-object v3, v1

    goto/16 :goto_1

    :catchall_3
    move-exception v0

    move-object v1, v2

    goto/16 :goto_1

    .line 569
    :catch_7
    move-exception v0

    goto :goto_5

    :catch_8
    move-exception v0

    move-object v1, v2

    goto :goto_5

    .line 566
    :catch_9
    move-exception v0

    move-object v3, v1

    goto/16 :goto_4

    .line 564
    :catch_a
    move-exception v0

    move-object v3, v1

    goto/16 :goto_3

    .line 562
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
    .line 579
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

    .line 580
    :cond_0
    new-instance v8, Ljava/util/HashSet;

    invoke-direct {v8}, Ljava/util/HashSet;-><init>()V

    .line 581
    const/4 v4, 0x0

    .line 583
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

    .line 584
    const/high16 v2, 0x10000

    :try_start_1
    new-array v9, v2, [B

    .line 586
    :cond_1
    invoke-virtual {v3}, Ljava/util/zip/ZipInputStream;->getNextEntry()Ljava/util/zip/ZipEntry;

    move-result-object v10

    if-eqz v10, :cond_a

    .line 587
    invoke-virtual {v10}, Ljava/util/zip/ZipEntry;->getName()Ljava/lang/String;

    move-result-object v11

    .line 590
    const-string v2, "pack.json"

    invoke-virtual {v11, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 591
    const-wide/32 v4, 0x10000

    .line 592
    move-object/from16 v0, p2

    iget-object v2, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->manifestSha:Ljava/lang/String;

    move-wide v6, v4

    .line 599
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

    .line 618
    :catch_0
    move-exception v2

    .line 619
    :goto_1
    :try_start_2
    throw v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 623
    :catchall_0
    move-exception v2

    :goto_2
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 624
    throw v2

    .line 594
    :cond_3
    :try_start_3
    move-object/from16 v0, p2

    iget-object v2, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->fileNames:[Ljava/lang/String;

    invoke-static {v2, v11}, Lcom/mrkeyboard/app/MrPacks;->indexOf([Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 595
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

    .line 620
    :catch_1
    move-exception v2

    .line 621
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

    .line 596
    :cond_4
    :try_start_5
    move-object/from16 v0, p2

    iget-object v4, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSizes:[J

    aget-wide v4, v4, v2

    .line 597
    move-object/from16 v0, p2

    iget-object v6, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSha:[Ljava/lang/String;

    aget-object v2, v6, v2

    move-wide v6, v4

    goto :goto_0

    .line 600
    :cond_5
    const-string v4, "SHA-256"

    invoke-static {v4}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v10

    .line 601
    new-instance v12, Ljava/io/FileOutputStream;

    new-instance v4, Ljava/io/File;

    move-object/from16 v0, p1

    invoke-direct {v4, v0, v11}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-direct {v12, v4}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_5
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_5 .. :try_end_5} :catch_0
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 602
    const-wide/16 v4, 0x0

    .line 605
    :goto_4
    :try_start_6
    invoke-virtual {v3, v9}, Ljava/util/zip/ZipInputStream;->read([B)I

    move-result v13

    if-lez v13, :cond_8

    .line 606
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

    .line 613
    :catchall_1
    move-exception v2

    :try_start_7
    invoke-virtual {v12}, Ljava/io/OutputStream;->close()V

    .line 614
    throw v2
    :try_end_7
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_7 .. :try_end_7} :catch_0
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_1
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 607
    :cond_6
    int-to-long v14, v13

    add-long/2addr v4, v14

    .line 608
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

    .line 609
    :cond_7
    const/4 v14, 0x0

    invoke-virtual {v10, v9, v14, v13}, Ljava/security/MessageDigest;->update([BII)V

    .line 610
    const/4 v14, 0x0

    invoke-virtual {v12, v9, v14, v13}, Ljava/io/OutputStream;->write([BII)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    goto :goto_4

    .line 613
    :cond_8
    :try_start_9
    invoke-virtual {v12}, Ljava/io/OutputStream;->close()V

    .line 615
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

    .line 616
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

    .line 623
    :cond_a
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 625
    move-object/from16 v0, p2

    iget-object v3, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->fileNames:[Ljava/lang/String;

    array-length v4, v3

    const/4 v2, 0x0

    :goto_5
    if-ge v2, v4, :cond_c

    aget-object v5, v3, v2

    .line 626
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

    .line 625
    :cond_b
    add-int/lit8 v2, v2, 0x1

    goto :goto_5

    .line 628
    :cond_c
    return-void

    .line 623
    :catchall_2
    move-exception v2

    move-object v3, v4

    goto/16 :goto_2

    .line 620
    :catch_2
    move-exception v2

    move-object v3, v4

    goto/16 :goto_3

    .line 618
    :catch_3
    move-exception v2

    move-object v3, v4

    goto/16 :goto_1
.end method

.method static fetchBytes(Ljava/lang/String;I)[B
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    const/16 v0, 0x2000

    .line 374
    const/4 v1, 0x0

    .line 376
    const/4 v2, 0x1

    :try_start_0
    new-array v2, v2, [J

    .line 377
    sget-object v3, Lcom/mrkeyboard/app/MrPacks;->sNet:Lcom/mrkeyboard/app/MrPacks$Net;

    invoke-interface {v3, p0, v2}, Lcom/mrkeyboard/app/MrPacks$Net;->open(Ljava/lang/String;[J)Ljava/io/InputStream;

    move-result-object v1

    .line 378
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

    .line 379
    const/16 v0, 0x2000

    new-array v0, v0, [B

    .line 381
    :cond_1
    invoke-virtual {v1, v0}, Ljava/io/InputStream;->read([B)I

    move-result v2

    if-lez v2, :cond_2

    .line 382
    const/4 v4, 0x0

    invoke-virtual {v3, v0, v4, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 383
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v2

    if-le v2, p1, :cond_1

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_dicts_err_corrupt"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    const-string v5, "catalogo.json"

    aput-object v5, v3, v4

    invoke-direct {v0, v2, v3}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrPacks$HttpError; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 386
    :catch_0
    move-exception v0

    .line 387
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

    .line 391
    :catchall_0
    move-exception v0

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 392
    throw v0

    .line 385
    :cond_2
    :try_start_2
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B
    :try_end_2
    .catch Lcom/mrkeyboard/app/MrPacks$HttpError; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v0

    .line 391
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 385
    return-object v0

    .line 388
    :catch_1
    move-exception v0

    .line 389
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
    .line 432
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sCatalogUrl:Ljava/lang/String;

    const/high16 v1, 0x100000

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacks;->fetchBytes(Ljava/lang/String;I)[B

    move-result-object v0

    .line 433
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 434
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->certs(Landroid/content/Context;)[Ljava/security/cert/X509Certificate;

    move-result-object v2

    const-string v3, "serial"

    const-wide/16 v4, 0x0

    invoke-interface {v1, v3, v4, v5}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v4

    invoke-static {v0, v2, v4, v5}, Lcom/mrkeyboard/app/MrPacks;->parseCatalog([B[Ljava/security/cert/X509Certificate;J)Lcom/mrkeyboard/app/MrPacks$Catalog;

    move-result-object v0

    .line 435
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

    .line 436
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-interface {v1, v2, v4, v5}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 437
    return-object v0
.end method

.method private static head(Ljava/io/File;I)[B
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 663
    .line 665
    :try_start_0
    new-instance v2, Ljava/io/FileInputStream;

    invoke-direct {v2, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 666
    :try_start_1
    new-array v1, p1, [B

    .line 667
    const/4 v3, 0x0

    .line 668
    :goto_0
    if-ge v3, p1, :cond_1

    .line 669
    sub-int v4, p1, v3

    invoke-virtual {v2, v1, v3, v4}, Ljava/io/InputStream;->read([BII)I
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result v4

    .line 670
    if-gtz v4, :cond_0

    .line 677
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 675
    :goto_1
    return-object v0

    .line 671
    :cond_0
    add-int/2addr v3, v4

    .line 672
    goto :goto_0

    .line 677
    :cond_1
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    move-object v0, v1

    .line 673
    goto :goto_1

    .line 674
    :catch_0
    move-exception v1

    move-object v1, v0

    .line 677
    :goto_2
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    goto :goto_1

    :catchall_0
    move-exception v1

    move-object v2, v0

    move-object v0, v1

    :goto_3
    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->closeQuietly(Ljava/io/Closeable;)V

    .line 678
    throw v0

    .line 677
    :catchall_1
    move-exception v0

    goto :goto_3

    .line 674
    :catch_1
    move-exception v1

    move-object v1, v2

    goto :goto_2
.end method

.method static hex([B)Ljava/lang/String;
    .locals 5

    .prologue
    .line 922
    array-length v0, p0

    mul-int/lit8 v0, v0, 0x2

    new-array v1, v0, [C

    .line 923
    const-string v0, "0123456789abcdef"

    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v2

    .line 924
    const/4 v0, 0x0

    :goto_0
    array-length v3, p0

    if-ge v0, v3, :cond_0

    .line 925
    mul-int/lit8 v3, v0, 0x2

    aget-byte v4, p0, v0

    shr-int/lit8 v4, v4, 0x4

    and-int/lit8 v4, v4, 0xf

    aget-char v4, v2, v4

    aput-char v4, v1, v3

    .line 926
    mul-int/lit8 v3, v0, 0x2

    add-int/lit8 v3, v3, 0x1

    aget-byte v4, p0, v0

    and-int/lit8 v4, v4, 0xf

    aget-char v4, v2, v4

    aput-char v4, v1, v3

    .line 924
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 928
    :cond_0
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/String;-><init>([C)V

    return-object v0
.end method

.method private static hexField(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;
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

    .line 280
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    .line 281
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v0

    if-eq v0, v4, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 282
    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v4, :cond_4

    .line 283
    invoke-virtual {v1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 284
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

    .line 282
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 286
    :cond_4
    return-object v1
.end method

.method private static indexOf([Ljava/lang/String;Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 932
    const/4 v0, 0x0

    :goto_0
    array-length v1, p0

    if-ge v0, v1, :cond_1

    aget-object v1, p0, v0

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 933
    :goto_1
    return v0

    .line 932
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 933
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

    .line 501
    sput-boolean v1, Lcom/mrkeyboard/app/MrPacks;->sCancel:Z

    .line 502
    sput v1, Lcom/mrkeyboard/app/MrPacks;->sJobPercent:I

    .line 503
    sput-boolean v1, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 504
    iget-object v0, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    .line 505
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->root(Landroid/content/Context;)Ljava/io/File;

    move-result-object v0

    .line 506
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

    .line 507
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

    .line 509
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

    .line 531
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    .line 532
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 533
    sput-object v9, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    .line 534
    sput-boolean v1, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 535
    throw v0

    .line 510
    :cond_0
    :try_start_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->wifiOnly(Landroid/content/Context;)Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->isMetered(Landroid/content/Context;)Z

    move-result v4

    if-eqz v4, :cond_1

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v4, "mr_dicts_err_wifi"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-direct {v0, v4, v5}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 511
    :cond_1
    iget-wide v4, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    iget-wide v6, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->installedSize:J

    add-long/2addr v4, v6

    const-wide/32 v6, 0x200000

    add-long/2addr v4, v6

    .line 512
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v6

    if-nez v6, :cond_2

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    .line 513
    :cond_2
    invoke-virtual {v0}, Ljava/io/File;->getUsableSpace()J

    move-result-wide v6

    cmp-long v6, v6, v4

    if-gez v6, :cond_3

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

    .line 514
    :cond_3
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v5, p1, Lcom/mrkeyboard/app/MrPacks$Catalog;->baseUrl:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->url:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v2, p2}, Lcom/mrkeyboard/app/MrPacks;->download(Ljava/lang/String;Ljava/io/File;Lcom/mrkeyboard/app/MrPacks$Pack;)V

    .line 515
    const/4 v4, 0x1

    sput-boolean v4, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 516
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 517
    invoke-static {v2, v3, p2}, Lcom/mrkeyboard/app/MrPacks;->extract(Ljava/io/File;Ljava/io/File;Lcom/mrkeyboard/app/MrPacks$Pack;)V

    .line 518
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->checkFiles(Ljava/io/File;)V

    .line 519
    iget-object v4, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    iget v5, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    invoke-static {p0, v4, v5}, Lcom/mrkeyboard/app/MrPacks;->packDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;

    move-result-object v4

    .line 520
    invoke-static {v4}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 521
    invoke-virtual {v3, v4}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    move-result v4

    if-nez v4, :cond_4

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v4, "mr_dicts_err_io"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    const-string v7, "rename"

    aput-object v7, v5, v6

    invoke-direct {v0, v4, v5}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 522
    :cond_4
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

    .line 523
    new-instance v4, Ljava/io/File;

    iget-object v5, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-direct {v4, v0, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v4}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v4

    .line 524
    if-eqz v4, :cond_6

    .line 525
    array-length v5, v4

    move v0, v1

    :goto_0
    if-ge v0, v5, :cond_6

    aget-object v6, v4, v0

    .line 526
    invoke-virtual {v6}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v7

    iget v8, p2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    invoke-static {v8}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_5

    invoke-static {v6}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 525
    :cond_5
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 529
    :cond_6
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->signal(Landroid/content/Context;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 531
    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    .line 532
    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 533
    sput-object v9, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    .line 534
    sput-boolean v1, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 536
    return-void
.end method

.method static installedFor(Landroid/content/Context;Ljava/lang/String;)Ljava/io/File;
    .locals 10

    .prologue
    const/4 v9, 0x0

    const/4 v2, 0x0

    const/4 v8, 0x1

    .line 712
    invoke-static {p1}, Lcom/mrkeyboard/app/MrPacks;->splitLocale(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v3

    .line 713
    aget-object v0, v3, v9

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    .line 722
    :cond_0
    :goto_0
    return-object v2

    .line 715
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

    .line 716
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->splitLocale(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    .line 717
    aget-object v6, v5, v9

    aget-object v7, v3, v9

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 718
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

    .line 719
    goto :goto_1

    .line 720
    :cond_4
    if-eqz v1, :cond_0

    .line 721
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrPacks;->installedVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    invoke-static {p0, v1, v0}, Lcom/mrkeyboard/app/MrPacks;->packDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;

    move-result-object v0

    .line 722
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
    .line 446
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 447
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

    .line 448
    const-string v3, "installed."

    invoke-virtual {v0, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 449
    const-string v3, "installed."

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v0, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 450
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->validId(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 453
    :cond_1
    invoke-static {v1}, Ljava/util/Collections;->sort(Ljava/util/List;)V

    .line 454
    return-object v1
.end method

.method static installedVersion(Landroid/content/Context;Ljava/lang/String;)I
    .locals 3

    .prologue
    .line 441
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

.method static isMetered(Landroid/content/Context;)Z
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    .line 474
    const-string v0, "connectivity"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 475
    if-nez v0, :cond_0

    move v0, v1

    .line 480
    :goto_0
    return v0

    .line 477
    :cond_0
    :try_start_0
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetwork()Landroid/net/Network;

    move-result-object v2

    if-nez v2, :cond_1

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_dicts_err_network"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-direct {v0, v2, v3}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 479
    :catch_0
    move-exception v0

    move v0, v1

    .line 480
    goto :goto_0

    .line 478
    :cond_1
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->isActiveNetworkMetered()Z
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    goto :goto_0
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
    .line 125
    if-nez p0, :cond_1

    .line 132
    :cond_0
    :goto_0
    return-object p2

    .line 126
    :cond_1
    if-eqz p1, :cond_4

    invoke-virtual {p1}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 127
    :goto_1
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_2

    const-string v0, "en"

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 128
    :cond_2
    instance-of v1, v0, Ljava/lang/String;

    if-nez v1, :cond_5

    .line 129
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

    .line 126
    :cond_4
    const/4 v0, 0x0

    goto :goto_1

    .line 132
    :cond_5
    check-cast v0, Ljava/lang/String;

    move-object p2, v0

    goto :goto_0
.end method

.method private static lowerLetters(Ljava/lang/String;II)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 305
    sub-int v1, p2, p1

    const/4 v2, 0x2

    if-ge v1, v2, :cond_2

    .line 310
    :cond_0
    :goto_0
    return v0

    .line 306
    :cond_1
    add-int/lit8 p1, p1, 0x1

    :cond_2
    if-ge p1, p2, :cond_3

    .line 307
    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 308
    const/16 v2, 0x61

    if-lt v1, v2, :cond_0

    const/16 v2, 0x7a

    if-le v1, v2, :cond_1

    goto :goto_0

    .line 310
    :cond_3
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public static mainDictionary(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/BinaryDictionary;
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 762
    invoke-static {p1}, Lcom/mrkeyboard/app/MrPacks;->splitLocale(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x0

    aget-object v0, v0, v2

    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sLastLang:Ljava/lang/String;

    .line 766
    :try_start_0
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->installedFor(Landroid/content/Context;Ljava/lang/String;)Ljava/io/File;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 767
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

    .line 771
    :goto_1
    if-eqz v2, :cond_0

    move-object v1, v0

    :cond_0
    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacks;->activate(Ljava/io/File;)V

    .line 772
    if-eqz v2, :cond_1

    move-object v0, v2

    .line 773
    :goto_2
    return-object v0

    .line 768
    :catch_0
    move-exception v0

    move-object v0, v1

    :goto_3
    move-object v2, v1

    .line 769
    goto :goto_1

    .line 773
    :cond_1
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/PluginManager;->getDictionary(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v0

    goto :goto_2

    .line 768
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

    .line 817
    :try_start_0
    sget-object v4, Lcom/mrkeyboard/app/MrPacks;->sLastLang:Ljava/lang/String;

    .line 818
    if-eqz p0, :cond_0

    if-eqz v4, :cond_0

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    move-object v0, v3

    .line 840
    :goto_0
    return-object v0

    .line 819
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->cachedCatalog(Landroid/content/Context;)Lcom/mrkeyboard/app/MrPacks$Catalog;

    move-result-object v0

    .line 820
    if-eqz v0, :cond_3

    .line 822
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

    .line 823
    :cond_2
    if-nez v2, :cond_3

    move-object v0, v3

    goto :goto_0

    .line 825
    :cond_3
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    .line 826
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sOfferLabel:Ljava/lang/String;

    .line 827
    if-eqz v0, :cond_4

    sget-wide v6, Lcom/mrkeyboard/app/MrPacks;->sOfferAt:J

    sub-long v6, v4, v6

    const-wide/16 v8, 0x7530

    cmp-long v1, v6, v8

    if-lez v1, :cond_5

    .line 828
    :cond_4
    const-string v0, "mr_dicts_offer"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 829
    sput-wide v4, Lcom/mrkeyboard/app/MrPacks;->sOfferAt:J

    .line 831
    :cond_5
    if-nez v0, :cond_6

    move-object v0, v3

    goto :goto_0

    .line 832
    :cond_6
    sget-object v1, Lcom/mrkeyboard/app/MrPacks;->sOffer:Ljava/lang/String;

    if-eqz v1, :cond_7

    sget-object v1, Lcom/mrkeyboard/app/MrPacks;->sOfferLabel:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_8

    .line 833
    :cond_7
    sput-object v0, Lcom/mrkeyboard/app/MrPacks;->sOfferLabel:Ljava/lang/String;

    .line 834
    new-instance v1, Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/String;-><init>([C)V

    sput-object v1, Lcom/mrkeyboard/app/MrPacks;->sOffer:Ljava/lang/String;

    .line 836
    :cond_8
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 837
    sget-object v1, Lcom/mrkeyboard/app/MrPacks;->sOffer:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 839
    :catch_0
    move-exception v0

    move-object v0, v3

    .line 840
    goto :goto_0

    :cond_9
    move v0, v2

    goto :goto_2
.end method

.method public static onPick(Landroid/content/Context;Ljava/lang/CharSequence;)Z
    .locals 2

    .prologue
    .line 846
    if-eqz p1, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sOffer:Ljava/lang/String;

    if-eq p1, v0, :cond_1

    :cond_0
    const/4 v0, 0x0

    .line 854
    :goto_0
    return v0

    .line 848
    :cond_1
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 849
    const/high16 v1, 0x10000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 850
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 854
    :goto_1
    const/4 v0, 0x1

    goto :goto_0

    .line 851
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

    .line 737
    invoke-static {p1}, Lcom/mrkeyboard/app/MrPacks;->dictHeaderOk(Ljava/io/File;)Z

    move-result v0

    if-nez v0, :cond_0

    move-object v0, v6

    .line 747
    :goto_0
    return-object v0

    .line 738
    :cond_0
    new-instance v7, Ljava/io/RandomAccessFile;

    const-string v0, "r"

    invoke-direct {v7, p1, v0}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 740
    :try_start_0
    invoke-virtual {v7}, Ljava/io/RandomAccessFile;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v0

    .line 741
    sget-object v1, Ljava/nio/channels/FileChannel$MapMode;->READ_ONLY:Ljava/nio/channels/FileChannel$MapMode;

    const-wide/16 v2, 0x0

    invoke-virtual {v0}, Ljava/nio/channels/FileChannel;->size()J

    move-result-wide v4

    invoke-virtual/range {v0 .. v5}, Ljava/nio/channels/FileChannel;->map(Ljava/nio/channels/FileChannel$MapMode;JJ)Ljava/nio/MappedByteBuffer;

    move-result-object v1

    .line 742
    new-instance v0, Lcom/mrkeyboard/app/BinaryDictionary;

    const/4 v2, 0x1

    invoke-direct {v0, p0, v1, v2}, Lcom/mrkeyboard/app/BinaryDictionary;-><init>(Landroid/content/Context;Ljava/nio/ByteBuffer;I)V

    .line 743
    invoke-virtual {v0}, Lcom/mrkeyboard/app/BinaryDictionary;->getSize()I

    move-result v1

    const/4 v2, 0x2

    if-gt v1, v2, :cond_1

    .line 744
    invoke-virtual {v0}, Lcom/mrkeyboard/app/BinaryDictionary;->close()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 749
    invoke-virtual {v7}, Ljava/io/RandomAccessFile;->close()V

    move-object v0, v6

    .line 745
    goto :goto_0

    .line 749
    :cond_1
    invoke-virtual {v7}, Ljava/io/RandomAccessFile;->close()V

    goto :goto_0

    :catchall_0
    move-exception v0

    invoke-virtual {v7}, Ljava/io/RandomAccessFile;->close()V

    .line 750
    throw v0
.end method

.method static openDictionary(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/BinaryDictionary;
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 728
    if-nez p0, :cond_1

    .line 732
    :cond_0
    :goto_0
    return-object v0

    .line 729
    :cond_1
    :try_start_0
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->installedFor(Landroid/content/Context;Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    .line 730
    if-eqz v1, :cond_0

    new-instance v2, Ljava/io/File;

    const-string v3, "main.dict"

    invoke-direct {v2, v1, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrPacks;->open(Landroid/content/Context;Ljava/io/File;)Lcom/mrkeyboard/app/BinaryDictionary;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_0

    .line 731
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static packDir(Landroid/content/Context;Ljava/lang/String;I)Ljava/io/File;
    .locals 3

    .prologue
    .line 462
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
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrPacks$PackException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 145
    :try_start_0
    new-instance v2, Ljava/lang/String;

    const-string v3, "UTF-8"

    invoke-direct {v2, p0, v3}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    invoke-static {v2}, Lcom/mrkeyboard/app/MrJson;->parse(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Lcom/mrkeyboard/app/MrJson;->obj(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v3

    .line 146
    const-string v2, "format"

    invoke-static {v3, v2}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v4

    const-wide/16 v6, 0x1

    cmp-long v2, v4, v6

    if-eqz v2, :cond_0

    new-instance v2, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v3, "mr_dicts_err_new_format"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-direct {v2, v3, v4}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v2
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 150
    :catch_0
    move-exception v0

    .line 151
    throw v0

    .line 147
    :cond_0
    :try_start_1
    const-string v2, "algorithm"

    invoke-static {v3, v2}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 148
    const-string v2, "data"

    invoke-static {v3, v2}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 149
    invoke-static {}, Ljava/util/Base64;->getDecoder()Ljava/util/Base64$Decoder;

    move-result-object v2

    const-string v6, "signature"

    invoke-static {v3, v6}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Ljava/util/Base64$Decoder;->decode(Ljava/lang/String;)[B
    :try_end_1
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v6

    .line 155
    const-string v2, "SHA256withRSA"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "SHA256withECDSA"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "SHA256withDSA"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 156
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_dicts_err_signature"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {v0, v2, v1}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 152
    :catch_1
    move-exception v2

    .line 153
    new-instance v2, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v3, "mr_dicts_err_corrupt"

    new-array v0, v0, [Ljava/lang/Object;

    const-string v4, "catalogo.json"

    aput-object v4, v0, v1

    invoke-direct {v2, v3, v0}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v2

    .line 160
    :cond_1
    :try_start_2
    const-string v2, "mr-keyboard/catalogo/v1\n"

    const-string v7, "UTF-8"

    invoke-virtual {v2, v7}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v2

    .line 161
    const-string v7, "UTF-8"

    invoke-virtual {v5, v7}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v7

    .line 162
    array-length v8, v2

    array-length v9, v7

    add-int/2addr v8, v9

    new-array v8, v8, [B

    .line 163
    const/4 v9, 0x0

    const/4 v10, 0x0

    array-length v11, v2

    invoke-static {v2, v9, v8, v10, v11}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 164
    const/4 v9, 0x0

    array-length v2, v2

    array-length v10, v7

    invoke-static {v7, v9, v8, v2, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    .line 169
    if-eqz p1, :cond_6

    .line 170
    array-length v7, p1

    move v2, v1

    :goto_0
    if-ge v2, v7, :cond_6

    aget-object v9, p1, v2

    .line 172
    :try_start_3
    invoke-static {v4}, Ljava/security/Signature;->getInstance(Ljava/lang/String;)Ljava/security/Signature;

    move-result-object v10

    .line 173
    invoke-virtual {v9}, Ljava/security/cert/X509Certificate;->getPublicKey()Ljava/security/PublicKey;

    move-result-object v9

    invoke-virtual {v10, v9}, Ljava/security/Signature;->initVerify(Ljava/security/PublicKey;)V

    .line 174
    invoke-virtual {v10, v8}, Ljava/security/Signature;->update([B)V

    .line 175
    invoke-virtual {v10, v6}, Ljava/security/Signature;->verify([B)Z
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    move-result v9

    if-eqz v9, :cond_2

    .line 184
    :goto_1
    if-nez v0, :cond_4

    .line 185
    const-string v0, "signer"

    const/4 v2, 0x0

    invoke-static {v3, v0, v2}, Lcom/mrkeyboard/app/MrJson;->optStr(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 186
    if-eqz v0, :cond_3

    if-eqz p1, :cond_3

    array-length v2, p1

    if-lez v2, :cond_3

    aget-object v2, p1, v1

    invoke-static {v2}, Lcom/mrkeyboard/app/MrPacks;->certSha(Ljava/security/cert/X509Certificate;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 187
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_dicts_err_other_key"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {v0, v2, v1}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 165
    :catch_2
    move-exception v0

    .line 166
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_dicts_err_signature"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {v0, v2, v1}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 179
    :catch_3
    move-exception v9

    .line 170
    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 189
    :cond_3
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_dicts_err_signature"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {v0, v2, v1}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 191
    :cond_4
    invoke-static {v5}, Lcom/mrkeyboard/app/MrPacks;->readData(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Catalog;

    move-result-object v0

    .line 192
    iget-wide v2, v0, Lcom/mrkeyboard/app/MrPacks$Catalog;->serial:J

    cmp-long v2, v2, p2

    if-gez v2, :cond_5

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v2, "mr_dicts_err_old_catalog"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {v0, v2, v1}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 193
    :cond_5
    return-object v0

    :cond_6
    move v0, v1

    goto :goto_1
.end method

.method static prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .locals 2

    .prologue
    .line 398
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

    .line 199
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrJson;->parse(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrJson;->obj(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v0

    .line 200
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

    .line 215
    :catch_0
    move-exception v0

    .line 216
    throw v0

    .line 201
    :cond_0
    :try_start_1
    new-instance v1, Lcom/mrkeyboard/app/MrPacks$Catalog;

    invoke-direct {v1}, Lcom/mrkeyboard/app/MrPacks$Catalog;-><init>()V

    .line 202
    iput-object p0, v1, Lcom/mrkeyboard/app/MrPacks$Catalog;->data:Ljava/lang/String;

    .line 203
    const-string v2, "serial"

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v2

    iput-wide v2, v1, Lcom/mrkeyboard/app/MrPacks$Catalog;->serial:J

    .line 204
    const-string v2, "generated"

    const-string v3, ""

    invoke-static {v0, v2, v3}, Lcom/mrkeyboard/app/MrJson;->optStr(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/mrkeyboard/app/MrPacks$Catalog;->generated:Ljava/lang/String;

    .line 205
    const-string v2, "baseUrl"

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/mrkeyboard/app/MrPacks$Catalog;->baseUrl:Ljava/lang/String;

    .line 206
    iget-object v2, v1, Lcom/mrkeyboard/app/MrPacks$Catalog;->baseUrl:Ljava/lang/String;

    const-string v3, "https://"

    invoke-virtual {v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v2, v1, Lcom/mrkeyboard/app/MrPacks$Catalog;->baseUrl:Ljava/lang/String;

    const-string v3, "/"

    invoke-virtual {v2, v3}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    .line 207
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "baseUrl"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_1
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    .line 217
    :catch_1
    move-exception v0

    .line 218
    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_dicts_err_corrupt"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const-string v3, "catalogo.json"

    aput-object v3, v2, v6

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 209
    :cond_2
    :try_start_2
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    .line 210
    const-string v3, "packs"

    invoke-interface {v0, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrJson;->list(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_3
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .line 211
    invoke-static {v3}, Lcom/mrkeyboard/app/MrJson;->obj(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrPacks;->readPack(Ljava/util/Map;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v3

    .line 212
    iget-object v4, v3, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    iget-object v4, v1, Lcom/mrkeyboard/app/MrPacks$Catalog;->packs:Ljava/util/ArrayList;

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_2
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    .line 214
    :cond_4
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
    .line 224
    new-instance v2, Lcom/mrkeyboard/app/MrPacks$Pack;

    invoke-direct {v2}, Lcom/mrkeyboard/app/MrPacks$Pack;-><init>()V

    .line 225
    const-string v0, "id"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    .line 226
    iget-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->validId(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "id"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 227
    :cond_0
    const-string v0, "lang"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->lang:Ljava/lang/String;

    .line 228
    const-string v0, "region"

    const-string v1, ""

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrJson;->optStr(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->region:Ljava/lang/String;

    .line 229
    const-string v0, "name"

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 230
    instance-of v1, v0, Ljava/util/Map;

    if-eqz v1, :cond_2

    check-cast v0, Ljava/util/Map;

    :goto_0
    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->name:Ljava/util/Map;

    .line 231
    const-string v0, "description"

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 232
    instance-of v1, v0, Ljava/util/Map;

    if-eqz v1, :cond_3

    check-cast v0, Ljava/util/Map;

    :goto_1
    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->description:Ljava/util/Map;

    .line 233
    const-string v0, "version"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v0

    long-to-int v0, v0

    iput v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    .line 234
    const-string v0, "format"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v0

    long-to-int v0, v0

    iput v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->format:I

    .line 235
    const-string v0, "minApp"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->minApp:J

    .line 236
    const-string v0, "url"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->url:Ljava/lang/String;

    .line 237
    iget-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->url:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->safeName(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->url:Ljava/lang/String;

    const-string v1, ".zip"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "url"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 230
    :cond_2
    const/4 v0, 0x0

    goto :goto_0

    .line 232
    :cond_3
    const/4 v0, 0x0

    goto :goto_1

    .line 238
    :cond_4
    const-string v0, "size"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    .line 239
    const-string v0, "installedSize"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v0

    iput-wide v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->installedSize:J

    .line 240
    iget v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->version:I

    const/4 v1, 0x1

    if-lt v0, v1, :cond_5

    iget-wide v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    const-wide/16 v4, 0x0

    cmp-long v0, v0, v4

    if-lez v0, :cond_5

    iget-wide v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->size:J

    const-wide/32 v4, 0x4000000

    cmp-long v0, v0, v4

    if-gtz v0, :cond_5

    iget-wide v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->installedSize:J

    const-wide/16 v4, 0x0

    cmp-long v0, v0, v4

    if-lez v0, :cond_5

    iget-wide v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->installedSize:J

    const-wide/32 v4, 0x4000000

    cmp-long v0, v0, v4

    if-lez v0, :cond_6

    .line 241
    :cond_5
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "tamanho"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 243
    :cond_6
    const-string v0, "sha256"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPacks;->hexField(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->sha256:Ljava/lang/String;

    .line 244
    const-string v0, "manifestSha256"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPacks;->hexField(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->manifestSha:Ljava/lang/String;

    .line 245
    const-string v0, "files"

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrJson;->list(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v3

    .line 246
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v4

    .line 247
    if-eqz v4, :cond_7

    const/16 v0, 0x20

    if-le v4, v0, :cond_8

    :cond_7
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "files"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 248
    :cond_8
    new-array v0, v4, [Ljava/lang/String;

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->fileNames:[Ljava/lang/String;

    .line 249
    new-array v0, v4, [J

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSizes:[J

    .line 250
    new-array v0, v4, [Ljava/lang/String;

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSha:[Ljava/lang/String;

    .line 251
    const/4 v1, 0x0

    .line 252
    new-instance v5, Ljava/util/HashSet;

    invoke-direct {v5}, Ljava/util/HashSet;-><init>()V

    .line 253
    const/4 v0, 0x0

    move v12, v0

    move v0, v1

    move v1, v12

    :goto_2
    if-ge v1, v4, :cond_e

    .line 254
    invoke-interface {v3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    invoke-static {v6}, Lcom/mrkeyboard/app/MrJson;->obj(Ljava/lang/Object;)Ljava/util/Map;

    move-result-object v6

    .line 255
    const-string v7, "name"

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrJson;->str(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 256
    invoke-static {v7}, Lcom/mrkeyboard/app/MrPacks;->safeName(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_9

    const-string v8, "pack.json"

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_9

    invoke-virtual {v5, v7}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_a

    :cond_9
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "nome"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 257
    :cond_a
    iget-object v8, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->fileNames:[Ljava/lang/String;

    aput-object v7, v8, v1

    .line 258
    iget-object v8, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSizes:[J

    const-string v9, "size"

    invoke-static {v6, v9}, Lcom/mrkeyboard/app/MrJson;->num(Ljava/util/Map;Ljava/lang/String;)J

    move-result-wide v10

    aput-wide v10, v8, v1

    .line 259
    iget-object v8, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSizes:[J

    aget-wide v8, v8, v1

    const-wide/16 v10, 0x0

    cmp-long v8, v8, v10

    if-lez v8, :cond_b

    iget-object v8, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSizes:[J

    aget-wide v8, v8, v1

    const-wide/32 v10, 0x4000000

    cmp-long v8, v8, v10

    if-lez v8, :cond_c

    :cond_b
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "tamanho"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 260
    :cond_c
    iget-object v8, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->fileSha:[Ljava/lang/String;

    const-string v9, "sha256"

    invoke-static {v6, v9}, Lcom/mrkeyboard/app/MrPacks;->hexField(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v8, v1

    .line 261
    const-string v6, "main.dict"

    invoke-virtual {v7, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_d

    const/4 v0, 0x1

    .line 253
    :cond_d
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 263
    :cond_e
    if-nez v0, :cond_f

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "sem main.dict"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 264
    :cond_f
    const-string v0, "licenses"

    invoke-interface {p0, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 265
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 266
    instance-of v3, v0, Ljava/util/List;

    if-eqz v3, :cond_12

    .line 267
    check-cast v0, Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_10
    :goto_3
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_12

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    .line 268
    instance-of v4, v0, Ljava/lang/String;

    if-eqz v4, :cond_10

    .line 269
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->length()I

    move-result v4

    if-lez v4, :cond_11

    const-string v4, ", "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 270
    :cond_11
    check-cast v0, Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_3

    .line 274
    :cond_12
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->licenses:Ljava/lang/String;

    .line 275
    const-string v0, "credits"

    const-string v1, ""

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrJson;->optStr(Ljava/util/Map;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Pack;->credits:Ljava/lang/String;

    .line 276
    return-object v2
.end method

.method static remove(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 683
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

    .line 684
    new-instance v0, Ljava/io/File;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->root(Landroid/content/Context;)Ljava/io/File;

    move-result-object v1

    invoke-direct {v0, v1, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->deleteTree(Ljava/io/File;)V

    .line 685
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->signal(Landroid/content/Context;)V

    .line 686
    return-void
.end method

.method static root(Landroid/content/Context;)Ljava/io/File;
    .locals 3

    .prologue
    .line 458
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

    .line 315
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v3, 0x40

    if-le v0, v3, :cond_1

    .line 324
    :cond_0
    :goto_0
    return v1

    .line 316
    :cond_1
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 317
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

    .line 318
    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v0, v3, :cond_a

    .line 319
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 320
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

    .line 322
    :goto_2
    if-eqz v3, :cond_0

    .line 318
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_9
    move v3, v1

    .line 320
    goto :goto_2

    .line 324
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
    .line 690
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "mr_dicts_updated_at"

    .line 691
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 692
    return-void
.end method

.method static sizeText(J)Ljava/lang/String;
    .locals 6

    .prologue
    const-wide v0, 0x3fb999999999999aL    # 0.1

    .line 916
    long-to-double v2, p0

    const-wide v4, 0x412e848000000000L    # 1000000.0

    div-double/2addr v2, v4

    .line 917
    cmpg-double v4, v2, v0

    if-gez v4, :cond_0

    .line 918
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

    .line 698
    if-nez p0, :cond_0

    new-array v0, v6, [Ljava/lang/String;

    const-string v1, ""

    aput-object v1, v0, v4

    const-string v1, ""

    aput-object v1, v0, v5

    .line 707
    :goto_0
    return-object v0

    .line 699
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    .line 700
    invoke-virtual {v1, v8}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    .line 701
    if-gez v0, :cond_5

    invoke-virtual {v1, v7}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    move v2, v0

    .line 702
    :goto_1
    if-gez v2, :cond_3

    move-object v0, v1

    :goto_2
    sget-object v3, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v3

    .line 703
    if-gez v2, :cond_4

    const-string v0, ""

    .line 704
    :goto_3
    invoke-virtual {v0, v8}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    .line 705
    if-gez v1, :cond_1

    invoke-virtual {v0, v7}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    .line 706
    :cond_1
    if-ltz v1, :cond_2

    invoke-virtual {v0, v4, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 707
    :cond_2
    new-array v1, v6, [Ljava/lang/String;

    aput-object v3, v1, v4

    aput-object v0, v1, v5

    move-object v0, v1

    goto :goto_0

    .line 702
    :cond_3
    invoke-virtual {v1, v4, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    .line 703
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

.method static varargs text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 859
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v1

    .line 860
    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const-string v3, "string"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, p1, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 861
    if-nez v2, :cond_0

    .line 864
    :goto_0
    return-object v0

    .line 862
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

    .line 863
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static validId(Ljava/lang/String;)Z
    .locals 5

    .prologue
    const/16 v4, 0x5a

    const/4 v0, 0x0

    .line 291
    if-nez p0, :cond_1

    .line 301
    :cond_0
    :goto_0
    return v0

    .line 292
    :cond_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    .line 293
    const/4 v2, 0x2

    if-eq v1, v2, :cond_2

    const/4 v2, 0x3

    if-ne v1, v2, :cond_3

    :cond_2
    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->lowerLetters(Ljava/lang/String;II)Z

    move-result v0

    goto :goto_0

    .line 294
    :cond_3
    const/4 v2, 0x5

    if-eq v1, v2, :cond_4

    const/4 v2, 0x6

    if-ne v1, v2, :cond_0

    .line 295
    :cond_4
    add-int/lit8 v1, v1, -0x3

    .line 296
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const/16 v3, 0x2d

    if-ne v2, v3, :cond_0

    .line 297
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

    .line 298
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v2

    if-eqz v2, :cond_0

    add-int/lit8 v2, v1, 0x1

    .line 299
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

.method static wifiOnly(Landroid/content/Context;)Z
    .locals 3

    .prologue
    .line 402
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "wifi_only"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method
