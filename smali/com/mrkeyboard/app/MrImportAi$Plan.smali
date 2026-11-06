.class final Lcom/mrkeyboard/app/MrImportAi$Plan;
.super Ljava/lang/Object;
.source "MrImportAi.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrImportAi;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Plan"
.end annotation


# instance fields
.field final chars:I

.field final originalChars:I

.field final parts:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final truncated:Z


# direct methods
.method constructor <init>(Ljava/util/List;IZI)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;IZI)V"
        }
    .end annotation

    .prologue
    .line 115
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 116
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportAi$Plan;->parts:Ljava/util/List;

    .line 117
    iput p2, p0, Lcom/mrkeyboard/app/MrImportAi$Plan;->chars:I

    .line 118
    iput-boolean p3, p0, Lcom/mrkeyboard/app/MrImportAi$Plan;->truncated:Z

    .line 119
    iput p4, p0, Lcom/mrkeyboard/app/MrImportAi$Plan;->originalChars:I

    .line 120
    return-void
.end method


# virtual methods
.method requests()I
    .locals 1

    .prologue
    .line 123
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportAi$Plan;->parts:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method
