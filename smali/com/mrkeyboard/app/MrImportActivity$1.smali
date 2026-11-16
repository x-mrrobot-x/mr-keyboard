.class Lcom/mrkeyboard/app/MrImportActivity$1;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrImportActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity;)V
    .locals 0

    .prologue
    .line 114
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$1;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .prologue
    .line 116
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$1;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrImportActivity;->finish()V

    .line 117
    return-void
.end method
