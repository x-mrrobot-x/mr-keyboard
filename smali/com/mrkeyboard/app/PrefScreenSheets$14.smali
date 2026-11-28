.class Lcom/mrkeyboard/app/PrefScreenSheets$14;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Lcom/mrkeyboard/app/SheetNameDialog$OnNamed;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->showRenameAbcDialog(Lcom/mrkeyboard/app/MrAbcKeys$Model;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

.field final synthetic val$abc:Lcom/mrkeyboard/app/MrAbcKeys$Model;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/MrAbcKeys$Model;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 358
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->val$abc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onNamed(Ljava/lang/String;Ljava/lang/String;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 360
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->val$abc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->val$abc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-static {p1, v1}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 361
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->val$abc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->val$abc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-static {p2, v1}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    .line 362
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->val$abc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAbcKeys;->save(Landroid/content/Context;Lcom/mrkeyboard/app/MrAbcKeys$Model;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    const-string v2, "mr_abc_save_failed"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1500(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1600(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;Z)V

    .line 363
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1700(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 364
    return-void
.end method
