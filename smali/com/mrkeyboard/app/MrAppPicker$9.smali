.class Lcom/mrkeyboard/app/MrAppPicker$9;
.super Ljava/lang/Object;
.source "MrAppPicker.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAppPicker;->loadIcons(Ljava/util/ArrayList;Ljava/util/ArrayList;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrAppPicker;

.field final synthetic val$drawing:I

.field final synthetic val$entries:Ljava/util/ArrayList;

.field final synthetic val$views:Ljava/util/ArrayList;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/ArrayList;ILjava/util/ArrayList;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 283
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$9;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrAppPicker$9;->val$entries:Ljava/util/ArrayList;

    iput p3, p0, Lcom/mrkeyboard/app/MrAppPicker$9;->val$drawing:I

    iput-object p4, p0, Lcom/mrkeyboard/app/MrAppPicker$9;->val$views:Ljava/util/ArrayList;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    .line 285
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$9;->val$entries:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_0

    .line 286
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$9;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAppPicker;->access$800(Lcom/mrkeyboard/app/MrAppPicker;)Z

    move-result v0

    if-nez v0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrAppPicker$9;->val$drawing:I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAppPicker$9;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v2}, Lcom/mrkeyboard/app/MrAppPicker;->access$1100(Lcom/mrkeyboard/app/MrAppPicker;)I

    move-result v2

    if-eq v0, v2, :cond_1

    .line 296
    :cond_0
    return-void

    .line 287
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$9;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAppPicker;->access$100(Lcom/mrkeyboard/app/MrAppPicker;)Landroid/app/Activity;

    move-result-object v2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$9;->val$entries:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrAppList$Entry;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAppList$Entry;->pkg:Ljava/lang/String;

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrAppList;->icon(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    .line 288
    if-nez v2, :cond_2

    .line 285
    :goto_1
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 289
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$9;->val$views:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    .line 290
    iget-object v3, p0, Lcom/mrkeyboard/app/MrAppPicker$9;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v3}, Lcom/mrkeyboard/app/MrAppPicker;->access$100(Lcom/mrkeyboard/app/MrAppPicker;)Landroid/app/Activity;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/MrAppPicker$9$1;

    invoke-direct {v4, p0, v0, v2}, Lcom/mrkeyboard/app/MrAppPicker$9$1;-><init>(Lcom/mrkeyboard/app/MrAppPicker$9;Landroid/widget/ImageView;Landroid/graphics/drawable/Drawable;)V

    invoke-virtual {v3, v4}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    goto :goto_1
.end method
