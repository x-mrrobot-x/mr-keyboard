.class public final Lcom/mrkeyboard/app/ListDividerFix;
.super Ljava/lang/Object;
.source "ListDividerFix.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

# Remove os divisores entre os cartões de uma tela de preferências.
.method public static apply(Landroid/preference/PreferenceActivity;)V
    .locals 2

    invoke-virtual {p0}, Landroid/preference/PreferenceActivity;->getListView()Landroid/widget/ListView;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setDivider(Landroid/graphics/drawable/Drawable;)V

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setDividerHeight(I)V

    :cond_0
    # Telas de configuracoes sem ActionBar do framework: instala o cabecalho no proprio layout.
    invoke-static {p0}, Lcom/mrkeyboard/app/SettingsHeader;->install(Landroid/app/Activity;)V

    return-void
.end method
