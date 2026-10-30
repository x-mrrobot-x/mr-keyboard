.class public Lcom/mrkeyboard/app/LatinIME$TypedWordAlternatives;
.super Lcom/mrkeyboard/app/LatinIME$WordAlternatives;
.source "LatinIME.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/LatinIME;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "TypedWordAlternatives"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/LatinIME;

.field private word:Lcom/mrkeyboard/app/WordComposer;


# direct methods
.method public constructor <init>(Lcom/mrkeyboard/app/LatinIME;)V
    .locals 0

    .line 318
    iput-object p1, p0, Lcom/mrkeyboard/app/LatinIME$TypedWordAlternatives;->this$0:Lcom/mrkeyboard/app/LatinIME;

    invoke-direct {p0}, Lcom/mrkeyboard/app/LatinIME$WordAlternatives;-><init>()V

    return-void
.end method

.method public constructor <init>(Lcom/mrkeyboard/app/LatinIME;Ljava/lang/CharSequence;Lcom/mrkeyboard/app/WordComposer;)V
    .locals 0

    .line 323
    iput-object p1, p0, Lcom/mrkeyboard/app/LatinIME$TypedWordAlternatives;->this$0:Lcom/mrkeyboard/app/LatinIME;

    .line 324
    invoke-direct {p0, p2}, Lcom/mrkeyboard/app/LatinIME$WordAlternatives;-><init>(Ljava/lang/CharSequence;)V

    .line 325
    iput-object p3, p0, Lcom/mrkeyboard/app/LatinIME$TypedWordAlternatives;->word:Lcom/mrkeyboard/app/WordComposer;

    return-void
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/LatinIME$TypedWordAlternatives;)Lcom/mrkeyboard/app/WordComposer;
    .locals 0

    .line 315
    iget-object p0, p0, Lcom/mrkeyboard/app/LatinIME$TypedWordAlternatives;->word:Lcom/mrkeyboard/app/WordComposer;

    return-object p0
.end method


# virtual methods
.method public getAlternatives()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/CharSequence;",
            ">;"
        }
    .end annotation

    .line 335
    iget-object v0, p0, Lcom/mrkeyboard/app/LatinIME$TypedWordAlternatives;->this$0:Lcom/mrkeyboard/app/LatinIME;

    iget-object v1, p0, Lcom/mrkeyboard/app/LatinIME$TypedWordAlternatives;->word:Lcom/mrkeyboard/app/WordComposer;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/LatinIME;->access$000(Lcom/mrkeyboard/app/LatinIME;Lcom/mrkeyboard/app/WordComposer;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getOriginalWord()Ljava/lang/CharSequence;
    .locals 1

    .line 330
    iget-object v0, p0, Lcom/mrkeyboard/app/LatinIME$TypedWordAlternatives;->word:Lcom/mrkeyboard/app/WordComposer;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/WordComposer;->getTypedWord()Ljava/lang/CharSequence;

    move-result-object v0

    return-object v0
.end method
