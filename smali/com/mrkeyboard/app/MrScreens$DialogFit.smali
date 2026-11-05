.class final Lcom/mrkeyboard/app/MrScreens$DialogFit;
.super Ljava/lang/Object;
.source "MrScreens.java"

# interfaces
.implements Landroid/view/View$OnApplyWindowInsetsListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrScreens;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "DialogFit"
.end annotation


# instance fields
.field private final mRoot:Landroid/view/View;


# direct methods
.method constructor <init>(Landroid/view/View;)V
    .locals 0

    .prologue
    .line 129
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/mrkeyboard/app/MrScreens$DialogFit;->mRoot:Landroid/view/View;

    return-void
.end method


# virtual methods
.method public onApplyWindowInsets(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .locals 2

    .prologue
    .line 132
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrScreens$DialogFit;->mRoot:Landroid/view/View;

    invoke-static {v0, p2}, Lcom/mrkeyboard/app/MrScreens$Api30;->pad(Landroid/view/View;Landroid/view/WindowInsets;)V

    .line 133
    :cond_0
    invoke-virtual {p1, p2}, Landroid/view/View;->onApplyWindowInsets(Landroid/view/WindowInsets;)Landroid/view/WindowInsets;

    move-result-object v0

    return-object v0
.end method
