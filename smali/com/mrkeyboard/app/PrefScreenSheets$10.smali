.class Lcom/mrkeyboard/app/PrefScreenSheets$10;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->buildSheetCard(ILcom/mrkeyboard/app/SheetModel$Sheet;Z)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

.field final synthetic val$idx:I

.field final synthetic val$moreBtn:Landroid/widget/ImageView;

.field final synthetic val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/widget/ImageView;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .registers 5

    .line 337
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$10;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$10;->val$moreBtn:Landroid/widget/ImageView;

    iput p3, p0, Lcom/mrkeyboard/app/PrefScreenSheets$10;->val$idx:I

    iput-object p4, p0, Lcom/mrkeyboard/app/PrefScreenSheets$10;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 5

    .line 340
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$10;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$10;->val$moreBtn:Landroid/widget/ImageView;

    iget v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$10;->val$idx:I

    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$10;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->showCardContextMenu(Landroid/view/View;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    invoke-static {p1, v0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$700(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/view/View;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    .line 341
    return-void
.end method
