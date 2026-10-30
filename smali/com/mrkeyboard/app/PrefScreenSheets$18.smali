.class Lcom/mrkeyboard/app/PrefScreenSheets$18;
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

.field final synthetic val$badgeEt:Landroid/widget/EditText;

.field final synthetic val$fallbackBadge:Ljava/lang/String;

.field final synthetic val$fallbackName:Ljava/lang/String;

.field final synthetic val$nameEt:Landroid/widget/EditText;

.field final synthetic val$sourceToCopy:Lcom/mrkeyboard/app/SheetModel$Sheet;

.field final synthetic val$templateKind:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/widget/EditText;Ljava/lang/String;Landroid/widget/EditText;Ljava/lang/String;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .registers 8

    .line 665
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->val$nameEt:Landroid/widget/EditText;

    iput-object p3, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->val$fallbackName:Ljava/lang/String;

    iput-object p4, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->val$badgeEt:Landroid/widget/EditText;

    iput-object p5, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->val$fallbackBadge:Ljava/lang/String;

    iput p6, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->val$templateKind:I

    iput-object p7, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->val$sourceToCopy:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .registers 6

    .line 668
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    # getter for: Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;
    invoke-static {p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1200(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;

    move-result-object p1

    const-string p2, "custom"

    invoke-static {p1, p2}, Lcom/mrkeyboard/app/SheetModel;->makeUniqueId(Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 669
    iget-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->val$nameEt:Landroid/widget/EditText;

    invoke-virtual {p2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p2

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->val$fallbackName:Ljava/lang/String;

    invoke-static {p2, v0}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    .line 670
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->val$badgeEt:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->val$fallbackBadge:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 672
    iget v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->val$templateKind:I

    const/4 v2, 0x1

    if-ne v1, v2, :cond_36

    .line 673
    invoke-static {p1, p2, v0}, Lcom/mrkeyboard/app/SheetModel;->createNumpadTemplate(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object p1

    goto :goto_59

    .line 674
    :cond_36
    iget v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->val$templateKind:I

    const/4 v2, 0x2

    if-ne v1, v2, :cond_40

    .line 675
    invoke-static {p1, p2, v0}, Lcom/mrkeyboard/app/SheetModel;->createNavEditTemplate(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object p1

    goto :goto_59

    .line 676
    :cond_40
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->val$sourceToCopy:Lcom/mrkeyboard/app/SheetModel$Sheet;

    if-eqz v1, :cond_55

    .line 677
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->val$sourceToCopy:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v1

    .line 678
    iput-object p1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 679
    iput-object p2, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 680
    iput-object v0, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    .line 681
    const/4 p1, 0x0

    iput-boolean p1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    move-object p1, v1

    goto :goto_59

    .line 683
    :cond_55
    invoke-static {p1, p2, v0}, Lcom/mrkeyboard/app/SheetModel;->createBlankTemplate(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object p1

    .line 685
    :goto_59
    iget-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    # getter for: Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;
    invoke-static {p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1200(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;

    move-result-object p2

    invoke-virtual {p2, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 686
    iget-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    # getter for: Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;
    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1200(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-static {p2, v0}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 687
    iget-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V
    invoke-static {p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1300(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 688
    iget-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object p1, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->openEditor(Ljava/lang/String;)V
    invoke-static {p2, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$500(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;)V

    .line 689
    return-void
.end method
