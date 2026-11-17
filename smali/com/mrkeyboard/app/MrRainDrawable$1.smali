.class Lcom/mrkeyboard/app/MrRainDrawable$1;
.super Ljava/lang/Object;
.source "MrRainDrawable.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrRainDrawable;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrRainDrawable;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrRainDrawable;)V
    .locals 0

    .prologue
    .line 54
    iput-object p1, p0, Lcom/mrkeyboard/app/MrRainDrawable$1;->this$0:Lcom/mrkeyboard/app/MrRainDrawable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 56
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRainDrawable$1;->this$0:Lcom/mrkeyboard/app/MrRainDrawable;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrRainDrawable;->access$002(Lcom/mrkeyboard/app/MrRainDrawable;Z)Z

    .line 57
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRainDrawable$1;->this$0:Lcom/mrkeyboard/app/MrRainDrawable;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrRainDrawable;->access$100(Lcom/mrkeyboard/app/MrRainDrawable;)Lcom/mrkeyboard/app/MrRain;

    move-result-object v0

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrRain;->step()V

    .line 58
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRainDrawable$1;->this$0:Lcom/mrkeyboard/app/MrRainDrawable;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrRainDrawable;->invalidateSelf()V

    .line 59
    return-void
.end method
