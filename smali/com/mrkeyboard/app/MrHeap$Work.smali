.class final Lcom/mrkeyboard/app/MrHeap$Work;
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
    name = "Work"
.end annotation


# instance fields
.field private final mClick:Lcom/mrkeyboard/app/MrHeap$Click;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrHeap$Click;)V
    .locals 0

    .prologue
    .line 149
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 150
    iput-object p1, p0, Lcom/mrkeyboard/app/MrHeap$Work;->mClick:Lcom/mrkeyboard/app/MrHeap$Click;

    .line 151
    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 154
    iget-object v0, p0, Lcom/mrkeyboard/app/MrHeap$Work;->mClick:Lcom/mrkeyboard/app/MrHeap$Click;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrHeap$Click;->work()V

    .line 155
    return-void
.end method
