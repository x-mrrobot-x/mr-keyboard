.class Lcom/mrkeyboard/app/ExpandableDictionary$LoadDictionaryTask;
.super Lcom/mrkeyboard/app/BgTask;
.source "ExpandableDictionary.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/ExpandableDictionary;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "LoadDictionaryTask"
.end annotation



# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/ExpandableDictionary;


# direct methods
.method private constructor <init>(Lcom/mrkeyboard/app/ExpandableDictionary;)V
    .locals 0

    .line 495
    iput-object p1, p0, Lcom/mrkeyboard/app/ExpandableDictionary$LoadDictionaryTask;->this$0:Lcom/mrkeyboard/app/ExpandableDictionary;

    invoke-direct {p0}, Lcom/mrkeyboard/app/BgTask;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/mrkeyboard/app/ExpandableDictionary;Lcom/mrkeyboard/app/ExpandableDictionary$1;)V
    .locals 0

    .line 495
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/ExpandableDictionary$LoadDictionaryTask;-><init>(Lcom/mrkeyboard/app/ExpandableDictionary;)V

    return-void
.end method


# virtual methods
.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 495
    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/ExpandableDictionary$LoadDictionaryTask;->doInBackground([Ljava/lang/Void;)Ljava/lang/Void;

    move-result-object p1

    return-object p1
.end method

.method protected varargs doInBackground([Ljava/lang/Void;)Ljava/lang/Void;
    .locals 2

    .line 498
    iget-object p1, p0, Lcom/mrkeyboard/app/ExpandableDictionary$LoadDictionaryTask;->this$0:Lcom/mrkeyboard/app/ExpandableDictionary;

    invoke-virtual {p1}, Lcom/mrkeyboard/app/ExpandableDictionary;->loadDictionaryAsync()V

    .line 499
    iget-object p1, p0, Lcom/mrkeyboard/app/ExpandableDictionary$LoadDictionaryTask;->this$0:Lcom/mrkeyboard/app/ExpandableDictionary;

    invoke-static {p1}, Lcom/mrkeyboard/app/ExpandableDictionary;->access$100(Lcom/mrkeyboard/app/ExpandableDictionary;)Ljava/lang/Object;

    move-result-object p1

    monitor-enter p1

    .line 500
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/ExpandableDictionary$LoadDictionaryTask;->this$0:Lcom/mrkeyboard/app/ExpandableDictionary;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/ExpandableDictionary;->access$202(Lcom/mrkeyboard/app/ExpandableDictionary;Z)Z

    .line 501
    monitor-exit p1

    const/4 p1, 0x0

    return-object p1

    :catchall_0
    move-exception v0

    monitor-exit p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method
