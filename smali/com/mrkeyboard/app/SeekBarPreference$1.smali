.class Lcom/mrkeyboard/app/SeekBarPreference$1;
.super Ljava/lang/Object;
.source "SeekBarPreference.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SeekBarPreference;->onBindDialogView(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SeekBarPreference;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SeekBarPreference;)V
    .locals 0

    .line 136
    iput-object p1, p0, Lcom/mrkeyboard/app/SeekBarPreference$1;->this$0:Lcom/mrkeyboard/app/SeekBarPreference;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 6

    if-eqz p3, :cond_1

    .line 141
    iget-object v0, p0, Lcom/mrkeyboard/app/SeekBarPreference$1;->this$0:Lcom/mrkeyboard/app/SeekBarPreference;

    iget-object p1, p0, Lcom/mrkeyboard/app/SeekBarPreference$1;->this$0:Lcom/mrkeyboard/app/SeekBarPreference;

    invoke-static {p1}, Lcom/mrkeyboard/app/SeekBarPreference;->access$000(Lcom/mrkeyboard/app/SeekBarPreference;)F

    move-result v2

    iget-object p1, p0, Lcom/mrkeyboard/app/SeekBarPreference$1;->this$0:Lcom/mrkeyboard/app/SeekBarPreference;

    invoke-static {p1}, Lcom/mrkeyboard/app/SeekBarPreference;->access$100(Lcom/mrkeyboard/app/SeekBarPreference;)F

    move-result v3

    iget-object p1, p0, Lcom/mrkeyboard/app/SeekBarPreference$1;->this$0:Lcom/mrkeyboard/app/SeekBarPreference;

    invoke-static {p1}, Lcom/mrkeyboard/app/SeekBarPreference;->access$200(Lcom/mrkeyboard/app/SeekBarPreference;)F

    move-result v4

    iget-object p1, p0, Lcom/mrkeyboard/app/SeekBarPreference$1;->this$0:Lcom/mrkeyboard/app/SeekBarPreference;

    invoke-static {p1}, Lcom/mrkeyboard/app/SeekBarPreference;->access$300(Lcom/mrkeyboard/app/SeekBarPreference;)Z

    move-result v5

    move v1, p2

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/SeekBarPreference;->access$400(Lcom/mrkeyboard/app/SeekBarPreference;IFFFZ)F

    move-result p1

    .line 142
    iget-object p2, p0, Lcom/mrkeyboard/app/SeekBarPreference$1;->this$0:Lcom/mrkeyboard/app/SeekBarPreference;

    invoke-static {p2}, Lcom/mrkeyboard/app/SeekBarPreference;->access$500(Lcom/mrkeyboard/app/SeekBarPreference;)F

    move-result p2

    cmpl-float p2, p1, p2

    if-eqz p2, :cond_0

    .line 143
    iget-object p2, p0, Lcom/mrkeyboard/app/SeekBarPreference$1;->this$0:Lcom/mrkeyboard/app/SeekBarPreference;

    invoke-virtual {p2, p1}, Lcom/mrkeyboard/app/SeekBarPreference;->onChange(F)V

    .line 145
    :cond_0
    iget-object p2, p0, Lcom/mrkeyboard/app/SeekBarPreference$1;->this$0:Lcom/mrkeyboard/app/SeekBarPreference;

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p1

    invoke-virtual {p2, p1}, Lcom/mrkeyboard/app/SeekBarPreference;->setVal(Ljava/lang/Float;)V

    .line 146
    iget-object p1, p0, Lcom/mrkeyboard/app/SeekBarPreference$1;->this$0:Lcom/mrkeyboard/app/SeekBarPreference;

    invoke-static {p1}, Lcom/mrkeyboard/app/SeekBarPreference;->access$700(Lcom/mrkeyboard/app/SeekBarPreference;)Landroid/widget/SeekBar;

    move-result-object p1

    iget-object p2, p0, Lcom/mrkeyboard/app/SeekBarPreference$1;->this$0:Lcom/mrkeyboard/app/SeekBarPreference;

    invoke-static {p2}, Lcom/mrkeyboard/app/SeekBarPreference;->access$600(Lcom/mrkeyboard/app/SeekBarPreference;)I

    move-result p2

    invoke-virtual {p1, p2}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 148
    :cond_1
    iget-object p1, p0, Lcom/mrkeyboard/app/SeekBarPreference$1;->this$0:Lcom/mrkeyboard/app/SeekBarPreference;

    invoke-static {p1}, Lcom/mrkeyboard/app/SeekBarPreference;->access$800(Lcom/mrkeyboard/app/SeekBarPreference;)V

    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0

    return-void
.end method
