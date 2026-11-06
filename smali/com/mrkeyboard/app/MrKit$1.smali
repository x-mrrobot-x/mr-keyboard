.class Lcom/mrkeyboard/app/MrKit$1;
.super Ljava/lang/Object;
.source "MrKit.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrKit;->languageCard(Landroid/widget/LinearLayout;Ljava/util/List;Ljava/lang/String;Lcom/mrkeyboard/app/MrKit$LangPick;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrKit;

.field final synthetic val$current:Ljava/lang/String;

.field final synthetic val$langs:Ljava/util/List;

.field final synthetic val$onPick:Lcom/mrkeyboard/app/MrKit$LangPick;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrKit;Ljava/util/List;Ljava/lang/String;Lcom/mrkeyboard/app/MrKit$LangPick;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 187
    iput-object p1, p0, Lcom/mrkeyboard/app/MrKit$1;->this$0:Lcom/mrkeyboard/app/MrKit;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrKit$1;->val$langs:Ljava/util/List;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrKit$1;->val$current:Ljava/lang/String;

    iput-object p4, p0, Lcom/mrkeyboard/app/MrKit$1;->val$onPick:Lcom/mrkeyboard/app/MrKit$LangPick;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 7

    .prologue
    const/4 v2, 0x0

    .line 189
    iget-object v0, p0, Lcom/mrkeyboard/app/MrKit$1;->val$langs:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    new-array v4, v0, [Ljava/lang/CharSequence;

    .line 190
    const/4 v0, -0x1

    move v1, v2

    move v3, v0

    .line 191
    :goto_0
    array-length v0, v4

    if-ge v1, v0, :cond_1

    .line 192
    iget-object v5, p0, Lcom/mrkeyboard/app/MrKit$1;->this$0:Lcom/mrkeyboard/app/MrKit;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrKit$1;->val$langs:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v5, v0}, Lcom/mrkeyboard/app/MrKit;->langName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v4, v1

    .line 193
    iget-object v0, p0, Lcom/mrkeyboard/app/MrKit$1;->val$langs:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrKit$1;->val$current:Ljava/lang/String;

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    move v3, v1

    .line 191
    :cond_0
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 195
    :cond_1
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit$1;->this$0:Lcom/mrkeyboard/app/MrKit;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrKit;->act:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit$1;->this$0:Lcom/mrkeyboard/app/MrKit;

    const-string v5, "mr_lang_card_title"

    new-array v6, v2, [Ljava/lang/Object;

    .line 196
    invoke-virtual {v1, v5, v6}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/MrKit$1$1;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrKit$1$1;-><init>(Lcom/mrkeyboard/app/MrKit$1;)V

    .line 197
    invoke-virtual {v0, v4, v3, v1}, Landroid/app/AlertDialog$Builder;->setSingleChoiceItems([Ljava/lang/CharSequence;ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrKit$1;->this$0:Lcom/mrkeyboard/app/MrKit;

    const-string v3, "mr_words_cancel"

    new-array v2, v2, [Ljava/lang/Object;

    .line 204
    invoke-virtual {v1, v3, v2}, Lcom/mrkeyboard/app/MrKit;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 205
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 206
    return-void
.end method
