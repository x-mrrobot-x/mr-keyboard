.class Lcom/mrkeyboard/app/MrKeySound$1;
.super Ljava/lang/Object;
.source "MrKeySound.java"

# interfaces
.implements Landroid/media/SoundPool$OnLoadCompleteListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrKeySound;->ensure(Landroid/content/Context;Ljava/lang/String;)I
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 161
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onLoadComplete(Landroid/media/SoundPool;II)V
    .locals 7

    .prologue
    const/high16 v2, -0x40800000    # -1.0f

    const/4 v1, 0x1

    .line 163
    .line 164
    const-class v3, Lcom/mrkeyboard/app/MrKeySound;

    monitor-enter v3

    .line 165
    :try_start_0
    invoke-static {}, Lcom/mrkeyboard/app/MrKeySound;->access$000()I

    move-result v0

    if-ne p2, v0, :cond_1

    .line 166
    if-nez p3, :cond_3

    move v0, v1

    :goto_0
    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeySound;->access$102(I)I

    .line 167
    invoke-static {}, Lcom/mrkeyboard/app/MrKeySound;->access$100()I

    move-result v0

    if-ne v0, v1, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrKeySound;->access$200()F

    move-result v2

    .line 168
    :cond_0
    const/high16 v0, -0x40800000    # -1.0f

    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeySound;->access$202(F)F

    .line 170
    :cond_1
    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 171
    const/4 v0, 0x0

    cmpl-float v0, v2, v0

    if-ltz v0, :cond_2

    .line 173
    const/4 v4, 0x1

    const/4 v5, 0x0

    const/high16 v6, 0x3f800000    # 1.0f

    move-object v0, p1

    move v1, p2

    move v3, v2

    :try_start_1
    invoke-virtual/range {v0 .. v6}, Landroid/media/SoundPool;->play(IFFIIF)I
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    .line 178
    :cond_2
    :goto_1
    return-void

    .line 166
    :cond_3
    const/4 v0, 0x2

    goto :goto_0

    .line 170
    :catchall_0
    move-exception v0

    :try_start_2
    monitor-exit v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0

    .line 174
    :catch_0
    move-exception v0

    goto :goto_1
.end method
