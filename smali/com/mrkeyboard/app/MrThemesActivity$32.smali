.class Lcom/mrkeyboard/app/MrThemesActivity$32;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnCancelListener;


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

.field final synthetic val$cancelNow:Ljava/lang/Runnable;

.field final synthetic val$p:Landroid/app/Dialog;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/app/Dialog;Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1204
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->val$p:Landroid/app/Dialog;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->val$cancelNow:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCancel(Landroid/content/DialogInterface;)V
    .locals 2

    .prologue
    .line 1206
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mPicker:Landroid/app/Dialog;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->val$p:Landroid/app/Dialog;

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->val$cancelNow:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1207
    :cond_0
    return-void
.end method
