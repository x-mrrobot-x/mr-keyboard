.class final Lcom/mrkeyboard/app/MrScenes$Seq;
.super Ljava/lang/Object;
.source "MrScenes.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrScenes;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Seq"
.end annotation


# instance fields
.field private s:J


# direct methods
.method constructor <init>(J)V
    .locals 1

    .prologue
    .line 67
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-wide p1, p0, Lcom/mrkeyboard/app/MrScenes$Seq;->s:J

    return-void
.end method


# virtual methods
.method next()F
    .locals 4

    .prologue
    .line 70
    iget-wide v0, p0, Lcom/mrkeyboard/app/MrScenes$Seq;->s:J

    const-wide/32 v2, 0x41c64e6d

    mul-long/2addr v0, v2

    const-wide/16 v2, 0x3039

    add-long/2addr v0, v2

    const-wide/32 v2, 0x7fffffff

    and-long/2addr v0, v2

    iput-wide v0, p0, Lcom/mrkeyboard/app/MrScenes$Seq;->s:J

    .line 71
    iget-wide v0, p0, Lcom/mrkeyboard/app/MrScenes$Seq;->s:J

    const/16 v2, 0x8

    shr-long/2addr v0, v2

    const-wide/32 v2, 0xffff

    and-long/2addr v0, v2

    long-to-float v0, v0

    const v1, 0x477fff00    # 65535.0f

    div-float/2addr v0, v1

    return v0
.end method
