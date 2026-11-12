.class Lcom/mrkeyboard/app/MrPacksActivity$7;
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


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrPacksActivity;)V
    .locals 0

    .prologue
    .line 410
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPacksActivity$7;->this$0:Lcom/mrkeyboard/app/MrPacksActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    .prologue
    .line 412
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrPacks;->sCancel:Z

    .line 413
    return-void
.end method
