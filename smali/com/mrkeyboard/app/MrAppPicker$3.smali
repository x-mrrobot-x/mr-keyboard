.class Lcom/mrkeyboard/app/MrAppPicker$3;
.super Ljava/lang/Object;
.source "MrAppPicker.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAppPicker;->show(Lcom/mrkeyboard/app/MrKit;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/MrAppPicker$Live;Lcom/mrkeyboard/app/MrAppPicker$Pick;)Lcom/mrkeyboard/app/MrAppPicker;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$live:Lcom/mrkeyboard/app/MrAppPicker$Live;

.field final synthetic val$p:Lcom/mrkeyboard/app/MrAppPicker;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAppPicker$Live;Lcom/mrkeyboard/app/MrAppPicker;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 108
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$3;->val$live:Lcom/mrkeyboard/app/MrAppPicker$Live;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrAppPicker$3;->val$p:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 111
    .line 113
    :try_start_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker$3;->val$live:Lcom/mrkeyboard/app/MrAppPicker$Live;

    invoke-interface {v1}, Lcom/mrkeyboard/app/MrAppPicker$Live;->cached()Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v1

    move-object v2, v1

    .line 117
    :goto_0
    if-eqz v2, :cond_3

    :try_start_1
    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_3

    const/4 v1, 0x1

    .line 118
    :goto_1
    if-eqz v1, :cond_0

    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker$3;->val$p:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v3, v2}, Lcom/mrkeyboard/app/MrAppPicker;->access$100(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 121
    :cond_0
    :try_start_2
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker$3;->val$live:Lcom/mrkeyboard/app/MrAppPicker$Live;

    invoke-interface {v2}, Lcom/mrkeyboard/app/MrAppPicker$Live;->refresh()Ljava/util/List;
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result-object v0

    .line 125
    :cond_1
    :goto_2
    if-eqz v0, :cond_4

    :try_start_3
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker$3;->val$p:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrAppPicker;->access$100(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 129
    :cond_2
    :goto_3
    :try_start_4
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$3;->val$live:Lcom/mrkeyboard/app/MrAppPicker$Live;

    invoke-interface {v0}, Lcom/mrkeyboard/app/MrAppPicker$Live;->close()V
    :try_end_4
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_3

    .line 133
    :goto_4
    return-void

    .line 114
    :catch_0
    move-exception v1

    move-object v2, v0

    .line 115
    goto :goto_0

    .line 117
    :cond_3
    const/4 v1, 0x0

    goto :goto_1

    .line 122
    :catch_1
    move-exception v2

    .line 123
    if-nez v1, :cond_1

    :try_start_5
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_2

    .line 128
    :catchall_0
    move-exception v0

    .line 129
    :try_start_6
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker$3;->val$live:Lcom/mrkeyboard/app/MrAppPicker$Live;

    invoke-interface {v1}, Lcom/mrkeyboard/app/MrAppPicker$Live;->close()V
    :try_end_6
    .catch Ljava/lang/RuntimeException; {:try_start_6 .. :try_end_6} :catch_2

    .line 132
    :goto_5
    throw v0

    .line 126
    :cond_4
    if-nez v1, :cond_2

    :try_start_7
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$3;->val$p:Lcom/mrkeyboard/app/MrAppPicker;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAppPicker;->access$100(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    goto :goto_3

    .line 130
    :catch_2
    move-exception v1

    goto :goto_5

    :catch_3
    move-exception v0

    goto :goto_4
.end method
