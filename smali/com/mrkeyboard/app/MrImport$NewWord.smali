.class final Lcom/mrkeyboard/app/MrImport$NewWord;
.super Ljava/lang/Object;
.source "MrImport.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrImport;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "NewWord"
.end annotation


# instance fields
.field checked:Z

.field count:I

.field weight:I

.field final word:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;II)V
    .locals 1

    .prologue
    .line 68
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 66
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrImport$NewWord;->checked:Z

    .line 69
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImport$NewWord;->word:Ljava/lang/String;

    .line 70
    iput p2, p0, Lcom/mrkeyboard/app/MrImport$NewWord;->weight:I

    .line 71
    iput p3, p0, Lcom/mrkeyboard/app/MrImport$NewWord;->count:I

    .line 72
    return-void
.end method
