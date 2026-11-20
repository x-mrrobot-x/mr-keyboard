.class Lcom/mrkeyboard/app/MrThemesActivity$25;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->fillKeys(Landroid/widget/LinearLayout;[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$draw:[Ljava/lang/Runnable;

.field final synthetic val$look:[Lcom/mrkeyboard/app/MrKeyLook;

.field final synthetic val$own:I

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$style:[I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;[II[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1051
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$style:[I

    iput p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$own:I

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$redraw:Ljava/lang/Runnable;

    iput-object p6, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$draw:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 7

    .prologue
    const/4 v4, 0x0

    .line 1053
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$style:[I

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$own:I

    aput v1, v0, v4

    .line 1054
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    aget-object v0, v0, v4

    iget v0, v0, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    aget-object v1, v1, v4

    const v2, -0x908401

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKeyLook;->withHue(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v1

    aput-object v1, v0, v4

    .line 1055
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    aget-object v1, v1, v4

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$own:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    aget-object v3, v3, v4

    iget v3, v3, Lcom/mrkeyboard/app/MrKeyLook;->hue:I

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrKeyLook;->lineFor(II)I

    move-result v2

    invoke-virtual {v1, v2}, Lcom/mrkeyboard/app/MrKeyLook;->withLine(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v1

    aput-object v1, v0, v4

    .line 1056
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$redraw:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1057
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$draw:[Ljava/lang/Runnable;

    aget-object v0, v0, v4

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1058
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_pick_color"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$style:[I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$redraw:Ljava/lang/Runnable;

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$draw:[Ljava/lang/Runnable;

    invoke-virtual/range {v0 .. v6}, Lcom/mrkeyboard/app/MrThemesActivity;->showColorPicker(Ljava/lang/String;I[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    .line 1059
    return-void
.end method
