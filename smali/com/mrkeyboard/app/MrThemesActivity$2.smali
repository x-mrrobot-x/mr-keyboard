.class Lcom/mrkeyboard/app/MrThemesActivity$2;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;)V
    .locals 0

    .prologue
    .line 105
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$2;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 1

    .prologue
    .line 107
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$2;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-virtual {v0, p1, p2}, Lcom/mrkeyboard/app/MrThemesActivity;->drag(Landroid/view/View;Landroid/view/MotionEvent;)Z

    move-result v0

    return v0
.end method
