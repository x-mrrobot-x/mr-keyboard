.class Lcom/mrkeyboard/app/MrAccel$2;
.super Ljava/lang/Object;
.source "MrAccel.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAccel;->fillScreen(Landroid/preference/PreferenceActivity;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$decor:Landroid/view/View;

.field final synthetic val$row:Landroid/preference/Preference;

.field final synthetic val$screen:Landroid/preference/PreferenceActivity;


# direct methods
.method constructor <init>(Landroid/preference/PreferenceActivity;Landroid/preference/Preference;Landroid/view/View;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 129
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAccel$2;->val$screen:Landroid/preference/PreferenceActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrAccel$2;->val$row:Landroid/preference/Preference;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrAccel$2;->val$decor:Landroid/view/View;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 130
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAccel$2;->val$screen:Landroid/preference/PreferenceActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAccel$2;->val$row:Landroid/preference/Preference;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrAccel$2;->val$decor:Landroid/view/View;

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrAccel;->showScreen(Landroid/preference/PreferenceActivity;Landroid/preference/Preference;Landroid/view/View;)V

    return-void
.end method
