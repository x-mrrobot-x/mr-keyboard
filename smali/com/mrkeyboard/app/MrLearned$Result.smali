.class final Lcom/mrkeyboard/app/MrLearned$Result;
.super Ljava/lang/Object;
.source "MrLearned.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrLearned;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Result"
.end annotation


# instance fields
.field batch:J

.field blocked:I

.field blockedSkipped:I

.field cappedPairs:I

.field cappedWords:I

.field dupPairs:I

.field dupWords:I

.field pairs:I

.field words:I


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 202
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method total()I
    .locals 2

    .prologue
    .line 217
    iget v0, p0, Lcom/mrkeyboard/app/MrLearned$Result;->words:I

    iget v1, p0, Lcom/mrkeyboard/app/MrLearned$Result;->pairs:I

    add-int/2addr v0, v1

    iget v1, p0, Lcom/mrkeyboard/app/MrLearned$Result;->blocked:I

    add-int/2addr v0, v1

    return v0
.end method
