.class final Lcom/mrkeyboard/app/MrShotScroll;
.super Ljava/lang/Object;
.implements Landroid/widget/AbsListView$OnScrollListener;
.field private rect:Landroid/graphics/Rect;
.method public constructor <init>()V
 .locals 1
 invoke-direct {p0}, Ljava/lang/Object;-><init>()V
 new-instance v0, Landroid/graphics/Rect;
 invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V
 iput-object v0, p0, Lcom/mrkeyboard/app/MrShotScroll;->rect:Landroid/graphics/Rect;
 return-void
.end method
.method public onScroll(Landroid/widget/AbsListView;III)V
 .locals 1
 iget-object v0, p0, Lcom/mrkeyboard/app/MrShotScroll;->rect:Landroid/graphics/Rect;
 invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->pruneThumbs(Landroid/graphics/Rect;)V
 return-void
.end method
.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
 .locals 1
 iget-object v0, p0, Lcom/mrkeyboard/app/MrShotScroll;->rect:Landroid/graphics/Rect;
 invoke-static {v0}, Lcom/mrkeyboard/app/MrShots;->pruneThumbs(Landroid/graphics/Rect;)V
 return-void
.end method
