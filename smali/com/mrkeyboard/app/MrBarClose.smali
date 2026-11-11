.class final Lcom/mrkeyboard/app/MrBarClose;
.super Ljava/lang/Object;
.source "MrBarClose.java"


# static fields
.field static final AI:I = 0x18

.field static final TOOLBAR:[I

.field static final TUNE:I = 0x13


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 16
    const/16 v0, 0x8

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/mrkeyboard/app/MrBarClose;->TOOLBAR:[I

    return-void

    :array_0
    .array-data 4
        0x0
        0x1
        0x8
        0x13
        0x14
        0x15
        0x18
        0x19
    .end array-data
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static isToolbar(I)Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 23
    move v0, v1

    :goto_0
    sget-object v2, Lcom/mrkeyboard/app/MrBarClose;->TOOLBAR:[I

    array-length v2, v2

    if-ge v0, v2, :cond_0

    .line 24
    sget-object v2, Lcom/mrkeyboard/app/MrBarClose;->TOOLBAR:[I

    aget v2, v2, v0

    if-ne v2, p0, :cond_1

    const/4 v1, 0x1

    .line 26
    :cond_0
    return v1

    .line 23
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method static onClick(I)V
    .locals 1

    .prologue
    .line 31
    invoke-static {p0}, Lcom/mrkeyboard/app/MrBarClose;->isToolbar(I)Z

    move-result v0

    if-nez v0, :cond_1

    .line 38
    :cond_0
    :goto_0
    return-void

    .line 33
    :cond_1
    const/16 v0, 0x18

    if-eq p0, v0, :cond_2

    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->dismiss()V

    .line 34
    :cond_2
    const/16 v0, 0x13

    if-eq p0, v0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrTune;->dismissDialog()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 35
    :catch_0
    move-exception v0

    goto :goto_0
.end method
