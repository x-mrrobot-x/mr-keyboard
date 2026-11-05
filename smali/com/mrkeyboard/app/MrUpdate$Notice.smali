.class final Lcom/mrkeyboard/app/MrUpdate$Notice;
.super Ljava/lang/Object;
.source "MrUpdate.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrUpdate;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Notice"
.end annotation


# instance fields
.field apkName:Ljava/lang/String;

.field apkSha256:Ljava/lang/String;

.field apkSize:J

.field data:Ljava/lang/String;

.field generated:Ljava/lang/String;

.field notesEn:Ljava/lang/String;

.field notesPt:Ljava/lang/String;

.field versionCode:J

.field versionName:Ljava/lang/String;


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 73
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method apkUrl()Ljava/lang/String;
    .locals 2

    .prologue
    .line 85
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "https://github.com/x-mrrobot-x/mr-keyboard/releases/download/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdate$Notice;->apkName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method notes(Ljava/util/Locale;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 79
    if-eqz p1, :cond_0

    const-string v0, "pt"

    invoke-virtual {p1}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdate$Notice;->notesPt:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdate$Notice;->notesPt:Ljava/lang/String;

    .line 80
    :goto_0
    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdate;->plain(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 79
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdate$Notice;->notesEn:Ljava/lang/String;

    goto :goto_0
.end method
