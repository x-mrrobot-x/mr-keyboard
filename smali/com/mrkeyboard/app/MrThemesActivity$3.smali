.class Lcom/mrkeyboard/app/MrThemesActivity$3;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


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
    .line 124
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$3;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 2

    .prologue
    .line 126
    if-eqz p3, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$3;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    add-int/lit8 v1, p2, 0x64

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->zoomChanged(I)V

    .line 127
    :cond_0
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    .prologue
    .line 130
    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 1

    .prologue
    .line 133
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$3;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrThemesActivity;->saveSpec()V

    .line 134
    return-void
.end method
