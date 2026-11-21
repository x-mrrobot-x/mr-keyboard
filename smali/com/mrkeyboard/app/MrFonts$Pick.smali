.class final Lcom/mrkeyboard/app/MrFonts$Pick;
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
    name = "Pick"
.end annotation


# instance fields
.field private final index:I


# direct methods
.method constructor <init>(I)V
    .locals 0

    .prologue
    .line 433
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 434
    iput p1, p0, Lcom/mrkeyboard/app/MrFonts$Pick;->index:I

    .line 435
    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .prologue
    .line 439
    iget v0, p0, Lcom/mrkeyboard/app/MrFonts$Pick;->index:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrFonts;->access$100(I)V

    .line 440
    return-void
.end method
