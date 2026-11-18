.class Lcom/mrkeyboard/app/MrAppPicker$1;
.super Ljava/lang/Object;
.source "MrAppPicker.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrAppPicker;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrAppPicker;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAppPicker;)V
    .locals 0

    .prologue
    .line 68
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$1;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 70
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$1;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAppPicker;->access$000(Lcom/mrkeyboard/app/MrAppPicker;)V

    .line 71
    return-void
.end method
