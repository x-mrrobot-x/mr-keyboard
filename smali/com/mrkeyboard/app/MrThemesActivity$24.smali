.class Lcom/mrkeyboard/app/MrThemesActivity$24;
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
    .line 1020
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$style:[I

    iput p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$n:I

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$redraw:Ljava/lang/Runnable;

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$draw:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 1022
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$style:[I

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$n:I

    aput v1, v0, v2

    .line 1023
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$redraw:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1024
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$draw:[Ljava/lang/Runnable;

    aget-object v0, v0, v2

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1025
    return-void
.end method
