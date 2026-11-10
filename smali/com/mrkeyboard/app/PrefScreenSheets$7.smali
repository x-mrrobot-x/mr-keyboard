.class Lcom/mrkeyboard/app/PrefScreenSheets$7;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->buildSheetCard(ILcom/mrkeyboard/app/SheetModel$Sheet;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

.field final synthetic val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 193
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$7;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$7;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 195
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$7;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$7;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$500(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;)V

    .line 196
    return-void
.end method
