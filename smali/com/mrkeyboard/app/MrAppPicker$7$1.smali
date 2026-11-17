.class Lcom/mrkeyboard/app/MrAppPicker$7$1;
.super Ljava/lang/Object;
.source "MrAppPicker.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAppPicker$7;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrAppPicker$7;

.field final synthetic val$d:Landroid/graphics/drawable/Drawable;

.field final synthetic val$v:Landroid/widget/ImageView;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAppPicker$7;Landroid/widget/ImageView;Landroid/graphics/drawable/Drawable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 238
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$7$1;->this$1:Lcom/mrkeyboard/app/MrAppPicker$7;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrAppPicker$7$1;->val$v:Landroid/widget/ImageView;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrAppPicker$7$1;->val$d:Landroid/graphics/drawable/Drawable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 240
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$7$1;->this$1:Lcom/mrkeyboard/app/MrAppPicker$7;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAppPicker$7;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAppPicker;->access$700(Lcom/mrkeyboard/app/MrAppPicker;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$7$1;->this$1:Lcom/mrkeyboard/app/MrAppPicker$7;

    iget v0, v0, Lcom/mrkeyboard/app/MrAppPicker$7;->val$drawing:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker$7$1;->this$1:Lcom/mrkeyboard/app/MrAppPicker$7;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrAppPicker$7;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrAppPicker;->access$900(Lcom/mrkeyboard/app/MrAppPicker;)I

    move-result v1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$7$1;->val$v:Landroid/widget/ImageView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker$7$1;->val$d:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 241
    :cond_0
    return-void
.end method
