.class Lcom/mrkeyboard/app/MrVersion$1;
.super Ljava/lang/Object;
.source "MrVersion.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrVersion;->fill(Landroid/app/Activity;Landroid/view/View;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 202
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 0

    .prologue
    .line 204
    invoke-static {}, Lcom/mrkeyboard/app/MrVersion;->dismiss()V

    .line 205
    return-void
.end method
