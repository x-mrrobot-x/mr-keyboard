.class Lcom/mrkeyboard/app/MrLearnedActivity$10;
.super Ljava/lang/Object;
.source "MrLearnedActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrLearnedActivity;->typeChip(ILjava/lang/String;)Landroid/widget/TextView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

.field final synthetic val$type:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrLearnedActivity;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 294
    iput-object p1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$10;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    iput p2, p0, Lcom/mrkeyboard/app/MrLearnedActivity$10;->val$type:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 296
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$10;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    iget v1, p0, Lcom/mrkeyboard/app/MrLearnedActivity$10;->val$type:I

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$902(Lcom/mrkeyboard/app/MrLearnedActivity;I)I

    .line 297
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$10;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    const/16 v1, 0x32

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$102(Lcom/mrkeyboard/app/MrLearnedActivity;I)I

    .line 298
    iget-object v0, p0, Lcom/mrkeyboard/app/MrLearnedActivity$10;->this$0:Lcom/mrkeyboard/app/MrLearnedActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrLearnedActivity;->access$700(Lcom/mrkeyboard/app/MrLearnedActivity;)V

    .line 299
    return-void
.end method
