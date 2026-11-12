.class Lcom/mrkeyboard/app/MrEmojiSearch$4;
.super Ljava/lang/Object;
.source "MrEmojiSearch.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrEmojiSearch;->setup(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 136
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .prologue
    .line 138
    const/4 v0, 0x4

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    .line 139
    return-void
.end method
