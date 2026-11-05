.class final Lcom/mrkeyboard/app/MrUpdateUi$Check;
.super Ljava/lang/Object;
.source "MrUpdateUi.java"

# interfaces
.implements Landroid/preference/Preference$OnPreferenceClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrUpdateUi;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Check"
.end annotation


# instance fields
.field private final mActivity:Landroid/preference/PreferenceActivity;


# direct methods
.method constructor <init>(Landroid/preference/PreferenceActivity;)V
    .locals 0

    .prologue
    .line 192
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 193
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateUi$Check;->mActivity:Landroid/preference/PreferenceActivity;

    .line 194
    return-void
.end method


# virtual methods
.method public onPreferenceClick(Landroid/preference/Preference;)Z
    .locals 1

    .prologue
    .line 197
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateUi$Check;->mActivity:Landroid/preference/PreferenceActivity;

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrUpdateUi;->access$200(Landroid/app/Activity;Landroid/preference/Preference;)V

    .line 198
    const/4 v0, 0x1

    return v0
.end method
