.class Lcom/mrkeyboard/app/MrThemesActivity$21;
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

.field final synthetic val$look:[Lcom/mrkeyboard/app/MrKeyLook;

.field final synthetic val$pending:Z

.field final synthetic val$softNow:[I

.field final synthetic val$spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

.field final synthetic val$style:[I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;Lcom/mrkeyboard/app/MrBackdrop$Spec;[I[I[Lcom/mrkeyboard/app/MrKeyLook;Z)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 933
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$21;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$21;->val$spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$21;->val$softNow:[I

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$21;->val$style:[I

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$21;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iput-boolean p6, p0, Lcom/mrkeyboard/app/MrThemesActivity$21;->val$pending:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 935
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$21;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$21;->val$spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$21;->val$softNow:[I

    aget v2, v2, v5

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$21;->val$style:[I

    aget v3, v3, v5

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity$21;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    aget-object v4, v4, v5

    iget-boolean v5, p0, Lcom/mrkeyboard/app/MrThemesActivity$21;->val$pending:Z

    invoke-virtual/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemesActivity;->applyBackdrop(Lcom/mrkeyboard/app/MrBackdrop$Spec;IILcom/mrkeyboard/app/MrKeyLook;Z)V

    .line 936
    return-void
.end method
