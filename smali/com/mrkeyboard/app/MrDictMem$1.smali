.class Lcom/mrkeyboard/app/MrDictMem$1;
.super Ljava/lang/Object;
.source "MrDictMem.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrDictMem;->fill(Landroid/preference/PreferenceActivity;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$dir:Ljava/io/File;

.field final synthetic val$gen:I

.field final synthetic val$main:Landroid/os/Handler;

.field final synthetic val$owner:Landroid/preference/PreferenceActivity;

.field final synthetic val$row:Landroid/preference/Preference;


# direct methods
.method constructor <init>(Landroid/preference/PreferenceActivity;Ljava/io/File;Landroid/os/Handler;ILandroid/preference/Preference;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 51
    iput-object p1, p0, Lcom/mrkeyboard/app/MrDictMem$1;->val$owner:Landroid/preference/PreferenceActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrDictMem$1;->val$dir:Ljava/io/File;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrDictMem$1;->val$main:Landroid/os/Handler;

    iput p4, p0, Lcom/mrkeyboard/app/MrDictMem$1;->val$gen:I

    iput-object p5, p0, Lcom/mrkeyboard/app/MrDictMem$1;->val$row:Landroid/preference/Preference;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 55
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrDictMem$1;->val$owner:Landroid/preference/PreferenceActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrDictMem$1;->val$dir:Ljava/io/File;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrDiag;->collect(Ljava/io/File;)Lcom/mrkeyboard/app/MrDiag$Report;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrDictMem;->text(Landroid/content/Context;Lcom/mrkeyboard/app/MrDiag$Report;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 60
    iget-object v1, p0, Lcom/mrkeyboard/app/MrDictMem$1;->val$main:Landroid/os/Handler;

    new-instance v2, Lcom/mrkeyboard/app/MrDictMem$1$1;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrDictMem$1$1;-><init>(Lcom/mrkeyboard/app/MrDictMem$1;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 66
    :goto_0
    return-void

    .line 56
    :catch_0
    move-exception v0

    goto :goto_0
.end method
