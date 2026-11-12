.class Lcom/mrkeyboard/app/MrPacksActivity$14;
.super Ljava/lang/Object;
.source "MrPacksActivity.java"

# interfaces
.implements Landroid/preference/Preference$OnPreferenceChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPacksActivity;->buildGesture()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrPacksActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 544
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$14;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPreferenceChange(Landroid/preference/Preference;Ljava/lang/Object;)Z
    .locals 4

    .prologue
    .line 547
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v0, p2}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$14;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    const-string v1, "gesture"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacks;->modelVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "gesture"

    sget-object v1, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 548
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$14;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$2100(Lcom/mrkeyboard/app/MrPacksActivity;)V

    .line 551
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$14;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$200(Lcom/mrkeyboard/app/MrPacksActivity;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$14;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$2200(Lcom/mrkeyboard/app/MrPacksActivity;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 552
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$14;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$200(Lcom/mrkeyboard/app/MrPacksActivity;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$14;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$2200(Lcom/mrkeyboard/app/MrPacksActivity;)Ljava/lang/Runnable;

    move-result-object v1

    const-wide/16 v2, 0x12c

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 553
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$14;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$200(Lcom/mrkeyboard/app/MrPacksActivity;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$14;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$2200(Lcom/mrkeyboard/app/MrPacksActivity;)Ljava/lang/Runnable;

    move-result-object v1

    const-wide/16 v2, 0x7d0

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 554
    const/4 v0, 0x1

    return v0
.end method
