.class Lcom/mrkeyboard/app/MrPacksActivity$14;
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
    .line 513
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$14;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    .prologue
    .line 515
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$14;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    const-string v1, "gesture"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrPacksActivity;->access$802(Lcom/mrkeyboard/app/MrPacksActivity;Ljava/lang/String;)Ljava/lang/String;

    .line 516
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPacksActivity$14;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrPacksActivity;->access$400(Lcom/mrkeyboard/app/MrPacksActivity;)V

    .line 517
    return-void
.end method
