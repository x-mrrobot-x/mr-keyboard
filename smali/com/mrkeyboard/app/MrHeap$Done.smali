.class final Lcom/mrkeyboard/app/MrHeap$Done;
.super Ljava/lang/Object;
.source "MrHeap.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrHeap;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Done"
.end annotation


# instance fields
.field private final mClick:Lcom/mrkeyboard/app/MrHeap$Click;

.field private final mZip:Ljava/io/File;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrHeap$Click;Ljava/io/File;)V
    .locals 0

    .prologue
    .line 162
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 163
    iput-object p1, p0, Lcom/mrkeyboard/app/MrHeap$Done;->mClick:Lcom/mrkeyboard/app/MrHeap$Click;

    .line 164
    iput-object p2, p0, Lcom/mrkeyboard/app/MrHeap$Done;->mZip:Ljava/io/File;

    .line 165
    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 168
    iget-object v0, p0, Lcom/mrkeyboard/app/MrHeap$Done;->mClick:Lcom/mrkeyboard/app/MrHeap$Click;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrHeap$Done;->mZip:Ljava/io/File;

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrHeap$Click;->done(Ljava/io/File;)V

    .line 169
    return-void
.end method
