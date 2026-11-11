.class final Lcom/mrkeyboard/app/MrTranslucentBlur;

.super Ljava/lang/Object;

.source "MrTranslucentBlur.java"

.method static apply(Landroid/inputmethodservice/InputMethodService;Z)Z
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0}, Landroid/inputmethodservice/InputMethodService;->getWindow()Landroid/app/Dialog;

    move-result-object v1

    if-nez v1, :cond_0

    return v0

    :cond_0
    invoke-virtual {v1}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    if-nez v1, :cond_1

    return v0

    :cond_1
    if-nez p1, :cond_2

    invoke-virtual {v1, v0}, Landroid/view/Window;->setBackgroundBlurRadius(I)V

    return v0

    :cond_2
    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->isAttachedToWindow()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-virtual {v2}, Landroid/view/View;->isHardwareAccelerated()Z

    move-result v2

    if-eqz v2, :cond_4

    goto :goto_0

    :cond_3
    invoke-virtual {v1}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v2

    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->flags:I

    const/high16 v3, 0x1000000

    and-int/2addr v2, v3

    if-nez v2, :cond_5

    :cond_4
    invoke-virtual {v1, v0}, Landroid/view/Window;->setBackgroundBlurRadius(I)V

    return v0

    :cond_5
    :goto_0
    const-string v2, "window"

    invoke-virtual {p0, v2}, Landroid/inputmethodservice/InputMethodService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/view/WindowManager;

    invoke-interface {v2}, Landroid/view/WindowManager;->isCrossWindowBlurEnabled()Z

    move-result v2

    if-nez v2, :cond_6

    invoke-virtual {v1, v0}, Landroid/view/Window;->setBackgroundBlurRadius(I)V

    return v0

    :cond_6
    invoke-virtual {p0}, Landroid/inputmethodservice/InputMethodService;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    iget v2, v2, Landroid/util/DisplayMetrics;->density:F

    const/high16 v3, 0x41600000    # 14.0f

    mul-float/2addr v2, v3

    const/high16 v3, 0x3f000000    # 0.5f

    add-float/2addr v2, v3

    float-to-int v3, v2

    invoke-virtual {v1, v3}, Landroid/view/Window;->setBackgroundBlurRadius(I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v0, 0x1

    return v0

    :catchall_0
    move-exception v1

    const/4 v0, 0x0

    return v0
.end method
