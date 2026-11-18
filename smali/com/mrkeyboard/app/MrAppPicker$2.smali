.class Lcom/mrkeyboard/app/MrAppPicker$2;
.super Ljava/lang/Object;
.source "MrAppPicker.java"

# interfaces
.implements Lcom/mrkeyboard/app/MrAppPicker$Live;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAppPicker;->show(Lcom/mrkeyboard/app/MrKit;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/MrAppPicker$Source;Lcom/mrkeyboard/app/MrAppPicker$Pick;)Lcom/mrkeyboard/app/MrAppPicker;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$source:Lcom/mrkeyboard/app/MrAppPicker$Source;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAppPicker$Source;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 90
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$2;->val$source:Lcom/mrkeyboard/app/MrAppPicker$Source;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public cached()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;"
        }
    .end annotation

    .prologue
    .line 92
    const/4 v0, 0x0

    return-object v0
.end method

.method public close()V
    .locals 0

    .prologue
    .line 101
    return-void
.end method

.method public refresh()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/MrAppList$Entry;",
            ">;"
        }
    .end annotation

    .prologue
    .line 96
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$2;->val$source:Lcom/mrkeyboard/app/MrAppPicker$Source;

    invoke-interface {v0}, Lcom/mrkeyboard/app/MrAppPicker$Source;->load()Ljava/util/List;

    move-result-object v0

    .line 97
    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    :cond_0
    return-object v0
.end method
