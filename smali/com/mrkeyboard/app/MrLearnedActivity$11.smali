.class Lcom/mrkeyboard/app/MrLearnedActivity$11;
.super Ljava/lang/Object;
.source "MrLearnedActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrLearnedActivity;->refreshList()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

.field final synthetic val$r:Lcom/mrkeyboard/app/MrWordStore$Row;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrLearnedActivity;Lcom/mrkeyboard/app/MrWordStore$Row;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 316
    iput-object p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$11;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrLearnedActivity$11;->val$r:Lcom/mrkeyboard/app/MrWordStore$Row;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 318
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$11;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$11;->val$r:Lcom/mrkeyboard/app/MrWordStore$Row;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$1000(Lcom/mrkeyboard/app/MrLearnedActivity;Lcom/mrkeyboard/app/MrWordStore$Row;)V

    .line 319
    return-void
.end method
