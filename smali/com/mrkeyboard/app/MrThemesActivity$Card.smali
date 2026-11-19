.class final Lcom/mrkeyboard/app/MrThemesActivity$Card;
.super Ljava/lang/Object;
.source "MrThemesActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrThemesActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Card"
.end annotation


# instance fields
.field final index:I

.field final kind:I

.field final name:Ljava/lang/String;

.field final spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;


# direct methods
.method constructor <init>(IILcom/mrkeyboard/app/MrBackdrop$Spec;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 78
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 79
    iput p1, p0, Lcom/mrkeyboard/app/MrThemesActivity$Card;->kind:I

    .line 80
    iput p2, p0, Lcom/mrkeyboard/app/MrThemesActivity$Card;->index:I

    .line 81
    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemesActivity$Card;->spec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 82
    iput-object p4, p0, Lcom/mrkeyboard/app/MrThemesActivity$Card;->name:Ljava/lang/String;

    .line 83
    return-void
.end method
