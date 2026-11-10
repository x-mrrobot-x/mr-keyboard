.class Lcom/mrkeyboard/app/KeyEditDialog$Editor$4;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindWidth(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V
    .locals 0

    .prologue
    .line 285
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$4;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 1

    .prologue
    .line 287
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$4;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v0, p2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$602(Lcom/mrkeyboard/app/KeyEditDialog$Editor;I)I

    .line 288
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$4;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$700(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V

    .line 289
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    .prologue
    .line 291
    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    .prologue
    .line 293
    return-void
.end method
