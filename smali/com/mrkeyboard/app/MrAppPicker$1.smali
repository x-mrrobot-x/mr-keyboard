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
.method constructor <init>(Lcom/mrkeyboard/app/MrAppPicker;Lcom/mrkeyboard/app/MrAppPicker$Source;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 95
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$1;->val$p:Lcom/mrkeyboard/app/MrAppPicker;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrAppPicker$1;->val$source:Lcom/mrkeyboard/app/MrAppPicker$Source;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 97
    const/4 v0, 0x1

    new-array v0, v0, [Z

    .line 98
    new-instance v1, Lcom/mrkeyboard/app/MrAppPicker$1$1;

    invoke-direct {v1, p0, v0}, Lcom/mrkeyboard/app/MrAppPicker$1$1;-><init>(Lcom/mrkeyboard/app/MrAppPicker$1;[Z)V

    .line 110
    :try_start_0
    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker$1;->val$source:Lcom/mrkeyboard/app/MrAppPicker$Source;

    invoke-interface {v2, v1}, Lcom/mrkeyboard/app/MrAppPicker$Source;->load(Lcom/mrkeyboard/app/MrAppPicker$Sink;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 114
    :goto_0
    const/4 v2, 0x0

    aget-boolean v0, v0, v2

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {v1, v0}, Lcom/mrkeyboard/app/MrAppPicker$Sink;->publish(Ljava/util/List;)V

    .line 115
    :cond_0
    return-void

    .line 111
    :catch_0
    move-exception v2

    goto :goto_0
.end method
