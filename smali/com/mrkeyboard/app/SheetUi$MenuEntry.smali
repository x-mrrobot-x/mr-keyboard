.class public final Lcom/mrkeyboard/app/SheetUi$MenuEntry;
.super Ljava/lang/Object;
.source "SheetUi.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/SheetUi;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "MenuEntry"
.end annotation


# instance fields
.field public final dividerBefore:Z

.field public final icon:I

.field public final id:I

.field public final title:Ljava/lang/String;

.field public final tone:I


# direct methods
.method public constructor <init>(IILjava/lang/String;)V
    .registers 10

    .line 184
    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move v1, p1

    move v2, p2

    move-object v3, p3

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    .line 185
    return-void
.end method

.method public constructor <init>(IILjava/lang/String;IZ)V
    .registers 6

    .line 175
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 176
    iput p1, p0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;->id:I

    .line 177
    iput p2, p0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;->icon:I

    .line 178
    iput-object p3, p0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;->title:Ljava/lang/String;

    .line 179
    iput p4, p0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;->tone:I

    .line 180
    iput-boolean p5, p0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;->dividerBefore:Z

    .line 181
    return-void
.end method
