.class Lcom/mrkeyboard/app/MrAccel$1;
.super Ljava/lang/Object;
.source "MrAccel.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAccel;->onShown(Landroid/inputmethodservice/InputMethodService;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$decor:Landroid/view/View;


# direct methods
.method constructor <init>(Landroid/view/View;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 58
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAccel$1;->val$decor:Landroid/view/View;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 59
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAccel$1;->val$decor:Landroid/view/View;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAccel;->log(Landroid/view/View;)V

    return-void
.end method
