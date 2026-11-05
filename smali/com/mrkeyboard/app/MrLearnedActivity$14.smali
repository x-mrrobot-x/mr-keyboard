.class Lcom/mrkeyboard/app/MrLearnedActivity$14;
.super Ljava/lang/Object;
.source "MrLearnedActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrLearnedActivity;->askDeleteAll()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

.field final synthetic val$tab:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrLearnedActivity;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 466
    iput-object p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$14;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    iput p2, p0, Lcom/mrkeyboard/app/MrLearnedActivity$14;->val$tab:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    .prologue
    .line 468
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$14;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    iget v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$14;->val$tab:I

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$1300(Lcom/mrkeyboard/app/MrLearnedActivity;I)V

    .line 469
    return-void
.end method
