.class Lcom/mrkeyboard/app/MrLearnedActivity$3;
.super Ljava/lang/Object;
.source "MrLearnedActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrLearnedActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrLearnedActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrLearnedActivity;)V
    .locals 0

    .prologue
    .line 150
    iput-object p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$3;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 152
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$3;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$3;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$300(Lcom/mrkeyboard/app/MrLearnedActivity;)I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$302(Lcom/mrkeyboard/app/MrLearnedActivity;I)I

    .line 153
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$3;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    const/16 v1, 0x32

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$102(Lcom/mrkeyboard/app/MrLearnedActivity;I)I

    .line 154
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$3;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$200(Lcom/mrkeyboard/app/MrLearnedActivity;)V

    .line 155
    return-void

    .line 152
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
