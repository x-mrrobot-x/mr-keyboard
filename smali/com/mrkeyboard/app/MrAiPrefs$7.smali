.class Lcom/mrkeyboard/app/MrAiPrefs$7;
.super Ljava/lang/Object;
.source "MrAiPrefs.java"

# interfaces
.implements Landroid/preference/Preference$OnPreferenceClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAiPrefs;->rebuildStyles()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrAiPrefs;

.field final synthetic val$index:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAiPrefs;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 193
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAiPrefs$7;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    iput p2, p0, Lcom/mrkeyboard/app/MrAiPrefs$7;->val$index:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPreferenceClick(Landroid/preference/Preference;)Z
    .locals 2

    .prologue
    .line 195
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiPrefs$7;->this$0:Lcom/mrkeyboard/app/MrAiPrefs;

    iget v1, p0, Lcom/mrkeyboard/app/MrAiPrefs$7;->val$index:I

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAi;->openStyleEditor(Landroid/content/Context;I)V

    .line 196
    const/4 v0, 0x1

    return v0
.end method
