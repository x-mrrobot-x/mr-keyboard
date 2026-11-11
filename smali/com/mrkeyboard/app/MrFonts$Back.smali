.class final Lcom/mrkeyboard/app/MrFonts$Back;
.super Ljava/lang/Object;
.source "MrFonts.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrFonts;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Back"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 427
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/mrkeyboard/app/MrFonts$1;)V
    .locals 0

    .prologue
    .line 427
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrFonts$Back;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .prologue
    .line 430
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTools;->showPanel(I)V

    .line 431
    return-void
.end method
