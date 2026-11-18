.class Lcom/mrkeyboard/app/MrImportActivity$10;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrAppPicker$Pick;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity;->chooseApp()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrImportActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 313
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$10;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPick(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 315
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$10;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1100(Lcom/mrkeyboard/app/MrImportActivity;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$10;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrImportActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 321
    :cond_0
    :goto_0
    return-void

    .line 316
    :cond_1
    if-nez p1, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$10;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1600(Lcom/mrkeyboard/app/MrImportActivity;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 317
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$10;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->access$1602(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 319
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$10;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$400(Lcom/mrkeyboard/app/MrImportActivity;)V

    .line 320
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$10;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1700(Lcom/mrkeyboard/app/MrImportActivity;)V

    goto :goto_0

    .line 316
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$10;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1600(Lcom/mrkeyboard/app/MrImportActivity;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    goto :goto_0
.end method
