.class Lcom/mrkeyboard/app/MrAppPicker$7;
.super Ljava/lang/Object;
.source "MrAppPicker.java"

# interfaces
.implements Landroid/view/View$OnScrollChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAppPicker;->open(Ljava/lang/String;)V
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
    .line 190
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$7;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onScrollChange(Landroid/view/View;IIII)V
    .locals 1

    .prologue
    .line 192
    if-le p3, p5, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$7;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAppPicker;->access$000(Lcom/mrkeyboard/app/MrAppPicker;)V

    .line 193
    :cond_0
    return-void
.end method
