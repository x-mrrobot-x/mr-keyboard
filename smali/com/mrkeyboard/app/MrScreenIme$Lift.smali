.class final Lcom/mrkeyboard/app/MrScreenIme$Lift;
.super Ljava/lang/Object;
.source "MrScreenIme.java"

# interfaces
.implements Landroid/view/View$OnApplyWindowInsetsListener;
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrScreenIme;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Lift"
.end annotation


# instance fields
.field private final mBottom:I

.field private final mColumn:Landroid/view/View;

.field private mLastExtra:I

.field private final mLeft:I

.field private final mMargin:I

.field private final mRight:I

.field private final mScroll:Landroid/widget/ScrollView;

.field private final mTop:I


# direct methods
.method constructor <init>(Landroid/widget/ScrollView;Landroid/view/View;IIIII)V
    .locals 0

    .prologue
    .line 128
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 129
    iput-object p1, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mScroll:Landroid/widget/ScrollView;

    .line 130
    iput-object p2, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mColumn:Landroid/view/View;

    .line 131
    iput p3, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mLeft:I

    .line 132
    iput p4, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mTop:I

    .line 133
    iput p5, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mRight:I

    .line 134
    iput p6, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mBottom:I

    .line 135
    iput p7, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mMargin:I

    .line 136
    return-void
.end method


# virtual methods
.method public onApplyWindowInsets(Landroid/view/View;Landroid/view/WindowInsets;)Landroid/view/WindowInsets;
    .locals 7

    .prologue
    .line 139
    invoke-static {p2}, Lcom/mrkeyboard/app/MrScreenIme$Api30;->extra(Landroid/view/WindowInsets;)I

    move-result v1

    .line 140
    iget v0, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mLastExtra:I

    if-eq v1, v0, :cond_0

    .line 141
    iget v0, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mLastExtra:I

    if-le v1, v0, :cond_1

    if-lez v1, :cond_1

    const/4 v0, 0x1

    .line 142
    :goto_0
    iput v1, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mLastExtra:I

    .line 143
    iget-object v2, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mColumn:Landroid/view/View;

    iget v3, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mLeft:I

    iget v4, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mTop:I

    iget v5, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mRight:I

    iget v6, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mBottom:I

    add-int/2addr v1, v6

    invoke-virtual {v2, v3, v4, v5, v1}, Landroid/view/View;->setPadding(IIII)V

    .line 144
    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {v0, p0}, Landroid/widget/ScrollView;->post(Ljava/lang/Runnable;)Z

    .line 146
    :cond_0
    return-object p2

    .line 141
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public run()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 150
    iget-object v0, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {v0}, Landroid/widget/ScrollView;->findFocus()Landroid/view/View;

    move-result-object v0

    .line 151
    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mColumn:Landroid/view/View;

    if-eq v0, v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mScroll:Landroid/widget/ScrollView;

    invoke-virtual {v0}, Landroid/view/View;->getTop()I

    move-result v0

    iget v2, p0, Lcom/mrkeyboard/app/MrScreenIme$Lift;->mMargin:I

    sub-int/2addr v0, v2

    invoke-static {v3, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-virtual {v1, v3, v0}, Landroid/widget/ScrollView;->scrollTo(II)V

    .line 152
    :cond_0
    return-void
.end method
