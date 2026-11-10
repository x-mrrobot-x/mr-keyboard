.class Lcom/mrkeyboard/app/MrPacksActivity$4$1;
.super Ljava/lang/Object;
.source "MrPacksActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPacksActivity$4;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrPacksActivity$4;

.field final synthetic val$text:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPacksActivity$4;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 195
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$4$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$4;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrPacksActivity$4$1;->val$text:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 197
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$4$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$4;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$4;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$000(Lcom/mrkeyboard/app/MrPacksActivity;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$4$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$4;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$4;->val$target:Landroid/preference/Preference;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$4$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$4;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrPacksActivity$4;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$600(Lcom/mrkeyboard/app/MrPacksActivity;)Landroid/preference/Preference;

    move-result-object v1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$4$1;->this$1:Lcom/mrkeyboard/app/MrPacksActivity$4;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacksActivity$4;->val$target:Landroid/preference/Preference;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$4$1;->val$text:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 198
    :cond_0
    return-void
.end method
