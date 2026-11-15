.class final Lcom/mrkeyboard/app/MrLive$Result;
.super Ljava/lang/Object;
.source "MrLive.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrLive;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Result"
.end annotation


# instance fields
.field kind:I

.field path:Ljava/lang/String;


# direct methods
.method constructor <init>()V
    .locals 1

    .prologue
    .line 166
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 168
    const-string v0, ""

    iput-object v0, p0, Lcom/mrkeyboard/app/MrLive$Result;->path:Ljava/lang/String;

    return-void
.end method
