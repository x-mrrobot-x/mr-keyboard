.class Lcom/mrkeyboard/app/MrAppPicker$7;
.super Ljava/lang/Object;
.source "MrAppPicker.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAppPicker;->checkMore()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrAppPicker;

.field final synthetic val$from:I

.field final synthetic val$list:Ljava/util/List;

.field final synthetic val$to:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;II)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 247
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$7;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrAppPicker$7;->val$list:Ljava/util/List;

    iput p3, p0, Lcom/mrkeyboard/app/MrAppPicker$7;->val$from:I

    iput p4, p0, Lcom/mrkeyboard/app/MrAppPicker$7;->val$to:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 249
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$7;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker$7;->val$list:Ljava/util/List;

    iget v2, p0, Lcom/mrkeyboard/app/MrAppPicker$7;->val$from:I

    iget v3, p0, Lcom/mrkeyboard/app/MrAppPicker$7;->val$to:I

    invoke-static {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrAppPicker;->access$1000(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;II)V

    .line 250
    return-void
.end method
