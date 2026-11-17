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
    .line 783
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 784
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPerf$Trim;->mContext:Landroid/content/Context;

    .line 785
    iput-object p2, p0, Lcom/mrkeyboard/app/MrPerf$Trim;->mRow:Landroid/preference/Preference;

    .line 786
    return-void
.end method


# virtual methods
.method public onPreferenceClick(Landroid/preference/Preference;)Z
    .locals 2

    .prologue
    .line 789
    const/16 v0, 0x50

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTrim;->onTrim(I)V

    .line 790
    invoke-static {}, Ljava/lang/System;->gc()V

    .line 791
    invoke-static {}, Lcom/mrkeyboard/app/MrLive;->measure()V

    .line 792
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPerf$Trim;->mRow:Landroid/preference/Preference;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPerf$Trim;->mContext:Landroid/content/Context;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrPerf;->summary(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 793
    const/4 v0, 0x1

    return v0
.end method
