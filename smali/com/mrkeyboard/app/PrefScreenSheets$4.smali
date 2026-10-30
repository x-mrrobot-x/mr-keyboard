.class Lcom/mrkeyboard/app/PrefScreenSheets$4;
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

    .line 151
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$4;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 2

    .line 154
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$4;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->startExportJson()V
    invoke-static {p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$200(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 155
    return-void
.end method
