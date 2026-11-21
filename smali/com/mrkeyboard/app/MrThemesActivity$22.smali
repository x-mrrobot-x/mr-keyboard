.class Lcom/mrkeyboard/app/MrThemesActivity$22;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->fillKeys(Landroid/widget/LinearLayout;Z[II[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$draw:[Ljava/lang/Runnable;

.field final synthetic val$look:[Lcom/mrkeyboard/app/MrKeyLook;

.field final synthetic val$n:I

.field final synthetic val$pale:Z

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$style:[I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;[IIZ[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1084
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$style:[I

    iput p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$n:I

    iput-boolean p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$pale:Z

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iput-object p6, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$redraw:Ljava/lang/Runnable;

    iput-object p7, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$draw:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 1086
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$style:[I

    aget v0, v0, v4

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->kindOf(I)I

    move-result v0

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$n:I

    if-ne v0, v1, :cond_0

    .line 1090
    :goto_0
    return-void

    .line 1087
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->KIND_FIRST:[I

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$n:I

    aget v0, v0, v1

    iget-boolean v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$pale:Z

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$style:[I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    invoke-static {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->choosePreset(IZ[I[Lcom/mrkeyboard/app/MrKeyLook;)V

    .line 1088
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$redraw:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1089
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$draw:[Ljava/lang/Runnable;

    aget-object v0, v0, v4

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    goto :goto_0
.end method
