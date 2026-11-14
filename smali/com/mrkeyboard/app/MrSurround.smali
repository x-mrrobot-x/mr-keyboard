.class public final Lcom/mrkeyboard/app/MrSurround;
.super Ljava/lang/Object;
.source "MrSurround.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrSurround$Api31;
    }
.end annotation


# static fields
.field public static final END:I = -0x1

.field public static final NONE:I = -0x2

.field private static sBefore:Ljava/lang/CharSequence;

.field private static sUnsupported:Z


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$002(Z)Z
    .locals 0

    .prologue
    .line 22
    sput-boolean p0, Lcom/mrkeyboard/app/MrSurround;->sUnsupported:Z

    return p0
.end method

.method static synthetic access$102(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;
    .locals 0

    .prologue
    .line 22
    sput-object p0, Lcom/mrkeyboard/app/MrSurround;->sBefore:Ljava/lang/CharSequence;

    return-object p0
.end method

.method public static clear()V
    .locals 1

    .prologue
    .line 81
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrSurround;->sBefore:Ljava/lang/CharSequence;

    .line 82
    return-void
.end method

.method public static echo(Landroid/view/inputmethod/InputConnection;)I
    .locals 2

    .prologue
    .line 38
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrSurround;->sBefore:Ljava/lang/CharSequence;

    .line 39
    if-eqz p0, :cond_0

    sget-boolean v0, Lcom/mrkeyboard/app/MrSurround;->sUnsupported:Z

    if-nez v0, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1f

    if-ge v0, v1, :cond_1

    :cond_0
    const/4 v0, -0x2

    .line 40
    :goto_0
    return v0

    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrSurround$Api31;->echo(Landroid/view/inputmethod/InputConnection;)I

    move-result v0

    goto :goto_0
.end method

.method public static fieldChanged()V
    .locals 1

    .prologue
    .line 86
    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrSurround;->sBefore:Ljava/lang/CharSequence;

    .line 87
    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrSurround;->sUnsupported:Z

    .line 88
    return-void
.end method

.method public static takeBefore()Ljava/lang/CharSequence;
    .locals 2

    .prologue
    .line 74
    sget-object v0, Lcom/mrkeyboard/app/MrSurround;->sBefore:Ljava/lang/CharSequence;

    .line 75
    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrSurround;->sBefore:Ljava/lang/CharSequence;

    .line 76
    return-object v0
.end method
