.class final Lcom/mrkeyboard/app/MrPacks$PackException;
.super Ljava/lang/Exception;
.source "MrPacks.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrPacks;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "PackException"
.end annotation


# instance fields
.field final args:[Ljava/lang/Object;

.field final key:Ljava/lang/String;


# direct methods
.method varargs constructor <init>(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 95
    invoke-direct {p0, p1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    .line 96
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacks$PackException;->key:Ljava/lang/String;

    .line 97
    iput-object p2, p0, Lcom/mrkeyboard/app/MrPacks$PackException;->args:[Ljava/lang/Object;

    .line 98
    return-void
.end method
