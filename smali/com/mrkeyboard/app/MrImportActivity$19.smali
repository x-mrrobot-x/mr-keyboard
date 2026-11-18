.class Lcom/mrkeyboard/app/MrImportActivity$19;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity;->drawWords(Landroid/widget/ScrollView;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrImportActivity;

.field final synthetic val$scroll:Landroid/widget/ScrollView;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/ScrollView;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 605
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$19;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity$19;->val$scroll:Landroid/widget/ScrollView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 607
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$19;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$19;->val$scroll:Landroid/widget/ScrollView;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$2400(Lcom/mrkeyboard/app/MrImportActivity;Landroid/widget/ScrollView;)V

    .line 608
    return-void
.end method
