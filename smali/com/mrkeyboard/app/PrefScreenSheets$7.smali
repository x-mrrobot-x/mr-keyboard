.class Lcom/mrkeyboard/app/PrefScreenSheets$7;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->buildAbcCard()Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

.field final synthetic val$abc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

.field final synthetic val$more:Landroid/widget/ImageView;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/widget/ImageView;Lcom/mrkeyboard/app/MrAbcKeys$Model;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 242
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$7;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$7;->val$more:Landroid/widget/ImageView;

    iput-object p3, p0, Lcom/mrkeyboard/app/PrefScreenSheets$7;->val$abc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 244
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$7;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$7;->val$more:Landroid/widget/ImageView;

    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$7;->val$abc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$500(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/view/View;Lcom/mrkeyboard/app/MrAbcKeys$Model;)V

    .line 245
    return-void
.end method
