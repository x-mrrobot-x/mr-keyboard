.class Lcom/mrkeyboard/app/MrThemesActivity$39$1;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity$39;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/MrThemesActivity$39;

.field final synthetic val$shown:Landroid/graphics/Bitmap;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity$39;Landroid/graphics/Bitmap;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 1603
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$39$1;->this$1:Lcom/mrkeyboard/app/MrThemesActivity$39;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$39$1;->val$shown:Landroid/graphics/Bitmap;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 1605
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$39$1;->this$1:Lcom/mrkeyboard/app/MrThemesActivity$39;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrThemesActivity$39;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$39$1;->val$shown:Landroid/graphics/Bitmap;

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->imported(Landroid/graphics/Bitmap;)V

    .line 1606
    return-void
.end method
