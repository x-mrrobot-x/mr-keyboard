.class Lcom/mrkeyboard/app/MrSoundActivity$1;
.super Ljava/lang/Object;
.source "MrSoundActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrSoundActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrSoundActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrSoundActivity;)V
    .locals 0

    .prologue
    .line 77
    iput-object p1, p0, Lcom/mrkeyboard/app/MrSoundActivity$1;->this$0:Lcom/mrkeyboard/app/MrSoundActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .prologue
    .line 79
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity$1;->this$0:Lcom/mrkeyboard/app/MrSoundActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrSoundActivity;->finish()V

    .line 80
    return-void
.end method
