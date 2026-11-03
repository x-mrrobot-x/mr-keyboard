.class Lcom/mrkeyboard/app/MrAiPrefs$6;
.super Ljava/lang/Object;
.source "MrAiPrefs.java"

# interfaces
.implements Landroid/preference/Preference$OnPreferenceClickListener;


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
    .line 95
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAiPrefs$6;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPreferenceClick(Landroid/preference/Preference;)Z
    .locals 1

    .prologue
    .line 97
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs$6;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAiPrefs;->access$300(Lcom/mrkeyboard/app/MrAiPrefs;)V

    .line 98
    const/4 v0, 0x1

    return v0
.end method
