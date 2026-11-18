.class final Lcom/mrkeyboard/app/MrAppList$Entry;
.super Ljava/lang/Object;
.source "MrAppList.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrAppList;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Entry"
.end annotation


# instance fields
.field final folded:Ljava/lang/String;

.field final label:Ljava/lang/String;

.field final note:Ljava/lang/String;

.field final pkg:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .prologue
    .line 42
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/mrkeyboard/app/MrAppList$Entry;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 43
    return-void
.end method

.method constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 46
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppList$Entry;->pkg:Ljava/lang/String;

    .line 47
    iput-object p2, p0, Lcom/mrkeyboard/app/MrAppList$Entry;->label:Ljava/lang/String;

    .line 48
    invoke-static {p2}, Lcom/mrkeyboard/app/MrMemStore;->fold(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrAppList$Entry;->folded:Ljava/lang/String;

    .line 49
    iput-object p3, p0, Lcom/mrkeyboard/app/MrAppList$Entry;->note:Ljava/lang/String;

    .line 50
    return-void
.end method
