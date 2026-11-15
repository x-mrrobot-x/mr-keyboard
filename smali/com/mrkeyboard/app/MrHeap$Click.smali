.class final Lcom/mrkeyboard/app/MrHeap$Click;
.super Ljava/lang/Object;
.source "MrHeap.java"

# interfaces
.implements Landroid/preference/Preference$OnPreferenceClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrHeap;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Click"
.end annotation


# instance fields
.field private final mContext:Landroid/content/Context;

.field private final mMain:Landroid/os/Handler;

.field private final mRow:Landroid/preference/Preference;


# direct methods
.method constructor <init>(Landroid/content/Context;Landroid/preference/Preference;)V
    .locals 2

    .prologue
    .line 106
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 104
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrHeap$Click;->mMain:Landroid/os/Handler;

    .line 107
    iput-object p1, p0, Lcom/mrkeyboard/app/MrHeap$Click;->mContext:Landroid/content/Context;

    .line 108
    iput-object p2, p0, Lcom/mrkeyboard/app/MrHeap$Click;->mRow:Landroid/preference/Preference;

    .line 109
    return-void
.end method


# virtual methods
.method done(Ljava/io/File;)V
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 134
    sput-boolean v0, Lcom/mrkeyboard/app/MrHeap;->sBusy:Z

    .line 135
    if-nez p1, :cond_0

    const-string v0, "mr_ui_perf_heap_fail"

    :goto_0
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrHeap$Click;->setSummary(Ljava/lang/String;)V

    .line 136
    if-nez p1, :cond_1

    .line 143
    :goto_1
    return-void

    .line 135
    :cond_0
    const-string v0, "mr_ui_perf_heap_sum"

    goto :goto_0

    .line 138
    :cond_1
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrHeap$Click;->mContext:Landroid/content/Context;

    const-string v1, "mr_ui_perf_heap_title"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 139
    iget-object v1, p0, Lcom/mrkeyboard/app/MrHeap$Click;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrHeap$Click;->mContext:Landroid/content/Context;

    const-string v3, "com.mrkeyboard.app.shots"

    invoke-static {v2, v3, p1}, Landroid/support/v4/content/FileProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object v2

    if-eqz v0, :cond_2

    :goto_2
    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrHeap;->share(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 140
    :catch_0
    move-exception v0

    .line 141
    const-string v0, "mr_ui_perf_heap_fail"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrHeap$Click;->setSummary(Ljava/lang/String;)V

    goto :goto_1

    .line 139
    :cond_2
    :try_start_1
    const-string v0, ""
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2
.end method

.method public onPreferenceClick(Landroid/preference/Preference;)Z
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 112
    sget-boolean v0, Lcom/mrkeyboard/app/MrHeap;->sBusy:Z

    if-eqz v0, :cond_0

    .line 118
    :goto_0
    return v2

    .line 113
    :cond_0
    sput-boolean v2, Lcom/mrkeyboard/app/MrHeap;->sBusy:Z

    .line 114
    const-string v0, "mr_ui_perf_heap_busy"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrHeap$Click;->setSummary(Ljava/lang/String;)V

    .line 115
    const/16 v0, 0x50

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTrim;->onTrim(I)V

    .line 116
    invoke-static {}, Ljava/lang/System;->gc()V

    .line 117
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/mrkeyboard/app/MrHeap$Work;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrHeap$Work;-><init>(Lcom/mrkeyboard/app/MrHeap$Click;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    goto :goto_0
.end method

.method setSummary(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 122
    iget-object v0, p0, Lcom/mrkeyboard/app/MrHeap$Click;->mContext:Landroid/content/Context;

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, p1, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 123
    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrHeap$Click;->mRow:Landroid/preference/Preference;

    invoke-virtual {v1, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 124
    :cond_0
    return-void
.end method

.method work()V
    .locals 3

    .prologue
    .line 128
    iget-object v0, p0, Lcom/mrkeyboard/app/MrHeap$Click;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrHeap;->save(Landroid/content/Context;)Ljava/io/File;

    move-result-object v0

    .line 129
    iget-object v1, p0, Lcom/mrkeyboard/app/MrHeap$Click;->mMain:Landroid/os/Handler;

    new-instance v2, Lcom/mrkeyboard/app/MrHeap$Done;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrHeap$Done;-><init>(Lcom/mrkeyboard/app/MrHeap$Click;Ljava/io/File;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 130
    return-void
.end method
