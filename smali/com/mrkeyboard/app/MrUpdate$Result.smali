.class final Lcom/mrkeyboard/app/MrUpdate$Result;
.super Ljava/lang/Object;
.source "MrUpdate.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrUpdate;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Result"
.end annotation


# instance fields
.field error:I

.field fromCache:Z

.field httpCode:I

.field notice:Lcom/mrkeyboard/app/MrUpdate$Notice;

.field status:I


# direct methods
.method constructor <init>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 86
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 87
    iput v0, p0, Lcom/mrkeyboard/app/MrUpdate$Result;->status:I

    .line 89
    iput v0, p0, Lcom/mrkeyboard/app/MrUpdate$Result;->error:I

    return-void
.end method
