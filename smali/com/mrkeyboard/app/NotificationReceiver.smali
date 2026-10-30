.class public Lcom/mrkeyboard/app/NotificationReceiver;
.super Landroid/content/BroadcastReceiver;
.source "NotificationReceiver.java"


# static fields
.field public static final ACTION_SHOW:Ljava/lang/String; = "com.mrkeyboard.app.SHOW"

.field static final TAG:Ljava/lang/String; = "PCKeyboard/Notification"


# instance fields
.field private final mIME:Lcom/mrkeyboard/app/LatinIME;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/LatinIME;)V
    .registers 3

    .line 15
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    .line 16
    iput-object p1, p0, Lcom/mrkeyboard/app/NotificationReceiver;->mIME:Lcom/mrkeyboard/app/LatinIME;

    .line 17
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "NotificationReceiver created, ime="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget-object v0, p0, Lcom/mrkeyboard/app/NotificationReceiver;->mIME:Lcom/mrkeyboard/app/LatinIME;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "PCKeyboard/Notification"

    invoke-static {v0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 18
    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 5

    .line 22
    if-nez p2, :cond_3

    .line 23
    return-void

    .line 25
    :cond_3
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p2

    .line 26
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "NotificationReceiver.onReceive called, action="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "PCKeyboard/Notification"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 27
    const-string v0, "com.mrkeyboard.app.SHOW"

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_3b

    .line 28
    const-string p2, "input_method"

    invoke-virtual {p1, p2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/inputmethod/InputMethodManager;

    .line 29
    if-eqz p1, :cond_3b

    iget-object p1, p0, Lcom/mrkeyboard/app/NotificationReceiver;->mIME:Lcom/mrkeyboard/app/LatinIME;

    if-eqz p1, :cond_3b

    .line 30
    iget-object p1, p0, Lcom/mrkeyboard/app/NotificationReceiver;->mIME:Lcom/mrkeyboard/app/LatinIME;

    const/4 p2, 0x2

    invoke-virtual {p1, p2}, Lcom/mrkeyboard/app/LatinIME;->requestShowSelf(I)V

    .line 33
    :cond_3b
    return-void
.end method
