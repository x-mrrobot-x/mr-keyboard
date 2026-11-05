.class Lcom/mrkeyboard/app/MrUpdateDialog$Ui$1;
.super Ljava/lang/Object;
.source "MrUpdateDialog.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrUpdateDialog$Ui;->state(II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrUpdateDialog$Ui;

.field final synthetic val$percent:I

.field final synthetic val$state:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrUpdateDialog$Ui;II)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 264
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$1;->this$0:Lcom/mrkeyboard/app/MrUpdateDialog$Ui;

    iput p2, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$1;->val$state:I

    iput p3, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$1;->val$percent:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 266
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$1;->this$0:Lcom/mrkeyboard/app/MrUpdateDialog$Ui;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateDialog$Ui;->access$400(Lcom/mrkeyboard/app/MrUpdateDialog$Ui;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$1;->val$state:I

    iget v1, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$1;->val$percent:I

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrUpdateDialog;->setState(IILjava/lang/String;)V

    .line 267
    :cond_0
    return-void
.end method
