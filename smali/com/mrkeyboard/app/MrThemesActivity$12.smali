.class Lcom/mrkeyboard/app/MrThemesActivity$12;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->sheetBox(Ljava/lang/String;Z)Lcom/mrkeyboard/app/MrSheetBox;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;)V
    .locals 0

    .prologue
    .line 824
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$12;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .prologue
    .line 826
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$12;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogCancel:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$12;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrThemesActivity;->mDialogCancel:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->performClick()Z

    .line 827
    :cond_0
    return-void
.end method
