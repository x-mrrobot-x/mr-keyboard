.class Lcom/mrkeyboard/app/MrTourActivity$2;
.super Ljava/lang/Object;
.source "MrTourActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrTourActivity;->render()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrTourActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrTourActivity;)V
    .locals 0

    .prologue
    .line 134
    iput-object p1, p0, Lcom/mrkeyboard/app/MrTourActivity$2;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .prologue
    .line 136
    iget-object v0, p0, Lcom/mrkeyboard/app/MrTourActivity$2;->this$0:Lcom/mrkeyboard/app/MrTourActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrTourActivity;->finish()V

    .line 137
    return-void
.end method
