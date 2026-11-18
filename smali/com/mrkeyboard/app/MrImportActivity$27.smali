.class Lcom/mrkeyboard/app/MrImportActivity$27;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity;->runAi(Lcom/mrkeyboard/app/MrImportAi$Plan;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrImportActivity;

.field final synthetic val$control:Lcom/mrkeyboard/app/MrImportAi$Control;

.field final synthetic val$plan:Lcom/mrkeyboard/app/MrImportAi$Plan;

.field final synthetic val$sender:Lcom/mrkeyboard/app/MrImportAi$Sender;

.field final synthetic val$tag:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Plan;Ljava/lang/String;Lcom/mrkeyboard/app/MrImportAi$Sender;Lcom/mrkeyboard/app/MrImportAi$Control;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 850
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$27;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity$27;->val$plan:Lcom/mrkeyboard/app/MrImportAi$Plan;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrImportActivity$27;->val$tag:Ljava/lang/String;

    iput-object p4, p0, Lcom/mrkeyboard/app/MrImportActivity$27;->val$sender:Lcom/mrkeyboard/app/MrImportAi$Sender;

    iput-object p5, p0, Lcom/mrkeyboard/app/MrImportActivity$27;->val$control:Lcom/mrkeyboard/app/MrImportAi$Control;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 854
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$27;->val$plan:Lcom/mrkeyboard/app/MrImportAi$Plan;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$27;->val$tag:Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity$27;->val$sender:Lcom/mrkeyboard/app/MrImportAi$Sender;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity$27;->val$control:Lcom/mrkeyboard/app/MrImportAi$Control;

    invoke-static {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrImportAi;->run(Lcom/mrkeyboard/app/MrImportAi$Plan;Ljava/lang/String;Lcom/mrkeyboard/app/MrImportAi$Sender;Lcom/mrkeyboard/app/MrImportAi$Control;)Lcom/mrkeyboard/app/MrImportAi$Result;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v0

    .line 865
    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$27;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    new-instance v2, Lcom/mrkeyboard/app/MrImportActivity$27$1;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrImportActivity$27$1;-><init>(Lcom/mrkeyboard/app/MrImportActivity$27;Lcom/mrkeyboard/app/MrImportAi$Result;)V

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrImportActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 870
    return-void

    .line 855
    :catch_0
    move-exception v0

    .line 856
    new-instance v0, Lcom/mrkeyboard/app/MrImportAi$Result;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrImportAi$Result;-><init>()V

    .line 857
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$27;->val$plan:Lcom/mrkeyboard/app/MrImportAi$Plan;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrImportAi$Plan;->requests()I

    move-result v1

    iput v1, v0, Lcom/mrkeyboard/app/MrImportAi$Result;->parts:I

    .line 858
    const-string v1, ""

    iput-object v1, v0, Lcom/mrkeyboard/app/MrImportAi$Result;->failure:Ljava/lang/String;

    goto :goto_0

    .line 859
    :catch_1
    move-exception v0

    .line 860
    new-instance v0, Lcom/mrkeyboard/app/MrImportAi$Result;

    invoke-direct {v0}, Lcom/mrkeyboard/app/MrImportAi$Result;-><init>()V

    .line 861
    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$27;->val$plan:Lcom/mrkeyboard/app/MrImportAi$Plan;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrImportAi$Plan;->requests()I

    move-result v1

    iput v1, v0, Lcom/mrkeyboard/app/MrImportAi$Result;->parts:I

    .line 862
    const-string v1, ""

    iput-object v1, v0, Lcom/mrkeyboard/app/MrImportAi$Result;->failure:Ljava/lang/String;

    goto :goto_0
.end method
