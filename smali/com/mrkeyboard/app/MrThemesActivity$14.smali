.class Lcom/mrkeyboard/app/MrThemesActivity$14;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->sheetShow(Landroid/app/Dialog;Landroid/widget/LinearLayout;Lcom/mrkeyboard/app/MrThemePreview;Landroid/widget/SeekBar;ZLjava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$onApply:Ljava/lang/Runnable;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 849
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$14;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$14;->val$onApply:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .prologue
    .line 851
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$14;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrThemesActivity;->closeDialog()V

    .line 852
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$14;->val$onApply:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 853
    return-void
.end method
