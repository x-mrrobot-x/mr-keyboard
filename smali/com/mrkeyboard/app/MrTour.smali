.class final Lcom/mrkeyboard/app/MrTour;
.super Ljava/lang/Object;
.source "MrTour.java"


# static fields
.field static final DICT:Ljava/lang/String; = "dict"

.field static final FALLBACK_COUNTRY:Ljava/lang/String; = "US"

.field static final FALLBACK_LANGUAGE:Ljava/lang/String; = "en"

.field static final GESTURE:Ljava/lang/String; = "gesture"

.field static final KEY_DONE:Ljava/lang/String; = "done"

.field static final KEY_SUGGESTIONS:Ljava/lang/String; = "show_suggestions"

.field static final PREFS:Ljava/lang/String; = "mr_tour"

.field static final WORD:Ljava/lang/String; = "word"

.field static volatile sBusy:Z

.field static volatile sError:Ljava/lang/String;

.field static volatile sErrorStep:Ljava/lang/String;

.field static volatile sStep:Ljava/lang/String;


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 51
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static defaults(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .locals 1

    .prologue
    .line 56
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method static done(Landroid/content/Context;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 60
    const-string v1, "mr_tour"

    invoke-virtual {p0, v1, v0}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 61
    if-eqz v1, :cond_0

    const-string v2, "done"

    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0
.end method

.method static download(Landroid/content/Context;Ljava/lang/String;)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x0

    .line 167
    sget-boolean v0, Lcom/mrkeyboard/app/MrTour;->sBusy:Z

    if-nez v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->sJobId:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 191
    :cond_0
    :goto_0
    return-void

    .line 168
    :cond_1
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    .line 169
    :cond_2
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    .line 170
    const/4 v1, 0x1

    sput-boolean v1, Lcom/mrkeyboard/app/MrTour;->sBusy:Z

    .line 171
    sput-object p1, Lcom/mrkeyboard/app/MrTour;->sStep:Ljava/lang/String;

    .line 172
    sput-object v3, Lcom/mrkeyboard/app/MrTour;->sError:Ljava/lang/String;

    .line 173
    sput-object v3, Lcom/mrkeyboard/app/MrTour;->sErrorStep:Ljava/lang/String;

    .line 174
    sput v2, Lcom/mrkeyboard/app/MrPacks;->sJobPercent:I

    .line 175
    sput-boolean v2, Lcom/mrkeyboard/app/MrPacks;->sJobInstalling:Z

    .line 176
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrTour$1;

    invoke-direct {v2, p0, p1, v0}, Lcom/mrkeyboard/app/MrTour$1;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/util/Locale;)V

    const-string v0, "MrTour"

    invoke-direct {v1, v2, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 190
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method static markDone(Landroid/content/Context;)V
    .locals 3

    .prologue
    .line 65
    const-string v0, "mr_tour"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 66
    if-eqz v0, :cond_0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "done"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 67
    :cond_0
    return-void
.end method

.method static onOpen(Landroid/app/Activity;)V
    .locals 1

    .prologue
    .line 101
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrTour;->shouldShow(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 107
    :goto_0
    return-void

    .line 102
    :cond_0
    const-class v0, Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrNav;->intent(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V

    .line 103
    invoke-static {p0}, Lcom/mrkeyboard/app/MrTour;->markDone(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 104
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static packFor(Lcom/mrkeyboard/app/MrPacks$Catalog;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 129
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 130
    if-eqz p0, :cond_0

    .line 131
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacks$Catalog;->packs:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrPacks$Pack;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 133
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrPacks;->DEFAULT_IDS:[Ljava/lang/String;

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v1, v0}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 135
    :cond_1
    invoke-static {v1, p1, p2}, Lcom/mrkeyboard/app/MrTour;->pick(Ljava/util/List;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 136
    if-eqz v0, :cond_2

    :goto_1
    return-object v0

    :cond_2
    const-string v0, "en"

    const-string v2, "US"

    invoke-static {v1, v0, v2}, Lcom/mrkeyboard/app/MrTour;->pick(Ljava/util/List;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method static packIdForSystem(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 156
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    .line 157
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->cachedCatalog(Landroid/content/Context;)Lcom/mrkeyboard/app/MrPacks$Catalog;

    move-result-object v1

    invoke-virtual {v0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v2, v0}, Lcom/mrkeyboard/app/MrTour;->packFor(Lcom/mrkeyboard/app/MrPacks$Catalog;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static pick(Ljava/util/List;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/String;"
        }
    .end annotation

    .prologue
    const/4 v2, 0x0

    .line 141
    if-nez p1, :cond_1

    const-string v0, ""

    move-object v3, v0

    .line 142
    :goto_0
    if-nez p2, :cond_2

    const-string v0, ""

    move-object v1, v0

    .line 143
    :goto_1
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_3

    .line 151
    :cond_0
    :goto_2
    return-object v2

    .line 141
    :cond_1
    sget-object v0, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {p1, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    move-object v3, v0

    goto :goto_0

    .line 142
    :cond_2
    sget-object v0, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {p2, v0}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    goto :goto_1

    .line 145
    :cond_3
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_4
    :goto_3
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 146
    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacks;->splitLocale(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    .line 147
    const/4 v6, 0x0

    aget-object v6, v5, v6

    invoke-virtual {v6, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_4

    .line 148
    const/4 v6, 0x1

    aget-object v5, v5, v6

    invoke-virtual {v5, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_5

    move-object v2, v0

    goto :goto_2

    .line 149
    :cond_5
    if-nez v2, :cond_6

    :goto_4
    move-object v2, v0

    .line 150
    goto :goto_3

    :cond_6
    move-object v0, v2

    goto :goto_4
.end method

.method static ready(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x1

    .line 71
    const-string v2, "dict"

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->installedIds(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_1

    .line 73
    :cond_0
    :goto_0
    return v0

    :cond_1
    move v0, v1

    .line 71
    goto :goto_0

    .line 72
    :cond_2
    const-string v2, "gesture"

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v2, "gesture"

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrPacks;->modelVersion(Landroid/content/Context;Ljava/lang/String;)I

    move-result v2

    if-gtz v2, :cond_0

    move v0, v1

    goto :goto_0
.end method

.method static shouldShow(Landroid/content/Context;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 93
    invoke-static {p0}, Lcom/mrkeyboard/app/MrTour;->done(Landroid/content/Context;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 95
    :cond_0
    :goto_0
    return v0

    .line 94
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrTour;->steps(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v1

    .line 95
    const-string v2, "dict"

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "gesture"

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    :cond_2
    const/4 v0, 0x1

    goto :goto_0
.end method

.method static steps(Landroid/content/Context;)Ljava/util/ArrayList;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v1, 0x1

    .line 78
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 79
    invoke-static {p0}, Lcom/mrkeyboard/app/MrTour;->defaults(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v3

    .line 80
    if-nez v3, :cond_6

    move v0, v1

    .line 81
    :goto_0
    if-nez v0, :cond_0

    const-string v4, "show_suggestions"

    invoke-interface {v3, v4, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 82
    :cond_0
    const-string v4, "dict"

    invoke-static {p0, v4}, Lcom/mrkeyboard/app/MrTour;->ready(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_1

    const-string v4, "dict"

    invoke-virtual {v2, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 84
    :cond_1
    if-nez v0, :cond_2

    const-string v4, "pref_gesture_typing"

    invoke-interface {v3, v4, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 85
    :cond_2
    const-string v4, "gesture"

    invoke-static {p0, v4}, Lcom/mrkeyboard/app/MrTour;->ready(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_3

    const-string v4, "gesture"

    invoke-virtual {v2, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 87
    :cond_3
    invoke-virtual {v2}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_5

    if-nez v0, :cond_4

    const-string v0, "pref_word_delete"

    invoke-interface {v3, v0, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_5

    :cond_4
    const-string v0, "word"

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 88
    :cond_5
    return-object v2

    .line 80
    :cond_6
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static turnOff(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 111
    invoke-static {p0}, Lcom/mrkeyboard/app/MrTour;->defaults(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 112
    if-nez v1, :cond_1

    .line 115
    :cond_0
    :goto_0
    return-void

    .line 113
    :cond_1
    const-string v0, "dict"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "show_suggestions"

    .line 114
    :goto_1
    if-eqz v0, :cond_0

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const/4 v2, 0x0

    invoke-interface {v1, v0, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    goto :goto_0

    .line 113
    :cond_2
    const-string v0, "gesture"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    const-string v0, "pref_gesture_typing"

    goto :goto_1

    :cond_3
    const-string v0, "word"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    const-string v0, "pref_word_delete"

    goto :goto_1

    :cond_4
    const/4 v0, 0x0

    goto :goto_1
.end method

.method static work(Landroid/content/Context;Ljava/lang/String;Ljava/util/Locale;)Ljava/lang/String;
    .locals 5

    .prologue
    const/4 v1, 0x0

    .line 196
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->fetchCatalog(Landroid/content/Context;)Lcom/mrkeyboard/app/MrPacks$Catalog;

    move-result-object v2

    .line 197
    const-string v0, "gesture"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 198
    const-string v0, "gesture"

    invoke-virtual {v2, v0}, Lcom/mrkeyboard/app/MrPacks$Catalog;->model(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v0

    .line 199
    if-nez v0, :cond_0

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_tour_no_gesture"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0
    :try_end_0
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_0 .. :try_end_0} :catch_0

    .line 213
    :catch_0
    move-exception v0

    move-object v1, v0

    .line 214
    iget-object v0, v1, Lcom/mrkeyboard/app/MrPacks$PackException;->key:Ljava/lang/String;

    iget-object v2, v1, Lcom/mrkeyboard/app/MrPacks$PackException;->args:[Ljava/lang/Object;

    invoke-static {p0, v0, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 215
    if-eqz v0, :cond_6

    :goto_0
    return-object v0

    .line 200
    :cond_0
    :try_start_1
    invoke-static {p0, v2, v0}, Lcom/mrkeyboard/app/MrPacks;->install(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Catalog;Lcom/mrkeyboard/app/MrPacks$Pack;)V

    move-object v0, v1

    .line 201
    goto :goto_0

    .line 203
    :cond_1
    invoke-virtual {p2}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v0, v3}, Lcom/mrkeyboard/app/MrTour;->packFor(Lcom/mrkeyboard/app/MrPacks$Catalog;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 204
    if-nez v0, :cond_2

    move-object v0, v1

    .line 205
    :goto_1
    if-nez v0, :cond_3

    new-instance v0, Lcom/mrkeyboard/app/MrPacks$PackException;

    const-string v1, "mr_tour_no_pack"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks$PackException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 204
    :cond_2
    invoke-virtual {v2, v0}, Lcom/mrkeyboard/app/MrPacks$Catalog;->find(Ljava/lang/String;)Lcom/mrkeyboard/app/MrPacks$Pack;

    move-result-object v0

    goto :goto_1

    .line 206
    :cond_3
    invoke-static {p0, v2, v0}, Lcom/mrkeyboard/app/MrPacks;->install(Landroid/content/Context;Lcom/mrkeyboard/app/MrPacks$Catalog;Lcom/mrkeyboard/app/MrPacks$Pack;)V

    .line 207
    invoke-static {p0}, Lcom/mrkeyboard/app/MrTour;->defaults(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 208
    if-eqz v0, :cond_4

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v3, "show_suggestions"

    const/4 v4, 0x1

    invoke-interface {v0, v3, v4}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 209
    :cond_4
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 210
    iget-object v0, v2, Lcom/mrkeyboard/app/MrPacks$Catalog;->packs:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/MrPacks$Pack;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrPacks$Pack;->id:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 211
    :cond_5
    invoke-static {p0}, Lcom/mrkeyboard/app/MrPacks;->installedIds(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {p2}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v2

    invoke-static {v3, v0, v2}, Lcom/mrkeyboard/app/MrPacks;->cardIds(Ljava/util/List;Ljava/util/List;Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrPacks;->syncLanguages(Landroid/content/Context;Ljava/util/List;)V
    :try_end_1
    .catch Lcom/mrkeyboard/app/MrPacks$PackException; {:try_start_1 .. :try_end_1} :catch_0

    move-object v0, v1

    .line 212
    goto :goto_0

    .line 215
    :cond_6
    iget-object v0, v1, Lcom/mrkeyboard/app/MrPacks$PackException;->key:Ljava/lang/String;

    goto :goto_0
.end method
