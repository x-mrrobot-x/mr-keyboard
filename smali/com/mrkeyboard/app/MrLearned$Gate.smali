.class final Lcom/mrkeyboard/app/MrLearned$Gate;
.super Ljava/lang/Object;
.source "MrLearned.java"

# interfaces
.implements Lcom/mrkeyboard/app/Dictionary$WordCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrLearned;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Gate"
.end annotation


# instance fields
.field to:Lcom/mrkeyboard/app/Dictionary$WordCallback;


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 155
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/mrkeyboard/app/MrLearned$1;)V
    .locals 0

    .prologue
    .line 155
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrLearned$Gate;-><init>()V

    return-void
.end method


# virtual methods
.method public addWord([CIIIILcom/mrkeyboard/app/Dictionary$DataType;)Z
    .locals 7

    .prologue
    .line 159
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearned$Gate;->to:Lcom/mrkeyboard/app/Dictionary$WordCallback;

    .line 160
    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 162
    :goto_0
    return v0

    .line 161
    :cond_0
    const/4 v1, 0x6

    if-ge p4, v1, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    move-object v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move-object v6, p6

    .line 162
    invoke-interface/range {v0 .. v6}, Lcom/mrkeyboard/app/Dictionary$WordCallback;->addWord([CIIIILcom/mrkeyboard/app/Dictionary$DataType;)Z

    move-result v0

    goto :goto_0
.end method
