.class Lcom/mrkeyboard/app/PrefScreenSheets$2;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 129
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$2;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 131
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$2;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    const-string v1, "abc"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$000(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;)V

    .line 132
    return-void
.end method
