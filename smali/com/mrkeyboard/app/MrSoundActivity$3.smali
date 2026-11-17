.class Lcom/mrkeyboard/app/MrSoundActivity$3;
.super Ljava/lang/Object;
.source "MrSoundActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrSoundActivity;->tile(Ljava/lang/String;Landroid/graphics/Paint;)Landroid/widget/LinearLayout;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrSoundActivity;

.field final synthetic val$id:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrSoundActivity;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 135
    iput-object p1, p0, Lcom/mrkeyboard/app/MrSoundActivity$3;->this$0:Lcom/mrkeyboard/app/MrSoundActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrSoundActivity$3;->val$id:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 137
    iget-object v0, p0, Lcom/mrkeyboard/app/MrSoundActivity$3;->this$0:Lcom/mrkeyboard/app/MrSoundActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrSoundActivity$3;->val$id:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrSoundActivity;->choose(Ljava/lang/String;)V

    .line 138
    return-void
.end method
