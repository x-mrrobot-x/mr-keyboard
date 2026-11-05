.class public Lcom/mrkeyboard/app/MrApplication;
.super Landroid/app/Application;
.source "MrApplication.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    return-void
.end method


# virtual methods
.method public onCreate()V
    .locals 0

    invoke-super {p0}, Landroid/app/Application;->onCreate()V

    # Insets of the screens (Android 15+, where the SDK check is): see MrScreens.
    invoke-static {p0}, Lcom/mrkeyboard/app/MrScreens;->install(Landroid/app/Application;)V

    return-void
.end method
