.class Lcom/mrkeyboard/app/MrTour$1;
.super Ljava/lang/Object;
.source "MrTour.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrTour;->download(Landroid/content/Context;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$app:Landroid/content/Context;

.field final synthetic val$locale:Ljava/util/Locale;

.field final synthetic val$step:Ljava/lang/String;


# direct methods
.method constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/util/Locale;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 232
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTour$1;->val$app:Landroid/content/Context;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrTour$1;->val$step:Ljava/lang/String;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrTour$1;->val$locale:Ljava/util/Locale;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    .prologue
    const/4 v0, 0x0

    const/4 v6, 0x0

    .line 234
    .line 236
    :try_start_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrTour$1;->val$app:Landroid/content/Context;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrTour$1;->val$step:Ljava/lang/String;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrTour$1;->val$locale:Ljava/util/Locale;

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrTour;->work(Landroid/content/Context;Ljava/lang/String;Ljava/util/Locale;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v1

    .line 241
    sput-object v1, Lcom/mrkeyboard/app/MrTour;->sError:Ljava/lang/String;

    .line 242
    if-nez v1, :cond_0

    :goto_0
    sput-object v0, Lcom/mrkeyboard/app/MrTour;->sErrorStep:Ljava/lang/String;

    .line 243
    sput-boolean v6, Lcom/mrkeyboard/app/MrTour;->sBusy:Z

    .line 245
    :goto_1
    return-void

    .line 242
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTour$1;->val$step:Ljava/lang/String;

    goto :goto_0

    .line 237
    :catch_0
    move-exception v1

    .line 238
    :try_start_1
    iget-object v2, p0, Lcom/mrkeyboard/app/MrTour$1;->val$app:Landroid/content/Context;

    const-string v3, "mr_dicts_err_io"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v4, v5

    invoke-static {v2, v3, v4}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v1

    .line 239
    if-nez v1, :cond_1

    :try_start_2
    const-string v1, "mr_dicts_err_io"
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 241
    :cond_1
    sput-object v1, Lcom/mrkeyboard/app/MrTour;->sError:Ljava/lang/String;

    .line 242
    if-nez v1, :cond_2

    :goto_2
    sput-object v0, Lcom/mrkeyboard/app/MrTour;->sErrorStep:Ljava/lang/String;

    .line 243
    sput-boolean v6, Lcom/mrkeyboard/app/MrTour;->sBusy:Z

    goto :goto_1

    .line 242
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTour$1;->val$step:Ljava/lang/String;

    goto :goto_2

    .line 241
    :catchall_0
    move-exception v1

    move-object v2, v0

    :goto_3
    sput-object v2, Lcom/mrkeyboard/app/MrTour;->sError:Ljava/lang/String;

    .line 242
    if-nez v2, :cond_3

    :goto_4
    sput-object v0, Lcom/mrkeyboard/app/MrTour;->sErrorStep:Ljava/lang/String;

    .line 243
    sput-boolean v6, Lcom/mrkeyboard/app/MrTour;->sBusy:Z

    .line 244
    throw v1

    .line 242
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTour$1;->val$step:Ljava/lang/String;

    goto :goto_4

    .line 241
    :catchall_1
    move-exception v2

    move-object v7, v2

    move-object v2, v1

    move-object v1, v7

    goto :goto_3
.end method
