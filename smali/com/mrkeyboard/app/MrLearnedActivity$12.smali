.class Lcom/mrkeyboard/app/MrLearnedActivity$12;
.super Ljava/lang/Object;
.source "MrLearnedActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrAppPicker$Pick;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrLearnedActivity;->chooseApp()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrLearnedActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrLearnedActivity;)V
    .locals 0

    .prologue
    .line 367
    iput-object p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$12;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPick(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 369
    if-nez p1, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$12;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$900(Lcom/mrkeyboard/app/MrLearnedActivity;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_2

    .line 374
    :cond_0
    :goto_0
    return-void

    .line 369
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$12;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$900(Lcom/mrkeyboard/app/MrLearnedActivity;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 370
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$12;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$902(Lcom/mrkeyboard/app/MrLearnedActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 371
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$12;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    const/16 v1, 0x32

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$102(Lcom/mrkeyboard/app/MrLearnedActivity;I)I

    .line 372
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$12;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$200(Lcom/mrkeyboard/app/MrLearnedActivity;)Lcom/mrkeyboard/app/MrPage;

    move-result-object v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$12;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$200(Lcom/mrkeyboard/app/MrLearnedActivity;)Lcom/mrkeyboard/app/MrPage;

    move-result-object v0

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrPage;->release()V

    .line 373
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$12;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$1300(Lcom/mrkeyboard/app/MrLearnedActivity;)V

    goto :goto_0
.end method
