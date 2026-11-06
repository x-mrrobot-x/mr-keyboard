.class Lcom/mrkeyboard/app/MrImportActivity$24;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrImportAi$Sender;


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


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 766
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$24;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public send(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/mrkeyboard/app/MrImportAi$Fail;
        }
    .end annotation

    .prologue
    .line 769
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$24;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    const-wide v2, 0x3fc999999999999aL    # 0.2

    invoke-static {v0, p1, p2, v2, v3}, Lcom/mrkeyboard/app/MrAi;->complete(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;D)Ljava/lang/String;
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrAi$AiFail; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    return-object v0

    .line 770
    :catch_0
    move-exception v0

    .line 771
    new-instance v1, Lcom/mrkeyboard/app/MrImportAi$Fail;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrAi$AiFail;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Lcom/mrkeyboard/app/MrImportAi$Fail;-><init>(Ljava/lang/String;)V

    throw v1
.end method
