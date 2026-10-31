.class final Lcom/mrkeyboard/app/MrLink$SafeSpan;
.super Landroid/text/style/ClickableSpan;
.source "MrLink.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrLink;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "SafeSpan"
.end annotation


# instance fields
.field private final mUrl:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0}, Landroid/text/style/ClickableSpan;-><init>()V

    .line 57
    iput-object p1, p0, Lcom/mrkeyboard/app/MrLink$SafeSpan;->mUrl:Ljava/lang/String;

    .line 58
    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 62
    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLink$SafeSpan;->mUrl:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLink;->open(Landroid/content/Context;Ljava/lang/String;)Z

    .line 63
    return-void
.end method
