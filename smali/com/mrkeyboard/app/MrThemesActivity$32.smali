.class Lcom/mrkeyboard/app/MrThemesActivity$32;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->showColorPicker(Ljava/lang/String;I[I[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;[Ljava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$before:Lcom/mrkeyboard/app/MrKeyLook;

.field final synthetic val$draw:[Ljava/lang/Runnable;

.field final synthetic val$look:[Lcom/mrkeyboard/app/MrKeyLook;

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$style:[I

.field final synthetic val$styleBefore:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;[Lcom/mrkeyboard/app/MrKeyLook;Lcom/mrkeyboard/app/MrKeyLook;[IILjava/lang/Runnable;[Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1446
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->val$before:Lcom/mrkeyboard/app/MrKeyLook;

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->val$style:[I

    iput p5, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->val$styleBefore:I

    iput-object p6, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->val$redraw:Ljava/lang/Runnable;

    iput-object p7, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->val$draw:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 1448
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->val$before:Lcom/mrkeyboard/app/MrKeyLook;

    aput-object v1, v0, v2

    .line 1449
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->val$style:[I

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->val$styleBefore:I

    aput v1, v0, v2

    .line 1450
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->val$redraw:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1451
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrThemesActivity;->closePicker()V

    .line 1452
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$32;->val$draw:[Ljava/lang/Runnable;

    aget-object v0, v0, v2

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1453
    return-void
.end method
