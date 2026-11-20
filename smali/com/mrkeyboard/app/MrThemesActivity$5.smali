.class Lcom/mrkeyboard/app/MrThemesActivity$5;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->buildMore(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$load:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 403
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$5;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$5;->val$load:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 405
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$5;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$5;->val$load:I

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->buildMore(I)V

    .line 406
    return-void
.end method
