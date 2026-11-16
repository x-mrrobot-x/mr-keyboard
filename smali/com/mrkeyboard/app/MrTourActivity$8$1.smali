.class Lcom/mrkeyboard/app/MrTourActivity$8$1;
.super Ljava/lang/Object;
.source "MrTourActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrTourActivity$8;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrTourActivity$8;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrTourActivity$8;)V
    .locals 0

    .prologue
    .line 692
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTourActivity$8$1;->this$1:Lcom/mrkeyboard/app/MrTourActivity$8;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 694
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$8$1;->this$1:Lcom/mrkeyboard/app/MrTourActivity$8;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrTourActivity$8;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity$8$1;->this$1:Lcom/mrkeyboard/app/MrTourActivity$8;

    iget v1, v1, Lcom/mrkeyboard/app/MrTourActivity$8;->val$gen:I

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$1800(Lcom/mrkeyboard/app/MrTourActivity;I)V

    .line 695
    return-void
.end method
