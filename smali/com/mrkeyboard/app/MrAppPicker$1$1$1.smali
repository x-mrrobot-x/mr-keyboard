.class Lcom/mrkeyboard/app/MrAppPicker$1$1$1;
.super Ljava/lang/Object;
.source "MrAppPicker.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAppPicker$1$1;->publish(Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrAppPicker$1$1;

.field final synthetic val$done:Ljava/util/List;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAppPicker$1$1;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 102
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$1$1$1;->this$1:Lcom/mrkeyboard/app/MrAppPicker$1$1;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrAppPicker$1$1$1;->val$done:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 104
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$1$1$1;->this$1:Lcom/mrkeyboard/app/MrAppPicker$1$1;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAppPicker$1$1;->this$0:Lcom/mrkeyboard/app/MrAppPicker$1;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAppPicker$1;->val$p:Lcom/mrkeyboard/app/MrAppPicker;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker$1$1$1;->val$done:Ljava/util/List;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAppPicker;->access$000(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)V

    .line 105
    return-void
.end method
