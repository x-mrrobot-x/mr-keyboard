.class final Lcom/mrkeyboard/app/MrImport$Ignored;
.super Ljava/lang/Object;
.source "MrImport.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrImport;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Ignored"
.end annotation


# instance fields
.field final line:I

.field final reason:I

.field final text:Ljava/lang/String;


# direct methods
.method constructor <init>(ILjava/lang/String;I)V
    .locals 0

    .prologue
    .line 94
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 95
    iput p1, p0, Lcom/mrkeyboard/app/MrImport$Ignored;->line:I

    .line 96
    iput-object p2, p0, Lcom/mrkeyboard/app/MrImport$Ignored;->text:Ljava/lang/String;

    .line 97
    iput p3, p0, Lcom/mrkeyboard/app/MrImport$Ignored;->reason:I

    .line 98
    return-void
.end method
