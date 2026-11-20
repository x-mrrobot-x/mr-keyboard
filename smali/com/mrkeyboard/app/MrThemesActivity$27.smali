.class Lcom/mrkeyboard/app/MrThemesActivity$27;
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

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$style:[I

.field final synthetic val$which:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;[ZI[I[Lcom/mrkeyboard/app/MrKeyLook;Lcom/mrkeyboard/app/MrOpacityBar;Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1255
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$moved:[Z

    iput p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$which:I

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$style:[I

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iput-object p6, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$bar:Lcom/mrkeyboard/app/MrOpacityBar;

    iput-object p7, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$redraw:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onColor(I)V
    .locals 5

    .prologue
    const/4 v1, 0x1

    const/4 v4, 0x0

    .line 1257
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$moved:[Z

    aput-boolean v1, v0, v4

    .line 1259
    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$which:I

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$style:[I

    aget v0, v0, v4

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->isOwnStyle(I)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$style:[I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$style:[I

    aget v1, v1, v4

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->kindOf(I)I

    move-result v1

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->ownStyle(I)I

    move-result v1

    aput v1, v0, v4

    .line 1260
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    aget-object v1, v1, v4

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$which:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$style:[I

    aget v3, v3, v4

    invoke-static {v1, v2, v3, p1}, Lcom/mrkeyboard/app/MrThemesActivity;->withPicked(Lcom/mrkeyboard/app/MrKeyLook;III)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v1

    aput-object v1, v0, v4

    .line 1261
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$bar:Lcom/mrkeyboard/app/MrOpacityBar;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$bar:Lcom/mrkeyboard/app/MrOpacityBar;

    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/MrOpacityBar;->setColor(I)V

    .line 1262
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$redraw:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1263
    return-void
.end method
