.class final Lcom/mrkeyboard/app/MrMediaHelper$Api25;
.super Ljava/lang/Object;
.source "MrMediaHelper.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrMediaHelper;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Api25"
.end annotation


# direct methods
.method constructor <init>()V
    .registers 1

    .line 110
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static commit(Landroid/view/inputmethod/InputConnection;Landroid/view/inputmethod/EditorInfo;Landroid/net/Uri;Landroid/content/ClipDescription;)Z
    .registers 5

    .line 112
    iget-object p1, p1, Landroid/view/inputmethod/EditorInfo;->contentMimeTypes:[Ljava/lang/String;

    invoke-static {p3, p1}, Lcom/mrkeyboard/app/MrMediaHelper;->matchesAnyMime(Landroid/content/ClipDescription;[Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_a

    .line 113
    const/4 p0, 0x0

    return p0

    .line 115
    :cond_a
    new-instance p1, Landroid/view/inputmethod/InputContentInfo;

    const/4 v0, 0x0

    invoke-direct {p1, p2, p3, v0}, Landroid/view/inputmethod/InputContentInfo;-><init>(Landroid/net/Uri;Landroid/content/ClipDescription;Landroid/net/Uri;)V

    .line 116
    const/4 p2, 0x1

    invoke-interface {p0, p1, p2, v0}, Landroid/view/inputmethod/InputConnection;->commitContent(Landroid/view/inputmethod/InputContentInfo;ILandroid/os/Bundle;)Z

    move-result p0

    return p0
.end method
