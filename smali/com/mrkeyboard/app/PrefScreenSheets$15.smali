.class Lcom/mrkeyboard/app/PrefScreenSheets$15;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->confirmRestoreAbc()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 384
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 386
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->reset(Landroid/content/Context;)Z

    .line 387
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1700(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 388
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    const-string v2, "mr_abc_restored"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1500(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1600(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;Z)V

    .line 389
    return-void
.end method
