.class interface abstract Lcom/mrkeyboard/app/MrAppPicker$Live;
.super Ljava/lang/Object;
.source "MrAppPicker.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrAppPicker;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x608
    name = "Live"
.end annotation


# virtual methods
.method public abstract cached()Ljava/util/List;
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

.method public abstract close()V
.end method

.method public abstract refresh()Ljava/util/List;
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
