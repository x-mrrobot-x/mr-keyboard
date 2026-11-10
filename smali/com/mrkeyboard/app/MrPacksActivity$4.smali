.class Lcom/mrkeyboard/app/MrPacksActivity$4;
.super Ljava/lang/Object;
.source "MrPacksActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPacksActivity;->refreshMem()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrPacksActivity;

.field final synthetic val$dir:Ljava/io/File;

.field final synthetic val$target:Landroid/preference/Preference;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/io/File;Landroid/preference/Preference;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 192
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$4;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrPacksActivity$4;->val$dir:Ljava/io/File;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrPacksActivity$4;->val$target:Landroid/preference/Preference;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 194
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$4;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$4;->val$dir:Ljava/io/File;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrDiag;->collect(Ljava/io/File;)Lcom/mrkeyboard/app/MrDiag$Report;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$500(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrDiag$Report;)Ljava/lang/String;

    move-result-object v0

    .line 195
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$4;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$200(Lcom/mrkeyboard/app/MrPacksActivity;)Landroid/os/Handler;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/MrPacksActivity$4$1;

    invoke-direct {v2, p0, v0}, Lcom/mrkeyboard/app/MrPacksActivity$4$1;-><init>(Lcom/mrkeyboard/app/MrPacksActivity$4;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 200
    return-void
.end method
