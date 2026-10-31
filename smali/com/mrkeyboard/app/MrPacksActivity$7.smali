.class Lcom/mrkeyboard/app/MrPacksActivity$7;
.super Ljava/lang/Object;
.source "MrPacksActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPacksActivity;->showPack(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrPacksActivity;

.field final synthetic val$id:Ljava/lang/String;

.field final synthetic val$title:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 329
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$7;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrPacksActivity$7;->val$id:Ljava/lang/String;

    iput-object p3, p0, Lcom/mrkeyboard/app/MrPacksActivity$7;->val$title:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3

    .prologue
    .line 331
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$7;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrPacksActivity$7;->val$id:Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrPacksActivity$7;->val$title:Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1300(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;Ljava/lang/String;)V

    .line 332
    return-void
.end method
