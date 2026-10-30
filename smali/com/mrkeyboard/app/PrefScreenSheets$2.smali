.class Lcom/mrkeyboard/app/PrefScreenSheets$2;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

.field final synthetic val$menuBtn:Landroid/widget/ImageView;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/widget/ImageView;)V
    .registers 3

    .line 90
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$2;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$2;->val$menuBtn:Landroid/widget/ImageView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 3

    .line 93
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$2;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$2;->val$menuBtn:Landroid/widget/ImageView;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->showHeaderMenu(Landroid/view/View;)V
    invoke-static {p1, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$000(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/view/View;)V

    .line 94
    return-void
.end method
