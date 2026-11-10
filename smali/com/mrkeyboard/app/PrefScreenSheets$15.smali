.class Lcom/mrkeyboard/app/PrefScreenSheets$15;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


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

.field final synthetic val$fields:[Landroid/widget/EditText;

.field final synthetic val$source:Lcom/mrkeyboard/app/SheetModel$Sheet;

.field final synthetic val$templateKind:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;[Landroid/widget/EditText;Ljava/lang/String;Ljava/lang/String;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 392
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$fields:[Landroid/widget/EditText;

    iput-object p3, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$fallbackName:Ljava/lang/String;

    iput-object p4, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$fallbackBadge:Ljava/lang/String;

    iput p5, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$templateKind:I

    iput-object p6, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$source:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 6

    .prologue
    const/4 v4, 0x1

    const/4 v5, 0x0

    .line 394
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1400(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;

    move-result-object v0

    const-string v1, "custom"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetModel;->makeUniqueId(Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 395
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$fields:[Landroid/widget/EditText;

    aget-object v0, v0, v5

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$fallbackName:Ljava/lang/String;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 396
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$fields:[Landroid/widget/EditText;

    aget-object v0, v0, v4

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v3, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$fallbackBadge:Ljava/lang/String;

    invoke-static {v0, v3}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 398
    iget v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$templateKind:I

    if-ne v0, v4, :cond_0

    .line 399
    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/SheetModel;->createNumpadTemplate(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    .line 411
    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1400(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 412
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1400(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 413
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1500(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 414
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$500(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;)V

    .line 415
    return-void

    .line 400
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$templateKind:I

    const/4 v4, 0x2

    if-ne v0, v4, :cond_1

    .line 401
    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/SheetModel;->createNavEditTemplate(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    goto :goto_0

    .line 402
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$source:Lcom/mrkeyboard/app/SheetModel$Sheet;

    if-eqz v0, :cond_2

    .line 403
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$source:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    .line 404
    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 405
    iput-object v2, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 406
    iput-object v3, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    .line 407
    iput-boolean v5, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    goto :goto_0

    .line 409
    :cond_2
    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/SheetModel;->createBlankTemplate(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    goto :goto_0
.end method
