.class final Lcom/mrkeyboard/app/MrAiStyleActivity$Act;
.super Ljava/lang/Object;
.source "MrAiStyleActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrAiStyleActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "Act"
.end annotation


# instance fields
.field private final code:I

.field final synthetic this$0:Lcom/mrkeyboard/app/MrAiStyleActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAiStyleActivity;I)V
    .locals 0

    .prologue
    .line 44
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;->this$0:Lcom/mrkeyboard/app/MrAiStyleActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 45
    iput p2, p0, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;->code:I

    .line 46
    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 49
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;->this$0:Lcom/mrkeyboard/app/MrAiStyleActivity;

    iget v1, p0, Lcom/mrkeyboard/app/MrAiStyleActivity$Act;->code:I

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAiStyleActivity;->access$000(Lcom/mrkeyboard/app/MrAiStyleActivity;I)V

    .line 50
    return-void
.end method
