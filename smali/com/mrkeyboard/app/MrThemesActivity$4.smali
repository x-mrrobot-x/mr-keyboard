.class Lcom/mrkeyboard/app/MrThemesActivity$4;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->revealRow(Landroid/view/View;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$row:Landroid/view/View;

.field final synthetic val$tries:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/view/View;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 335
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$4;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$4;->val$row:Landroid/view/View;

    iput p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$4;->val$tries:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 337
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$4;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$4;->val$row:Landroid/view/View;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemesActivity$4;->val$tries:I

    add-int/lit8 v2, v2, -0x1

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrThemesActivity;->access$000(Lcom/mrkeyboard/app/MrThemesActivity;Landroid/view/View;I)V

    .line 338
    return-void
.end method
