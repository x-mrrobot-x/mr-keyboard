.class Lcom/mrkeyboard/app/MrAppPicker$5;
.super Ljava/lang/Object;
.source "MrAppPicker.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrPage$Pager;


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
    .line 171
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$5;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public more()Z
    .locals 1

    .prologue
    .line 173
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$5;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAppPicker;->access$800(Lcom/mrkeyboard/app/MrAppPicker;)Z

    move-result v0

    return v0
.end method
