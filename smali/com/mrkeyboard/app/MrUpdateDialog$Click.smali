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
    .line 134
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 135
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mActivity:Landroid/app/Activity;

    .line 136
    iput-object p2, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mNotice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    .line 137
    iput p3, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mWhat:I

    .line 138
    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 141
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mActivity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mNotice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrUpdate;->snooze(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdate$Notice;)V

    .line 142
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateDialog;->dismiss()V

    .line 143
    iget v0, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mWhat:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mActivity:Landroid/app/Activity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mNotice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrUpdateDialog;->install(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;)V

    .line 145
    :cond_0
    :goto_0
    return-void

    .line 144
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mWhat:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Click;->mActivity:Landroid/app/Activity;

    const-string v1, "https://github.com/x-mrrobot-x/mr-keyboard/releases/latest"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLink;->open(Landroid/content/Context;Ljava/lang/String;)Z

    goto :goto_0
.end method
