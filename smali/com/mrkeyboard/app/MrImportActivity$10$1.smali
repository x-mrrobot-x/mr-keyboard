.class Lcom/mrkeyboard/app/MrImportActivity$10$1;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrImport$Known;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity$10;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrImportActivity$10;

.field final synthetic val$dict:Lcom/mrkeyboard/app/BinaryDictionary;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity$10;Lcom/mrkeyboard/app/BinaryDictionary;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 391
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$10$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$10;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity$10$1;->val$dict:Lcom/mrkeyboard/app/BinaryDictionary;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public knows(Ljava/lang/String;)Z
    .locals 1

    .prologue
    .line 393
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$10$1;->val$dict:Lcom/mrkeyboard/app/BinaryDictionary;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$10$1;->val$dict:Lcom/mrkeyboard/app/BinaryDictionary;

    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/BinaryDictionary;->isValidWord(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
