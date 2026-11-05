.class final Lcom/mrkeyboard/app/MrImport$Tok;
.super Ljava/lang/Object;
.source "MrImport.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrImport;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Tok"
.end annotation


# instance fields
.field final capMiddle:Z

.field final joined:Z

.field final sentenceStart:Z

.field final text:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;ZZZ)V
    .locals 0

    .prologue
    .line 394
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 395
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImport$Tok;->text:Ljava/lang/String;

    .line 396
    iput-boolean p2, p0, Lcom/mrkeyboard/app/MrImport$Tok;->sentenceStart:Z

    .line 397
    iput-boolean p3, p0, Lcom/mrkeyboard/app/MrImport$Tok;->capMiddle:Z

    .line 398
    iput-boolean p4, p0, Lcom/mrkeyboard/app/MrImport$Tok;->joined:Z

    .line 399
    return-void
.end method
