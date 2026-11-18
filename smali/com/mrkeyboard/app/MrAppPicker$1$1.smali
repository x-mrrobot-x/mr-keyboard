.class Lcom/mrkeyboard/app/MrAppPicker$1$1;
.super Ljava/lang/Object;
.source "MrAppPicker.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrAppPicker$Sink;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAppPicker$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrAppPicker$1;

.field final synthetic val$answered:[Z


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAppPicker$1;[Z)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 98
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$1$1;->this$0:Lcom/mrkeyboard/app/MrAppPicker$1;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrAppPicker$1$1;->val$answered:[Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public publish(Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 100
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$1$1;->val$answered:[Z

    const/4 v1, 0x0

    const/4 v2, 0x1

    aput-boolean v2, v0, v1

    .line 101
    if-nez p1, :cond_0

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    .line 102
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$1$1;->this$0:Lcom/mrkeyboard/app/MrAppPicker$1;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAppPicker$1;->val$p:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAppPicker;->access$100(Lcom/mrkeyboard/app/MrAppPicker;)Landroid/app/Activity;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/MrAppPicker$1$1$1;

    invoke-direct {v1, p0, p1}, Lcom/mrkeyboard/app/MrAppPicker$1$1$1;-><init>(Lcom/mrkeyboard/app/MrAppPicker$1$1;Ljava/util/List;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 107
    return-void
.end method
