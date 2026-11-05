.class final Lcom/mrkeyboard/app/MrUpdateInstall$Failure;
.super Ljava/lang/Exception;
.source "MrUpdateInstall.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrUpdateInstall;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Failure"
.end annotation


# instance fields
.field final arg:I

.field final key:Ljava/lang/String;

.field final reasonKey:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;I)V
    .locals 0

    .prologue
    .line 90
    invoke-direct {p0, p1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    .line 91
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;->key:Ljava/lang/String;

    .line 92
    iput-object p2, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;->reasonKey:Ljava/lang/String;

    .line 93
    iput p3, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;->arg:I

    .line 94
    return-void
.end method

.method static cancelled()Lcom/mrkeyboard/app/MrUpdateInstall$Failure;
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 97
    new-instance v0, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    const/4 v1, 0x0

    invoke-direct {v0, v2, v2, v1}, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    return-object v0
.end method


# virtual methods
.method isCancel()Z
    .locals 1

    .prologue
    .line 101
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateInstall$Failure;->key:Ljava/lang/String;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
