.class final Lcom/mrkeyboard/app/MrBackdrop$Look;
.super Ljava/lang/Object;
.source "MrBackdrop.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrBackdrop;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Look"
.end annotation


# instance fields
.field final accent:I

.field final barLuminance:F

.field final bottom:I

.field final luminance:F

.field final veilAlpha:I

.field final veilColor:I


# direct methods
.method constructor <init>(FFIII)V
    .locals 7

    .prologue
    .line 405
    const/4 v6, 0x0

    move-object v0, p0

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrBackdrop$Look;-><init>(FFIIII)V

    .line 406
    return-void
.end method

.method constructor <init>(FFIIII)V
    .locals 0

    .prologue
    .line 408
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 409
    iput p1, p0, Lcom/mrkeyboard/app/MrBackdrop$Look;->luminance:F

    .line 410
    iput p2, p0, Lcom/mrkeyboard/app/MrBackdrop$Look;->barLuminance:F

    .line 411
    iput p3, p0, Lcom/mrkeyboard/app/MrBackdrop$Look;->veilAlpha:I

    .line 412
    iput p4, p0, Lcom/mrkeyboard/app/MrBackdrop$Look;->veilColor:I

    .line 413
    iput p5, p0, Lcom/mrkeyboard/app/MrBackdrop$Look;->bottom:I

    .line 414
    iput p6, p0, Lcom/mrkeyboard/app/MrBackdrop$Look;->accent:I

    .line 415
    return-void
.end method
