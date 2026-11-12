.class Lcom/mrkeyboard/app/MrEmojiSearch$7$1;
.super Ljava/lang/Object;
.source "MrEmojiSearch.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrEmojiSearch$7;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrEmojiSearch$7;

.field final synthetic val$built:Lcom/mrkeyboard/app/MrEmojiIndex;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrEmojiSearch$7;Lcom/mrkeyboard/app/MrEmojiIndex;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 338
    iput-object p1, p0, Lcom/mrkeyboard/app/MrEmojiSearch$7$1;->this$0:Lcom/mrkeyboard/app/MrEmojiSearch$7;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrEmojiSearch$7$1;->val$built:Lcom/mrkeyboard/app/MrEmojiIndex;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 340
    iget-object v0, p0, Lcom/mrkeyboard/app/MrEmojiSearch$7$1;->val$built:Lcom/mrkeyboard/app/MrEmojiIndex;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrEmojiSearch;->loaded(Lcom/mrkeyboard/app/MrEmojiIndex;)V

    .line 341
    return-void
.end method
