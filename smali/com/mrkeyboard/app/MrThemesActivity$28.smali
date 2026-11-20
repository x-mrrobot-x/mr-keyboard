.class Lcom/mrkeyboard/app/MrThemesActivity$28;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrOpacityBar$Listener;


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

.field final synthetic val$look:[Lcom/mrkeyboard/app/MrKeyLook;

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$value:Landroid/widget/TextView;

.field final synthetic val$which:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;[Lcom/mrkeyboard/app/MrKeyLook;ILandroid/widget/TextView;Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1276
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iput p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->val$which:I

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->val$value:Landroid/widget/TextView;

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->val$redraw:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onOpacity(I)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 1278
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->val$which:I

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    aget-object v0, v0, v3

    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/MrKeyLook;->withKey(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    :goto_0
    aput-object v0, v1, v3

    .line 1279
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->val$value:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "%"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1280
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->val$redraw:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1281
    return-void

    .line 1278
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    aget-object v0, v0, v3

    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/MrKeyLook;->withEdge(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    goto :goto_0
.end method
