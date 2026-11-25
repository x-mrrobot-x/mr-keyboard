.class Lcom/mrkeyboard/app/PrefScreenSheets$13;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Lcom/mrkeyboard/app/SheetNameDialog$OnNamed;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->promptNameForNewSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

.field final synthetic val$fallbackBadge:Ljava/lang/String;

.field final synthetic val$fallbackName:Ljava/lang/String;

.field final synthetic val$source:Lcom/mrkeyboard/app/SheetModel$Sheet;

.field final synthetic val$templateKind:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;Ljava/lang/String;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 382
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->val$fallbackName:Ljava/lang/String;

    iput-object p3, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->val$fallbackBadge:Ljava/lang/String;

    iput p4, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->val$templateKind:I

    iput-object p5, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->val$source:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onNamed(Ljava/lang/String;Ljava/lang/String;)V
    .locals 5

    .prologue
    .line 384
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1400(Lcom/mrkeyboard/app/PrefScreenSheets;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 407
    :goto_0
    return-void

    .line 385
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1300(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;

    move-result-object v0

    const-string v1, "custom"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetModel;->makeUniqueId(Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 386
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->val$fallbackName:Ljava/lang/String;

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 387
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->val$fallbackBadge:Ljava/lang/String;

    invoke-static {p2, v0}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 389
    iget v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->val$templateKind:I

    const/4 v4, 0x1

    if-ne v0, v4, :cond_1

    .line 390
    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/SheetModel;->createNumpadTemplate(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    .line 402
    :goto_1
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1300(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 403
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1300(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 404
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1500(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 405
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    const-wide/16 v2, -0x2bc

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1602(Lcom/mrkeyboard/app/PrefScreenSheets;J)J

    .line 406
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$400(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;)V

    goto :goto_0

    .line 391
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->val$templateKind:I

    const/4 v4, 0x2

    if-ne v0, v4, :cond_2

    .line 392
    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/SheetModel;->createNavEditTemplate(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    goto :goto_1

    .line 393
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->val$source:Lcom/mrkeyboard/app/SheetModel$Sheet;

    if-eqz v0, :cond_3

    .line 394
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$13;->val$source:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    .line 395
    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 396
    iput-object v2, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 397
    iput-object v3, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    .line 398
    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    goto :goto_1

    .line 400
    :cond_3
    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/SheetModel;->createBlankTemplate(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    goto :goto_1
.end method
