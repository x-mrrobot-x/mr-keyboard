.class final Lcom/mrkeyboard/app/MrPredict$UserCollector;
.super Ljava/lang/Object;
.source "MrPredict.java"

# interfaces
.implements Lcom/mrkeyboard/app/Dictionary$WordCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrPredict;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "UserCollector"
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public addWord([CIIIILcom/mrkeyboard/app/Dictionary$DataType;)Z
    .locals 2

    .prologue
    .line 54
    if-eqz p1, :cond_0

    if-lez p3, :cond_0

    if-lez p4, :cond_0

    .line 55
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p1, p2, p3}, Ljava/lang/String;-><init>([CII)V

    const/4 v1, 0x0

    invoke-static {v0, v1, p4}, Lcom/mrkeyboard/app/MrPredict;->access$000(Ljava/lang/String;II)V

    .line 57
    :cond_0
    const/4 v0, 0x1

    return v0
.end method
