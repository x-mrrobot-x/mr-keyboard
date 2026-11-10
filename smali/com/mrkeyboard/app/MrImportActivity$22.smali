.class Lcom/mrkeyboard/app/MrImportActivity$22;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity;->askToSend(Lcom/mrkeyboard/app/MrImportAi$Plan;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrImportActivity;

.field final synthetic val$plan:Lcom/mrkeyboard/app/MrImportAi$Plan;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Plan;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 744
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$22;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity$22;->val$plan:Lcom/mrkeyboard/app/MrImportAi$Plan;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    .prologue
    .line 746
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$22;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$22;->val$plan:Lcom/mrkeyboard/app/MrImportAi$Plan;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$3500(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImportAi$Plan;)V

    .line 747
    return-void
.end method
