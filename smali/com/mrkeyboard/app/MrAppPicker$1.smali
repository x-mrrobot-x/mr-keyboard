.class Lcom/mrkeyboard/app/MrAppPicker$1;
.super Ljava/lang/Object;
.source "MrAppPicker.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAppPicker;->show(Lcom/mrkeyboard/app/MrKit;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/MrAppPicker$Source;Lcom/mrkeyboard/app/MrAppPicker$Pick;)Lcom/mrkeyboard/app/MrAppPicker;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$p:Lcom/mrkeyboard/app/MrAppPicker;

.field final synthetic val$source:Lcom/mrkeyboard/app/MrAppPicker$Source;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAppPicker$Source;Lcom/mrkeyboard/app/MrAppPicker;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 78
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$1;->val$source:Lcom/mrkeyboard/app/MrAppPicker$Source;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrAppPicker$1;->val$p:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 82
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$1;->val$source:Lcom/mrkeyboard/app/MrAppPicker$Source;

    invoke-interface {v0}, Lcom/mrkeyboard/app/MrAppPicker$Source;->load()Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 86
    :goto_0
    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 87
    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker$1;->val$p:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAppPicker;->access$100(Lcom/mrkeyboard/app/MrAppPicker;)Landroid/app/Activity;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrAppPicker$1$1;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrAppPicker$1$1;-><init>(Lcom/mrkeyboard/app/MrAppPicker$1;Ljava/util/List;)V

    invoke-virtual {v1, v2}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 92
    return-void

    .line 83
    :catch_0
    move-exception v0

    .line 84
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    goto :goto_0
.end method
