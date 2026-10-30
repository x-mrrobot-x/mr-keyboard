.class Lcom/mrkeyboard/app/ExpandableDictionary$NextWord;
.super Ljava/lang/Object;
.source "ExpandableDictionary.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/ExpandableDictionary;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "NextWord"
.end annotation


# instance fields
.field frequency:I

.field nextWord:Lcom/mrkeyboard/app/ExpandableDictionary$NextWord;

.field word:Lcom/mrkeyboard/app/ExpandableDictionary$Node;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/ExpandableDictionary$Node;I)V
    .locals 0

    .line 87
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 88
    iput-object p1, p0, Lcom/mrkeyboard/app/ExpandableDictionary$NextWord;->word:Lcom/mrkeyboard/app/ExpandableDictionary$Node;

    .line 89
    iput p2, p0, Lcom/mrkeyboard/app/ExpandableDictionary$NextWord;->frequency:I

    return-void
.end method
