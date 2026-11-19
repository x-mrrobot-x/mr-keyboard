.class Lcom/mrkeyboard/app/MrThemesActivity$27;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->colourLine(Ljava/lang/String;IZI[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)Landroid/widget/LinearLayout;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$draw:[Ljava/lang/Runnable;

.field final synthetic val$look:[Lcom/mrkeyboard/app/MrKeyLook;

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$which:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1082
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$which:I

    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$redraw:Ljava/lang/Runnable;

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$draw:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 6

    .prologue
    .line 1084
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_pick_color"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$which:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$redraw:Ljava/lang/Runnable;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity$27;->val$draw:[Ljava/lang/Runnable;

    invoke-virtual/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemesActivity;->showColorPicker(Ljava/lang/String;I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    .line 1085
    return-void
.end method
