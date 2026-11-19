.class Lcom/mrkeyboard/app/MrPage$1;
.super Ljava/lang/Object;
.source "MrPage.java"

# interfaces
.implements Landroid/view/View$OnLayoutChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPage;->fling(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrPage;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPage;)V
    .locals 0

    .prologue
    .line 143
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPage$1;->this$0:Lcom/mrkeyboard/app/MrPage;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onLayoutChange(Landroid/view/View;IIIIIIII)V
    .locals 3

    .prologue
    .line 145
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPage$1;->this$0:Lcom/mrkeyboard/app/MrPage;

    invoke-virtual {v0, p0}, Lcom/mrkeyboard/app/MrPage;->removeOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V

    .line 146
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPage$1;->this$0:Lcom/mrkeyboard/app/MrPage;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPage;->access$000(Lcom/mrkeyboard/app/MrPage;)I

    move-result v0

    .line 147
    iget-object v1, p0, Lcom/mrkeyboard/app/MrPage$1;->this$0:Lcom/mrkeyboard/app/MrPage;

    const/4 v2, 0x0

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrPage;->access$002(Lcom/mrkeyboard/app/MrPage;I)I

    .line 148
    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPage$1;->this$0:Lcom/mrkeyboard/app/MrPage;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPage;->access$100(Lcom/mrkeyboard/app/MrPage;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPage$1;->this$0:Lcom/mrkeyboard/app/MrPage;

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrPage;->fling(I)V

    .line 149
    :cond_0
    return-void
.end method
