.class Lcom/mrkeyboard/app/MrTourActivity$2;
.super Ljava/lang/Object;
.source "MrTourActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrTourActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrTourActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrTourActivity;)V
    .locals 0

    .prologue
    .line 134
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTourActivity$2;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 136
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$2;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$100(Lcom/mrkeyboard/app/MrTourActivity;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 142
    :cond_0
    :goto_0
    return-void

    .line 137
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$2;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrTourActivity;->access$102(Lcom/mrkeyboard/app/MrTourActivity;Z)Z

    .line 138
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$2;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$000(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/widget/LinearLayout;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 139
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$2;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$000(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/widget/LinearLayout;

    move-result-object v0

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setAlpha(F)V

    .line 140
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$2;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTourActivity;->access$000(Lcom/mrkeyboard/app/MrTourActivity;)Landroid/widget/LinearLayout;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setTranslationX(F)V

    goto :goto_0
.end method
