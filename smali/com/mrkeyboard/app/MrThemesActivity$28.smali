.class Lcom/mrkeyboard/app/MrThemesActivity$28;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrColorPicker$Listener;


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

.field final synthetic val$look:[Lcom/mrkeyboard/app/MrKeyLook;

.field final synthetic val$redraw:Ljava/lang/Runnable;

.field final synthetic val$which:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;[Lcom/mrkeyboard/app/MrKeyLook;ILjava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1127
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iput p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->val$which:I

    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->val$redraw:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onColor(I)V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 1129
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    aget-object v1, v1, v3

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->val$which:I

    invoke-static {v1, v2, p1}, Lcom/mrkeyboard/app/MrThemesActivity;->withColor(Lcom/mrkeyboard/app/MrKeyLook;II)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v1

    aput-object v1, v0, v3

    .line 1130
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$28;->val$redraw:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 1131
    return-void
.end method
