.class public final enum Lcom/mrkeyboard/app/TextEntryState$State;
.super Ljava/lang/Enum;
.source "TextEntryState.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/TextEntryState;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "State"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/mrkeyboard/app/TextEntryState$State;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/mrkeyboard/app/TextEntryState$State;

.field public static final enum ACCEPTED_DEFAULT:Lcom/mrkeyboard/app/TextEntryState$State;

.field public static final enum CORRECTING:Lcom/mrkeyboard/app/TextEntryState$State;

.field public static final enum IN_WORD:Lcom/mrkeyboard/app/TextEntryState$State;

.field public static final enum PICKED_CORRECTION:Lcom/mrkeyboard/app/TextEntryState$State;

.field public static final enum PICKED_SUGGESTION:Lcom/mrkeyboard/app/TextEntryState$State;

.field public static final enum PUNCTUATION_AFTER_ACCEPTED:Lcom/mrkeyboard/app/TextEntryState$State;

.field public static final enum PUNCTUATION_AFTER_WORD:Lcom/mrkeyboard/app/TextEntryState$State;

.field public static final enum SPACE_AFTER_ACCEPTED:Lcom/mrkeyboard/app/TextEntryState$State;

.field public static final enum SPACE_AFTER_PICKED:Lcom/mrkeyboard/app/TextEntryState$State;

.field public static final enum START:Lcom/mrkeyboard/app/TextEntryState$State;

.field public static final enum UNDO_COMMIT:Lcom/mrkeyboard/app/TextEntryState$State;

.field public static final enum UNKNOWN:Lcom/mrkeyboard/app/TextEntryState$State;


# direct methods
.method static constructor <clinit>()V
    .locals 14

    .line 53
    new-instance v0, Lcom/mrkeyboard/app/TextEntryState$State;

    const-string v1, "UNKNOWN"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/TextEntryState$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/mrkeyboard/app/TextEntryState$State;->UNKNOWN:Lcom/mrkeyboard/app/TextEntryState$State;

    .line 54
    new-instance v0, Lcom/mrkeyboard/app/TextEntryState$State;

    const-string v1, "START"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lcom/mrkeyboard/app/TextEntryState$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/mrkeyboard/app/TextEntryState$State;->START:Lcom/mrkeyboard/app/TextEntryState$State;

    .line 55
    new-instance v0, Lcom/mrkeyboard/app/TextEntryState$State;

    const-string v1, "IN_WORD"

    const/4 v4, 0x2

    invoke-direct {v0, v1, v4}, Lcom/mrkeyboard/app/TextEntryState$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/mrkeyboard/app/TextEntryState$State;->IN_WORD:Lcom/mrkeyboard/app/TextEntryState$State;

    .line 56
    new-instance v0, Lcom/mrkeyboard/app/TextEntryState$State;

    const-string v1, "ACCEPTED_DEFAULT"

    const/4 v5, 0x3

    invoke-direct {v0, v1, v5}, Lcom/mrkeyboard/app/TextEntryState$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/mrkeyboard/app/TextEntryState$State;->ACCEPTED_DEFAULT:Lcom/mrkeyboard/app/TextEntryState$State;

    .line 57
    new-instance v0, Lcom/mrkeyboard/app/TextEntryState$State;

    const-string v1, "PICKED_SUGGESTION"

    const/4 v6, 0x4

    invoke-direct {v0, v1, v6}, Lcom/mrkeyboard/app/TextEntryState$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/mrkeyboard/app/TextEntryState$State;->PICKED_SUGGESTION:Lcom/mrkeyboard/app/TextEntryState$State;

    .line 58
    new-instance v0, Lcom/mrkeyboard/app/TextEntryState$State;

    const-string v1, "PUNCTUATION_AFTER_WORD"

    const/4 v7, 0x5

    invoke-direct {v0, v1, v7}, Lcom/mrkeyboard/app/TextEntryState$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/mrkeyboard/app/TextEntryState$State;->PUNCTUATION_AFTER_WORD:Lcom/mrkeyboard/app/TextEntryState$State;

    .line 59
    new-instance v0, Lcom/mrkeyboard/app/TextEntryState$State;

    const-string v1, "PUNCTUATION_AFTER_ACCEPTED"

    const/4 v8, 0x6

    invoke-direct {v0, v1, v8}, Lcom/mrkeyboard/app/TextEntryState$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/mrkeyboard/app/TextEntryState$State;->PUNCTUATION_AFTER_ACCEPTED:Lcom/mrkeyboard/app/TextEntryState$State;

    .line 60
    new-instance v0, Lcom/mrkeyboard/app/TextEntryState$State;

    const-string v1, "SPACE_AFTER_ACCEPTED"

    const/4 v9, 0x7

    invoke-direct {v0, v1, v9}, Lcom/mrkeyboard/app/TextEntryState$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/mrkeyboard/app/TextEntryState$State;->SPACE_AFTER_ACCEPTED:Lcom/mrkeyboard/app/TextEntryState$State;

    .line 61
    new-instance v0, Lcom/mrkeyboard/app/TextEntryState$State;

    const-string v1, "SPACE_AFTER_PICKED"

    const/16 v10, 0x8

    invoke-direct {v0, v1, v10}, Lcom/mrkeyboard/app/TextEntryState$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/mrkeyboard/app/TextEntryState$State;->SPACE_AFTER_PICKED:Lcom/mrkeyboard/app/TextEntryState$State;

    .line 62
    new-instance v0, Lcom/mrkeyboard/app/TextEntryState$State;

    const-string v1, "UNDO_COMMIT"

    const/16 v11, 0x9

    invoke-direct {v0, v1, v11}, Lcom/mrkeyboard/app/TextEntryState$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/mrkeyboard/app/TextEntryState$State;->UNDO_COMMIT:Lcom/mrkeyboard/app/TextEntryState$State;

    .line 63
    new-instance v0, Lcom/mrkeyboard/app/TextEntryState$State;

    const-string v1, "CORRECTING"

    const/16 v12, 0xa

    invoke-direct {v0, v1, v12}, Lcom/mrkeyboard/app/TextEntryState$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/mrkeyboard/app/TextEntryState$State;->CORRECTING:Lcom/mrkeyboard/app/TextEntryState$State;

    .line 64
    new-instance v0, Lcom/mrkeyboard/app/TextEntryState$State;

    const-string v1, "PICKED_CORRECTION"

    const/16 v13, 0xb

    invoke-direct {v0, v1, v13}, Lcom/mrkeyboard/app/TextEntryState$State;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/mrkeyboard/app/TextEntryState$State;->PICKED_CORRECTION:Lcom/mrkeyboard/app/TextEntryState$State;

    const/16 v0, 0xc

    .line 52
    new-array v0, v0, [Lcom/mrkeyboard/app/TextEntryState$State;

    sget-object v1, Lcom/mrkeyboard/app/TextEntryState$State;->UNKNOWN:Lcom/mrkeyboard/app/TextEntryState$State;

    aput-object v1, v0, v2

    sget-object v1, Lcom/mrkeyboard/app/TextEntryState$State;->START:Lcom/mrkeyboard/app/TextEntryState$State;

    aput-object v1, v0, v3

    sget-object v1, Lcom/mrkeyboard/app/TextEntryState$State;->IN_WORD:Lcom/mrkeyboard/app/TextEntryState$State;

    aput-object v1, v0, v4

    sget-object v1, Lcom/mrkeyboard/app/TextEntryState$State;->ACCEPTED_DEFAULT:Lcom/mrkeyboard/app/TextEntryState$State;

    aput-object v1, v0, v5

    sget-object v1, Lcom/mrkeyboard/app/TextEntryState$State;->PICKED_SUGGESTION:Lcom/mrkeyboard/app/TextEntryState$State;

    aput-object v1, v0, v6

    sget-object v1, Lcom/mrkeyboard/app/TextEntryState$State;->PUNCTUATION_AFTER_WORD:Lcom/mrkeyboard/app/TextEntryState$State;

    aput-object v1, v0, v7

    sget-object v1, Lcom/mrkeyboard/app/TextEntryState$State;->PUNCTUATION_AFTER_ACCEPTED:Lcom/mrkeyboard/app/TextEntryState$State;

    aput-object v1, v0, v8

    sget-object v1, Lcom/mrkeyboard/app/TextEntryState$State;->SPACE_AFTER_ACCEPTED:Lcom/mrkeyboard/app/TextEntryState$State;

    aput-object v1, v0, v9

    sget-object v1, Lcom/mrkeyboard/app/TextEntryState$State;->SPACE_AFTER_PICKED:Lcom/mrkeyboard/app/TextEntryState$State;

    aput-object v1, v0, v10

    sget-object v1, Lcom/mrkeyboard/app/TextEntryState$State;->UNDO_COMMIT:Lcom/mrkeyboard/app/TextEntryState$State;

    aput-object v1, v0, v11

    sget-object v1, Lcom/mrkeyboard/app/TextEntryState$State;->CORRECTING:Lcom/mrkeyboard/app/TextEntryState$State;

    aput-object v1, v0, v12

    sget-object v1, Lcom/mrkeyboard/app/TextEntryState$State;->PICKED_CORRECTION:Lcom/mrkeyboard/app/TextEntryState$State;

    aput-object v1, v0, v13

    sput-object v0, Lcom/mrkeyboard/app/TextEntryState$State;->$VALUES:[Lcom/mrkeyboard/app/TextEntryState$State;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 52
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/mrkeyboard/app/TextEntryState$State;
    .locals 1

    .line 52
    const-class v0, Lcom/mrkeyboard/app/TextEntryState$State;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/mrkeyboard/app/TextEntryState$State;

    return-object p0
.end method

.method public static values()[Lcom/mrkeyboard/app/TextEntryState$State;
    .locals 1

    .line 52
    sget-object v0, Lcom/mrkeyboard/app/TextEntryState$State;->$VALUES:[Lcom/mrkeyboard/app/TextEntryState$State;

    invoke-virtual {v0}, [Lcom/mrkeyboard/app/TextEntryState$State;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/mrkeyboard/app/TextEntryState$State;

    return-object v0
.end method
