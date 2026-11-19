.class Lcom/mrkeyboard/app/MrThemesActivity$11;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->addCard(Lcom/mrkeyboard/app/MrThemesActivity$Card;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$card:Lcom/mrkeyboard/app/MrThemesActivity$Card;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;Lcom/mrkeyboard/app/MrThemesActivity$Card;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 503
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$11;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$11;->val$card:Lcom/mrkeyboard/app/MrThemesActivity$Card;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 505
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$11;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$11;->val$card:Lcom/mrkeyboard/app/MrThemesActivity$Card;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrThemesActivity$Card;->spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->openBackdrop(Lcom/mrkeyboard/app/MrBackdrop$Spec;)V

    .line 506
    return-void
.end method
