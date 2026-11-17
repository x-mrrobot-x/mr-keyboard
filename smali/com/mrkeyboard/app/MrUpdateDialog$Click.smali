.class final Lcom/mrkeyboard/app/MrUpdateDialog$Click;
.super Ljava/lang/Object;
.source "MrUpdateDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrUpdateDialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Click"
.end annotation


# instance fields
.field private final mActivity:Landroid/app/Activity;

.field private final mNotice:Lcom/mrkeyboard/app/MrUpdate$Notice;

.field private final mWhat:I


# direct methods
.method constructor <init>(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;I)V
    .locals 0

    .prologue
    .line 294
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 295
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mActivity:Landroid/app/Activity;

    .line 296
    iput-object p2, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mNotice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    .line 297
    iput p3, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mWhat:I

    .line 298
    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 5

    .prologue
    const/4 v4, 0x2

    const/4 v3, 0x1

    .line 301
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateDialog;->access$600()I

    move-result v0

    .line 302
    iget v1, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mWhat:I

    if-ne v1, v3, :cond_2

    .line 303
    const/16 v1, 0xb

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mActivity:Landroid/app/Activity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateDialog;->access$700(Landroid/app/Activity;)V

    .line 315
    :cond_0
    :goto_0
    return-void

    .line 304
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mActivity:Landroid/app/Activity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mNotice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrUpdateDialog;->begin(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;)V

    goto :goto_0

    .line 307
    :cond_2
    iget v1, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mWhat:I

    const/4 v2, 0x3

    if-ne v1, v2, :cond_4

    if-eq v0, v3, :cond_3

    if-ne v0, v4, :cond_4

    .line 308
    :cond_3
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateInstall;->cancel()V

    .line 309
    const/16 v0, 0xa

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrUpdateDialog;->setState(IILjava/lang/String;)V

    goto :goto_0

    .line 312
    :cond_4
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mActivity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mNotice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrUpdate;->snooze(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdate$Notice;)V

    .line 313
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateDialog;->dismiss()V

    .line 314
    iget v0, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mWhat:I

    if-ne v0, v4, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mActivity:Landroid/app/Activity;

    const-string v1, "https://github.com/x-mrrobot-x/mr-keyboard/releases/latest"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLink;->open(Landroid/content/Context;Ljava/lang/String;)Z

    goto :goto_0
.end method
