.class Lcom/mrkeyboard/app/MrLearnedActivity$8;
.super Ljava/lang/Object;
.source "MrLearnedActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrKit$LangPick;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrLearnedActivity;->refreshAll()V
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
    .line 242
    iput-object p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$8;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPick(Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 244
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$8;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$402(Lcom/mrkeyboard/app/MrLearnedActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 245
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$8;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    const-string v1, "mr_words"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrLearnedActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrLang;->remember(Landroid/content/SharedPreferences;Ljava/lang/String;)V

    .line 246
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$8;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    const/16 v1, 0x32

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$102(Lcom/mrkeyboard/app/MrLearnedActivity;I)I

    .line 247
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$8;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$700(Lcom/mrkeyboard/app/MrLearnedActivity;)V

    .line 248
    return-void
.end method
