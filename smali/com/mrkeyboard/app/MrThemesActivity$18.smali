.class Lcom/mrkeyboard/app/MrThemesActivity$18;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrThemesActivity$Setter;


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

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$softNow:[I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;[ILjava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 942
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$softNow:[I

    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$redraw:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public set(I)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 944
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$softNow:[I

    const/16 v1, 0x46

    invoke-static {p1, v2, v1}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v1

    aput v1, v0, v2

    .line 945
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$redraw:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 946
    return-void
.end method
