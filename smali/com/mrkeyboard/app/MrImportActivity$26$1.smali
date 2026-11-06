.class Lcom/mrkeyboard/app/MrImportActivity$26$1;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity$26;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrImportActivity$26;

.field final synthetic val$result:Lcom/mrkeyboard/app/MrImportAi$Result;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity$26;Lcom/mrkeyboard/app/MrImportAi$Result;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 804
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$26$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$26;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity$26$1;->val$result:Lcom/mrkeyboard/app/MrImportAi$Result;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 806
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$26$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$26;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$26;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$26$1;->val$result:Lcom/mrkeyboard/app/MrImportAi$Result;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity$26$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$26;

    iget-object v2, v2, Lcom/mrkeyboard/app/MrImportActivity$26;->val$beforeBox:Ljava/lang/String;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrImportActivity$26$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$26;

    iget-object v3, v3, Lcom/mrkeyboard/app/MrImportActivity$26;->val$beforeFile:Ljava/lang/String;

    invoke-static {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrImportActivity;->access$3700(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Result;Ljava/lang/String;Ljava/lang/String;)V

    .line 807
    return-void
.end method
