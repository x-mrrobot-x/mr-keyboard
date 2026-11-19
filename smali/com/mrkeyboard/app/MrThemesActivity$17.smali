.class Lcom/mrkeyboard/app/MrThemesActivity$17;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


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

.field final synthetic val$softNow:[I

.field final synthetic val$spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

.field final synthetic val$style:[I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;Lcom/mrkeyboard/app/MrBackdrop$Spec;[I[IZ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 863
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$17;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$17;->val$spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$17;->val$softNow:[I

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$17;->val$style:[I

    iput-boolean p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$17;->val$pending:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 865
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$17;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$17;->val$spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$17;->val$softNow:[I

    aget v2, v2, v4

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$17;->val$style:[I

    aget v3, v3, v4

    iget-boolean v4, p0, Lcom/mrkeyboard/app/MrThemesActivity$17;->val$pending:Z

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->applyBackdrop(Lcom/mrkeyboard/app/MrBackdrop$Spec;IIZ)V

    .line 866
    return-void
.end method
