.class Lcom/mrkeyboard/app/LatinIME$3;
.super Landroid/content/BroadcastReceiver;
.source "LatinIME.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/LatinIME;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/LatinIME;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/LatinIME;)V
    .locals 0

    .line 3224
    iput-object p1, p0, Lcom/mrkeyboard/app/LatinIME$3;->this$0:Lcom/mrkeyboard/app/LatinIME;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 0

    .line 3227
    iget-object p1, p0, Lcom/mrkeyboard/app/LatinIME$3;->this$0:Lcom/mrkeyboard/app/LatinIME;

    invoke-static {p1}, Lcom/mrkeyboard/app/LatinIME;->access$500(Lcom/mrkeyboard/app/LatinIME;)V

    return-void
.end method
