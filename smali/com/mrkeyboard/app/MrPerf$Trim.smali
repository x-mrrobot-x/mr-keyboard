.class final Lcom/mrkeyboard/app/MrPerf$Trim;
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
    name = "Trim"
.end annotation


# instance fields
.field private final mContext:Landroid/content/Context;

.field private final mRow:Landroid/preference/Preference;


# direct methods
.method constructor <init>(Landroid/content/Context;Landroid/preference/Preference;)V
    .locals 0

    .prologue
    .line 629
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 630
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPerf$Trim;->mContext:Landroid/content/Context;

    .line 631
    iput-object p2, p0, Lcom/mrkeyboard/app/MrPerf$Trim;->mRow:Landroid/preference/Preference;

    .line 632
    return-void
.end method


# virtual methods
.method public onPreferenceClick(Landroid/preference/Preference;)Z
    .locals 2

    .prologue
    .line 635
    const/16 v0, 0x50

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTrim;->onTrim(I)V

    .line 636
    invoke-static {}, Ljava/lang/System;->gc()V

    .line 637
    invoke-static {}, Lcom/mrkeyboard/app/MrLive;->measure()V

    .line 638
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPerf$Trim;->mRow:Landroid/preference/Preference;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPerf$Trim;->mContext:Landroid/content/Context;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPerf;->summary(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 639
    const/4 v0, 0x1

    return v0
.end method
