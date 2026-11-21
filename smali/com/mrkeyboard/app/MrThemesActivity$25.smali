.class Lcom/mrkeyboard/app/MrThemesActivity$25;
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

.field final synthetic val$name:Ljava/lang/String;

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$style:[I

.field final synthetic val$which:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;Ljava/lang/String;I[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1177
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$name:Ljava/lang/String;

    iput p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$which:I

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$style:[I

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iput-object p6, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$redraw:Ljava/lang/Runnable;

    iput-object p7, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$draw:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 7

    .prologue
    .line 1179
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$name:Ljava/lang/String;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$which:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$style:[I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$redraw:Ljava/lang/Runnable;

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemesActivity$25;->val$draw:[Ljava/lang/Runnable;

    invoke-virtual/range {v0 .. v6}, Lcom/mrkeyboard/app/MrThemesActivity;->showColorPicker(Ljava/lang/String;I[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V

    .line 1180
    return-void
.end method
