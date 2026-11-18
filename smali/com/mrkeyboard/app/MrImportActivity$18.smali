.class Lcom/mrkeyboard/app/MrImportActivity$18;
.super Ljava/lang/Object;
.source "MrImportActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrImportActivity;->wordsNearEnd(Lcom/mrkeyboard/app/MrPage;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrImportActivity;

.field final synthetic val$scroll:Lcom/mrkeyboard/app/MrPage;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrPage;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 583
    iput-object p1, p0, Lcom/mrkeyboard/app/MrImportActivity$18;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrImportActivity$18;->val$scroll:Lcom/mrkeyboard/app/MrPage;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 585
    iget-object v0, p0, Lcom/mrkeyboard/app/MrImportActivity$18;->this$0:Lcom/mrkeyboard/app/MrImportActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrImportActivity$18;->val$scroll:Lcom/mrkeyboard/app/MrPage;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrImportActivity;->access$3100(Lcom/mrkeyboard/app/MrImportActivity;Lcom/mrkeyboard/app/MrPage;)V

    .line 586
    return-void
.end method
