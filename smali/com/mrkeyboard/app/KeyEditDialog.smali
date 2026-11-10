.class public final Lcom/mrkeyboard/app/KeyEditDialog;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/KeyEditDialog$Editor;,
        Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;,
        Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;
    }
.end annotation


# static fields
.field private static final ACTION_DELETE:I = 0x4

.field private static final ACTION_DUPLICATE:I = 0x3

.field private static final ACTION_LEFT:I = 0x1

.field private static final ACTION_RIGHT:I = 0x2

.field private static final EMPTY:Ljava/lang/String;

.field private static final MORE:Ljava/lang/String; = "  \u25be"

.field private static final WIDTH_MAX:I = 0xe

.field private static final WIDTH_PRESETS:[F


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 55
    const/4 v0, 0x5

    new-array v0, v0, [F

    fill-array-data v0, :array_0

    sput-object v0, Lcom/mrkeyboard/app/KeyEditDialog;->WIDTH_PRESETS:[F

    .line 62
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0}, Ljava/lang/String;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/KeyEditDialog;->EMPTY:Ljava/lang/String;

    return-void

    .line 55
    :array_0
    .array-data 4
        0x3f000000    # 0.5f
        0x3f800000    # 1.0f
        0x3fc00000    # 1.5f
        0x40000000    # 2.0f
        0x40400000    # 3.0f
    .end array-data
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 73
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$1000(Ljava/lang/String;I)I
    .locals 1

    .prologue
    .line 35
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/KeyEditDialog;->safeInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method static synthetic access$2300(F)Ljava/lang/String;
    .locals 1

    .prologue
    .line 35
    invoke-static {p0}, Lcom/mrkeyboard/app/KeyEditDialog;->formatWidth(F)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$300()Ljava/lang/String;
    .locals 1

    .prologue
    .line 35
    sget-object v0, Lcom/mrkeyboard/app/KeyEditDialog;->EMPTY:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$800()[F
    .locals 1

    .prologue
    .line 35
    sget-object v0, Lcom/mrkeyboard/app/KeyEditDialog;->WIDTH_PRESETS:[F

    return-object v0
.end method

.method private static formatWidth(F)Ljava/lang/String;
    .locals 5

    .prologue
    const/high16 v1, 0x40000000    # 2.0f

    const v3, 0x3c23d70a    # 0.01f

    const/4 v2, 0x1

    const/4 v4, 0x0

    .line 92
    invoke-static {p0}, Ljava/lang/Math;->round(F)I

    move-result v0

    int-to-float v0, v0

    sub-float v0, p0, v0

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    cmpg-float v0, v0, v3

    if-gez v0, :cond_0

    .line 93
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    const-string v1, "%.0fx"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v3

    aput-object v3, v2, v4

    invoke-static {v0, v1, v2}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 98
    :goto_0
    return-object v0

    .line 95
    :cond_0
    mul-float v0, v1, p0

    mul-float/2addr v1, p0

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    int-to-float v1, v1

    sub-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    cmpg-float v0, v0, v3

    if-gez v0, :cond_1

    .line 96
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    const-string v1, "%.1fx"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v3

    aput-object v3, v2, v4

    invoke-static {v0, v1, v2}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 98
    :cond_1
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    const-string v1, "%.2fx"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v3

    aput-object v3, v2, v4

    invoke-static {v0, v1, v2}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method private static safeInt(Ljava/lang/String;I)I
    .locals 1

    .prologue
    .line 103
    if-nez p0, :cond_0

    .line 107
    :goto_0
    return p1

    .line 105
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result p1

    goto :goto_0

    .line 106
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static show(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            "ZZZZ",
            "Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;",
            ")V"
        }
    .end annotation

    .prologue
    .line 79
    new-instance v0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    const/4 v4, 0x0

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move v5, p3

    move v6, p4

    move v7, p5

    move/from16 v8, p6

    move-object/from16 v9, p7

    invoke-direct/range {v0 .. v9}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;-><init>(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V

    invoke-virtual {v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->show()V

    .line 80
    return-void
.end method

.method public static showForPopupItem(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Lcom/mrkeyboard/app/SheetModel$KeySpec;",
            "Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;",
            ")V"
        }
    .end annotation

    .prologue
    const/4 v5, 0x0

    .line 85
    new-instance v0, Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    const/4 v4, 0x1

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move v6, v5

    move v7, v5

    move v8, v5

    move-object v9, p3

    invoke-direct/range {v0 .. v9}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;-><init>(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V

    invoke-virtual {v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->show()V

    .line 86
    return-void
.end method
