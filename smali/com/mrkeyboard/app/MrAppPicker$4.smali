.class Lcom/mrkeyboard/app/MrAppPicker$4;
.super Ljava/lang/Object;
.source "MrAppPicker.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAppPicker;->post(Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrAppPicker;

.field final synthetic val$list:Ljava/util/List;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 141
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$4;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrAppPicker$4;->val$list:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 143
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$4;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker$4;->val$list:Ljava/util/List;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAppPicker;->access$200(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)V

    .line 144
    return-void
.end method
