.class public Lcom/mrkeyboard/app/Keyboard$Row;
.super Ljava/lang/Object;
.source "Keyboard.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/Keyboard;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Row"
.end annotation


# instance fields
.field public defaultHeight:I

.field public defaultHorizontalGap:F

.field public defaultWidth:F

.field public extension:Z

.field public mode:I

.field private parent:Lcom/mrkeyboard/app/Keyboard;

.field public verticalGap:I


# direct methods
.method public constructor <init>(Landroid/content/res/Resources;Lcom/mrkeyboard/app/Keyboard;Landroid/content/res/XmlResourceParser;)V
    .locals 5

    .line 202
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 203
    iput-object p2, p0, Lcom/mrkeyboard/app/Keyboard$Row;->parent:Lcom/mrkeyboard/app/Keyboard;

    .line 204
    invoke-static {p3}, Landroid/util/Xml;->asAttributeSet(Lorg/xmlpull/v1/XmlPullParser;)Landroid/util/AttributeSet;

    move-result-object v0

    sget-object v1, Lcom/mrkeyboard/app/R$styleable;->Keyboard:[I

    invoke-virtual {p1, v0, v1}, Landroid/content/res/Resources;->obtainAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object v0

    .line 208
    invoke-static {p2}, Lcom/mrkeyboard/app/Keyboard;->access$000(Lcom/mrkeyboard/app/Keyboard;)I

    move-result v1

    invoke-static {p2}, Lcom/mrkeyboard/app/Keyboard;->access$100(Lcom/mrkeyboard/app/Keyboard;)F

    move-result v2

    const/4 v3, 0x3

    .line 206
    invoke-static {v0, v3, v1, v2}, Lcom/mrkeyboard/app/Keyboard;->getDimensionOrFraction(Landroid/content/res/TypedArray;IIF)F

    move-result v1

    iput v1, p0, Lcom/mrkeyboard/app/Keyboard$Row;->defaultWidth:F

    .line 211
    invoke-static {p2}, Lcom/mrkeyboard/app/Keyboard;->access$200(Lcom/mrkeyboard/app/Keyboard;)I

    move-result v1

    invoke-static {p2}, Lcom/mrkeyboard/app/Keyboard;->access$300(Lcom/mrkeyboard/app/Keyboard;)I

    move-result v2

    int-to-float v2, v2

    const/4 v3, 0x2

    .line 209
    invoke-static {v0, v3, v1, v2}, Lcom/mrkeyboard/app/Keyboard;->getDimensionOrFraction(Landroid/content/res/TypedArray;IIF)F

    move-result v1

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    iput v1, p0, Lcom/mrkeyboard/app/Keyboard$Row;->defaultHeight:I

    .line 214
    invoke-static {p2}, Lcom/mrkeyboard/app/Keyboard;->access$000(Lcom/mrkeyboard/app/Keyboard;)I

    move-result v1

    invoke-static {p2}, Lcom/mrkeyboard/app/Keyboard;->access$400(Lcom/mrkeyboard/app/Keyboard;)F

    move-result v2

    const/4 v3, 0x0

    .line 212
    invoke-static {v0, v3, v1, v2}, Lcom/mrkeyboard/app/Keyboard;->getDimensionOrFraction(Landroid/content/res/TypedArray;IIF)F

    move-result v1

    iput v1, p0, Lcom/mrkeyboard/app/Keyboard$Row;->defaultHorizontalGap:F

    .line 217
    invoke-static {p2}, Lcom/mrkeyboard/app/Keyboard;->access$200(Lcom/mrkeyboard/app/Keyboard;)I

    move-result v1

    invoke-static {p2}, Lcom/mrkeyboard/app/Keyboard;->access$500(Lcom/mrkeyboard/app/Keyboard;)I

    move-result v2

    int-to-float v2, v2

    const/4 v4, 0x6

    .line 215
    invoke-static {v0, v4, v1, v2}, Lcom/mrkeyboard/app/Keyboard;->getDimensionOrFraction(Landroid/content/res/TypedArray;IIF)F

    move-result v1

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    iput v1, p0, Lcom/mrkeyboard/app/Keyboard$Row;->verticalGap:I

    .line 218
    invoke-virtual {v0}, Landroid/content/res/TypedArray;->recycle()V

    .line 219
    invoke-static {p3}, Landroid/util/Xml;->asAttributeSet(Lorg/xmlpull/v1/XmlPullParser;)Landroid/util/AttributeSet;

    move-result-object p3

    sget-object v0, Lcom/mrkeyboard/app/R$styleable;->Keyboard_Row:[I

    invoke-virtual {p1, p3, v0}, Landroid/content/res/Resources;->obtainAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object p1

    const/4 p3, 0x1

    .line 221
    invoke-virtual {p1, p3, v3}, Landroid/content/res/TypedArray;->getResourceId(II)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/Keyboard$Row;->mode:I

    .line 223
    invoke-virtual {p1, v3, v3}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v0

    iput-boolean v0, p0, Lcom/mrkeyboard/app/Keyboard$Row;->extension:Z

    .line 225
    iget v0, p2, Lcom/mrkeyboard/app/Keyboard;->mLayoutRows:I

    const/4 v1, 0x5

    if-ge v0, v1, :cond_0

    iget-boolean v0, p0, Lcom/mrkeyboard/app/Keyboard$Row;->extension:Z

    if-eqz v0, :cond_4

    .line 228
    :cond_0
    iget-boolean v0, p0, Lcom/mrkeyboard/app/Keyboard$Row;->extension:Z

    if-nez v0, :cond_1

    iget v0, p2, Lcom/mrkeyboard/app/Keyboard;->mRowCount:I

    iget v1, p2, Lcom/mrkeyboard/app/Keyboard;->mExtensionRowCount:I

    sub-int/2addr v0, v1

    if-gtz v0, :cond_2

    :cond_1
    const/4 v3, 0x1

    .line 229
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/LatinIME;->sKeyboardSettings:Lcom/mrkeyboard/app/GlobalKeyboardSettings;

    iget v0, v0, Lcom/mrkeyboard/app/GlobalKeyboardSettings;->topRowScale:F

    if-eqz v3, :cond_3

    goto :goto_0

    :cond_3
    const/high16 v1, 0x3f800000    # 1.0f

    sub-float v0, v1, v0

    .line 233
    iget p2, p2, Lcom/mrkeyboard/app/Keyboard;->mLayoutRows:I

    sub-int/2addr p2, p3

    int-to-float p2, p2

    div-float/2addr v0, p2

    add-float/2addr v0, v1

    .line 236
    :goto_0
    iget p2, p0, Lcom/mrkeyboard/app/Keyboard$Row;->defaultHeight:I

    int-to-float p2, p2

    mul-float p2, p2, v0

    invoke-static {p2}, Ljava/lang/Math;->round(F)I

    move-result p2

    iput p2, p0, Lcom/mrkeyboard/app/Keyboard$Row;->defaultHeight:I

    .line 238
    :cond_4
    invoke-virtual {p1}, Landroid/content/res/TypedArray;->recycle()V

    return-void
.end method

.method public constructor <init>(Lcom/mrkeyboard/app/Keyboard;)V
    .locals 0

    .line 198
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 199
    iput-object p1, p0, Lcom/mrkeyboard/app/Keyboard$Row;->parent:Lcom/mrkeyboard/app/Keyboard;

    return-void
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/Keyboard$Row;)Lcom/mrkeyboard/app/Keyboard;
    .locals 0

    .line 181
    iget-object p0, p0, Lcom/mrkeyboard/app/Keyboard$Row;->parent:Lcom/mrkeyboard/app/Keyboard;

    return-object p0
.end method
