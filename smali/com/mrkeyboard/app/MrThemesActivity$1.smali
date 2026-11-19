.class Lcom/mrkeyboard/app/MrThemesActivity$1;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


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
    .line 161
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$1;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .prologue
    .line 163
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$1;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrThemesActivity;->finish()V

    .line 164
    return-void
.end method
