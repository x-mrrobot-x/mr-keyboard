.class Lcom/mrkeyboard/app/MrReset$1;
.super Ljava/lang/Object;
.source "MrReset.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrReset;->onPreferenceClick(Landroid/preference/Preference;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrReset;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrReset;)V
    .locals 0

    .prologue
    .line 88
    iput-object p1, p0, Lcom/mrkeyboard/app/MrReset$1;->this$0:Lcom/mrkeyboard/app/MrReset;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 90
    iget-object v0, p0, Lcom/mrkeyboard/app/MrReset$1;->this$0:Lcom/mrkeyboard/app/MrReset;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrReset;->access$000(Lcom/mrkeyboard/app/MrReset;)Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrReset;->apply(Landroid/content/Context;)V

    .line 91
    iget-object v0, p0, Lcom/mrkeyboard/app/MrReset$1;->this$0:Lcom/mrkeyboard/app/MrReset;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrReset;->access$000(Lcom/mrkeyboard/app/MrReset;)Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrReset$1;->this$0:Lcom/mrkeyboard/app/MrReset;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrReset;->access$000(Lcom/mrkeyboard/app/MrReset;)Landroid/content/Context;

    move-result-object v1

    const-string v2, "mr_reset_done"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, v4}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 92
    iget-object v0, p0, Lcom/mrkeyboard/app/MrReset$1;->this$0:Lcom/mrkeyboard/app/MrReset;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrReset;->access$000(Lcom/mrkeyboard/app/MrReset;)Landroid/content/Context;

    move-result-object v0

    instance-of v0, v0, Landroid/app/Activity;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrReset$1;->this$0:Lcom/mrkeyboard/app/MrReset;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrReset;->access$000(Lcom/mrkeyboard/app/MrReset;)Landroid/content/Context;

    move-result-object v0

    check-cast v0, Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->recreate()V

    .line 93
    :cond_0
    return-void
.end method
