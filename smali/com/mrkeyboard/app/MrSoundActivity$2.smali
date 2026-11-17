.class Lcom/mrkeyboard/app/MrSoundActivity$2;
.super Ljava/lang/Object;
.source "MrSoundActivity.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


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
    .line 109
    iput-object p1, p0, Lcom/mrkeyboard/app/MrSoundActivity$2;->this$0:Lcom/mrkeyboard/app/MrSoundActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 1

    .prologue
    .line 111
    if-eqz p3, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity$2;->this$0:Lcom/mrkeyboard/app/MrSoundActivity;

    invoke-virtual {v0, p2}, Lcom/mrkeyboard/app/MrSoundActivity;->volumeChanged(I)V

    .line 112
    :cond_0
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    .prologue
    .line 115
    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 1

    .prologue
    .line 118
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity$2;->this$0:Lcom/mrkeyboard/app/MrSoundActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrSoundActivity;->volumeLetGo()V

    .line 119
    return-void
.end method
