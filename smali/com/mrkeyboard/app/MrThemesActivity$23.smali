.class Lcom/mrkeyboard/app/MrThemesActivity$23;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->fillKeys(Landroid/widget/LinearLayout;[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$draw:[Ljava/lang/Runnable;

.field final synthetic val$n:I

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$style:[I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;[IILjava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 998
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->val$style:[I

    iput p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->val$n:I

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->val$redraw:Ljava/lang/Runnable;

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->val$draw:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 1000
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->val$style:[I

    aget v0, v0, v3

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->kindOf(I)I

    move-result v0

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->val$n:I

    if-ne v0, v1, :cond_0

    .line 1004
    :goto_0
    return-void

    .line 1001
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->val$style:[I

    sget-object v1, Lcom/mrkeyboard/app/MrBackdrop;->KIND_FIRST:[I

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->val$n:I

    aget v1, v1, v2

    aput v1, v0, v3

    .line 1002
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->val$redraw:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1003
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->val$draw:[Ljava/lang/Runnable;

    aget-object v0, v0, v3

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    goto :goto_0
.end method
