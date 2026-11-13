.class final Lcom/mrkeyboard/app/MrPerf$Reset;
.super Ljava/lang/Object;
.source "MrPerf.java"

# interfaces
.implements Landroid/preference/Preference$OnPreferenceClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrPerf;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Reset"
.end annotation


# instance fields
.field private final mContext:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0

    .prologue
    .line 348
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/mrkeyboard/app/MrPerf$Reset;->mContext:Landroid/content/Context;

    return-void
.end method


# virtual methods
.method public onPreferenceClick(Landroid/preference/Preference;)Z
    .locals 1

    .prologue
    .line 351
    invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->reset()V

    .line 352
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPerf$Reset;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPerf;->summary(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 353
    const/4 v0, 0x1

    return v0
.end method
