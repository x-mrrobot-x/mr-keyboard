.class Lcom/mrkeyboard/app/MrThemesActivity$34;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->showColorPicker(Ljava/lang/String;I[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$cp:Lcom/mrkeyboard/app/MrColorPicker;

.field final synthetic val$draw:[Ljava/lang/Runnable;

.field final synthetic val$hasOpacity:Z

.field final synthetic val$look:[Lcom/mrkeyboard/app/MrKeyLook;

.field final synthetic val$moved:[Z

.field final synthetic val$pale:Z

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$style:[I

.field final synthetic val$which:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;[ZZI[I[Lcom/mrkeyboard/app/MrKeyLook;ZLcom/mrkeyboard/app/MrColorPicker;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1460
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$moved:[Z

    iput-boolean p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$hasOpacity:Z

    iput p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$which:I

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$style:[I

    iput-object p6, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iput-boolean p7, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$pale:Z

    iput-object p8, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$cp:Lcom/mrkeyboard/app/MrColorPicker;

    iput-object p9, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$redraw:Ljava/lang/Runnable;

    iput-object p10, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$draw:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 6

    .prologue
    const/4 v2, 0x2

    const/4 v5, 0x0

    .line 1463
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$moved:[Z

    aget-boolean v0, v0, v5

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$hasOpacity:Z

    if-nez v0, :cond_3

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$which:I

    if-eq v0, v2, :cond_3

    .line 1464
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$which:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$which:I

    if-ne v0, v2, :cond_2

    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$style:[I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-boolean v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$pale:Z

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->ownFromPreset([I[Lcom/mrkeyboard/app/MrKeyLook;Z)V

    .line 1465
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    aget-object v1, v1, v5

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$which:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$style:[I

    aget v3, v3, v5

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$cp:Lcom/mrkeyboard/app/MrColorPicker;

    invoke-virtual {v4}, Lcom/mrkeyboard/app/MrColorPicker;->color()I

    move-result v4

    invoke-static {v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrThemesActivity;->withPicked(Lcom/mrkeyboard/app/MrKeyLook;III)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v1

    aput-object v1, v0, v5

    .line 1467
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$redraw:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1468
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrThemesActivity;->closePicker()V

    .line 1469
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$34;->val$draw:[Ljava/lang/Runnable;

    aget-object v0, v0, v5

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1470
    return-void
.end method
