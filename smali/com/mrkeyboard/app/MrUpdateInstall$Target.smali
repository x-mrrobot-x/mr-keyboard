.class interface abstract Lcom/mrkeyboard/app/MrUpdateInstall$Target;
.super Ljava/lang/Object;
.source "MrUpdateInstall.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrUpdateInstall;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x608
    name = "Target"
.end annotation


# virtual methods
.method public abstract abandon()V
.end method

.method public abstract close()V
.end method

.method public abstract commit()V
.end method

.method public abstract openWrite()Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method

.method public abstract sync(Ljava/io/OutputStream;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method
