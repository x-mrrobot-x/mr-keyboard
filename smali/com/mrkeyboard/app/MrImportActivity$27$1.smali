.class Lcom/mrkeyboard/app/MrImportActivity$27$1;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity$27;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrImportActivity$27;

.field final synthetic val$result:Lcom/mrkeyboard/app/MrImportAi$Result;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity$27;Lcom/mrkeyboard/app/MrImportAi$Result;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 865
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$27$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$27;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity$27$1;->val$result:Lcom/mrkeyboard/app/MrImportAi$Result;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 867
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$27$1;->this$1:Lcom/mrkeyboard/app/MrImportActivity$27;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrImportActivity$27;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$27$1;->val$result:Lcom/mrkeyboard/app/MrImportAi$Result;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$4100(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Result;)V

    .line 868
    return-void
.end method
