.class Lcom/mrkeyboard/app/MrTourActivity$5;
.super Ljava/lang/Object;
.source "MrTourActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrTourActivity;->paintButtons(Ljava/lang/String;IZZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrTourActivity;

.field final synthetic val$st:I

.field final synthetic val$step:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrTourActivity;Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 533
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTourActivity$5;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrTourActivity$5;->val$step:Ljava/lang/String;

    iput p3, p0, Lcom/mrkeyboard/app/MrTourActivity$5;->val$st:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 535
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$5;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrTourActivity$5;->val$step:Ljava/lang/String;

    iget v2, p0, Lcom/mrkeyboard/app/MrTourActivity$5;->val$st:I

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrTourActivity;->access$900(Lcom/mrkeyboard/app/MrTourActivity;Ljava/lang/String;I)V

    .line 536
    return-void
.end method
