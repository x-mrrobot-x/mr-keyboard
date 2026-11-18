.class final Lcom/mrkeyboard/app/MrAppList$Found;
.super Ljava/lang/Object;
.source "MrAppList.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrAppList;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Found"
.end annotation


# instance fields
.field final info:Landroid/content/pm/ResolveInfo;

.field final pkg:Ljava/lang/String;

.field final source:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;Landroid/content/pm/ResolveInfo;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 64
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 65
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppList$Found;->pkg:Ljava/lang/String;

    .line 66
    iput-object p2, p0, Lcom/mrkeyboard/app/MrAppList$Found;->info:Landroid/content/pm/ResolveInfo;

    .line 67
    if-nez p3, :cond_0

    const-string p3, ""

    :cond_0
    iput-object p3, p0, Lcom/mrkeyboard/app/MrAppList$Found;->source:Ljava/lang/String;

    .line 68
    return-void
.end method
