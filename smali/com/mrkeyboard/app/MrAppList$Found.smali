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

.field final stamp:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;Landroid/content/pm/ResolveInfo;)V
    .locals 0

    .prologue
    .line 67
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 68
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAppList$Found;->pkg:Ljava/lang/String;

    .line 69
    iput-object p2, p0, Lcom/mrkeyboard/app/MrAppList$Found;->stamp:Ljava/lang/String;

    .line 70
    iput-object p3, p0, Lcom/mrkeyboard/app/MrAppList$Found;->info:Landroid/content/pm/ResolveInfo;

    .line 71
    return-void
.end method
