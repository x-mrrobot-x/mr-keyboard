.class Lcom/mrkeyboard/app/MrPacksActivity$15;
.super Ljava/lang/Object;
.source "MrPacksActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrPacksActivity;->askModel()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrPacksActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 597
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$15;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    .prologue
    .line 599
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$15;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    const-string v1, "gesture"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$1002(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 600
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$15;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$400(Lcom/mrkeyboard/app/MrPacksActivity;)V

    .line 601
    return-void
.end method
