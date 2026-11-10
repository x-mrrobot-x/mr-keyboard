.class Lcom/mrkeyboard/app/SheetEditorActivity$12;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Landroid/view/View$OnFocusChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->bindTestCard(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SheetEditorActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 366
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$12;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFocusChange(Landroid/view/View;Z)V
    .locals 7

    .prologue
    .line 368
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$12;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1600(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/ImageView;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$12;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    const/4 v4, 0x3

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity$12;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    .line 369
    if-eqz p2, :cond_1

    const-string v0, "mr_ui_cyan"

    :goto_0
    invoke-static {v5, v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1400(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;)I

    move-result v0

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity$12;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    const/high16 v6, 0x41b00000    # 22.0f

    invoke-static {v5, v6}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1500(Lcom/mrkeyboard/app/SheetEditorActivity;F)I

    move-result v5

    invoke-direct {v2, v3, v4, v0, v5}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    .line 368
    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 370
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$12;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1800(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/view/View;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$12;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    if-eqz p2, :cond_2

    const-string v0, "mr_sheet_ed_field_bg_on"

    :goto_1
    invoke-static {v2, v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1700(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Landroid/view/View;->setBackgroundResource(I)V

    .line 371
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$12;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1900(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/view/View;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$12;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    if-eqz p2, :cond_3

    const-string v0, "mr_sheet_ed_card_bg_on"

    :goto_2
    invoke-static {v2, v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1700(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;)I

    move-result v0

    invoke-virtual {v1, v0}, Landroid/view/View;->setBackgroundResource(I)V

    .line 372
    if-eqz p2, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$12;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2000(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/ScrollView;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 373
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$12;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2000(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/ScrollView;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$12$1;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$12$1;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity$12;)V

    const-wide/16 v2, 0x78

    invoke-virtual {v0, v1, v2, v3}, Landroid/widget/ScrollView;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 379
    :cond_0
    return-void

    .line 369
    :cond_1
    const-string v0, "mr_ui_text3"

    goto :goto_0

    .line 370
    :cond_2
    const-string v0, "mr_sheet_ed_field_bg"

    goto :goto_1

    .line 371
    :cond_3
    const-string v0, "mr_sheet_ed_card_bg"

    goto :goto_2
.end method
