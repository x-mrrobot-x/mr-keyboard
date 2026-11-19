.class Lcom/mrkeyboard/app/MrThemesActivity$31;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->showColorPicker(Ljava/lang/String;I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$cp:Lcom/mrkeyboard/app/MrColorPicker;

.field final synthetic val$draw:[Ljava/lang/Runnable;

.field final synthetic val$look:[Lcom/mrkeyboard/app/MrKeyLook;

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$which:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;[Lcom/mrkeyboard/app/MrKeyLook;ILcom/mrkeyboard/app/MrColorPicker;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1146
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$31;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$31;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iput p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$31;->val$which:I

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$31;->val$cp:Lcom/mrkeyboard/app/MrColorPicker;

    iput-object p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$31;->val$redraw:Ljava/lang/Runnable;

    iput-object p6, p0, Lcom/mrkeyboard/app/MrThemesActivity$31;->val$draw:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 1148
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$31;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$31;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    aget-object v1, v1, v4

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$31;->val$which:I

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemesActivity$31;->val$cp:Lcom/mrkeyboard/app/MrColorPicker;

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrColorPicker;->color()I

    move-result v3

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrThemesActivity;->withColor(Lcom/mrkeyboard/app/MrKeyLook;II)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v1

    aput-object v1, v0, v4

    .line 1149
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$31;->val$redraw:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1150
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$31;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrThemesActivity;->closePicker()V

    .line 1151
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$31;->val$draw:[Ljava/lang/Runnable;

    aget-object v0, v0, v4

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1152
    return-void
.end method
