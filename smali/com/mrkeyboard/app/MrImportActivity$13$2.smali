.class Lcom/mrkeyboard/app/MrImportActivity$13$2;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity$13;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator",
        "<",
        "Lcom/mrkeyboard/app/MrImport$NewWord;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrImportActivity$13;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity$13;)V
    .locals 0

    .prologue
    .line 436
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$13$2;->this$1:Lcom/mrkeyboard/app/MrImportActivity$13;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public compare(Lcom/mrkeyboard/app/MrImport$NewWord;Lcom/mrkeyboard/app/MrImport$NewWord;)I
    .locals 2

    .prologue
    .line 438
    iget v0, p2, Lcom/mrkeyboard/app/MrImport$NewWord;->count:I

    iget v1, p1, Lcom/mrkeyboard/app/MrImport$NewWord;->count:I

    if-eq v0, v1, :cond_1

    iget v0, p2, Lcom/mrkeyboard/app/MrImport$NewWord;->count:I

    iget v1, p1, Lcom/mrkeyboard/app/MrImport$NewWord;->count:I

    if-le v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0

    :cond_1
    iget-object v0, p1, Lcom/mrkeyboard/app/MrImport$NewWord;->word:Ljava/lang/String;

    iget-object v1, p2, Lcom/mrkeyboard/app/MrImport$NewWord;->word:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v0

    goto :goto_0
.end method

.method public bridge synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 1

    .prologue
    .line 436
    check-cast p1, Lcom/mrkeyboard/app/MrImport$NewWord;

    check-cast p2, Lcom/mrkeyboard/app/MrImport$NewWord;

    invoke-virtual {p0, p1, p2}, Lcom/mrkeyboard/app/MrImportActivity$13$2;->compare(Lcom/mrkeyboard/app/MrImport$NewWord;Lcom/mrkeyboard/app/MrImport$NewWord;)I

    move-result v0

    return v0
.end method
