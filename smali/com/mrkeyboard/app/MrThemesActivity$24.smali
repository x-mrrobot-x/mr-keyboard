.class Lcom/mrkeyboard/app/MrThemesActivity$24;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->addSwatchDot(Landroid/widget/LinearLayout;ILjava/lang/String;ZI[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$draw:[Ljava/lang/Runnable;

.field final synthetic val$look:[Lcom/mrkeyboard/app/MrKeyLook;

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$rgb:I

.field final synthetic val$style:[I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;I[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1137
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$rgb:I

    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$style:[I

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$redraw:Ljava/lang/Runnable;

    iput-object p6, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$draw:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    .line 1139
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$rgb:I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$style:[I

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->chooseSuggested(I[I[Lcom/mrkeyboard/app/MrKeyLook;)V

    .line 1140
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$redraw:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1141
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$draw:[Ljava/lang/Runnable;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1142
    return-void
.end method
