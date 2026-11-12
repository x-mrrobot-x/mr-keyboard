.class Lcom/mrkeyboard/app/MrPacksActivity$13;
.super Ljava/lang/Object;
.source "MrPacksActivity.java"

# interfaces
.implements Landroid/preference/Preference$OnPreferenceClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPacksActivity;->buildGesture()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrPacksActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 521
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$13;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPreferenceClick(Landroid/preference/Preference;)Z
    .locals 1

    .prologue
    .line 523
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$13;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$2100(Lcom/mrkeyboard/app/MrPacksActivity;)V

    .line 524
    const/4 v0, 0x1

    return v0
.end method
