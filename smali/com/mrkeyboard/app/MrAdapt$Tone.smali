.class final Lcom/mrkeyboard/app/MrAdapt$Tone;
.super Ljava/lang/Object;
.source "MrAdapt.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrAdapt;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Tone"
.end annotation


# static fields
.field static final OFF:Lcom/mrkeyboard/app/MrAdapt$Tone;


# instance fields
.field final hue:F

.field final on:Z

.field final pale:Z

.field final sat:F


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 56
    new-instance v0, Lcom/mrkeyboard/app/MrAdapt$Tone;

    invoke-direct {v0, v1, v1, v2, v2}, Lcom/mrkeyboard/app/MrAdapt$Tone;-><init>(FFZZ)V

    sput-object v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->OFF:Lcom/mrkeyboard/app/MrAdapt$Tone;

    return-void
.end method

.method constructor <init>(FFZZ)V
    .locals 0

    .prologue
    .line 60
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 61
    iput p1, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->hue:F

    .line 62
    iput p2, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->sat:F

    .line 63
    iput-boolean p3, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->pale:Z

    .line 64
    iput-boolean p4, p0, Lcom/mrkeyboard/app/MrAdapt$Tone;->on:Z

    .line 65
    return-void
.end method
