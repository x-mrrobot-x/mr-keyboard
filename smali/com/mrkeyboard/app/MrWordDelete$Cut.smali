.class final Lcom/mrkeyboard/app/MrWordDelete$Cut;
.super Ljava/lang/Object;
.source "MrWordDelete.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrWordDelete;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Cut"
.end annotation


# instance fields
.field final after:Ljava/lang/String;

.field final at:J

.field final before:Ljava/lang/String;

.field final text:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V
    .locals 0

    .prologue
    .line 91
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 92
    iput-object p1, p0, Lcom/mrkeyboard/app/MrWordDelete$Cut;->text:Ljava/lang/String;

    .line 93
    iput-object p2, p0, Lcom/mrkeyboard/app/MrWordDelete$Cut;->before:Ljava/lang/String;

    .line 94
    iput-object p3, p0, Lcom/mrkeyboard/app/MrWordDelete$Cut;->after:Ljava/lang/String;

    .line 95
    iput-wide p4, p0, Lcom/mrkeyboard/app/MrWordDelete$Cut;->at:J

    .line 96
    return-void
.end method


# virtual methods
.method matches(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z
    .locals 1

    .prologue
    .line 99
    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrWordDelete$Cut;->before:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->contentEquals(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrWordDelete$Cut;->after:Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->contentEquals(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
