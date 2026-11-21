.class Lcom/mrkeyboard/app/MrThemesActivity$30;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrColorPicker$Listener;


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

.field final synthetic val$bar:Lcom/mrkeyboard/app/MrOpacityBar;

.field final synthetic val$look:[Lcom/mrkeyboard/app/MrKeyLook;

.field final synthetic val$moved:[Z

.field final synthetic val$pale:Z

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$style:[I

.field final synthetic val$which:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;[ZI[I[Lcom/mrkeyboard/app/MrKeyLook;ZLcom/mrkeyboard/app/MrOpacityBar;Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1414
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$moved:[Z

    iput p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$which:I

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$style:[I

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iput-boolean p6, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$pale:Z

    iput-object p7, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$bar:Lcom/mrkeyboard/app/MrOpacityBar;

    iput-object p8, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$redraw:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onColor(I)V
    .locals 5

    .prologue
    const/4 v1, 0x1

    const/4 v4, 0x0

    .line 1416
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$moved:[Z

    aput-boolean v1, v0, v4

    .line 1418
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$which:I

    if-eq v0, v1, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$which:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_1

    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$style:[I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-boolean v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$pale:Z

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->ownFromPreset([I[Lcom/mrkeyboard/app/MrKeyLook;Z)V

    .line 1419
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    aget-object v1, v1, v4

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$which:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$style:[I

    aget v3, v3, v4

    invoke-static {v1, v2, v3, p1}, Lcom/mrkeyboard/app/MrThemesActivity;->withPicked(Lcom/mrkeyboard/app/MrKeyLook;III)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v1

    aput-object v1, v0, v4

    .line 1420
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$bar:Lcom/mrkeyboard/app/MrOpacityBar;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$bar:Lcom/mrkeyboard/app/MrOpacityBar;

    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/MrOpacityBar;->setColor(I)V

    .line 1421
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$30;->val$redraw:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1422
    return-void
.end method
