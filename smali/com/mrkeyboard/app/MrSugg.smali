.class public final Lcom/mrkeyboard/app/MrSugg;
.super Ljava/lang/Object;
.source "MrSugg.java"

# Word suggestions in the toolbar row (bar_main).
#
# The suggestions strip (candidates.xml container with the CandidateView) lives in "sg_host",
# inside bar_main, and not in the InputMethodService candidates area. bar_main has two
# groups that alternate in the same 48dp row: bar_tools (tools) and bar_sugg.
#
# The row keeps obeying the bar key (MrTools.sBarOn): hidden, it shows nothing.
# Visible (no panel open):
#   there are suggestions and the user did not ask for the tools on this word -> suggestions
#   otherwise                                                              -> tools
# Bar key (MrTools.toggleBar -> onBarKey):
#   row visible and there are suggestions -> toggles suggestions <-> tools (holds until the word ends)
#   otherwise                             -> shows/hides the row, as before
# Strip colors follow the theme (CandidateView.mrTheme with MrTools.sTextColor).
#
# Delay (debounce): when the suggestions end (end of word, space), the strip stays
# visible for DELAY (1 s) before giving way to the tools. If new suggestions arrive in that
# interval (user typing the next word), the wait is cancelled and the row does not toggle.
# Each new list without suggestions during the wait restarts the clock. The bar key ends the
# wait and shows the tools at once. Switching from tools to suggestions is immediate.

# static fields
.field static sContainer:Landroid/view/View;

# Pending wait: no suggestions, but the strip is still shown.
.field static sHold:Z

.field static sHandler:Landroid/os/Handler;

.field static sExpire:Ljava/lang/Runnable;

.field static sHost:Landroid/view/ViewGroup;

.field static sTools:Landroid/view/View;

.field static sSugg:Landroid/view/View;

.field static sHas:Z

.field static sPinned:Z

# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

# Called by MrTools.wrap at every new bar root.
.method static setup(Landroid/view/View;)V
    .locals 2

    const-string v0, "bar_tools"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sTools:Landroid/view/View;

    const-string v0, "bar_sugg"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sSugg:Landroid/view/View;

    const-string v0, "sg_host"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrTools;->tag(Landroid/view/View;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    instance-of v1, v0, Landroid/view/ViewGroup;

    if-nez v1, :cond_host

    const/4 v0, 0x0

    :cond_host
    check-cast v0, Landroid/view/ViewGroup;

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sHost:Landroid/view/ViewGroup;

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->attach()V

    return-void
.end method

# Applies the text color of the current theme keys to the CandidateView of the strip.
.method private static theme()V
    .locals 2

    sget-object v0, Lcom/mrkeyboard/app/MrSugg;->sContainer:Landroid/view/View;

    if-eqz v0, :cond_end

    const v1, 0x7f080028

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    instance-of v1, v0, Lcom/mrkeyboard/app/CandidateView;

    if-eqz v1, :cond_end

    check-cast v0, Lcom/mrkeyboard/app/CandidateView;

    sget v1, Lcom/mrkeyboard/app/MrTools;->sTextColor:I

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/CandidateView;->mrTheme(I)V

    :cond_end
    return-void
.end method

# Moves the suggestions strip to the current host (the bar root is recreated at every setInputView)
# and applies the theme colors.
.method private static attach()V
    .locals 4

    sget-object v0, Lcom/mrkeyboard/app/MrSugg;->sContainer:Landroid/view/View;

    sget-object v1, Lcom/mrkeyboard/app/MrSugg;->sHost:Landroid/view/ViewGroup;

    if-eqz v0, :cond_end

    if-eqz v1, :cond_end

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->theme()V

    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    if-eq v2, v1, :cond_end

    instance-of v3, v2, Landroid/view/ViewGroup;

    if-eqz v3, :cond_add

    check-cast v2, Landroid/view/ViewGroup;

    invoke-virtual {v2, v0}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    :cond_add
    # transparent background: the strip uses the bar's own background
    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    new-instance v2, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v3, -0x1

    invoke-direct {v2, v3, v3}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v0, v2}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    :cond_end
    return-void
.end method

# LatinIME.onCreateCandidatesView: the strip was created (suggestions on for the field).
.method public static host(Landroid/view/View;)V
    .locals 0

    sput-object p0, Lcom/mrkeyboard/app/MrSugg;->sContainer:Landroid/view/View;

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->attach()V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    return-void
.end method

# LatinIME.removeCandidateViewContainer: suggestions off for the field.
.method public static unhost()V
    .locals 1

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->cancel()V

    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sContainer:Landroid/view/View;

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sPinned:Z

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    return-void
.end method

# LatinIME.setSuggestions / "tap to save" hint: there are (or not) suggestions to show.
# With suggestions: cancels the wait and shows the strip at once.
# Without suggestions: the manual tools choice is undone (holds only for the current word). If the
# strip was being shown, it is kept for DELAY before giving way to the tools.
.method public static onList(Z)V
    .locals 2

    if-eqz p0, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->cancel()V

    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    if-nez v0, :cond_3

    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    goto :goto_0

    :cond_0
    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHold:Z

    if-eqz v0, :cond_1

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->schedule()V

    goto :goto_0

    :cond_1
    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    if-eqz v0, :cond_3

    sget-boolean v0, Lcom/mrkeyboard/app/MrTools;->sBarOn:Z

    invoke-static {v0}, Lcom/mrkeyboard/app/MrSugg;->mode(Z)I

    move-result v0

    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    sput-boolean v1, Lcom/mrkeyboard/app/MrSugg;->sPinned:Z

    const/4 v1, 0x2

    if-ne v0, v1, :cond_2

    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHold:Z

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->schedule()V

    goto :goto_0

    :cond_2
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    :cond_3
    :goto_0
    return-void
.end method

# Schedules (or reschedules) the end of the wait for DELAY (1000 ms) from now.
.method private static schedule()V
    .locals 4

    sget-object v0, Lcom/mrkeyboard/app/MrSugg;->sHandler:Landroid/os/Handler;

    if-nez v0, :cond_ready

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sHandler:Landroid/os/Handler;

    new-instance v1, Lcom/mrkeyboard/app/MrSugg$Expire;

    invoke-direct {v1}, Lcom/mrkeyboard/app/MrSugg$Expire;-><init>()V

    sput-object v1, Lcom/mrkeyboard/app/MrSugg;->sExpire:Ljava/lang/Runnable;

    :cond_ready
    sget-object v1, Lcom/mrkeyboard/app/MrSugg;->sExpire:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    const-wide/16 v2, 0x3e8

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

# Ends the wait without changing the row.
.method private static cancel()V
    .locals 2

    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHold:Z

    sget-object v0, Lcom/mrkeyboard/app/MrSugg;->sHandler:Landroid/os/Handler;

    if-eqz v0, :cond_end

    sget-object v1, Lcom/mrkeyboard/app/MrSugg;->sExpire:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    :cond_end
    return-void
.end method

# End of the wait (MrSugg$Expire.run, on the main thread): shows the tools.
.method public static expire()V
    .locals 1

    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHold:Z

    if-eqz v0, :cond_end

    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHold:Z

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    :cond_end
    return-void
.end method

# Suggestions to show: real ones (sHas) or still held by the wait (sHold).
.method private static available()Z
    .locals 1

    sget-object v0, Lcom/mrkeyboard/app/MrSugg;->sContainer:Landroid/view/View;

    if-eqz v0, :cond_no

    sget-object v0, Lcom/mrkeyboard/app/MrSugg;->sHost:Landroid/view/ViewGroup;

    if-eqz v0, :cond_no

    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    if-nez v0, :cond_yes

    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHold:Z

    return v0

    :cond_yes
    const/4 v0, 0x1

    return v0

    :cond_no
    const/4 v0, 0x0

    return v0
.end method

# 0 = row hidden, 1 = tools, 2 = suggestions (MrTools.applyMain, no panel open).
.method static mode(Z)I
    .locals 1

    if-nez p0, :cond_on

    const/4 v0, 0x0

    return v0

    :cond_on
    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->available()Z

    move-result v0

    if-eqz v0, :cond_tools

    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sPinned:Z

    if-nez v0, :cond_tools

    const/4 v0, 0x2

    return v0

    :cond_tools
    const/4 v0, 0x1

    return v0
.end method

# Applies the mode to the internal groups of bar_main (the visibility of bar_main belongs to MrTools).
.method static applyInner(IZ)V
    .locals 4

    const/16 v0, 0x8

    const/4 v1, 0x0

    const/4 v2, 0x2

    sget-object v3, Lcom/mrkeyboard/app/MrSugg;->sTools:Landroid/view/View;

    if-eqz v3, :cond_1

    if-ne p0, v2, :cond_0

    invoke-virtual {v3, v0}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_0
    invoke-virtual {v3, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_1
    :goto_0
    sget-object v3, Lcom/mrkeyboard/app/MrSugg;->sSugg:Landroid/view/View;

    if-eqz v3, :cond_3

    if-ne p0, v2, :cond_2

    invoke-virtual {v3, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_1

    :cond_2
    invoke-virtual {v3, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_3
    :goto_1
    return-void
.end method

# Bar key (MrTools.toggleBar). With the row visible and suggestions available, toggles
# suggestions <-> tools and returns true. Otherwise returns false and toggleBar
# shows/hides the row as before.
.method static onBarKey()Z
    .locals 2

    sget-boolean v0, Lcom/mrkeyboard/app/MrTools;->sBarOn:Z

    if-eqz v0, :cond_no

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBarMain:Landroid/view/View;

    if-eqz v0, :cond_no

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_no

    # key during the wait: shows the tools now
    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHold:Z

    if-eqz v0, :cond_chk

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->cancel()V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    const/4 v0, 0x1

    return v0

    :cond_chk
    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->available()Z

    move-result v0

    if-eqz v0, :cond_no

    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sPinned:Z

    xor-int/lit8 v0, v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sPinned:Z

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    const/4 v0, 0x1

    return v0

    :cond_no
    const/4 v0, 0x0

    return v0
.end method

# MrTools.release (keyboard destroyed).
.method static release()V
    .locals 1

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->cancel()V

    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sContainer:Landroid/view/View;

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sHost:Landroid/view/ViewGroup;

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sTools:Landroid/view/View;

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sSugg:Landroid/view/View;

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sPinned:Z

    return-void
.end method
