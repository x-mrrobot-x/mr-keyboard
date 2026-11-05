.class final Lcom/mrkeyboard/app/MrPacks$Pack;
.super Ljava/lang/Object;
.source "MrPacks.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrPacks;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Pack"
.end annotation


# instance fields
.field credits:Ljava/lang/String;

.field description:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field fileNames:[Ljava/lang/String;

.field fileSha:[Ljava/lang/String;

.field fileSizes:[J

.field format:I

.field id:Ljava/lang/String;

.field installedSize:J

.field lang:Ljava/lang/String;

.field licenses:Ljava/lang/String;

.field manifestSha:Ljava/lang/String;

.field minApp:J

.field name:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field region:Ljava/lang/String;

.field release:Ljava/lang/String;

.field sha256:Ljava/lang/String;

.field size:J

.field url:Ljava/lang/String;

.field version:I


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 94
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method description(Ljava/util/Locale;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 108
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacks$Pack;->description:Ljava/util/Map;

    const-string v1, ""

    invoke-static {v0, p1, v1}, Lcom/mrkeyboard/app/MrPacks;->localized(Ljava/util/Map;Ljava/util/Locale;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method name(Ljava/util/Locale;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 104
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacks$Pack;->name:Ljava/util/Map;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-static {v0, p1, v1}, Lcom/mrkeyboard/app/MrPacks;->localized(Ljava/util/Map;Ljava/util/Locale;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
