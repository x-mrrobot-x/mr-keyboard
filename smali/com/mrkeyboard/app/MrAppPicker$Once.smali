.class abstract Lcom/mrkeyboard/app/MrAppPicker$Once;
.super Ljava/lang/Object;
.source "MrAppPicker.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrAppPicker$Source;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrAppPicker;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x408
    name = "Once"
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 49
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method abstract list()Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;"
        }
    .end annotation
.end method

.method public load(Lcom/mrkeyboard/app/MrAppPicker$Sink;)V
    .locals 1

    .prologue
    .line 53
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrAppPicker$Once;->list()Ljava/util/List;

    move-result-object v0

    invoke-interface {p1, v0}, Lcom/mrkeyboard/app/MrAppPicker$Sink;->publish(Ljava/util/List;)V

    .line 54
    return-void
.end method
