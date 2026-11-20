.class Lcom/mrkeyboard/app/MrThemesActivity$23;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->fillKeys(Landroid/widget/LinearLayout;Z[I[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
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

.field final synthetic val$style:[I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1068
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->val$style:[I

    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->val$redraw:Ljava/lang/Runnable;

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->val$draw:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 7

    .prologue
    .line 1070
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrThemesActivity;->k:Lcom/mrkeyboard/app/MrKit;

    const-string v2, "mr_themes_pick_color"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v3}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->val$style:[I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->val$redraw:Ljava/lang/Runnable;

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity$23;->val$draw:[Ljava/lang/Runnable;

    invoke-virtual/range {v0 .. v6}, Lcom/mrkeyboard/app/MrThemesActivity;->showColorPicker(Ljava/lang/String;I[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    .line 1071
    return-void
.end method
