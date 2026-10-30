.class final Lcom/mrkeyboard/app/MrThumbnailCache;
.super Landroid/util/LruCache;

.method public constructor <init>()V
 .locals 1
 const v0, 0x800000
 invoke-direct {p0, v0}, Landroid/util/LruCache;-><init>(I)V
 return-void
.end method

.method protected sizeOf(Ljava/lang/Object;Ljava/lang/Object;)I
 .locals 1
 check-cast p2, Landroid/graphics/Bitmap;
 invoke-virtual {p2}, Landroid/graphics/Bitmap;->getAllocationByteCount()I
 move-result v0
 const/4 p1, 0x1
 invoke-static {v0, p1}, Ljava/lang/Math;->max(II)I
 move-result v0
 return v0
.end method
