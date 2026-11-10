.class Lcom/mrkeyboard/app/PopupEditDialog$Editor$5;
.super Ljava/lang/Object;
.source "PopupEditDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PopupEditDialog$Editor;->show()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PopupEditDialog$Editor;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)V
    .locals 0

    .prologue
    .line 199
    iput-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$5;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$Editor;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    .prologue
    .line 201
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$5;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->access$500(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)V

    .line 202
    return-void
.end method
