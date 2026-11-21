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
.field final barLuminance:F

.field final bottom:I

.field final luminance:F

.field final veilAlpha:I

.field final veilColor:I


# direct methods
.method constructor <init>(FFIII)V
    .locals 0

    .prologue
    .line 402
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 403
    iput p1, p0, Lcom/mrkeyboard/app/MrBackdrop$Look;->luminance:F

    .line 404
    iput p2, p0, Lcom/mrkeyboard/app/MrBackdrop$Look;->barLuminance:F

    .line 405
    iput p3, p0, Lcom/mrkeyboard/app/MrBackdrop$Look;->veilAlpha:I

    .line 406
    iput p4, p0, Lcom/mrkeyboard/app/MrBackdrop$Look;->veilColor:I

    .line 407
    iput p5, p0, Lcom/mrkeyboard/app/MrBackdrop$Look;->bottom:I

    .line 408
    return-void
.end method
