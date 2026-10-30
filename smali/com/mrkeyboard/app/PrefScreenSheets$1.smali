.class Lcom/mrkeyboard/app/PrefScreenSheets$1;
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
    .registers 2

    .line 62
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$1;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 2

    .line 65
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$1;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-virtual {p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->finish()V

    .line 66
    return-void
.end method
