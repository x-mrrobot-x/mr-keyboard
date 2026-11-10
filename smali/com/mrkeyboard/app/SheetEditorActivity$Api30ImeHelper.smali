.class final Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Api30ImeHelper"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 678
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static attach(Landroid/view/View;Landroid/view/View;IIIILjava/lang/Runnable;)V
    .locals 7

    .prologue
    .line 682
    new-instance v0, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;

    move-object v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move-object v6, p6

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper$1;-><init>(Landroid/view/View;IIIILjava/lang/Runnable;)V

    invoke-virtual {p0, v0}, Landroid/view/View;->setOnApplyWindowInsetsListener(Landroid/view/View$OnApplyWindowInsetsListener;)V

    .line 700
    invoke-virtual {p0}, Landroid/view/View;->requestApplyInsets()V

    .line 701
    return-void
.end method
