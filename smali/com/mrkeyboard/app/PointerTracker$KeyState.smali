.class Lcom/mrkeyboard/app/PointerTracker$KeyState;
.super Ljava/lang/Object;
.source "PointerTracker.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/PointerTracker;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "KeyState"
.end annotation


# instance fields
.field private mDownTime:J

.field private final mKeyDetector:Lcom/mrkeyboard/app/KeyDetector;

.field private mKeyIndex:I

.field private mKeyX:I

.field private mKeyY:I

.field private mLastX:I

.field private mLastY:I

.field private mStartX:I

.field private mStartY:I


# direct methods
.method public constructor <init>(Lcom/mrkeyboard/app/KeyDetector;)V
    .locals 1

    .line 107
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    .line 98
    iput v0, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mKeyIndex:I

    .line 108
    iput-object p1, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mKeyDetector:Lcom/mrkeyboard/app/KeyDetector;

    return-void
.end method

.method private onMoveKeyInternal(II)I
    .locals 2

    .line 152
    iput p1, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mLastX:I

    .line 153
    iput p2, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mLastY:I

    .line 154
    iget-object v0, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mKeyDetector:Lcom/mrkeyboard/app/KeyDetector;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, p2, v1}, Lcom/mrkeyboard/app/KeyDetector;->getKeyIndexAndNearbyCodes(II[I)I

    move-result p1

    return p1
.end method


# virtual methods
.method public getDownTime()J
    .locals 2

    .line 132
    iget-wide v0, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mDownTime:J

    return-wide v0
.end method

.method public getKeyIndex()I
    .locals 1

    .line 112
    iget v0, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mKeyIndex:I

    return v0
.end method

.method public getKeyX()I
    .locals 1

    .line 116
    iget v0, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mKeyX:I

    return v0
.end method

.method public getKeyY()I
    .locals 1

    .line 120
    iget v0, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mKeyY:I

    return v0
.end method

.method public getLastX()I
    .locals 1

    .line 136
    iget v0, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mLastX:I

    return v0
.end method

.method public getLastY()I
    .locals 1

    .line 140
    iget v0, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mLastY:I

    return v0
.end method

.method public getStartX()I
    .locals 1

    .line 124
    iget v0, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mStartX:I

    return v0
.end method

.method public getStartY()I
    .locals 1

    .line 128
    iget v0, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mStartY:I

    return v0
.end method

.method public onDownKey(IIJ)I
    .locals 0

    .line 144
    iput p1, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mStartX:I

    .line 145
    iput p2, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mStartY:I

    .line 146
    iput-wide p3, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mDownTime:J

    .line 148
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PointerTracker$KeyState;->onMoveKeyInternal(II)I

    move-result p3

    invoke-virtual {p0, p3, p1, p2}, Lcom/mrkeyboard/app/PointerTracker$KeyState;->onMoveToNewKey(III)I

    move-result p1

    return p1
.end method

.method public onMoveKey(II)I
    .locals 0

    .line 158
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PointerTracker$KeyState;->onMoveKeyInternal(II)I

    move-result p1

    return p1
.end method

.method public onMoveToNewKey(III)I
    .locals 0

    .line 162
    iput p1, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mKeyIndex:I

    .line 163
    iput p2, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mKeyX:I

    .line 164
    iput p3, p0, Lcom/mrkeyboard/app/PointerTracker$KeyState;->mKeyY:I

    return p1
.end method

.method public onUpKey(II)I
    .locals 0

    .line 169
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PointerTracker$KeyState;->onMoveKeyInternal(II)I

    move-result p1

    return p1
.end method
