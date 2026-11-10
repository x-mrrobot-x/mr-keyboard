.class Lcom/mrkeyboard/app/MrImportActivity$10;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrKit$LangPick;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity;->refreshLanguages()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrImportActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 269
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$10;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPick(Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 271
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$10;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1300(Lcom/mrkeyboard/app/MrImportActivity;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 277
    :goto_0
    return-void

    .line 272
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$10;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrImportActivity;->access$1402(Lcom/mrkeyboard/app/MrImportActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 273
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$10;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1500(Lcom/mrkeyboard/app/MrImportActivity;)Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrLang;->remember(Landroid/content/SharedPreferences;Ljava/lang/String;)V

    .line 275
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$10;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1600(Lcom/mrkeyboard/app/MrImportActivity;)V

    .line 276
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$10;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$1700(Lcom/mrkeyboard/app/MrImportActivity;)V

    goto :goto_0
.end method
