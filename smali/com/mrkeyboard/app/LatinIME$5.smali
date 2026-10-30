.class synthetic Lcom/mrkeyboard/app/LatinIME$5;
.super Ljava/lang/Object;
.source "LatinIME.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/LatinIME;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1008
    name = null
.end annotation


# static fields
.field static final synthetic $SwitchMap$com$mrkeyboard$app$TextEntryState$State:[I


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 997
    invoke-static {}, Lcom/mrkeyboard/app/TextEntryState$State;->values()[Lcom/mrkeyboard/app/TextEntryState$State;

    move-result-object v0

    array-length v0, v0

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/LatinIME$5;->$SwitchMap$com$mrkeyboard$app$TextEntryState$State:[I

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/LatinIME$5;->$SwitchMap$com$mrkeyboard$app$TextEntryState$State:[I

    sget-object v1, Lcom/mrkeyboard/app/TextEntryState$State;->ACCEPTED_DEFAULT:Lcom/mrkeyboard/app/TextEntryState$State;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/TextEntryState$State;->ordinal()I

    move-result v1

    const/4 v2, 0x1

    aput v2, v0, v1
    :try_end_0
    .catch Ljava/lang/NoSuchFieldError; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-object v0, Lcom/mrkeyboard/app/LatinIME$5;->$SwitchMap$com$mrkeyboard$app$TextEntryState$State:[I

    sget-object v1, Lcom/mrkeyboard/app/TextEntryState$State;->SPACE_AFTER_PICKED:Lcom/mrkeyboard/app/TextEntryState$State;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/TextEntryState$State;->ordinal()I

    move-result v1

    const/4 v2, 0x2

    aput v2, v0, v1
    :try_end_1
    .catch Ljava/lang/NoSuchFieldError; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method
