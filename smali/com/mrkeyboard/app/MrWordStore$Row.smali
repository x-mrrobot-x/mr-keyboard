.class public final Lcom/mrkeyboard/app/MrWordStore$Row;
.super Ljava/lang/Object;
.source "MrWordStore.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrWordStore;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Row"
.end annotation


# instance fields
.field a:Ljava/lang/String;

.field added:J

.field b:Ljava/lang/String;

.field batch:J

.field freq:I

.field id:J

.field kind:I


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method constructor <init>(ILjava/lang/String;Ljava/lang/String;IJJ)V
    .locals 1

    .prologue
    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 41
    iput p1, p0, Lcom/mrkeyboard/app/MrWordStore$Row;->kind:I

    .line 42
    iput-object p2, p0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    .line 43
    iput-object p3, p0, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    .line 44
    iput p4, p0, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    .line 45
    iput-wide p5, p0, Lcom/mrkeyboard/app/MrWordStore$Row;->batch:J

    .line 46
    iput-wide p7, p0, Lcom/mrkeyboard/app/MrWordStore$Row;->added:J

    .line 47
    return-void
.end method


# virtual methods
.method text()Ljava/lang/String;
    .locals 2

    .prologue
    .line 51
    iget-object v0, p0, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method
