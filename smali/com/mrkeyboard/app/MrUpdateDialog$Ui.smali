.class final Lcom/mrkeyboard/app/MrUpdateDialog$Ui;
.super Ljava/lang/Object;
.source "MrUpdateDialog.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrUpdateInstall$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrUpdateDialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Ui"
.end annotation


# instance fields
.field private final mActivity:Landroid/app/Activity;

.field private final mCode:J


# direct methods
.method constructor <init>(Landroid/app/Activity;J)V
    .locals 0

    .prologue
    .line 250
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 251
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui;->mActivity:Landroid/app/Activity;

    .line 252
    iput-wide p2, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui;->mCode:J

    .line 253
    return-void
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/MrUpdateDialog$Ui;)Z
    .locals 1

    .prologue
    .line 246
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrUpdateDialog$Ui;->mine()Z

    move-result v0

    return v0
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/MrUpdateDialog$Ui;)Landroid/app/Activity;
    .locals 1

    .prologue
    .line 246
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui;->mActivity:Landroid/app/Activity;

    return-object v0
.end method

.method private mine()Z
    .locals 4

    .prologue
    .line 260
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateDialog;->access$100()Landroid/app/Activity;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui;->mActivity:Landroid/app/Activity;

    if-ne v0, v1, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateDialog;->access$200()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui;->mCode:J

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateDialog;->access$300()Landroid/app/Dialog;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private post(Ljava/lang/Runnable;)V
    .locals 1

    .prologue
    .line 256
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui;->mActivity:Landroid/app/Activity;

    invoke-virtual {v0, p1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 257
    return-void
.end method


# virtual methods
.method public aborted()V
    .locals 1

    .prologue
    .line 280
    new-instance v0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$3;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$3;-><init>(Lcom/mrkeyboard/app/MrUpdateDialog$Ui;)V

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrUpdateDialog$Ui;->post(Ljava/lang/Runnable;)V

    .line 285
    return-void
.end method

.method public failed(Lcom/mrkeyboard/app/MrUpdateInstall$Failure;)V
    .locals 1

    .prologue
    .line 272
    new-instance v0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$2;

    invoke-direct {v0, p0, p1}, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$2;-><init>(Lcom/mrkeyboard/app/MrUpdateDialog$Ui;Lcom/mrkeyboard/app/MrUpdateInstall$Failure;)V

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrUpdateDialog$Ui;->post(Ljava/lang/Runnable;)V

    .line 277
    return-void
.end method

.method public state(II)V
    .locals 1

    .prologue
    .line 264
    new-instance v0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$1;

    invoke-direct {v0, p0, p1, p2}, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$1;-><init>(Lcom/mrkeyboard/app/MrUpdateDialog$Ui;II)V

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrUpdateDialog$Ui;->post(Ljava/lang/Runnable;)V

    .line 269
    return-void
.end method
