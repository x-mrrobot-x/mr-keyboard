.class final Lcom/mrkeyboard/app/MrUpdateUi$Auto;
.super Ljava/lang/Object;
.source "MrUpdateUi.java"

# interfaces
.implements Landroid/preference/Preference$OnPreferenceChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrUpdateUi;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Auto"
.end annotation


# instance fields
.field private final mContext:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0

    .prologue
    .line 134
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 135
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateUi$Auto;->mContext:Landroid/content/Context;

    .line 136
    return-void
.end method


# virtual methods
.method public onPreferenceChange(Landroid/preference/Preference;Ljava/lang/Object;)Z
    .locals 2

    .prologue
    .line 139
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$Auto;->mContext:Landroid/content/Context;

    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v1, p2}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrUpdate;->setAuto(Landroid/content/Context;Z)V

    .line 140
    const/4 v0, 0x1

    return v0
.end method
