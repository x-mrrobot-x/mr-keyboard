.class Lcom/mrkeyboard/app/MrThemesActivity$22;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->fillKeys(Landroid/widget/LinearLayout;Z[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
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
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;IZ[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1036
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$n:I

    iput-boolean p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$pale:Z

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$style:[I

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iput-object p6, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$redraw:Ljava/lang/Runnable;

    iput-object p7, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$draw:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 4

    .prologue
    .line 1038
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$n:I

    iget-boolean v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$pale:Z

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$style:[I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    invoke-static {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->choosePreset(IZ[I[Lcom/mrkeyboard/app/MrKeyLook;)V

    .line 1039
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$redraw:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1040
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$draw:[Ljava/lang/Runnable;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1041
    return-void
.end method
