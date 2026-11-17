.class final Lcom/mrkeyboard/app/MrScreenIme$Show;
.super Ljava/lang/Object;
.source "MrScreenIme.java"

# interfaces
.implements Ljava/lang/Runnable;
.implements Landroid/view/ViewTreeObserver$OnWindowFocusChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrScreenIme;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Show"
.end annotation


# instance fields
.field private final mField:Landroid/widget/EditText;


# direct methods
.method constructor <init>(Landroid/widget/EditText;)V
    .locals 0

    .prologue
    .line 93
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 94
    iput-object p1, p0, Lcom/mrkeyboard/app/MrScreenIme$Show;->mField:Landroid/widget/EditText;

    .line 95
    return-void
.end method


# virtual methods
.method arm()V
    .locals 1

    .prologue
    .line 98
    iget-object v0, p0, Lcom/mrkeyboard/app/MrScreenIme$Show;->mField:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->hasWindowFocus()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrScreenIme$Show;->mField:Landroid/widget/EditText;

    invoke-virtual {v0, p0}, Landroid/widget/EditText;->post(Ljava/lang/Runnable;)Z

    .line 100
    :goto_0
    return-void

    .line 99
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrScreenIme$Show;->mField:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/ViewTreeObserver;->addOnWindowFocusChangeListener(Landroid/view/ViewTreeObserver$OnWindowFocusChangeListener;)V

    goto :goto_0
.end method

.method public onWindowFocusChanged(Z)V
    .locals 2

    .prologue
    .line 103
    if-nez p1, :cond_0

    .line 108
    :goto_0
    return-void

    .line 104
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrScreenIme$Show;->mField:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v0

    .line 105
    invoke-virtual {v0}, Landroid/view/ViewTreeObserver;->isAlive()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {v0, p0}, Landroid/view/ViewTreeObserver;->removeOnWindowFocusChangeListener(Landroid/view/ViewTreeObserver$OnWindowFocusChangeListener;)V

    .line 107
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrScreenIme$Show;->mField:Landroid/widget/EditText;

    invoke-virtual {v0, p0}, Landroid/widget/EditText;->post(Ljava/lang/Runnable;)Z

    goto :goto_0
.end method

.method public run()V
    .locals 3

    .prologue
    .line 112
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrScreenIme$Show;->mField:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->requestFocus()Z

    .line 113
    iget-object v0, p0, Lcom/mrkeyboard/app/MrScreenIme$Show;->mField:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "input_method"

    .line 114
    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/inputmethod/InputMethodManager;

    .line 115
    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrScreenIme$Show;->mField:Landroid/widget/EditText;

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/view/inputmethod/InputMethodManager;->showSoftInput(Landroid/view/View;I)Z
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 119
    :cond_0
    :goto_0
    return-void

    .line 116
    :catch_0
    move-exception v0

    goto :goto_0
.end method
