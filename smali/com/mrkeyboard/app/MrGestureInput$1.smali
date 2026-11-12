.class Lcom/mrkeyboard/app/MrGestureInput$1;
.super Ljava/lang/Object;
.source "MrGestureInput.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrGestureInput$Engine;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrGestureInput;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 121
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private buffer(Lcom/mrkeyboard/app/LatinIME;)Ljava/nio/ByteBuffer;
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 148
    invoke-virtual {p1}, Lcom/mrkeyboard/app/LatinIME;->mrSuggest()Lcom/mrkeyboard/app/Suggest;

    move-result-object v1

    .line 149
    if-eqz v1, :cond_1

    invoke-virtual {v1}, Lcom/mrkeyboard/app/Suggest;->mrMainDict()Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v1

    .line 150
    :goto_0
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrBuffer()Ljava/nio/ByteBuffer;

    move-result-object v0

    :cond_0
    return-object v0

    :cond_1
    move-object v1, v0

    .line 149
    goto :goto_0
.end method


# virtual methods
.method public decode(Lcom/mrkeyboard/app/LatinIME;[F[F[IILjava/lang/String;Lcom/mrkeyboard/app/MrGesture$Result;)I
    .locals 9

    .prologue
    .line 139
    invoke-virtual {p1}, Lcom/mrkeyboard/app/LatinIME;->mrSuggest()Lcom/mrkeyboard/app/Suggest;

    move-result-object v0

    .line 140
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/mrkeyboard/app/Suggest;->mrMainDict()Lcom/mrkeyboard/app/BinaryDictionary;

    move-result-object v0

    move-object v1, v0

    .line 141
    :goto_0
    if-eqz v1, :cond_1

    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrBuffer()Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 142
    :goto_1
    if-nez v0, :cond_2

    const/4 v0, -0x1

    .line 144
    :goto_2
    return v0

    .line 140
    :cond_0
    const/4 v0, 0x0

    move-object v1, v0

    goto :goto_0

    .line 141
    :cond_1
    const/4 v0, 0x0

    goto :goto_1

    .line 144
    :cond_2
    invoke-virtual {v1}, Lcom/mrkeyboard/app/BinaryDictionary;->mrLength()I

    move-result v1

    invoke-static {p1}, Lcom/mrkeyboard/app/MrGestureWords;->get(Lcom/mrkeyboard/app/LatinIME;)Ljava/nio/ByteBuffer;

    move-result-object v2

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move v6, p5

    move-object v7, p6

    move-object/from16 v8, p7

    invoke-static/range {v0 .. v8}, Lcom/mrkeyboard/app/MrGesture;->decode(Ljava/nio/ByteBuffer;ILjava/nio/ByteBuffer;[F[F[IILjava/lang/CharSequence;Lcom/mrkeyboard/app/MrGesture$Result;)I

    move-result v0

    goto :goto_2
.end method

.method public hasDictionary(Lcom/mrkeyboard/app/LatinIME;)Z
    .locals 1

    .prologue
    .line 131
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrGestureInput$1;->buffer(Lcom/mrkeyboard/app/LatinIME;)Ljava/nio/ByteBuffer;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public layout([C[F)Z
    .locals 1

    .prologue
    .line 127
    invoke-static {p1, p2}, Lcom/mrkeyboard/app/MrGesture;->setLayout([C[F)Z

    move-result v0

    return v0
.end method

.method public prepare(Lcom/mrkeyboard/app/LatinIME;)V
    .locals 0

    .prologue
    .line 135
    invoke-static {p1}, Lcom/mrkeyboard/app/MrGestureWords;->get(Lcom/mrkeyboard/app/LatinIME;)Ljava/nio/ByteBuffer;

    .line 136
    return-void
.end method

.method public ready()Z
    .locals 1

    .prologue
    .line 123
    invoke-static {}, Lcom/mrkeyboard/app/MrGesture;->ready()Z

    move-result v0

    return v0
.end method
