.class Lcom/mrkeyboard/app/MrLearnedActivity$5;
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
    .line 175
    iput-object p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$5;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 177
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$5;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    const-class v1, Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrNav;->intent(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;

    move-result-object v0

    .line 178
    const-string v1, "mr_words_locale"

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity$5;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-static {v2}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$400(Lcom/mrkeyboard/app/MrLearnedActivity;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 179
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$5;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->startActivity(Landroid/content/Intent;)V

    .line 180
    return-void
.end method
