.class Lcom/mrkeyboard/app/MrThemesActivity$16$1;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity$16;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrThemesActivity$16;

.field final synthetic val$n:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity$16;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 772
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$16$1;->this$1:Lcom/mrkeyboard/app/MrThemesActivity$16;

    iput p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$16$1;->val$n:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 774
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$16$1;->this$1:Lcom/mrkeyboard/app/MrThemesActivity$16;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$style:[I

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$16$1;->val$n:I

    aput v1, v0, v2

    .line 775
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$16$1;->this$1:Lcom/mrkeyboard/app/MrThemesActivity$16;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$redraw:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 776
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$16$1;->this$1:Lcom/mrkeyboard/app/MrThemesActivity$16;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrThemesActivity$16;->val$draw:[Ljava/lang/Runnable;

    aget-object v0, v0, v2

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 777
    return-void
.end method
