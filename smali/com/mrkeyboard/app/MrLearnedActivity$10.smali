.class Lcom/mrkeyboard/app/MrLearnedActivity$10;
.super Lcom/mrkeyboard/app/MrAppPicker$Once;
.source "MrLearnedActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrLearnedActivity;->chooseApp()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

.field final synthetic val$locale:Ljava/lang/String;

.field final synthetic val$store:Lcom/mrkeyboard/app/MrWordStore;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrLearnedActivity;Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 342
    iput-object p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$10;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrLearnedActivity$10;->val$store:Lcom/mrkeyboard/app/MrWordStore;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrLearnedActivity$10;->val$locale:Ljava/lang/String;

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAppPicker$Once;-><init>()V

    return-void
.end method


# virtual methods
.method list()Ljava/util/List;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;"
        }
    .end annotation

    .prologue
    .line 344
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 345
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$10;->val$store:Lcom/mrkeyboard/app/MrWordStore;

    invoke-interface {v0}, Lcom/mrkeyboard/app/MrWordStore;->scopes()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 346
    iget-object v3, p0, Lcom/mrkeyboard/app/MrLearnedActivity$10;->val$locale:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrApp;->localeOf(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 347
    invoke-static {v0}, Lcom/mrkeyboard/app/MrApp;->packageOf(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 348
    iget-object v4, p0, Lcom/mrkeyboard/app/MrLearnedActivity$10;->val$store:Lcom/mrkeyboard/app/MrWordStore;

    const/4 v5, 0x2

    invoke-interface {v4, v5, v0}, Lcom/mrkeyboard/app/MrWordStore;->count(ILjava/lang/String;)I

    move-result v4

    iget-object v5, p0, Lcom/mrkeyboard/app/MrLearnedActivity$10;->val$store:Lcom/mrkeyboard/app/MrWordStore;

    const/4 v6, 0x3

    invoke-interface {v5, v6, v0}, Lcom/mrkeyboard/app/MrWordStore;->count(ILjava/lang/String;)I

    move-result v0

    add-int/2addr v0, v4

    .line 349
    new-instance v4, Lcom/mrkeyboard/app/MrAppList$Entry;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrLearnedActivity$10;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-static {v5, v3}, Lcom/mrkeyboard/app/MrAppList;->label(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v4, v3, v5, v0}, Lcom/mrkeyboard/app/MrAppList$Entry;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 351
    :cond_1
    new-instance v0, Lcom/mrkeyboard/app/MrLearnedActivity$10$1;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrLearnedActivity$10$1;-><init>(Lcom/mrkeyboard/app/MrLearnedActivity$10;)V

    invoke-static {v1, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 357
    return-object v1
.end method
