.class Lcom/mrkeyboard/app/MrPacksActivity$8;
.super Ljava/lang/Object;
.source "MrPacksActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPacksActivity;->details(Ljava/lang/String;Lcom/mrkeyboard/app/MrPacks$Pack;ILjava/lang/String;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrPacksActivity;

.field final synthetic val$p:Lcom/mrkeyboard/app/MrPacks$Pack;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrPacks$Pack;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 417
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$8;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrPacksActivity$8;->val$p:Lcom/mrkeyboard/app/MrPacks$Pack;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    .prologue
    .line 419
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$8;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$8;->val$p:Lcom/mrkeyboard/app/MrPacks$Pack;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1500(Lcom/mrkeyboard/app/MrPacksActivity;Lcom/mrkeyboard/app/MrPacks$Pack;)V

    .line 420
    return-void
.end method
