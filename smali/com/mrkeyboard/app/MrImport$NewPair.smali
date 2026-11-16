.class final Lcom/mrkeyboard/app/MrImport$NewPair;
.super Ljava/lang/Object;
.source "MrImport.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrImport;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "NewPair"
.end annotation


# instance fields
.field final a:Ljava/lang/String;

.field final b:Ljava/lang/String;

.field count:I

.field weight:I


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;II)V
    .locals 0

    .prologue
    .line 76
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 77
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImport$NewPair;->a:Ljava/lang/String;

    .line 78
    iput-object p2, p0, Lcom/mrkeyboard/app/MrImport$NewPair;->b:Ljava/lang/String;

    .line 79
    iput p3, p0, Lcom/mrkeyboard/app/MrImport$NewPair;->weight:I

    .line 80
    iput p4, p0, Lcom/mrkeyboard/app/MrImport$NewPair;->count:I

    .line 81
    return-void
.end method
