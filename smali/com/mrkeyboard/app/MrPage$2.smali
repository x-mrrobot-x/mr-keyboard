.class Lcom/mrkeyboard/app/MrPage$2;
.super Ljava/lang/Object;
.source "MrPage.java"

# interfaces
.implements Landroid/view/View$OnLayoutChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPage;->keepPosition(Ljava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrPage;

.field final synthetic val$y:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPage;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 170
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPage$2;->this$0:Lcom/mrkeyboard/app/MrPage;

    iput p2, p0, Lcom/mrkeyboard/app/MrPage$2;->val$y:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onLayoutChange(Landroid/view/View;IIIIIIII)V
    .locals 3

    .prologue
    .line 173
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPage$2;->this$0:Lcom/mrkeyboard/app/MrPage;

    invoke-virtual {v0, p0}, Lcom/mrkeyboard/app/MrPage;->removeOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V

    .line 174
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPage$2;->this$0:Lcom/mrkeyboard/app/MrPage;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrPage;->getScrollY()I

    move-result v0

    iget v1, p0, Lcom/mrkeyboard/app/MrPage$2;->val$y:I

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPage$2;->this$0:Lcom/mrkeyboard/app/MrPage;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPage$2;->this$0:Lcom/mrkeyboard/app/MrPage;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrPage;->getScrollX()I

    move-result v1

    iget v2, p0, Lcom/mrkeyboard/app/MrPage$2;->val$y:I

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrPage;->scrollTo(II)V

    .line 175
    :cond_0
    return-void
.end method
