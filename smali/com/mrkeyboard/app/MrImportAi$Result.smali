.class final Lcom/mrkeyboard/app/MrImportAi$Result;
.super Ljava/lang/Object;
.source "MrImportAi.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrImportAi;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Result"
.end annotation


# instance fields
.field cancelled:Z

.field done:I

.field dropped:I

.field failure:Ljava/lang/String;

.field parts:I

.field phrases:I

.field text:Ljava/lang/String;

.field unreadable:I

.field words:I


# direct methods
.method constructor <init>()V
    .locals 1

    .prologue
    .line 323
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 325
    const-string v0, ""

    iput-object v0, p0, Lcom/mrkeyboard/app/MrImportAi$Result;->text:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method complete()Z
    .locals 2

    .prologue
    .line 341
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrImportAi$Result;->cancelled:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportAi$Result;->failure:Ljava/lang/String;

    if-nez v0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrImportAi$Result;->unreadable:I

    if-nez v0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrImportAi$Result;->done:I

    iget v1, p0, Lcom/mrkeyboard/app/MrImportAi$Result;->parts:I

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method empty()Z
    .locals 2

    .prologue
    .line 345
    iget v0, p0, Lcom/mrkeyboard/app/MrImportAi$Result;->words:I

    iget v1, p0, Lcom/mrkeyboard/app/MrImportAi$Result;->phrases:I

    add-int/2addr v0, v1

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
