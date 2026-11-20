.class Lcom/mrkeyboard/app/MrThemesActivity$18;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->showPreview(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;IZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$draw:[Ljava/lang/Runnable;

.field final synthetic val$keysBox:Landroid/widget/LinearLayout;

.field final synthetic val$lineBox:Landroid/widget/LinearLayout;

.field final synthetic val$look:[Lcom/mrkeyboard/app/MrKeyLook;

.field final synthetic val$pale:Z

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$style:[I

.field final synthetic val$textBox:Landroid/widget/LinearLayout;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/widget/LinearLayout;Z[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;Landroid/widget/LinearLayout;Landroid/widget/LinearLayout;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 925
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$keysBox:Landroid/widget/LinearLayout;

    iput-boolean p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$pale:Z

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$style:[I

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iput-object p6, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$redraw:Ljava/lang/Runnable;

    iput-object p7, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$draw:[Ljava/lang/Runnable;

    iput-object p8, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$lineBox:Landroid/widget/LinearLayout;

    iput-object p9, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$textBox:Landroid/widget/LinearLayout;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .prologue
    .line 927
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$keysBox:Landroid/widget/LinearLayout;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$keysBox:Landroid/widget/LinearLayout;

    iget-boolean v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$pale:Z

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$style:[I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$redraw:Ljava/lang/Runnable;

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$draw:[Ljava/lang/Runnable;

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/MrThemesActivity;->access$100(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/widget/LinearLayout;Z[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    .line 928
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$lineBox:Landroid/widget/LinearLayout;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$lineBox:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$style:[I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$redraw:Ljava/lang/Runnable;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$draw:[Ljava/lang/Runnable;

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemesActivity;->access$200(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/widget/LinearLayout;[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    .line 929
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$textBox:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$style:[I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$redraw:Ljava/lang/Runnable;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity$18;->val$draw:[Ljava/lang/Runnable;

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemesActivity;->access$300(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/widget/LinearLayout;[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    .line 930
    return-void
.end method
