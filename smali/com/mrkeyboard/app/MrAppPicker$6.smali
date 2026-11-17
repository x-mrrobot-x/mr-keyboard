.class Lcom/mrkeyboard/app/MrAppPicker$6;
.super Ljava/lang/Object;
.source "MrAppPicker.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrAppPicker;->row(Lcom/mrkeyboard/app/MrAppList$Entry;Ljava/util/ArrayList;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrAppPicker;

.field final synthetic val$e:Lcom/mrkeyboard/app/MrAppList$Entry;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrAppPicker;Lcom/mrkeyboard/app/MrAppList$Entry;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 207
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppPicker$6;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrAppPicker$6;->val$e:Lcom/mrkeyboard/app/MrAppList$Entry;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 209
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAppPicker$6;->this$0:Lcom/mrkeyboard/app/MrAppPicker;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrAppPicker$6;->val$e:Lcom/mrkeyboard/app/MrAppList$Entry;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrAppList$Entry;->pkg:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAppPicker;->access$200(Lcom/mrkeyboard/app/MrAppPicker;Ljava/lang/String;)V

    .line 210
    return-void
.end method
