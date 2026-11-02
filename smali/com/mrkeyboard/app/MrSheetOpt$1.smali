.class Lcom/mrkeyboard/app/MrSheetOpt$1;
.super Ljava/lang/Object;
.source "MrSheetOpt.java"

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrSheetOpt;->row(Landroid/content/Context;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$c:Landroid/content/Context;

.field final synthetic val$sp:Landroid/content/SharedPreferences;

.field final synthetic val$summary:Landroid/widget/TextView;


# direct methods
.method constructor <init>(Landroid/content/SharedPreferences;Landroid/widget/TextView;Landroid/content/Context;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 66
    iput-object p1, p0, Lcom/mrkeyboard/app/MrSheetOpt$1;->val$sp:Landroid/content/SharedPreferences;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrSheetOpt$1;->val$summary:Landroid/widget/TextView;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrSheetOpt$1;->val$c:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 4

    .prologue
    .line 68
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSheetOpt$1;->val$sp:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "pref_sheet_return"

    invoke-interface {v0, v1, p2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 69
    iget-object v1, p0, Lcom/mrkeyboard/app/MrSheetOpt$1;->val$summary:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrSheetOpt$1;->val$c:Landroid/content/Context;

    if-eqz p2, :cond_0

    const-string v0, "summary_sheet_return_true"

    :goto_0
    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v2, v0, v3}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 70
    return-void

    .line 69
    :cond_0
    const-string v0, "summary_sheet_return_false"

    goto :goto_0
.end method
