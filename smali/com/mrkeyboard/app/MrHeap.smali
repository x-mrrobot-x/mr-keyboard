.class final Lcom/mrkeyboard/app/MrHeap;
.super Ljava/lang/Object;
.source "MrHeap.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrHeap$Click;,
        Lcom/mrkeyboard/app/MrHeap$Done;,
        Lcom/mrkeyboard/app/MrHeap$Work;
    }
.end annotation


# static fields
.field static final AUTHORITY:Ljava/lang/String; = "com.mrkeyboard.app.shots"

.field private static final DIR:Ljava/lang/String; = "shots"

.field static final NAME:Ljava/lang/String; = "mr_heap"

.field static final ROW:Ljava/lang/String; = "mr_perf_heap"

.field static volatile sBusy:Z


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 44
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static fill(Landroid/preference/PreferenceActivity;)V
    .locals 2

    .prologue
    .line 49
    :try_start_0
    const-string v0, "mr_perf_heap"

    invoke-virtual {p0, v0}, Landroid/preference/PreferenceActivity;->findPreference(Ljava/lang/CharSequence;)Landroid/preference/Preference;

    move-result-object v0

    .line 50
    if-eqz v0, :cond_0

    new-instance v1, Lcom/mrkeyboard/app/MrHeap$Click;

    invoke-direct {v1, p0, v0}, Lcom/mrkeyboard/app/MrHeap$Click;-><init>(Landroid/content/Context;Landroid/preference/Preference;)V

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setOnPreferenceClickListener(Landroid/preference/Preference$OnPreferenceClickListener;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 54
    :cond_0
    :goto_0
    return-void

    .line 51
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static save(Landroid/content/Context;)Ljava/io/File;
    .locals 4

    .prologue
    .line 58
    new-instance v1, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v0

    const-string v2, "shots"

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 59
    new-instance v2, Ljava/io/File;

    const-string v0, "mr_heap.hprof"

    invoke-direct {v2, v1, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 60
    new-instance v0, Ljava/io/File;

    const-string v3, "mr_heap.zip"

    invoke-direct {v0, v1, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 62
    :try_start_0
    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    .line 63
    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/os/Debug;->dumpHprofData(Ljava/lang/String;)V

    .line 64
    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrHeap;->zip(Ljava/io/File;Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 70
    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    .line 68
    :goto_0
    return-object v0

    .line 66
    :catch_0
    move-exception v1

    .line 67
    :try_start_1
    invoke-virtual {v0}, Ljava/io/File;->delete()Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 68
    const/4 v0, 0x0

    .line 70
    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    goto :goto_0

    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    .line 71
    throw v0
.end method

.method static share(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;
    .locals 2

    .prologue
    .line 91
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.SEND"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 92
    const-string v1, "application/zip"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 93
    const-string v1, "android.intent.extra.STREAM"

    invoke-virtual {v0, v1, p0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    .line 94
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 95
    invoke-static {v0, p1}, Landroid/content/Intent;->createChooser(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;

    move-result-object v0

    .line 96
    const v1, 0x10000001

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 97
    return-object v0
.end method

.method private static zip(Ljava/io/File;Ljava/io/File;)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 75
    new-instance v1, Ljava/util/zip/ZipOutputStream;

    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v1, v0}, Ljava/util/zip/ZipOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 76
    new-instance v2, Ljava/io/FileInputStream;

    invoke-direct {v2, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 78
    :try_start_0
    new-instance v0, Ljava/util/zip/ZipEntry;

    const-string v3, "mr_heap.hprof"

    invoke-direct {v0, v3}, Ljava/util/zip/ZipEntry;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/util/zip/ZipOutputStream;->putNextEntry(Ljava/util/zip/ZipEntry;)V

    .line 79
    const/high16 v0, 0x10000

    new-array v0, v0, [B

    .line 81
    :goto_0
    invoke-virtual {v2, v0}, Ljava/io/FileInputStream;->read([B)I

    move-result v3

    if-lez v3, :cond_0

    const/4 v4, 0x0

    invoke-virtual {v1, v0, v4, v3}, Ljava/util/zip/ZipOutputStream;->write([BII)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 84
    :catchall_0
    move-exception v0

    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V

    .line 85
    invoke-virtual {v1}, Ljava/util/zip/ZipOutputStream;->close()V

    .line 86
    throw v0

    .line 82
    :cond_0
    :try_start_1
    invoke-virtual {v1}, Ljava/util/zip/ZipOutputStream;->closeEntry()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 84
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V

    .line 85
    invoke-virtual {v1}, Ljava/util/zip/ZipOutputStream;->close()V

    .line 87
    return-void
.end method
