.class Lcom/mrkeyboard/app/MrTrigram$1;
.super Ljava/lang/Object;
.source "MrTrigram.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrTrigram;->use(Ljava/io/File;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$gen:I

.field final synthetic val$path:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 39
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTrigram$1;->val$path:Ljava/lang/String;

    iput p2, p0, Lcom/mrkeyboard/app/MrTrigram$1;->val$gen:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 41
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTrigram$1;->val$path:Ljava/lang/String;

    iget v1, p0, Lcom/mrkeyboard/app/MrTrigram$1;->val$gen:I

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTrigram;->access$000(Ljava/lang/String;I)Z

    .line 42
    return-void
.end method
