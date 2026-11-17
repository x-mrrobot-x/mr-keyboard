.class Lcom/mrkeyboard/app/MrAppPicker$2;
.super Ljava/lang/Object;
.source "MrAppPicker.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


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
    .line 110
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$2;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 112
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$2;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAppPicker;->access$200(Lcom/mrkeyboard/app/MrAppPicker;Ljava/lang/String;)V

    .line 113
    return-void
.end method
