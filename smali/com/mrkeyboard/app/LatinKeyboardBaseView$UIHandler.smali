.class Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;
.super Landroid/os/Handler;
.source "LatinKeyboardBaseView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/LatinKeyboardBaseView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "UIHandler"
.end annotation


# static fields
.field private static final MSG_DISMISS_PREVIEW:I = 0x2

.field private static final MSG_LONGPRESS_KEY:I = 0x4

.field private static final MSG_POPUP_PREVIEW:I = 0x1

.field private static final MSG_REPEAT_KEY:I = 0x3


# instance fields
.field private mInKeyRepeat:Z

.field final synthetic this$0:Lcom/mrkeyboard/app/LatinKeyboardBaseView;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/LatinKeyboardBaseView;)V
    .locals 1

    .line 292
    iput-object p1, p0, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->this$0:Lcom/mrkeyboard/app/LatinKeyboardBaseView;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-direct {p0, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    return-void
.end method


# virtual methods
.method public cancelAllMessages()V
    .locals 0

    .line 377
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->cancelKeyTimers()V

    .line 378
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->cancelPopupPreview()V

    .line 379
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->cancelDismissPreview()V

    return-void
.end method

.method public cancelDismissPreview()V
    .locals 1

    const/4 v0, 0x2

    .line 345
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->removeMessages(I)V

    return-void
.end method

.method public cancelKeyRepeatTimer()V
    .locals 1

    const/4 v0, 0x0

    .line 354
    iput-boolean v0, p0, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->mInKeyRepeat:Z

    const/4 v0, 0x3

    .line 355
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->removeMessages(I)V

    return-void
.end method

.method public cancelKeyTimers()V
    .locals 0

    .line 372
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->cancelKeyRepeatTimer()V

    .line 373
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->cancelLongPressTimer()V

    return-void
.end method

.method public cancelLongPressTimer()V
    .locals 1

    const/4 v0, 0x4

    .line 368
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->removeMessages(I)V

    return-void
.end method

.method public cancelPopupPreview()V
    .locals 1

    const/4 v0, 0x1

    .line 335
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->removeMessages(I)V

    return-void
.end method

.method public dismissPreview(J)V
    .locals 1

    .line 339
    iget-object v0, p0, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->this$0:Lcom/mrkeyboard/app/LatinKeyboardBaseView;

    iget-object v0, v0, Lcom/mrkeyboard/app/LatinKeyboardBaseView;->mPreviewPopup:Landroid/widget/PopupWindow;

    invoke-virtual {v0}, Landroid/widget/PopupWindow;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x2

    .line 340
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {p0, v0, p1, p2}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->sendMessageDelayed(Landroid/os/Message;J)Z

    :cond_0
    return-void
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 3

    .line 302
    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    .line 316
    :pswitch_0
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Lcom/mrkeyboard/app/PointerTracker;

    .line 317
    iget-object v1, p0, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->this$0:Lcom/mrkeyboard/app/LatinKeyboardBaseView;

    iget p1, p1, Landroid/os/Message;->arg1:I

    invoke-static {v1, p1, v0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView;->access$200(Lcom/mrkeyboard/app/LatinKeyboardBaseView;ILcom/mrkeyboard/app/PointerTracker;)Z

    goto :goto_0

    .line 310
    :pswitch_1
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Lcom/mrkeyboard/app/PointerTracker;

    .line 311
    iget v1, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/PointerTracker;->repeatKey(I)V

    .line 312
    iget-object v1, p0, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->this$0:Lcom/mrkeyboard/app/LatinKeyboardBaseView;

    invoke-static {v1}, Lcom/mrkeyboard/app/LatinKeyboardBaseView;->access$100(Lcom/mrkeyboard/app/LatinKeyboardBaseView;)I

    move-result v1

    int-to-long v1, v1

    iget p1, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {p0, v1, v2, p1, v0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->startKeyRepeatTimer(JILcom/mrkeyboard/app/PointerTracker;)V

    goto :goto_0

    .line 307
    :pswitch_2
    iget-object p1, p0, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->this$0:Lcom/mrkeyboard/app/LatinKeyboardBaseView;

    iget-object p1, p1, Lcom/mrkeyboard/app/LatinKeyboardBaseView;->mPreviewPopup:Landroid/widget/PopupWindow;

    invoke-virtual {p1}, Landroid/widget/PopupWindow;->dismiss()V

    goto :goto_0

    .line 304
    :pswitch_3
    iget-object v0, p0, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->this$0:Lcom/mrkeyboard/app/LatinKeyboardBaseView;

    iget v1, p1, Landroid/os/Message;->arg1:I

    iget-object p1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast p1, Lcom/mrkeyboard/app/PointerTracker;

    invoke-static {v0, v1, p1}, Lcom/mrkeyboard/app/LatinKeyboardBaseView;->access$000(Lcom/mrkeyboard/app/LatinKeyboardBaseView;ILcom/mrkeyboard/app/PointerTracker;)V

    :goto_0
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public isInKeyRepeat()Z
    .locals 1

    .line 359
    iget-boolean v0, p0, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->mInKeyRepeat:Z

    return v0
.end method

.method public popupPreview(JILcom/mrkeyboard/app/PointerTracker;)V
    .locals 2

    const/4 v0, 0x1

    .line 324
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->removeMessages(I)V

    .line 325
    iget-object v1, p0, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->this$0:Lcom/mrkeyboard/app/LatinKeyboardBaseView;

    iget-object v1, v1, Lcom/mrkeyboard/app/LatinKeyboardBaseView;->mPreviewPopup:Landroid/widget/PopupWindow;

    invoke-virtual {v1}, Landroid/widget/PopupWindow;->isShowing()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->this$0:Lcom/mrkeyboard/app/LatinKeyboardBaseView;

    iget-object v1, v1, Lcom/mrkeyboard/app/LatinKeyboardBaseView;->mPreviewText:Landroid/widget/TextView;

    invoke-virtual {v1}, Landroid/widget/TextView;->getVisibility()I

    move-result v1

    if-nez v1, :cond_0

    .line 327
    iget-object p1, p0, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->this$0:Lcom/mrkeyboard/app/LatinKeyboardBaseView;

    invoke-static {p1, p3, p4}, Lcom/mrkeyboard/app/LatinKeyboardBaseView;->access$000(Lcom/mrkeyboard/app/LatinKeyboardBaseView;ILcom/mrkeyboard/app/PointerTracker;)V

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    .line 329
    invoke-virtual {p0, v0, p3, v1, p4}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->obtainMessage(IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object p3

    invoke-virtual {p0, p3, p1, p2}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->sendMessageDelayed(Landroid/os/Message;J)Z

    :goto_0
    return-void
.end method

.method public startKeyRepeatTimer(JILcom/mrkeyboard/app/PointerTracker;)V
    .locals 2

    const/4 v0, 0x1

    .line 349
    iput-boolean v0, p0, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->mInKeyRepeat:Z

    const/4 v0, 0x3

    const/4 v1, 0x0

    .line 350
    invoke-virtual {p0, v0, p3, v1, p4}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->obtainMessage(IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object p3

    invoke-virtual {p0, p3, p1, p2}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->sendMessageDelayed(Landroid/os/Message;J)Z

    return-void
.end method

.method public startLongPressTimer(JILcom/mrkeyboard/app/PointerTracker;)V
    .locals 2

    const/4 v0, 0x4

    .line 363
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->removeMessages(I)V

    const/4 v1, 0x0

    .line 364
    invoke-virtual {p0, v0, p3, v1, p4}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->obtainMessage(IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object p3

    invoke-virtual {p0, p3, p1, p2}, Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;->sendMessageDelayed(Landroid/os/Message;J)Z

    return-void
.end method
