.class Lcom/mrkeyboard/app/MrThemesActivity$19;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrThemesActivity$Setter;


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

.field final synthetic val$look:[Lcom/mrkeyboard/app/MrKeyLook;

.field final synthetic val$redraw:Ljava/lang/Runnable;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;[Lcom/mrkeyboard/app/MrKeyLook;Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 918
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$19;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$19;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$19;->val$redraw:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public set(I)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 920
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$19;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$19;->val$look:[Lcom/mrkeyboard/app/MrKeyLook;

    aget-object v1, v1, v2

    invoke-virtual {v1, p1}, Lcom/mrkeyboard/app/MrKeyLook;->withEdge(I)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v1

    aput-object v1, v0, v2

    .line 921
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$19;->val$redraw:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 922
    return-void
.end method
