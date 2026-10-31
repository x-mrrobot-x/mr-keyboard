.class Lcom/mrkeyboard/app/InputLanguageSelection$1;
.super Ljava/lang/Object;
.source "InputLanguageSelection.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/InputLanguageSelection;->askDictionary(Landroid/preference/Preference;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/InputLanguageSelection;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/InputLanguageSelection;)V
    .locals 0

    iput-object p1, p0, Lcom/mrkeyboard/app/InputLanguageSelection$1;->this$0:Lcom/mrkeyboard/app/InputLanguageSelection;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
# "Baixar dicionario": abre a tela Dicionarios.
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.mrkeyboard.app.PREFS_DICTS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/mrkeyboard/app/InputLanguageSelection$1;->this$0:Lcom/mrkeyboard/app/InputLanguageSelection;

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/InputLanguageSelection;->startActivity(Landroid/content/Intent;)V

    return-void
.end method
