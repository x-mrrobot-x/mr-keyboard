.class Lcom/mrkeyboard/app/PopupEditDialog$8;
.super Ljava/lang/Object;
.source "PopupEditDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PopupEditDialog;->show(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$currentMode:[I

.field final synthetic val$refreshRef:[Ljava/lang/Runnable;


# direct methods
.method constructor <init>([I[Ljava/lang/Runnable;)V
    .registers 3

    .line 348
    iput-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$8;->val$currentMode:[I

    iput-object p2, p0, Lcom/mrkeyboard/app/PopupEditDialog$8;->val$refreshRef:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 4

    .line 351
    iget-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$8;->val$currentMode:[I

    const/4 v0, 0x2

    const/4 v1, 0x0

    aput v0, p1, v1

    .line 352
    iget-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$8;->val$refreshRef:[Ljava/lang/Runnable;

    aget-object p1, p1, v1

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 353
    return-void
.end method
