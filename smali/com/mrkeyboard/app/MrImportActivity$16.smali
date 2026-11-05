.class Lcom/mrkeyboard/app/MrImportActivity$16;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity;->drawWords()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrImportActivity;

.field final synthetic val$item:Landroid/widget/LinearLayout;

.field final synthetic val$w:Lcom/mrkeyboard/app/MrImport$NewWord;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrImport$NewWord;Landroid/widget/LinearLayout;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 518
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$16;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity$16;->val$w:Lcom/mrkeyboard/app/MrImport$NewWord;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrImportActivity$16;->val$item:Landroid/widget/LinearLayout;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 520
    iget-object v2, p0, Lcom/mrkeyboard/app/MrImportActivity$16;->val$w:Lcom/mrkeyboard/app/MrImport$NewWord;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$16;->val$w:Lcom/mrkeyboard/app/MrImport$NewWord;

    iget-boolean v0, v0, Lcom/mrkeyboard/app/MrImport$NewWord;->checked:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    iput-boolean v0, v2, Lcom/mrkeyboard/app/MrImport$NewWord;->checked:Z

    .line 521
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$16;->val$item:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$16;->val$w:Lcom/mrkeyboard/app/MrImport$NewWord;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$2200(Lcom/mrkeyboard/app/MrImport$NewWord;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 522
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$16;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrImportActivity;->access$2300(Lcom/mrkeyboard/app/MrImportActivity;)V

    .line 523
    return-void

    :cond_0
    move v0, v1

    .line 520
    goto :goto_0
.end method
