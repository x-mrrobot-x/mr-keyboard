.class public final Lcom/mrkeyboard/app/MrAuthor;
.super Ljava/lang/Object;
.source "MrAuthor.java"

# interfaces
.implements Landroid/preference/Preference$OnPreferenceClickListener;


# static fields
.field static final URL:Ljava/lang/String; = "https://github.com/x-mrrobot-x"


# instance fields
.field private final mContext:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    .prologue
    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    iput-object p1, p0, Lcom/mrkeyboard/app/MrAuthor;->mContext:Landroid/content/Context;

    .line 17
    return-void
.end method

.method static open(Landroid/content/Context;)Z
    .locals 1

    .prologue
    .line 26
    const-string v0, "https://github.com/x-mrrobot-x"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrLink;->open(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    return v0
.end method


# virtual methods
.method public onPreferenceClick(Landroid/preference/Preference;)Z
    .locals 1

    .prologue
    .line 20
    iget-object v0, p0, Lcom/mrkeyboard/app/MrAuthor;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAuthor;->open(Landroid/content/Context;)Z

    .line 21
    const/4 v0, 0x1

    return v0
.end method
