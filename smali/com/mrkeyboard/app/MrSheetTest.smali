.class public final Lcom/mrkeyboard/app/MrSheetTest;
.super Ljava/lang/Object;
.source "MrSheetTest.java"


# static fields
.field static final PREFIX:Ljava/lang/String; = "com.mrkeyboard.app.sheet="


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static holds(Lcom/mrkeyboard/app/LatinIME;)Z
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 67
    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v1

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/MrSheetTest;->position(Landroid/content/Context;Landroid/view/inputmethod/EditorInfo;)I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    if-lez v1, :cond_0

    const/4 v0, 0x1

    .line 69
    :cond_0
    :goto_0
    return v0

    .line 68
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static option(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 25
    if-nez p0, :cond_0

    const-string v0, "com.mrkeyboard.app.sheet="

    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "com.mrkeyboard.app.sheet="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method static position(Landroid/content/Context;Landroid/view/inputmethod/EditorInfo;)I
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 43
    if-nez p0, :cond_1

    .line 47
    :cond_0
    :goto_0
    return v0

    .line 44
    :cond_1
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v1}, Lcom/mrkeyboard/app/MrSheetTest;->sheetId(Landroid/view/inputmethod/EditorInfo;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 45
    if-eqz v1, :cond_0

    .line 46
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/SheetStore;->findSheetIndexById(Landroid/content/Context;Ljava/lang/String;)I

    move-result v1

    .line 47
    if-ltz v1, :cond_0

    add-int/lit8 v0, v1, 0x1

    goto :goto_0
.end method

.method static sheetId(Landroid/view/inputmethod/EditorInfo;Ljava/lang/String;)Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 30
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    iget-object v0, p0, Landroid/view/inputmethod/EditorInfo;->packageName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Landroid/view/inputmethod/EditorInfo;->privateImeOptions:Ljava/lang/String;

    if-nez v0, :cond_1

    .line 38
    :cond_0
    :goto_0
    return-object v1

    .line 31
    :cond_1
    iget-object v0, p0, Landroid/view/inputmethod/EditorInfo;->privateImeOptions:Ljava/lang/String;

    const-string v2, ","

    invoke-virtual {v0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    .line 32
    const/4 v0, 0x0

    :goto_1
    array-length v3, v2

    if-ge v0, v3, :cond_0

    .line 33
    aget-object v3, v2, v0

    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    .line 34
    const-string v4, "com.mrkeyboard.app.sheet="

    invoke-virtual {v3, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_2

    .line 32
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 35
    :cond_2
    const-string v0, "com.mrkeyboard.app.sheet="

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {v3, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 36
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_3

    move-object v0, v1

    :cond_3
    move-object v1, v0

    goto :goto_0
.end method

.method public static show(Lcom/mrkeyboard/app/LatinIME;)V
    .locals 2

    .prologue
    .line 53
    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getCurrentInputEditorInfo()Landroid/view/inputmethod/EditorInfo;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrSheetTest;->position(Landroid/content/Context;Landroid/view/inputmethod/EditorInfo;)I

    move-result v0

    .line 54
    if-gtz v0, :cond_1

    .line 62
    :cond_0
    :goto_0
    return-void

    .line 55
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getInstance()Lcom/mrkeyboard/app/KeyboardSwitcher;

    move-result-object v1

    .line 56
    if-eqz v1, :cond_2

    invoke-virtual {v1}, Lcom/mrkeyboard/app/KeyboardSwitcher;->getSheet()I

    move-result v1

    if-eq v1, v0, :cond_0

    .line 58
    :cond_2
    add-int/lit8 v0, v0, 0x1

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/LatinIME;->changeSheet(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 59
    :catch_0
    move-exception v0

    goto :goto_0
.end method
