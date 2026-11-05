.class public final Lcom/mrkeyboard/app/MrNav;
.super Ljava/lang/Object;
.source "MrNav.java"


# static fields
.field static final FROM_KEYBOARD:I = 0x10020000

.field static final REUSE:I = 0x20000


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static intent(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/Class",
            "<*>;)",
            "Landroid/content/Intent;"
        }
    .end annotation

    .prologue
    .line 32
    new-instance v1, Landroid/content/Intent;

    invoke-direct {v1, p0, p1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 33
    instance-of v0, p0, Landroid/app/Activity;

    if-eqz v0, :cond_0

    const/high16 v0, 0x20000

    :goto_0
    invoke-virtual {v1, v0}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 34
    return-object v1

    .line 33
    :cond_0
    const/high16 v0, 0x10020000

    goto :goto_0
.end method
