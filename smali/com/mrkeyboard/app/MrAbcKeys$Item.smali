.class final Lcom/mrkeyboard/app/MrAbcKeys$Item;
.super Ljava/lang/Object;
.source "MrAbcKeys.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrAbcKeys;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Item"
.end annotation


# instance fields
.field final popupOf:Ljava/lang/String;

.field final spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 69
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 70
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAbcKeys$Item;->spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 71
    iput-object p2, p0, Lcom/mrkeyboard/app/MrAbcKeys$Item;->popupOf:Ljava/lang/String;

    .line 72
    return-void
.end method
