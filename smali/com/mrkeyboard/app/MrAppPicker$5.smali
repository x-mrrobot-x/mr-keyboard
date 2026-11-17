.class Lcom/mrkeyboard/app/MrAppPicker$5;
.super Ljava/lang/Object;
.source "MrAppPicker.java"

# interfaces
.implements Landroid/content/DialogInterface$OnDismissListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAppPicker;->open(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrAppPicker;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAppPicker;)V
    .locals 0

    .prologue
    .line 154
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$5;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDismiss(Landroid/content/DialogInterface;)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 157
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$5;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAppPicker;->access$702(Lcom/mrkeyboard/app/MrAppPicker;Z)Z

    .line 158
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$5;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrAppPicker;->access$302(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)Ljava/util/List;

    .line 159
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$5;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrAppPicker;->access$402(Lcom/mrkeyboard/app/MrAppPicker;Ljava/util/List;)Ljava/util/List;

    .line 160
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$5;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAppPicker;->access$800(Lcom/mrkeyboard/app/MrAppPicker;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 161
    return-void
.end method
