.class final Lcom/mrkeyboard/app/MrBackdrop$Grad;
.super Ljava/lang/Object;
.source "MrBackdrop.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrBackdrop;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Grad"
.end annotation


# instance fields
.field final angle:I

.field final colours:[I

.field final glow:[I

.field final stops:[F


# direct methods
.method constructor <init>(I[I[F[I)V
    .locals 0

    .prologue
    .line 102
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 103
    iput p1, p0, Lcom/mrkeyboard/app/MrBackdrop$Grad;->angle:I

    .line 104
    iput-object p2, p0, Lcom/mrkeyboard/app/MrBackdrop$Grad;->colours:[I

    .line 105
    iput-object p3, p0, Lcom/mrkeyboard/app/MrBackdrop$Grad;->stops:[F

    .line 106
    iput-object p4, p0, Lcom/mrkeyboard/app/MrBackdrop$Grad;->glow:[I

    .line 107
    return-void
.end method
