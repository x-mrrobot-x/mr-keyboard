.class Lcom/mrkeyboard/app/MrLearnedActivity$12;
.super Ljava/lang/Object;
.source "MrLearnedActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrLearnedActivity;->menu(Lcom/mrkeyboard/app/MrWordStore$Row;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

.field final synthetic val$codes:Ljava/util/ArrayList;

.field final synthetic val$r:Lcom/mrkeyboard/app/MrWordStore$Row;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrLearnedActivity;Ljava/util/ArrayList;Lcom/mrkeyboard/app/MrWordStore$Row;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 364
    iput-object p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$12;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrLearnedActivity$12;->val$codes:Ljava/util/ArrayList;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrLearnedActivity$12;->val$r:Lcom/mrkeyboard/app/MrWordStore$Row;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3

    .prologue
    .line 366
    if-ltz p2, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$12;->val$codes:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge p2, v0, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$12;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$12;->val$codes:Ljava/util/ArrayList;

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrLearnedActivity$12;->val$r:Lcom/mrkeyboard/app/MrWordStore$Row;

    invoke-static {v1, v0, v2}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$1100(Lcom/mrkeyboard/app/MrLearnedActivity;ILcom/mrkeyboard/app/MrWordStore$Row;)V

    .line 367
    :cond_0
    return-void
.end method
