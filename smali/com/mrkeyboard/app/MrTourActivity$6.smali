.class Lcom/mrkeyboard/app/MrTourActivity$6;
.super Ljava/lang/Object;
.source "MrTourActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrTourActivity;->render()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrTourActivity;

.field final synthetic val$step:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrTourActivity;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 227
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTourActivity$6;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrTourActivity$6;->val$step:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 229
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$6;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity$6;->val$step:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTour;->turnOff(Landroid/content/Context;Ljava/lang/String;)V

    .line 230
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$6;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$600(Lcom/mrkeyboard/app/MrTourActivity;)V

    .line 231
    return-void
.end method
