.class interface abstract Lcom/mrkeyboard/app/MrGestureInput$Engine;
.super Ljava/lang/Object;
.source "MrGestureInput.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrGestureInput;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x608
    name = "Engine"
.end annotation


# virtual methods
.method public abstract decode(Lcom/mrkeyboard/app/LatinIME;[F[F[IILjava/lang/String;Lcom/mrkeyboard/app/MrGesture$Result;)I
.end method

.method public abstract hasDictionary(Lcom/mrkeyboard/app/LatinIME;)Z
.end method

.method public abstract layout([C[F)Z
.end method

.method public abstract prepare(Lcom/mrkeyboard/app/LatinIME;)V
.end method

.method public abstract ready()Z
.end method
