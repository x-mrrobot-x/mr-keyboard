.class Lcom/mrkeyboard/app/PrefScreenSheets$14;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->pickExistingSheetToCopy()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 344
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3

    .prologue
    .line 346
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    const/4 v2, 0x3

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$14;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1400(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-static {v1, v2, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1300(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    .line 347
    return-void
.end method
