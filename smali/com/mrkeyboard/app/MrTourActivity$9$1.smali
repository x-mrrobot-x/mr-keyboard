.class Lcom/mrkeyboard/app/MrTourActivity$9$1;
.super Ljava/lang/Object;
.source "MrTourActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrTourActivity$9;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrTourActivity$9;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrTourActivity$9;)V
    .locals 0

    .prologue
    .line 717
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTourActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrTourActivity$9;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 719
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrTourActivity$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrTourActivity$9;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrTourActivity$9;

    iget v1, v1, Lcom/mrkeyboard/app/MrTourActivity$9;->val$gen:I

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$2000(Lcom/mrkeyboard/app/MrTourActivity;I)V

    .line 720
    return-void
.end method
