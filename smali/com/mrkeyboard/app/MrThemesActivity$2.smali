.class Lcom/mrkeyboard/app/MrThemesActivity$2;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$tab:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 189
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$2;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$2;->val$tab:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 191
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$2;->val$tab:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$2;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget v1, v1, Lcom/mrkeyboard/app/MrThemesActivity;->mTab:I

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$2;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$2;->val$tab:I

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->showTab(I)V

    .line 192
    :cond_0
    return-void
.end method
