.class Lcom/mrkeyboard/app/PrefScreenSheets$8;
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


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;I)V
    .registers 3

    .line 315
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$8;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$8;->val$idx:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 4

    .line 318
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$8;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$8;->val$idx:I

    iget v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$8;->val$idx:I

    add-int/lit8 v1, v1, -0x1

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->moveSheet(II)V
    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$600(Lcom/mrkeyboard/app/PrefScreenSheets;II)V

    .line 319
    return-void
.end method
