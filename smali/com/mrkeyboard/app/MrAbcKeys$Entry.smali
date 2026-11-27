.class final Lcom/mrkeyboard/app/MrAbcKeys$Entry;
.super Ljava/lang/Object;
.source "MrAbcKeys.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrAbcKeys;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Entry"
.end annotation


# instance fields
.field final defaultPopup:Z

.field final spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetModel$KeySpec;Z)V
    .locals 0

    .prologue
    .line 59
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 60
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAbcKeys$Entry;->spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 61
    iput-boolean p2, p0, Lcom/mrkeyboard/app/MrAbcKeys$Entry;->defaultPopup:Z

    .line 62
    return-void
.end method
