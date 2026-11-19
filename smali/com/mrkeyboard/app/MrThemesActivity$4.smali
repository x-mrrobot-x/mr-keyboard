.class Lcom/mrkeyboard/app/MrThemesActivity$4;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrThemesActivity;->addBg(Landroid/widget/LinearLayout;Lcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;I)Lcom/mrkeyboard/app/MrThemePreview;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrThemesActivity;

.field final synthetic val$spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrThemesActivity;Lcom/mrkeyboard/app/MrBackdrop$Spec;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 245
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$4;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$4;->val$spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 247
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemesActivity$4;->this$0:Lcom/mrkeyboard/app/MrThemesActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemesActivity$4;->val$spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/MrThemesActivity;->openBackdrop(Lcom/mrkeyboard/app/MrBackdrop$Spec;)V

    .line 248
    return-void
.end method
