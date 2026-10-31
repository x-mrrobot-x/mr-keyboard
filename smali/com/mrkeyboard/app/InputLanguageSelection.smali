.class public Lcom/mrkeyboard/app/InputLanguageSelection;
.super Landroid/preference/PreferenceActivity;
.source "InputLanguageSelection.java"

# Tela "Idiomas de entrada" do Mr Keyboard.
# So lista os idiomas que tem dicionario no catalogo (pt, en, es), mostra o estado do
# dicionario de cada um e leva a tela Dicionarios. A lista marcada fica em
# "selected_languages" (ex.: "pt,en,"), lida pelo LanguageSwitcher.


# static fields
.field private static final CODES:[Ljava/lang/String;

.field private static final NAMES:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    const/4 v0, 0x3

    new-array v1, v0, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v0, "pt"

    aput-object v0, v1, v2

    const/4 v2, 0x1

    const-string v0, "en"

    aput-object v0, v1, v2

    const/4 v2, 0x2

    const-string v0, "es"

    aput-object v0, v1, v2

    sput-object v1, Lcom/mrkeyboard/app/InputLanguageSelection;->CODES:[Ljava/lang/String;

    const/4 v0, 0x3

    new-array v1, v0, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v0, "Portugu\u00eas (Brasil)"

    aput-object v0, v1, v2

    const/4 v2, 0x1

    const-string v0, "English (US)"

    aput-object v0, v1, v2

    const/4 v2, 0x2

    const-string v0, "Espa\u00f1ol"

    aput-object v0, v1, v2

    sput-object v1, Lcom/mrkeyboard/app/InputLanguageSelection;->NAMES:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/preference/PreferenceActivity;-><init>()V

    return-void
.end method

.method private arrayContains([Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3

    const/4 v0, 0x0

    const/4 v1, 0x0

    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_1

    aget-object v2, p1, v1

    invoke-virtual {v2, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    return v0
.end method

# O dicionario do idioma esta instalado? Mesmo criterio do teclado e da tela Dicionarios
# (pacote baixado, casado pelo idioma).
.method private hasDictionary(Ljava/lang/String;)Z
    .locals 1

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/MrPacks;->installedFor(Landroid/content/Context;Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

# Texto de estado que aparece embaixo do nome do idioma.
.method private status(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/InputLanguageSelection;->hasDictionary(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "mr_lang_dict_on"

    goto :goto_0

    :cond_0
    const-string v0, "mr_lang_dict_off"

    :goto_0
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

# Aviso ao marcar um idioma sem dicionario, com botao que abre a tela Dicionarios.
.method private askDictionary(Landroid/preference/Preference;)V
    .locals 6

    invoke-virtual {p1}, Landroid/preference/Preference;->getTitle()Ljava/lang/CharSequence;

    move-result-object v0

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object v0, v1, v2

    const-string v0, "mr_lang_dict_ask"

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v3, Landroid/app/AlertDialog$Builder;

    invoke-direct {v3, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    invoke-virtual {v3, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    new-array v4, v2, [Ljava/lang/Object;

    const-string v0, "mr_dicts_offer"

    invoke-static {p0, v0, v4}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    new-instance v5, Lcom/mrkeyboard/app/InputLanguageSelection$1;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/InputLanguageSelection$1;-><init>(Lcom/mrkeyboard/app/InputLanguageSelection;)V

    invoke-virtual {v3, v0, v5}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    const-string v0, "mr_dicts_close"

    invoke-static {p0, v0, v4}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/4 v5, 0x0

    invoke-virtual {v3, v0, v5}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    invoke-virtual {v3}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 0

    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object p1

    invoke-super {p0, p1}, Landroid/preference/PreferenceActivity;->attachBaseContext(Landroid/content/Context;)V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 9

    invoke-super {p0, p1}, Landroid/preference/PreferenceActivity;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0c0108

    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/InputLanguageSelection;->setTitle(I)V

    const p1, 0x7f0f000e

    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/InputLanguageSelection;->addPreferencesFromResource(I)V

    invoke-static {p0}, Lcom/mrkeyboard/app/ListDividerFix;->apply(Landroid/preference/PreferenceActivity;)V

    invoke-virtual {p0}, Lcom/mrkeyboard/app/InputLanguageSelection;->getPreferenceScreen()Landroid/preference/PreferenceScreen;

    move-result-object v0

    # item "Dicionarios" no topo, ligado a tela de dicionarios
    new-instance v1, Landroid/preference/Preference;

    invoke-direct {v1, p0}, Landroid/preference/Preference;-><init>(Landroid/content/Context;)V

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    const-string v4, "mr_dicts_title"

    invoke-static {p0, v4, v3}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Landroid/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V

    const-string v4, "mr_lang_dict_link"

    invoke-static {p0, v4, v3}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    invoke-virtual {v1, v2}, Landroid/preference/Preference;->setPersistent(Z)V

    new-instance v4, Landroid/content/Intent;

    const-string v5, "com.mrkeyboard.app.PREFS_DICTS"

    invoke-direct {v4, v5}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v4}, Landroid/preference/Preference;->setIntent(Landroid/content/Intent;)V

    invoke-virtual {v0, v1}, Landroid/preference/PreferenceGroup;->addPreference(Landroid/preference/Preference;)Z

    # idiomas ja marcados
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    const-string v3, "selected_languages"

    const-string v4, ""

    invoke-interface {v1, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v3, ","

    invoke-virtual {v1, v3}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    # uma linha por idioma
    :goto_0
    sget-object v3, Lcom/mrkeyboard/app/InputLanguageSelection;->CODES:[Ljava/lang/String;

    array-length v4, v3

    if-ge v2, v4, :cond_0

    aget-object v4, v3, v2

    new-instance v5, Landroid/preference/CheckBoxPreference;

    invoke-direct {v5, p0}, Landroid/preference/CheckBoxPreference;-><init>(Landroid/content/Context;)V

    invoke-virtual {v5, v4}, Landroid/preference/CheckBoxPreference;->setKey(Ljava/lang/String;)V

    const/4 v6, 0x0

    invoke-virtual {v5, v6}, Landroid/preference/CheckBoxPreference;->setPersistent(Z)V

    sget-object v6, Lcom/mrkeyboard/app/InputLanguageSelection;->NAMES:[Ljava/lang/String;

    aget-object v6, v6, v2

    invoke-virtual {v5, v6}, Landroid/preference/CheckBoxPreference;->setTitle(Ljava/lang/CharSequence;)V

    invoke-direct {p0, v1, v4}, Lcom/mrkeyboard/app/InputLanguageSelection;->arrayContains([Ljava/lang/String;Ljava/lang/String;)Z

    move-result v6

    invoke-virtual {v5, v6}, Landroid/preference/CheckBoxPreference;->setChecked(Z)V

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/InputLanguageSelection;->status(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Landroid/preference/CheckBoxPreference;->setSummary(Ljava/lang/CharSequence;)V

    invoke-virtual {v0, v5}, Landroid/preference/PreferenceGroup;->addPreference(Landroid/preference/Preference;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onPreferenceTreeClick(Landroid/preference/PreferenceScreen;Landroid/preference/Preference;)Z
    .locals 2

    invoke-super {p0, p1, p2}, Landroid/preference/PreferenceActivity;->onPreferenceTreeClick(Landroid/preference/PreferenceScreen;Landroid/preference/Preference;)Z

    move-result v0

    instance-of v1, p2, Landroid/preference/CheckBoxPreference;

    if-eqz v1, :cond_0

    check-cast p2, Landroid/preference/CheckBoxPreference;

    invoke-virtual {p2}, Landroid/preference/CheckBoxPreference;->isChecked()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p2}, Landroid/preference/CheckBoxPreference;->getKey()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/InputLanguageSelection;->hasDictionary(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-direct {p0, p2}, Lcom/mrkeyboard/app/InputLanguageSelection;->askDictionary(Landroid/preference/Preference;)V

    :cond_0
    return v0
.end method

.method protected onPause()V
    .locals 6

    invoke-super {p0}, Landroid/preference/PreferenceActivity;->onPause()V

    const-string v0, ""

    invoke-virtual {p0}, Lcom/mrkeyboard/app/InputLanguageSelection;->getPreferenceScreen()Landroid/preference/PreferenceScreen;

    move-result-object v1

    invoke-virtual {v1}, Landroid/preference/PreferenceGroup;->getPreferenceCount()I

    move-result v2

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_2

    invoke-virtual {v1, v3}, Landroid/preference/PreferenceGroup;->getPreference(I)Landroid/preference/Preference;

    move-result-object v4

    instance-of v5, v4, Landroid/preference/CheckBoxPreference;

    if-eqz v5, :cond_1

    check-cast v4, Landroid/preference/CheckBoxPreference;

    invoke-virtual {v4}, Landroid/preference/CheckBoxPreference;->isChecked()Z

    move-result v5

    if-eqz v5, :cond_1

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Landroid/preference/CheckBoxPreference;->getKey()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, ","

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_2
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x1

    if-ge v1, v2, :cond_3

    const/4 v0, 0x0

    :cond_3
    invoke-static {p0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "selected_languages"

    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

# Ao voltar da tela Dicionarios, atualiza o estado de cada idioma.
.method protected onResume()V
    .locals 5

    invoke-super {p0}, Landroid/preference/PreferenceActivity;->onResume()V

    invoke-virtual {p0}, Lcom/mrkeyboard/app/InputLanguageSelection;->getPreferenceScreen()Landroid/preference/PreferenceScreen;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Landroid/preference/PreferenceGroup;->getPreferenceCount()I

    move-result v1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_2

    invoke-virtual {v0, v2}, Landroid/preference/PreferenceGroup;->getPreference(I)Landroid/preference/Preference;

    move-result-object v3

    instance-of v4, v3, Landroid/preference/CheckBoxPreference;

    if-eqz v4, :cond_1

    invoke-virtual {v3}, Landroid/preference/Preference;->getKey()Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_1

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/InputLanguageSelection;->status(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    return-void
.end method
