.class Lcom/mrkeyboard/app/MrLearnedActivity$13;
.super Ljava/lang/Object;
.source "MrLearnedActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrLearnedActivity;->askEdit(Lcom/mrkeyboard/app/MrWordStore$Row;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

.field final synthetic val$box:Landroid/widget/EditText;

.field final synthetic val$r:Lcom/mrkeyboard/app/MrWordStore$Row;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrLearnedActivity;Lcom/mrkeyboard/app/MrWordStore$Row;Landroid/widget/EditText;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 411
    iput-object p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$13;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrLearnedActivity$13;->val$r:Lcom/mrkeyboard/app/MrWordStore$Row;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrLearnedActivity$13;->val$box:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3

    .prologue
    .line 413
    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$13;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity$13;->val$r:Lcom/mrkeyboard/app/MrWordStore$Row;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$13;->val$box:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, ""

    :goto_0
    invoke-static {v1, v2, v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$1200(Lcom/mrkeyboard/app/MrLearnedActivity;Lcom/mrkeyboard/app/MrWordStore$Row;Ljava/lang/String;)V

    .line 414
    return-void

    .line 413
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$13;->val$box:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method
