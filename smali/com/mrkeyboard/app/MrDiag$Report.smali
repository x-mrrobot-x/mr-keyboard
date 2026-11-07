.class final Lcom/mrkeyboard/app/MrDiag$Report;
.super Ljava/lang/Object;
.source "MrDiag.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrDiag;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Report"
.end annotation


# instance fields
.field dictBytes:J

.field dictMem:J

.field dictNs:J

.field engineNs:J

.field hasTri:Z

.field id:Ljava/lang/String;

.field rulesNs:J

.field triBytes:J

.field triFormat:I

.field triMem:J

.field triNs:J

.field version:I


# direct methods
.method constructor <init>()V
    .locals 4

    .prologue
    const-wide/16 v2, -0x1

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    const-string v0, ""

    iput-object v0, p0, Lcom/mrkeyboard/app/MrDiag$Report;->id:Ljava/lang/String;

    .line 38
    iput-wide v2, p0, Lcom/mrkeyboard/app/MrDiag$Report;->dictBytes:J

    iput-wide v2, p0, Lcom/mrkeyboard/app/MrDiag$Report;->dictMem:J

    iput-wide v2, p0, Lcom/mrkeyboard/app/MrDiag$Report;->dictNs:J

    .line 39
    iput-wide v2, p0, Lcom/mrkeyboard/app/MrDiag$Report;->triBytes:J

    iput-wide v2, p0, Lcom/mrkeyboard/app/MrDiag$Report;->triMem:J

    iput-wide v2, p0, Lcom/mrkeyboard/app/MrDiag$Report;->triNs:J

    .line 41
    iput-wide v2, p0, Lcom/mrkeyboard/app/MrDiag$Report;->engineNs:J

    iput-wide v2, p0, Lcom/mrkeyboard/app/MrDiag$Report;->rulesNs:J

    return-void
.end method
