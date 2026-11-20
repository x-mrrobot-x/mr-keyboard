.class Lcom/mrkeyboard/app/MrKit$2;
.super Ljava/lang/Object;
.source "MrKit.java"

# interfaces
.implements Landroid/view/View$OnScrollChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrKit;->onScroll(Landroid/widget/ScrollView;Ljava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrKit;

.field final synthetic val$r:Ljava/lang/Runnable;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrKit;Ljava/lang/Runnable;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 274
    iput-object p1, p0, Lcom/mrkeyboard/app/MrKit$2;->this$0:Lcom/mrkeyboard/app/MrKit;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrKit$2;->val$r:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onScrollChange(Landroid/view/View;IIII)V
    .locals 1

    .prologue
    .line 276
    iget-object v0, p0, Lcom/mrkeyboard/app/MrKit$2;->val$r:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 277
    return-void
.end method
