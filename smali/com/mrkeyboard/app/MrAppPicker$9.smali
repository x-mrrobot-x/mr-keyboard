.class Lcom/mrkeyboard/app/MrAppPicker$9;
.super Ljava/lang/Object;
.source "MrAppPicker.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAppPicker;->arrived(Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrAppPicker;

.field final synthetic val$y:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAppPicker;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 228
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$9;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    iput p2, p0, Lcom/mrkeyboard/app/MrAppPicker$9;->val$y:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 230
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$9;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAppPicker;->access$800(Lcom/mrkeyboard/app/MrAppPicker;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$9;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAppPicker;->access$1000(Lcom/mrkeyboard/app/MrAppPicker;)Landroid/widget/ScrollView;

    move-result-object v0

    const/4 v1, 0x0

    iget v2, p0, Lcom/mrkeyboard/app/MrAppPicker$9;->val$y:I

    invoke-virtual {v0, v1, v2}, Landroid/widget/ScrollView;->scrollTo(II)V

    .line 231
    :cond_0
    return-void
.end method
