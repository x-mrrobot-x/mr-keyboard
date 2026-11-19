.class Lcom/mrkeyboard/app/MrThemesActivity$19;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->showCrop(Landroid/graphics/Bitmap;Lcom/mrkeyboard/app/MrBackdrop$Spec;IZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$pending:Z


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;Z)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 841
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$19;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-boolean p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$19;->val$pending:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .prologue
    .line 843
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$19;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrThemesActivity;->closeDialog()V

    .line 844
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$19;->val$pending:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$19;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->discardPending(Landroid/content/Context;)V

    .line 845
    :cond_0
    return-void
.end method
