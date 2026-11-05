.class public final Lcom/mrkeyboard/app/MrLearned;
.super Ljava/lang/Object;
.source "MrLearned.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrLearned$Sink;,
        Lcom/mrkeyboard/app/MrLearned$Gate;,
        Lcom/mrkeyboard/app/MrLearned$Result;
    }
.end annotation


# static fields
.field static final COMPLETE_MIN_FREQ:I = 0x6

.field public static final IMPORT_MAX_PAIRS:I = 0x7530

.field public static final IMPORT_MAX_WORDS:I = 0x4e20

.field static final LEARNED_FREQ_FULL:I = 0xfa

.field static final LEARNED_FREQ_MIN_EXPORT:I = 0x6

.field static final LEARNED_PAIR_MIN_EXPORT:I = 0xc

.field static final PAIR_FREQ_MAX:I = 0x9

.field static final PAIR_FREQ_MIN:I = 0x4

.field static final WORD_FREQ_AT_50:I = 0x82

.field static final WORD_FREQ_MAX:I = 0xfa

.field static final WORD_FREQ_MIN:I = 0x6

.field private static volatile sBlocked:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final sGate:Lcom/mrkeyboard/app/MrLearned$Gate;

.field private static sStore:Lcom/mrkeyboard/app/MrWordStore;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 60
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrLearned;->sBlocked:Ljava/util/HashSet;

    .line 153
    new-instance v0, Lcom/mrkeyboard/app/MrLearned$Gate;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrLearned$Gate;-><init>(Lcom/mrkeyboard/app/MrLearned$1;)V

    sput-object v0, Lcom/mrkeyboard/app/MrLearned;->sGate:Lcom/mrkeyboard/app/MrLearned$Gate;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static apply(Lcom/mrkeyboard/app/MrWordStore;Lcom/mrkeyboard/app/MrImport$Plan;Ljava/lang/String;J)Lcom/mrkeyboard/app/MrLearned$Result;
    .locals 1

    .prologue
    .line 225
    invoke-interface {p0}, Lcom/mrkeyboard/app/MrWordStore;->begin()V

    .line 227
    :try_start_0
    invoke-static {p0, p1, p2, p3, p4}, Lcom/mrkeyboard/app/MrLearned;->applyIn(Lcom/mrkeyboard/app/MrWordStore;Lcom/mrkeyboard/app/MrImport$Plan;Ljava/lang/String;J)Lcom/mrkeyboard/app/MrLearned$Result;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 229
    invoke-interface {p0}, Lcom/mrkeyboard/app/MrWordStore;->end()V

    .line 227
    return-object v0

    .line 229
    :catchall_0
    move-exception v0

    invoke-interface {p0}, Lcom/mrkeyboard/app/MrWordStore;->end()V

    .line 230
    throw v0
.end method

.method private static applyIn(Lcom/mrkeyboard/app/MrWordStore;Lcom/mrkeyboard/app/MrImport$Plan;Ljava/lang/String;J)Lcom/mrkeyboard/app/MrLearned$Result;
    .locals 23

    .prologue
    .line 234
    new-instance v14, Lcom/mrkeyboard/app/MrLearned$Result;

    invoke-direct {v14}, Lcom/mrkeyboard/app/MrLearned$Result;-><init>()V

    .line 235
    new-instance v15, Ljava/util/HashSet;

    invoke-direct {v15}, Ljava/util/HashSet;-><init>()V

    .line 236
    const/4 v4, 0x2

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-interface {v0, v4, v1}, Lcom/mrkeyboard/app/MrWordStore;->all(ILjava/lang/String;)Ljava/util/List;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mrkeyboard/app/MrWordStore$Row;

    iget-object v4, v4, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    invoke-virtual {v15, v4}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 237
    :cond_0
    new-instance v16, Ljava/util/HashSet;

    invoke-direct/range {v16 .. v16}, Ljava/util/HashSet;-><init>()V

    .line 238
    const/4 v4, 0x3

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-interface {v0, v4, v1}, Lcom/mrkeyboard/app/MrWordStore;->all(ILjava/lang/String;)Ljava/util/List;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mrkeyboard/app/MrWordStore$Row;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v7, v4, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "\u0000"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v4, v4, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, v16

    invoke-virtual {v0, v4}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 239
    :cond_1
    new-instance v17, Ljava/util/HashSet;

    invoke-direct/range {v17 .. v17}, Ljava/util/HashSet;-><init>()V

    .line 240
    const/4 v4, 0x4

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-interface {v0, v4, v1}, Lcom/mrkeyboard/app/MrWordStore;->all(ILjava/lang/String;)Ljava/util/List;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_2
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mrkeyboard/app/MrWordStore$Row;

    iget-object v4, v4, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    invoke-static {v4}, Lcom/mrkeyboard/app/MrLearned;->key(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, v17

    invoke-virtual {v0, v4}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 241
    :cond_2
    new-instance v18, Ljava/util/HashSet;

    invoke-direct/range {v18 .. v18}, Ljava/util/HashSet;-><init>()V

    .line 242
    move-object/from16 v0, p1

    iget-object v4, v0, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :cond_3
    :goto_3
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_4

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mrkeyboard/app/MrImport$NewWord;

    iget-boolean v6, v4, Lcom/mrkeyboard/app/MrImport$NewWord;->checked:Z

    if-nez v6, :cond_3

    iget-object v4, v4, Lcom/mrkeyboard/app/MrImport$NewWord;->word:Ljava/lang/String;

    move-object/from16 v0, v18

    invoke-virtual {v0, v4}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    goto :goto_3

    .line 243
    :cond_4
    invoke-virtual {v15}, Ljava/util/HashSet;->size()I

    move-result v19

    .line 244
    invoke-virtual/range {v16 .. v16}, Ljava/util/HashSet;->size()I

    move-result v20

    .line 245
    const-wide/16 v10, 0x0

    .line 246
    move-object/from16 v0, p1

    iget-object v4, v0, Lcom/mrkeyboard/app/MrImport$Plan;->words:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v21

    :cond_5
    :goto_4
    invoke-interface/range {v21 .. v21}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_a

    invoke-interface/range {v21 .. v21}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mrkeyboard/app/MrImport$NewWord;

    .line 247
    iget-boolean v5, v4, Lcom/mrkeyboard/app/MrImport$NewWord;->checked:Z

    if-eqz v5, :cond_5

    .line 248
    iget-object v5, v4, Lcom/mrkeyboard/app/MrImport$NewWord;->word:Ljava/lang/String;

    invoke-static {v5}, Lcom/mrkeyboard/app/MrLearned;->key(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v17

    invoke-virtual {v0, v5}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_6

    .line 249
    iget v4, v14, Lcom/mrkeyboard/app/MrLearned$Result;->blockedSkipped:I

    add-int/lit8 v4, v4, 0x1

    iput v4, v14, Lcom/mrkeyboard/app/MrLearned$Result;->blockedSkipped:I

    goto :goto_4

    .line 252
    :cond_6
    iget-object v5, v4, Lcom/mrkeyboard/app/MrImport$NewWord;->word:Ljava/lang/String;

    invoke-virtual {v15, v5}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_7

    .line 253
    iget v4, v14, Lcom/mrkeyboard/app/MrLearned$Result;->dupWords:I

    add-int/lit8 v4, v4, 0x1

    iput v4, v14, Lcom/mrkeyboard/app/MrLearned$Result;->dupWords:I

    goto :goto_4

    .line 256
    :cond_7
    iget v5, v14, Lcom/mrkeyboard/app/MrLearned$Result;->words:I

    add-int v5, v5, v19

    const/16 v6, 0x4e20

    if-lt v5, v6, :cond_8

    .line 257
    iget v4, v14, Lcom/mrkeyboard/app/MrLearned$Result;->cappedWords:I

    add-int/lit8 v4, v4, 0x1

    iput v4, v14, Lcom/mrkeyboard/app/MrLearned$Result;->cappedWords:I

    goto :goto_4

    .line 260
    :cond_8
    const-wide/16 v6, 0x0

    cmp-long v5, v10, v6

    if-nez v5, :cond_9

    invoke-interface/range {p0 .. p0}, Lcom/mrkeyboard/app/MrWordStore;->newBatch()J

    move-result-wide v10

    .line 261
    :cond_9
    const/16 v22, 0x2

    new-instance v5, Lcom/mrkeyboard/app/MrWordStore$Row;

    const/4 v6, 0x2

    iget-object v7, v4, Lcom/mrkeyboard/app/MrImport$NewWord;->word:Ljava/lang/String;

    const/4 v8, 0x0

    iget v9, v4, Lcom/mrkeyboard/app/MrImport$NewWord;->weight:I

    invoke-static {v9}, Lcom/mrkeyboard/app/MrLearned;->clampWeight(I)I

    move-result v9

    move-wide/from16 v12, p3

    invoke-direct/range {v5 .. v13}, Lcom/mrkeyboard/app/MrWordStore$Row;-><init>(ILjava/lang/String;Ljava/lang/String;IJJ)V

    move-object/from16 v0, p0

    move/from16 v1, v22

    move-object/from16 v2, p2

    invoke-interface {v0, v1, v2, v5}, Lcom/mrkeyboard/app/MrWordStore;->add(ILjava/lang/String;Lcom/mrkeyboard/app/MrWordStore$Row;)J

    .line 262
    iget-object v4, v4, Lcom/mrkeyboard/app/MrImport$NewWord;->word:Ljava/lang/String;

    invoke-virtual {v15, v4}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 263
    iget v4, v14, Lcom/mrkeyboard/app/MrLearned$Result;->words:I

    add-int/lit8 v4, v4, 0x1

    iput v4, v14, Lcom/mrkeyboard/app/MrLearned$Result;->words:I

    goto :goto_4

    .line 265
    :cond_a
    move-object/from16 v0, p1

    iget-object v4, v0, Lcom/mrkeyboard/app/MrImport$Plan;->pairs:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v15

    :cond_b
    :goto_5
    invoke-interface {v15}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_11

    invoke-interface {v15}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mrkeyboard/app/MrImport$NewPair;

    .line 266
    iget-object v5, v4, Lcom/mrkeyboard/app/MrImport$NewPair;->a:Ljava/lang/String;

    move-object/from16 v0, v18

    invoke-virtual {v0, v5}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_b

    iget-object v5, v4, Lcom/mrkeyboard/app/MrImport$NewPair;->b:Ljava/lang/String;

    move-object/from16 v0, v18

    invoke-virtual {v0, v5}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_b

    .line 267
    iget-object v5, v4, Lcom/mrkeyboard/app/MrImport$NewPair;->a:Ljava/lang/String;

    invoke-static {v5}, Lcom/mrkeyboard/app/MrLearned;->key(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v17

    invoke-virtual {v0, v5}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_c

    iget-object v5, v4, Lcom/mrkeyboard/app/MrImport$NewPair;->b:Ljava/lang/String;

    invoke-static {v5}, Lcom/mrkeyboard/app/MrLearned;->key(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    move-object/from16 v0, v17

    invoke-virtual {v0, v5}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_d

    .line 268
    :cond_c
    iget v4, v14, Lcom/mrkeyboard/app/MrLearned$Result;->blockedSkipped:I

    add-int/lit8 v4, v4, 0x1

    iput v4, v14, Lcom/mrkeyboard/app/MrLearned$Result;->blockedSkipped:I

    goto :goto_5

    .line 271
    :cond_d
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v6, v4, Lcom/mrkeyboard/app/MrImport$NewPair;->a:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "\u0000"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, v4, Lcom/mrkeyboard/app/MrImport$NewPair;->b:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v19

    .line 272
    move-object/from16 v0, v16

    move-object/from16 v1, v19

    invoke-virtual {v0, v1}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_e

    .line 273
    iget v4, v14, Lcom/mrkeyboard/app/MrLearned$Result;->dupPairs:I

    add-int/lit8 v4, v4, 0x1

    iput v4, v14, Lcom/mrkeyboard/app/MrLearned$Result;->dupPairs:I

    goto :goto_5

    .line 276
    :cond_e
    iget v5, v14, Lcom/mrkeyboard/app/MrLearned$Result;->pairs:I

    add-int v5, v5, v20

    const/16 v6, 0x7530

    if-lt v5, v6, :cond_f

    .line 277
    iget v4, v14, Lcom/mrkeyboard/app/MrLearned$Result;->cappedPairs:I

    add-int/lit8 v4, v4, 0x1

    iput v4, v14, Lcom/mrkeyboard/app/MrLearned$Result;->cappedPairs:I

    goto :goto_5

    .line 280
    :cond_f
    const-wide/16 v6, 0x0

    cmp-long v5, v10, v6

    if-nez v5, :cond_10

    invoke-interface/range {p0 .. p0}, Lcom/mrkeyboard/app/MrWordStore;->newBatch()J

    move-result-wide v10

    .line 281
    :cond_10
    const/16 v21, 0x3

    new-instance v5, Lcom/mrkeyboard/app/MrWordStore$Row;

    const/4 v6, 0x3

    iget-object v7, v4, Lcom/mrkeyboard/app/MrImport$NewPair;->a:Ljava/lang/String;

    iget-object v8, v4, Lcom/mrkeyboard/app/MrImport$NewPair;->b:Ljava/lang/String;

    iget v4, v4, Lcom/mrkeyboard/app/MrImport$NewPair;->weight:I

    invoke-static {v4}, Lcom/mrkeyboard/app/MrLearned;->clampWeight(I)I

    move-result v9

    move-wide/from16 v12, p3

    invoke-direct/range {v5 .. v13}, Lcom/mrkeyboard/app/MrWordStore$Row;-><init>(ILjava/lang/String;Ljava/lang/String;IJJ)V

    move-object/from16 v0, p0

    move/from16 v1, v21

    move-object/from16 v2, p2

    invoke-interface {v0, v1, v2, v5}, Lcom/mrkeyboard/app/MrWordStore;->add(ILjava/lang/String;Lcom/mrkeyboard/app/MrWordStore$Row;)J

    .line 282
    move-object/from16 v0, v16

    move-object/from16 v1, v19

    invoke-virtual {v0, v1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 283
    iget v4, v14, Lcom/mrkeyboard/app/MrLearned$Result;->pairs:I

    add-int/lit8 v4, v4, 0x1

    iput v4, v14, Lcom/mrkeyboard/app/MrLearned$Result;->pairs:I

    goto/16 :goto_5

    .line 285
    :cond_11
    move-object/from16 v0, p1

    iget-object v4, v0, Lcom/mrkeyboard/app/MrImport$Plan;->blocked:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :cond_12
    :goto_6
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_14

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 286
    invoke-static {v4}, Lcom/mrkeyboard/app/MrLearned;->key(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    move-object/from16 v0, v17

    invoke-virtual {v0, v6}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_12

    .line 287
    const-wide/16 v6, 0x0

    cmp-long v6, v10, v6

    if-nez v6, :cond_13

    invoke-interface/range {p0 .. p0}, Lcom/mrkeyboard/app/MrWordStore;->newBatch()J

    move-result-wide v10

    .line 288
    :cond_13
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-wide/from16 v2, p3

    invoke-static {v0, v1, v4, v2, v3}, Lcom/mrkeyboard/app/MrLearned;->block(Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;Ljava/lang/String;J)I

    .line 289
    invoke-static {v4}, Lcom/mrkeyboard/app/MrLearned;->key(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, v17

    invoke-virtual {v0, v4}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 290
    iget v4, v14, Lcom/mrkeyboard/app/MrLearned$Result;->blocked:I

    add-int/lit8 v4, v4, 0x1

    iput v4, v14, Lcom/mrkeyboard/app/MrLearned$Result;->blocked:I

    goto :goto_6

    .line 292
    :cond_14
    iput-wide v10, v14, Lcom/mrkeyboard/app/MrLearned$Result;->batch:J

    .line 293
    return-object v14
.end method

.method static block(Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;Ljava/lang/String;J)I
    .locals 11

    .prologue
    const/4 v2, 0x4

    const/4 v5, 0x0

    .line 312
    if-nez p2, :cond_1

    const-string v3, ""

    .line 313
    :goto_0
    invoke-static {v3}, Lcom/mrkeyboard/app/MrImport;->checkWord(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, -0x1

    .line 325
    :cond_0
    return v0

    .line 312
    :cond_1
    invoke-virtual {p2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x2019

    const/16 v3, 0x27

    invoke-virtual {v0, v1, v3}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    .line 315
    :cond_2
    invoke-interface {p0, v2, p1}, Lcom/mrkeyboard/app/MrWordStore;->all(ILjava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    move v1, v5

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordStore$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->key(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v3}, Lcom/mrkeyboard/app/MrLearned;->key(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_8

    const/4 v0, 0x1

    :goto_2
    move v1, v0

    goto :goto_1

    .line 316
    :cond_3
    if-nez v1, :cond_4

    new-instance v1, Lcom/mrkeyboard/app/MrWordStore$Row;

    const/4 v4, 0x0

    const-wide/16 v6, 0x0

    move-wide v8, p3

    invoke-direct/range {v1 .. v9}, Lcom/mrkeyboard/app/MrWordStore$Row;-><init>(ILjava/lang/String;Ljava/lang/String;IJJ)V

    invoke-interface {p0, v2, p1, v1}, Lcom/mrkeyboard/app/MrWordStore;->add(ILjava/lang/String;Lcom/mrkeyboard/app/MrWordStore$Row;)J

    :cond_4
    move v0, v5

    .line 318
    :goto_3
    const/4 v1, 0x3

    if-gt v5, v1, :cond_0

    .line 319
    invoke-interface {p0, v5, p1}, Lcom/mrkeyboard/app/MrWordStore;->all(ILjava/lang/String;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    move v1, v0

    :goto_4
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordStore$Row;

    .line 320
    iget-object v4, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    invoke-static {v4}, Lcom/mrkeyboard/app/MrLearned;->key(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v3}, Lcom/mrkeyboard/app/MrLearned;->key(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_5

    iget-object v4, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    if-eqz v4, :cond_7

    iget-object v4, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    invoke-static {v4}, Lcom/mrkeyboard/app/MrLearned;->key(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v3}, Lcom/mrkeyboard/app/MrLearned;->key(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_7

    .line 321
    :cond_5
    iget-wide v6, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->id:J

    invoke-interface {p0, v5, v6, v7}, Lcom/mrkeyboard/app/MrWordStore;->delete(IJ)Z

    move-result v0

    if-eqz v0, :cond_7

    add-int/lit8 v1, v1, 0x1

    move v0, v1

    :goto_5
    move v1, v0

    .line 323
    goto :goto_4

    .line 318
    :cond_6
    add-int/lit8 v5, v5, 0x1

    move v0, v1

    goto :goto_3

    :cond_7
    move v0, v1

    goto :goto_5

    :cond_8
    move v0, v1

    goto :goto_2
.end method

.method static changed(Landroid/content/Context;)V
    .locals 4

    .prologue
    .line 83
    :try_start_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "mr_dicts_updated_at"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 87
    :goto_0
    return-void

    .line 84
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static clampWeight(I)I
    .locals 2

    .prologue
    .line 297
    const/4 v0, 0x1

    const/16 v1, 0x64

    invoke-static {v1, p0}, Ljava/lang/Math;->min(II)I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    return v0
.end method

.method static counts(Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;)[I
    .locals 4

    .prologue
    const/4 v3, 0x5

    .line 193
    new-array v1, v3, [I

    .line 194
    const/4 v0, 0x0

    :goto_0
    if-ge v0, v3, :cond_0

    invoke-interface {p0, v0, p1}, Lcom/mrkeyboard/app/MrWordStore;->count(ILjava/lang/String;)I

    move-result v2

    aput v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 195
    :cond_0
    return-object v1
.end method

.method static deleteAllImported(Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 363
    const/4 v0, 0x2

    invoke-interface {p0, v0, p1}, Lcom/mrkeyboard/app/MrWordStore;->deleteAll(ILjava/lang/String;)I

    move-result v0

    const/4 v1, 0x3

    invoke-interface {p0, v1, p1}, Lcom/mrkeyboard/app/MrWordStore;->deleteAll(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    return v0
.end method

.method static deleteAllLearned(Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;)I
    .locals 2

    .prologue
    .line 359
    const/4 v0, 0x0

    invoke-interface {p0, v0, p1}, Lcom/mrkeyboard/app/MrWordStore;->deleteAll(ILjava/lang/String;)I

    move-result v0

    const/4 v1, 0x1

    invoke-interface {p0, v1, p1}, Lcom/mrkeyboard/app/MrWordStore;->deleteAll(ILjava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    return v0
.end method

.method static edit(Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;Lcom/mrkeyboard/app/MrWordStore$Row;Ljava/lang/String;)I
    .locals 11

    .prologue
    const/16 v5, 0x2019

    const/16 v3, 0x27

    const/4 v1, 0x1

    const/4 v10, 0x0

    .line 341
    iget v0, p2, Lcom/mrkeyboard/app/MrWordStore$Row;->kind:I

    if-eq v0, v1, :cond_0

    iget v0, p2, Lcom/mrkeyboard/app/MrWordStore$Row;->kind:I

    const/4 v2, 0x3

    if-ne v0, v2, :cond_1

    :cond_0
    move v0, v1

    .line 342
    :goto_0
    const/4 v4, 0x0

    .line 343
    if-eqz v0, :cond_4

    .line 344
    if-nez p3, :cond_2

    const-string v0, ""

    :goto_1
    const/4 v2, 0x2

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrImport;->splitWords(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v0

    .line 345
    if-nez v0, :cond_3

    const/4 v0, 0x5

    .line 355
    :goto_2
    return v0

    :cond_1
    move v0, v10

    .line 341
    goto :goto_0

    .line 344
    :cond_2
    invoke-virtual {p3, v5, v3}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 346
    :cond_3
    aget-object v3, v0, v10

    .line 347
    aget-object v4, v0, v1

    .line 353
    :goto_3
    iget v0, p2, Lcom/mrkeyboard/app/MrWordStore$Row;->kind:I

    iget-wide v6, p2, Lcom/mrkeyboard/app/MrWordStore$Row;->id:J

    invoke-interface {p0, v0, v6, v7}, Lcom/mrkeyboard/app/MrWordStore;->delete(IJ)Z

    move-result v0

    if-nez v0, :cond_6

    const/4 v0, -0x1

    goto :goto_2

    .line 349
    :cond_4
    if-nez p3, :cond_5

    const-string v0, ""

    .line 350
    :goto_4
    invoke-static {v0}, Lcom/mrkeyboard/app/MrImport;->checkWord(Ljava/lang/String;)I

    move-result v1

    .line 351
    if-eqz v1, :cond_7

    move v0, v1

    goto :goto_2

    .line 349
    :cond_5
    invoke-virtual {p3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, v5, v3}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    goto :goto_4

    .line 354
    :cond_6
    iget v0, p2, Lcom/mrkeyboard/app/MrWordStore$Row;->kind:I

    new-instance v1, Lcom/mrkeyboard/app/MrWordStore$Row;

    iget v2, p2, Lcom/mrkeyboard/app/MrWordStore$Row;->kind:I

    iget v5, p2, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    iget-wide v6, p2, Lcom/mrkeyboard/app/MrWordStore$Row;->batch:J

    iget-wide v8, p2, Lcom/mrkeyboard/app/MrWordStore$Row;->added:J

    invoke-direct/range {v1 .. v9}, Lcom/mrkeyboard/app/MrWordStore$Row;-><init>(ILjava/lang/String;Ljava/lang/String;IJJ)V

    invoke-interface {p0, v0, p1, v1}, Lcom/mrkeyboard/app/MrWordStore;->add(ILjava/lang/String;Lcom/mrkeyboard/app/MrWordStore$Row;)J

    move v0, v10

    .line 355
    goto :goto_2

    :cond_7
    move-object v3, v0

    goto :goto_3
.end method

.method static export(Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;)Ljava/lang/String;
    .locals 8

    .prologue
    const/16 v7, 0xa

    .line 388
    new-instance v1, Ljava/util/TreeMap;

    invoke-direct {v1}, Ljava/util/TreeMap;-><init>()V

    .line 389
    const/4 v0, 0x0

    invoke-interface {p0, v0, p1}, Lcom/mrkeyboard/app/MrWordStore;->all(ILjava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordStore$Row;

    .line 390
    iget v3, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    const/4 v4, 0x6

    if-lt v3, v4, :cond_0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    iget v0, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->weightOfLearned(I)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v1, v3, v0}, Ljava/util/TreeMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 392
    :cond_1
    const/4 v0, 0x2

    invoke-interface {p0, v0, p1}, Lcom/mrkeyboard/app/MrWordStore;->all(ILjava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordStore$Row;

    iget-object v3, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    iget v0, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v1, v3, v0}, Ljava/util/TreeMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    .line 393
    :cond_2
    new-instance v2, Ljava/util/TreeSet;

    invoke-direct {v2}, Ljava/util/TreeSet;-><init>()V

    .line 394
    const/4 v0, 0x1

    invoke-interface {p0, v0, p1}, Lcom/mrkeyboard/app/MrWordStore;->all(ILjava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_3
    :goto_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordStore$Row;

    .line 395
    iget-object v4, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    if-eqz v4, :cond_3

    iget v4, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    const/16 v5, 0xc

    if-lt v4, v5, :cond_3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v5, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v0, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/util/TreeSet;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 397
    :cond_4
    const/4 v0, 0x3

    invoke-interface {p0, v0, p1}, Lcom/mrkeyboard/app/MrWordStore;->all(ILjava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_5
    :goto_3
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordStore$Row;

    iget-object v4, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    if-eqz v4, :cond_5

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v5, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v0, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/util/TreeSet;->add(Ljava/lang/Object;)Z

    goto :goto_3

    .line 398
    :cond_6
    new-instance v3, Ljava/util/TreeSet;

    invoke-direct {v3}, Ljava/util/TreeSet;-><init>()V

    .line 399
    const/4 v0, 0x4

    invoke-interface {p0, v0, p1}, Lcom/mrkeyboard/app/MrWordStore;->all(ILjava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_4
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_7

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordStore$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/util/TreeSet;->add(Ljava/lang/Object;)Z

    goto :goto_4

    .line 400
    :cond_7
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    .line 401
    const-string v0, "# mr-words 1\n# language: "

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Lcom/mrkeyboard/app/MrLearned;->tag(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 402
    const-string v0, "[words]\n"

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 403
    invoke-virtual {v1}, Ljava/util/TreeMap;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_5
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_9

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 404
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 405
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    const/16 v6, 0x32

    if-eq v1, v6, :cond_8

    const/16 v1, 0x9

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 406
    :cond_8
    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_5

    .line 408
    :cond_9
    const-string v0, "[phrases]\n"

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 409
    invoke-virtual {v2}, Ljava/util/TreeSet;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_6
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_a

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_6

    .line 410
    :cond_a
    invoke-virtual {v3}, Ljava/util/TreeSet;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_b

    .line 411
    const-string v0, "[blocked]\n"

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 412
    invoke-virtual {v3}, Ljava/util/TreeSet;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_7
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_b

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_7

    .line 414
    :cond_b
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static filter(Ljava/util/List;)Z
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/CharSequence;",
            ">;)Z"
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 177
    sget-object v4, Lcom/mrkeyboard/app/MrLearned;->sBlocked:Ljava/util/HashSet;

    .line 178
    invoke-virtual {v4}, Ljava/util/HashSet;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    if-nez p0, :cond_1

    .line 186
    :cond_0
    return v2

    .line 180
    :cond_1
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v3, v0

    :goto_0
    if-lt v3, v1, :cond_0

    .line 181
    invoke-interface {p0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->key(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 182
    invoke-interface {p0, v3}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 183
    if-ne v3, v1, :cond_2

    move v0, v1

    .line 180
    :goto_1
    add-int/lit8 v2, v3, -0x1

    move v3, v2

    move v2, v0

    goto :goto_0

    :cond_2
    move v0, v2

    goto :goto_1
.end method

.method static forget(Lcom/mrkeyboard/app/MrWordStore;IJ)Z
    .locals 2

    .prologue
    .line 333
    invoke-interface {p0, p1, p2, p3}, Lcom/mrkeyboard/app/MrWordStore;->delete(IJ)Z

    move-result v0

    return v0
.end method

.method public static gate(Lcom/mrkeyboard/app/Dictionary$WordCallback;)Lcom/mrkeyboard/app/Dictionary$WordCallback;
    .locals 1

    .prologue
    .line 148
    sget-object v0, Lcom/mrkeyboard/app/MrLearned;->sGate:Lcom/mrkeyboard/app/MrLearned$Gate;

    .line 149
    iput-object p0, v0, Lcom/mrkeyboard/app/MrLearned$Gate;->to:Lcom/mrkeyboard/app/Dictionary$WordCallback;

    .line 150
    return-object v0
.end method

.method public static isBlocked(Ljava/lang/String;)Z
    .locals 2

    .prologue
    .line 168
    sget-object v0, Lcom/mrkeyboard/app/MrLearned;->sBlocked:Ljava/util/HashSet;

    .line 169
    if-eqz p0, :cond_0

    invoke-virtual {v0}, Ljava/util/HashSet;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrLearned;->key(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static key(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 136
    if-nez p0, :cond_0

    const-string v0, ""

    :goto_0
    return-object v0

    :cond_0
    sget-object v0, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {p0, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method static languages(Ljava/util/List;Ljava/util/List;)Ljava/util/List;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 419
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 420
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 421
    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->localeOf(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 422
    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 424
    :cond_1
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 425
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_2
    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v4

    if-lez v4, :cond_2

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 426
    :cond_3
    invoke-static {v2}, Ljava/util/Collections;->sort(Ljava/util/List;)V

    .line 427
    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    .line 428
    return-object v1
.end method

.method public static load(Landroid/content/Context;Lcom/mrkeyboard/app/MrLearned$Sink;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 94
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrLearned;->store(Landroid/content/Context;)Lcom/mrkeyboard/app/MrWordStore;

    move-result-object v0

    .line 95
    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    if-nez p2, :cond_1

    .line 100
    :cond_0
    :goto_0
    return-void

    .line 96
    :cond_1
    invoke-static {v0, p1, p2}, Lcom/mrkeyboard/app/MrLearned;->loadFrom(Lcom/mrkeyboard/app/MrWordStore;Lcom/mrkeyboard/app/MrLearned$Sink;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 97
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static loadFrom(Lcom/mrkeyboard/app/MrWordStore;Lcom/mrkeyboard/app/MrLearned$Sink;Ljava/lang/String;)V
    .locals 4

    .prologue
    .line 103
    invoke-interface {p1}, Lcom/mrkeyboard/app/MrLearned$Sink;->kind()I

    move-result v0

    if-nez v0, :cond_1

    .line 104
    invoke-static {p0, p2}, Lcom/mrkeyboard/app/MrLearned;->refreshBlocked(Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;)V

    .line 105
    const/4 v0, 0x2

    invoke-interface {p0, v0, p2}, Lcom/mrkeyboard/app/MrWordStore;->all(ILjava/lang/String;)Ljava/util/List;

    move-result-object v0

    .line 106
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordStore$Row;

    .line 107
    iget-object v2, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    invoke-static {v2}, Lcom/mrkeyboard/app/MrLearned;->isBlocked(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    iget v0, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->wordFreq(I)I

    move-result v0

    invoke-interface {p1, v2, v0}, Lcom/mrkeyboard/app/MrLearned$Sink;->word(Ljava/lang/String;I)V

    goto :goto_0

    .line 110
    :cond_1
    const/4 v0, 0x3

    invoke-interface {p0, v0, p2}, Lcom/mrkeyboard/app/MrWordStore;->all(ILjava/lang/String;)Ljava/util/List;

    move-result-object v0

    .line 111
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_2
    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordStore$Row;

    .line 112
    iget-object v2, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    if-eqz v2, :cond_2

    iget-object v2, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    invoke-static {v2}, Lcom/mrkeyboard/app/MrLearned;->isBlocked(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    iget-object v2, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    invoke-static {v2}, Lcom/mrkeyboard/app/MrLearned;->isBlocked(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    iget-object v2, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    iget-object v3, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->b:Ljava/lang/String;

    iget v0, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->freq:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->pairFreq(I)I

    move-result v0

    invoke-interface {p1, v2, v3, v0}, Lcom/mrkeyboard/app/MrLearned$Sink;->pair(Ljava/lang/String;Ljava/lang/String;I)V

    goto :goto_1

    .line 115
    :cond_3
    return-void
.end method

.method static localeOf(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 375
    if-nez p0, :cond_0

    const-string v0, ""

    :goto_0
    return-object v0

    :cond_0
    const/16 v0, 0x2d

    const/16 v1, 0x5f

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method static pairFreq(I)I
    .locals 2

    .prologue
    .line 131
    const/4 v0, 0x1

    const/16 v1, 0x64

    invoke-static {v1, p0}, Ljava/lang/Math;->min(II)I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 132
    add-int/lit8 v0, v0, -0x1

    mul-int/lit8 v0, v0, 0x5

    int-to-float v0, v0

    const/high16 v1, 0x42c60000    # 99.0f

    div-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    add-int/lit8 v0, v0, 0x4

    return v0
.end method

.method static refreshBlocked(Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 118
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    .line 119
    const/4 v0, 0x4

    invoke-interface {p0, v0, p1}, Lcom/mrkeyboard/app/MrWordStore;->all(ILjava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrWordStore$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrWordStore$Row;->a:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearned;->key(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 120
    :cond_0
    sput-object v1, Lcom/mrkeyboard/app/MrLearned;->sBlocked:Ljava/util/HashSet;

    .line 121
    return-void
.end method

.method static declared-synchronized store(Landroid/content/Context;)Lcom/mrkeyboard/app/MrWordStore;
    .locals 3

    .prologue
    .line 64
    const-class v1, Lcom/mrkeyboard/app/MrLearned;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/mrkeyboard/app/MrLearned;->sStore:Lcom/mrkeyboard/app/MrWordStore;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    if-eqz p0, :cond_0

    .line 66
    :try_start_1
    new-instance v0, Lcom/mrkeyboard/app/MrSqlStore;

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/MrSqlStore;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/mrkeyboard/app/MrLearned;->sStore:Lcom/mrkeyboard/app/MrWordStore;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 71
    :cond_0
    :goto_0
    :try_start_2
    sget-object v0, Lcom/mrkeyboard/app/MrLearned;->sStore:Lcom/mrkeyboard/app/MrWordStore;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    monitor-exit v1

    return-object v0

    .line 67
    :catch_0
    move-exception v0

    .line 68
    const/4 v0, 0x0

    :try_start_3
    sput-object v0, Lcom/mrkeyboard/app/MrLearned;->sStore:Lcom/mrkeyboard/app/MrWordStore;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0

    .line 64
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static tag(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 370
    if-nez p0, :cond_0

    const-string v0, ""

    :goto_0
    return-object v0

    :cond_0
    const/16 v0, 0x5f

    const/16 v1, 0x2d

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method static unblock(Lcom/mrkeyboard/app/MrWordStore;J)Z
    .locals 1

    .prologue
    .line 329
    const/4 v0, 0x4

    invoke-interface {p0, v0, p1, p2}, Lcom/mrkeyboard/app/MrWordStore;->delete(IJ)Z

    move-result v0

    return v0
.end method

.method static undo(Lcom/mrkeyboard/app/MrWordStore;Ljava/lang/String;J)I
    .locals 2

    .prologue
    .line 302
    const-wide/16 v0, 0x0

    cmp-long v0, p2, v0

    if-gtz v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    invoke-interface {p0, p1, p2, p3}, Lcom/mrkeyboard/app/MrWordStore;->deleteBatch(Ljava/lang/String;J)I

    move-result v0

    goto :goto_0
.end method

.method static declared-synchronized useStore(Lcom/mrkeyboard/app/MrWordStore;)V
    .locals 2

    .prologue
    .line 76
    const-class v1, Lcom/mrkeyboard/app/MrLearned;

    monitor-enter v1

    :try_start_0
    sput-object p0, Lcom/mrkeyboard/app/MrLearned;->sStore:Lcom/mrkeyboard/app/MrWordStore;

    .line 77
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrLearned;->sBlocked:Ljava/util/HashSet;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 78
    monitor-exit v1

    return-void

    .line 76
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method static weightOfLearned(I)I
    .locals 4

    .prologue
    .line 379
    const/4 v0, 0x1

    const/16 v1, 0x64

    int-to-float v2, p0

    const/high16 v3, 0x42c80000    # 100.0f

    mul-float/2addr v2, v3

    const/high16 v3, 0x437a0000    # 250.0f

    div-float/2addr v2, v3

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    return v0
.end method

.method static wordFreq(I)I
    .locals 4

    .prologue
    .line 125
    const/4 v0, 0x1

    const/16 v1, 0x64

    invoke-static {v1, p0}, Ljava/lang/Math;->min(II)I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 126
    const/16 v1, 0xfa

    const/4 v2, 0x6

    mul-int/lit16 v0, v0, 0x82

    int-to-float v0, v0

    const/high16 v3, 0x42480000    # 50.0f

    div-float/2addr v0, v3

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-static {v2, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    return v0
.end method
