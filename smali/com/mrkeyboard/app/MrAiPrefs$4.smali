.class Lcom/mrkeyboard/app/MrAiPrefs$4;
.super Ljava/lang/Object;
.source "MrAiPrefs.java"

# interfaces
.implements Landroid/preference/Preference$OnPreferenceChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAiPrefs;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrAiPrefs;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAiPrefs;)V
    .locals 0

    .prologue
    .line 75
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAiPrefs$4;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPreferenceChange(Landroid/preference/Preference;Ljava/lang/Object;)Z
    .locals 2

    .prologue
    .line 77
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs$4;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    invoke-static {p2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAiPrefs;->access$100(Lcom/mrkeyboard/app/MrAiPrefs;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    .line 78
    const/4 v0, 0x1

    return v0
.end method
