.class public Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;
.super Ljava/lang/Object;
.source "LatinIMEUtil.java"


# static fields
.field private static final GC_INTERVAL:J = 0x3e8L

.field public static final GC_TRY_COUNT:I = 0x2

.field public static final GC_TRY_LOOP_MAX:I = 0x5

.field private static final TAG:Ljava/lang/String; = "GCUtils"

.field private static sInstance:Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;


# instance fields
.field private mGCTryCount:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 48
    new-instance v0, Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;

    invoke-direct {v0}, Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;->sInstance:Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 49
    iput v0, p0, Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;->mGCTryCount:I

    return-void
.end method

.method public static getInstance()Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;
    .locals 1

    .line 52
    sget-object v0, Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;->sInstance:Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;

    return-object v0
.end method


# virtual methods
.method public reset()V
    .locals 1

    const/4 v0, 0x0

    .line 56
    iput v0, p0, Lcom/mrkeyboard/app/LatinIMEUtil$GCUtils;->mGCTryCount:I

    return-void
.end method

.method public tryGCOrWait(Ljava/lang/String;Ljava/lang/Throwable;)Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method
