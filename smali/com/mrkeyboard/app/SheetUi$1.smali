.class Lcom/mrkeyboard/app/SheetUi$1;
.super Ljava/lang/Object;
.source "SheetUi.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetUi;->showPopupMenu(Landroid/content/Context;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$entry:Lcom/mrkeyboard/app/SheetUi$MenuEntry;

.field final synthetic val$listener:Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;

.field final synthetic val$popup:Landroid/widget/PopupWindow;


# direct methods
.method constructor <init>(Landroid/widget/PopupWindow;Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;Lcom/mrkeyboard/app/SheetUi$MenuEntry;)V
    .registers 4

    .line 338
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetUi$1;->val$popup:Landroid/widget/PopupWindow;

    iput-object p2, p0, Lcom/mrkeyboard/app/SheetUi$1;->val$listener:Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;

    iput-object p3, p0, Lcom/mrkeyboard/app/SheetUi$1;->val$entry:Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 3

    .line 342
    :try_start_0
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetUi$1;->val$popup:Landroid/widget/PopupWindow;

    invoke-virtual {p1}, Landroid/widget/PopupWindow;->dismiss()V
    :try_end_5
    .catchall {:try_start_0 .. :try_end_5} :catchall_6

    goto :goto_7

    .line 343
    :catchall_6
    move-exception p1

    :goto_7
    nop

    .line 344
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetUi$1;->val$listener:Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;

    if-eqz p1, :cond_15

    .line 345
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetUi$1;->val$listener:Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetUi$1;->val$entry:Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    iget v0, v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;->id:I

    invoke-interface {p1, v0}, Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;->onSelect(I)V

    .line 347
    :cond_15
    return-void
.end method
