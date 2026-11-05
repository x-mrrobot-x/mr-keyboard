.class final Lcom/mrkeyboard/app/MrAiDialog$Retry;
.super Ljava/lang/Object;
.source "MrAiDialog.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrAiDialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Retry"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 155
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/mrkeyboard/app/MrAiDialog$1;)V
    .locals 0

    .prologue
    .line 155
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAiDialog$Retry;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 0

    .prologue
    .line 157
    invoke-static {}, Lcom/mrkeyboard/app/MrAiDialog;->retryKeyboard()V

    .line 158
    return-void
.end method
