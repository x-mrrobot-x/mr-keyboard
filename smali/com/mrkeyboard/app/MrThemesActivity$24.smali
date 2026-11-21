.class Lcom/mrkeyboard/app/MrThemesActivity$24;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->gradientRow(Ljava/lang/String;IZZIZ[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)Landroid/widget/LinearLayout;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$draw:[Ljava/lang/Runnable;

.field final synthetic val$look:[Lcom/mrkeyboard/app/MrKeyLook;

.field final synthetic val$pale:Z

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$style:[I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;[I[Lcom/mrkeyboard/app/MrKeyLook;ZLjava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1162
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$style:[I

    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iput-boolean p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$pale:Z

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$redraw:Ljava/lang/Runnable;

    iput-object p6, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$draw:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 1164
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$style:[I

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-boolean v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$pale:Z

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->ownFromPreset([I[Lcom/mrkeyboard/app/MrKeyLook;Z)V

    .line 1165
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    aget-object v1, v1, v3

    invoke-virtual {v1, v3}, Lcom/mrkeyboard/app/MrKeyLook;->withHue2(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v1

    aput-object v1, v0, v3

    .line 1166
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$redraw:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1167
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$24;->val$draw:[Ljava/lang/Runnable;

    aget-object v0, v0, v3

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1168
    return-void
.end method
