.class Lcom/mrkeyboard/app/MrThemesActivity$9$1;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity$9;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrThemesActivity$9;

.field final synthetic val$ok:Z


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity$9;Z)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 474
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrThemesActivity$9;

    iput-boolean p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$9$1;->val$ok:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 476
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$9$1;->this$1:Lcom/mrkeyboard/app/MrThemesActivity$9;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrThemesActivity$9;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-boolean v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$9$1;->val$ok:Z

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->imported(Z)V

    .line 477
    return-void
.end method
