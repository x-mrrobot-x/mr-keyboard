.class Lcom/mrkeyboard/app/MrUpdateDialog$Ui$3;
.super Ljava/lang/Object;
.source "MrUpdateDialog.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrUpdateDialog$Ui;->aborted()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrUpdateDialog$Ui;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrUpdateDialog$Ui;)V
    .locals 0

    .prologue
    .line 280
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$3;->this$0:Lcom/mrkeyboard/app/MrUpdateDialog$Ui;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 282
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$3;->this$0:Lcom/mrkeyboard/app/MrUpdateDialog$Ui;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateDialog$Ui;->access$400(Lcom/mrkeyboard/app/MrUpdateDialog$Ui;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/16 v0, 0xa

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrUpdateDialog;->setState(IILjava/lang/String;)V

    .line 283
    :cond_0
    return-void
.end method
