.class final Lcom/mrkeyboard/app/MrAbcKeys$Model;
.super Ljava/lang/Object;
.source "MrAbcKeys.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrAbcKeys;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Model"
.end annotation


# instance fields
.field final defaults:Lcom/mrkeyboard/app/SheetModel$Sheet;

.field sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetModel$Sheet;Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 87
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 88
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 89
    iput-object p2, p0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->defaults:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 90
    return-void
.end method
