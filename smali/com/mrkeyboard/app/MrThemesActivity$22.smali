.class Lcom/mrkeyboard/app/MrThemesActivity$22;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->slider(Landroid/widget/LinearLayout;Ljava/lang/String;IIIZLcom/mrkeyboard/app/MrThemesActivity$Setter;)Landroid/widget/SeekBar;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$max:I

.field final synthetic val$onChange:Lcom/mrkeyboard/app/MrThemesActivity$Setter;

.field final synthetic val$value:Landroid/widget/TextView;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;ILandroid/widget/TextView;Lcom/mrkeyboard/app/MrThemesActivity$Setter;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 978
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$max:I

    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$value:Landroid/widget/TextView;

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$onChange:Lcom/mrkeyboard/app/MrThemesActivity$Setter;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 4

    .prologue
    .line 980
    if-nez p3, :cond_0

    .line 984
    :goto_0
    return-void

    .line 981
    :cond_0
    const/4 v0, 0x0

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$max:I

    invoke-static {p2, v0, v1}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v0

    .line 982
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$value:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "%"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 983
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$22;->val$onChange:Lcom/mrkeyboard/app/MrThemesActivity$Setter;

    invoke-interface {v1, v0}, Lcom/mrkeyboard/app/MrThemesActivity$Setter;->set(I)V

    goto :goto_0
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    .prologue
    .line 987
    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    .prologue
    .line 990
    return-void
.end method
