.class public Lcom/mrkeyboard/app/MrAiPrefs;
.super Landroid/preference/PreferenceActivity;
.source "MrAiPrefs.java"


# instance fields
.field private mEndpoint:Landroid/preference/Preference;

.field private final mHandler:Landroid/os/Handler;

.field private mKey:Landroid/preference/Preference;

.field private mModel:Landroid/preference/Preference;

.field private final mRecreate:Ljava/lang/Runnable;

.field private mStyles:Landroid/preference/PreferenceCategory;

.field private mTest:Landroid/preference/Preference;

.field private mTesting:Z


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    .line 27
    invoke-direct {p0}, Landroid/preference/PreferenceActivity;-><init>()V

    .line 28
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mHandler:Landroid/os/Handler;

    .line 36
    new-instance v0, Lcom/mrkeyboard/app/MrAiPrefs$1;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrAiPrefs$1;-><init>(Lcom/mrkeyboard/app/MrAiPrefs;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mRecreate:Ljava/lang/Runnable;

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/MrAiPrefs;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrAiPrefs;->applyPreset(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/MrAiPrefs;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 27
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrAiPrefs;->summaryOr(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/MrAiPrefs;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 27
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrAiPrefs;->keySummary(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/MrAiPrefs;)V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAiPrefs;->test()V

    return-void
.end method

.method static synthetic access$402(Lcom/mrkeyboard/app/MrAiPrefs;Z)Z
    .locals 0

    .prologue
    .line 27
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mTesting:Z

    return p1
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/MrAiPrefs;)Landroid/preference/Preference;
    .locals 1

    .prologue
    .line 27
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mTest:Landroid/preference/Preference;

    return-object v0
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/MrAiPrefs;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 27
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrAiPrefs;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/MrAiPrefs;)Landroid/os/Handler;
    .locals 1

    .prologue
    .line 27
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mHandler:Landroid/os/Handler;

    return-object v0
.end method

.method private applyPreset(Ljava/lang/String;)V
    .locals 4

    .prologue
    .line 144
    const-string v0, "groq"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 145
    const-string v1, "https://api.groq.com/openai/v1/chat/completions"

    .line 146
    const-string v0, "openai/gpt-oss-120b"

    .line 159
    :goto_0
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    const-string v3, "pref_ai_endpoint"

    .line 160
    invoke-interface {v2, v3, v1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "pref_ai_model"

    .line 161
    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 162
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mRecreate:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 163
    :cond_0
    return-void

    .line 147
    :cond_1
    const-string v0, "openrouter"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 148
    const-string v1, "https://openrouter.ai/api/v1/chat/completions"

    .line 149
    const-string v0, "openai/gpt-6.1-terra"

    goto :goto_0

    .line 150
    :cond_2
    const-string v0, "gemini"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 151
    const-string v1, "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions"

    .line 152
    const-string v0, "gemini-3.5-flash-lite"

    goto :goto_0

    .line 153
    :cond_3
    const-string v0, "openai"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 154
    const-string v1, "https://api.openai.com/v1/chat/completions"

    .line 155
    const-string v0, "gpt-6.1-terra"

    goto :goto_0
.end method

.method private keySummary(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 171
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    const-string v0, "mr_ai_key_set"

    :goto_0
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrAiPrefs;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const-string v0, "mr_ai_key_unset"

    goto :goto_0
.end method

.method private migratePreviousPresets()V
    .locals 5

    .prologue
    .line 129
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 130
    const-string v0, "pref_ai_provider"

    const-string v2, "openai"

    invoke-interface {v1, v0, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 131
    const-string v0, "pref_ai_model"

    const-string v3, ""

    invoke-interface {v1, v0, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 132
    const/4 v0, 0x0

    .line 133
    const-string v4, "openai"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    const-string v4, "gpt-4o-mini"

    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    const-string v0, "gpt-6.1-terra"

    .line 137
    :cond_0
    :goto_0
    if-eqz v0, :cond_1

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "pref_ai_model"

    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 138
    :cond_1
    return-void

    .line 134
    :cond_2
    const-string v4, "groq"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    const-string v4, "llama-3.3-70b-versatile"

    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    const-string v0, "openai/gpt-oss-120b"

    goto :goto_0

    .line 135
    :cond_3
    const-string v4, "openrouter"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    const-string v4, "openai/gpt-4o-mini"

    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    const-string v0, "openai/gpt-6.1-terra"

    goto :goto_0

    .line 136
    :cond_4
    const-string v4, "gemini"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v2, "gemini-2.5-flash"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_5

    const-string v2, "gemini-3.8-flash"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_5

    const-string v2, "gemini-4-argon"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    :cond_5
    const-string v0, "gemini-3.5-flash-lite"

    goto :goto_0
.end method

.method private rebuildStyles()V
    .locals 8

    .prologue
    const/16 v7, 0x78

    const/4 v2, 0x0

    .line 182
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mStyles:Landroid/preference/PreferenceCategory;

    if-nez v0, :cond_0

    .line 211
    :goto_0
    return-void

    .line 183
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mStyles:Landroid/preference/PreferenceCategory;

    invoke-virtual {v0}, Landroid/preference/PreferenceCategory;->removeAll()V

    .line 184
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAi;->loadCustom(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v3

    move v1, v2

    .line 185
    :goto_1
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_2

    .line 186
    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    .line 188
    new-instance v4, Landroid/preference/Preference;

    invoke-direct {v4, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    .line 189
    invoke-virtual {v4, v2}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 190
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    aget-object v6, v0, v2

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "  "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const/4 v6, 0x1

    aget-object v6, v0, v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 191
    const/4 v5, 0x2

    aget-object v0, v0, v5

    const/16 v5, 0xa

    const/16 v6, 0x20

    invoke-virtual {v0, v5, v6}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    .line 192
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v5

    if-le v5, v7, :cond_1

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v2, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v5, "\u2026"

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_1
    invoke-virtual {v4, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 193
    new-instance v0, Lcom/mrkeyboard/app/MrAiPrefs$7;

    invoke-direct {v0, p0, v1}, Lcom/mrkeyboard/app/MrAiPrefs$7;-><init>(Lcom/mrkeyboard/app/MrAiPrefs;I)V

    invoke-virtual {v4, v0}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    .line 199
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mStyles:Landroid/preference/PreferenceCategory;

    invoke-virtual {v0, v4}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    .line 185
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 201
    :cond_2
    new-instance v0, Landroid/preference/Preference;

    invoke-direct {v0, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    .line 202
    invoke-virtual {v0, v2}, Landroid/preference/Preference;->setPersistent(Z)V

    .line 203
    const-string v1, "mr_ai_add_style"

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrAiPrefs;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    .line 204
    new-instance v1, Lcom/mrkeyboard/app/MrAiPrefs$8;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrAiPrefs$8;-><init>(Lcom/mrkeyboard/app/MrAiPrefs;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    .line 210
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mStyles:Landroid/preference/PreferenceCategory;

    invoke-virtual {v1, v0}, Landroid/preference/PreferenceCategory;->addPreference(Landroid/preference/Preference;)Z

    goto/16 :goto_0
.end method

.method private refreshSummaries()V
    .locals 4

    .prologue
    .line 175
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 176
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mEndpoint:Landroid/preference/Preference;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mEndpoint:Landroid/preference/Preference;

    const-string v2, "pref_ai_endpoint"

    const-string v3, "https://api.openai.com/v1/chat/completions"

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/MrAiPrefs;->summaryOr(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 177
    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mModel:Landroid/preference/Preference;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mModel:Landroid/preference/Preference;

    const-string v2, "pref_ai_model"

    const-string v3, "gpt-6.1-terra"

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrAiPrefs;->summaryOr(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 178
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mKey:Landroid/preference/Preference;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mKey:Landroid/preference/Preference;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrAi;->apiKey(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrAiPrefs;->keySummary(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 179
    :cond_2
    return-void
.end method

.method private summaryOr(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .prologue
    .line 166
    if-nez p1, :cond_0

    const-string v0, ""

    .line 167
    :goto_0
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_1

    :goto_1
    return-object v0

    .line 166
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 167
    :cond_1
    const-string v0, "\u2014"

    goto :goto_1
.end method

.method private t(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 123
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {p0, p1, v0}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 124
    if-eqz v0, :cond_0

    move-object p1, v0

    :cond_0
    return-object p1
.end method

.method private test()V
    .locals 3

    .prologue
    .line 214
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mTesting:Z

    if-eqz v0, :cond_0

    .line 241
    :goto_0
    return-void

    .line 215
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mTesting:Z

    .line 216
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mTest:Landroid/preference/Preference;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mTest:Landroid/preference/Preference;

    const-string v1, "mr_ai_working"

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/MrAiPrefs;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 217
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrAiPrefs;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 218
    new-instance v1, Ljava/lang/Thread;

    new-instance v2, Lcom/mrkeyboard/app/MrAiPrefs$9;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrAiPrefs$9;-><init>(Lcom/mrkeyboard/app/MrAiPrefs;Landroid/content/Context;)V

    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 240
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 44
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/preference/PreferenceActivity;->attachBaseContext(Landroid/content/Context;)V

    .line 45
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 4

    .prologue
    .line 49
    invoke-super {p0, p1}, Landroid/preference/PreferenceActivity;->onCreate(Landroid/os/Bundle;)V

    .line 50
    const-string v0, "mr_ai_title"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrAiPrefs;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrAiPrefs;->setTitle(Ljava/lang/CharSequence;)V

    .line 51
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrAiPrefs;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "prefs_ai"

    const-string v2, "xml"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrAiPrefs;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrAiPrefs;->addPreferencesFromResource(I)V

    .line 52
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAiPrefs;->migratePreviousPresets()V

    .line 53
    invoke-static {p0}, Lcom/mrkeyboard/app/ListDividerFix;->apply(Landroid/preference/PreferenceActivity;)V

    .line 55
    const-string v0, "pref_ai_provider"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrAiPrefs;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    .line 56
    if-eqz v0, :cond_0

    .line 57
    new-instance v1, Lcom/mrkeyboard/app/MrAiPrefs$2;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrAiPrefs$2;-><init>(Lcom/mrkeyboard/app/MrAiPrefs;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceChangeListener(Landroid/preference/Preference$OnPreferenceChangeListener;)V

    .line 64
    :cond_0
    const-string v0, "pref_ai_endpoint"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrAiPrefs;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mEndpoint:Landroid/preference/Preference;

    .line 65
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mEndpoint:Landroid/preference/Preference;

    if-eqz v0, :cond_1

    .line 66
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mEndpoint:Landroid/preference/Preference;

    new-instance v1, Lcom/mrkeyboard/app/MrAiPrefs$3;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrAiPrefs$3;-><init>(Lcom/mrkeyboard/app/MrAiPrefs;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceChangeListener(Landroid/preference/Preference$OnPreferenceChangeListener;)V

    .line 73
    :cond_1
    const-string v0, "pref_ai_model"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrAiPrefs;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mModel:Landroid/preference/Preference;

    .line 74
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mModel:Landroid/preference/Preference;

    if-eqz v0, :cond_2

    .line 75
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mModel:Landroid/preference/Preference;

    new-instance v1, Lcom/mrkeyboard/app/MrAiPrefs$4;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrAiPrefs$4;-><init>(Lcom/mrkeyboard/app/MrAiPrefs;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceChangeListener(Landroid/preference/Preference$OnPreferenceChangeListener;)V

    .line 82
    :cond_2
    const-string v0, "pref_ai_key"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrAiPrefs;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mKey:Landroid/preference/Preference;

    .line 83
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mKey:Landroid/preference/Preference;

    if-eqz v0, :cond_3

    .line 84
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mKey:Landroid/preference/Preference;

    new-instance v1, Lcom/mrkeyboard/app/MrAiPrefs$5;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrAiPrefs$5;-><init>(Lcom/mrkeyboard/app/MrAiPrefs;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceChangeListener(Landroid/preference/Preference$OnPreferenceChangeListener;)V

    .line 91
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mKey:Landroid/preference/Preference;

    check-cast v0, Landroid/preference/EditTextPreference;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrAi;->apiKey(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/EditTextPreference;->setText(Ljava/lang/String;)V

    .line 93
    :cond_3
    const-string v0, "pref_ai_test"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrAiPrefs;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mTest:Landroid/preference/Preference;

    .line 94
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mTest:Landroid/preference/Preference;

    if-eqz v0, :cond_4

    .line 95
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mTest:Landroid/preference/Preference;

    new-instance v1, Lcom/mrkeyboard/app/MrAiPrefs$6;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrAiPrefs$6;-><init>(Lcom/mrkeyboard/app/MrAiPrefs;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V

    .line 102
    :cond_4
    const-string v0, "mr_ai_cat_styles"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrAiPrefs;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    check-cast v0, Landroid/preference/PreferenceCategory;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mStyles:Landroid/preference/PreferenceCategory;

    .line 103
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAiPrefs;->refreshSummaries()V

    .line 104
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAiPrefs;->rebuildStyles()V

    .line 105
    return-void
.end method

.method protected onPause()V
    .locals 2

    .prologue
    .line 117
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAiPrefs;->mRecreate:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 118
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAiDialog;->setAuxiliaryUiVisible(Z)V

    .line 119
    invoke-super {p0}, Landroid/preference/PreferenceActivity;->onPause()V

    .line 120
    return-void
.end method

.method protected onResume()V
    .locals 1

    .prologue
    .line 109
    invoke-super {p0}, Landroid/preference/PreferenceActivity;->onResume()V

    .line 110
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAiDialog;->setAuxiliaryUiVisible(Z)V

    .line 111
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAiPrefs;->refreshSummaries()V

    .line 112
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrAiPrefs;->rebuildStyles()V

    .line 113
    return-void
.end method
