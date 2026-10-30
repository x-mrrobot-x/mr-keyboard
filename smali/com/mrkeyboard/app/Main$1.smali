.class Lcom/mrkeyboard/app/Main$1;
.super Ljava/lang/Object;
.source "Main.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/Main;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/Main;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/Main;)V
    .locals 0

    .line 52
    iput-object p1, p0, Lcom/mrkeyboard/app/Main$1;->this$0:Lcom/mrkeyboard/app/Main;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .line 54
    iget-object p1, p0, Lcom/mrkeyboard/app/Main$1;->this$0:Lcom/mrkeyboard/app/Main;

    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.INPUT_METHOD_SETTINGS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Lcom/mrkeyboard/app/Main;->startActivityForResult(Landroid/content/Intent;I)V

    return-void
.end method
