.class Lcom/mrkeyboard/app/MrThemesActivity$8;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->showPreview(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;IZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$pending:Z

.field final synthetic val$soft:I

.field final synthetic val$spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;Lcom/mrkeyboard/app/MrBackdrop$Spec;IZ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 478
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$8;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$8;->val$spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iput p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$8;->val$soft:I

    iput-boolean p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$8;->val$pending:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 4

    .prologue
    .line 480
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$8;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrThemesActivity;->closeDialog()V

    .line 481
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$8;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$8;->val$spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$8;->val$soft:I

    iget-boolean v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$8;->val$pending:Z

    invoke-virtual {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->applyBackdrop(Lcom/mrkeyboard/app/MrBackdrop$Spec;IZ)V

    .line 482
    return-void
.end method
