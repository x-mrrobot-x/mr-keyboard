.class public final Lcom/mrkeyboard/app/MrSugg;
.super Ljava/lang/Object;
.source "MrSugg.java"

# Word suggestions in the toolbar row (bar_main).
#
# The suggestions strip (candidates.xml container with the CandidateView) lives in "sg_host",
# inside bar_main, and not in the InputMethodService candidates area. bar_main has two
# groups that alternate in the same 48dp row: bar_tools (tools) and bar_sugg.
# They overlay each other (bar_main is a FrameLayout) and change with a crossfade (MrAnim.swap, from applyInner), only with the row on screen.
#
# RULE of the row: while a tool uses it (a header beside bar_main is visible, MrTools.rowOwned: clipboard, translator, attachments,
# emojis, Customize, Fonts, emoji search...), bar_main is hidden whatever the suggestions do, and LatinIME stops the suggestions flow
# (LatinIME.suggestionsSuspended). The strip never sits above a tool's header.
#
# The grid key (MrTools.toggleBar): with a tool open it closes it, as the tool's back button does, and the tools take the row;
# with the strip in view the tools take the row (toTools); only with the tools in view it shows/hides the whole row
# (MrTools.sBarOn); shown again it has the tools in it (toTools), not the strip. While the row is hidden LatinIME searches no
# suggestions (suggestionsSuspended). What goes in the row, tools or suggestions, is decided here, by what the user is doing.
#
# Row visible (no tool header open):
#   there are suggestions and the tools were not handed back (sIdle false) -> suggestions
#   otherwise                                                              -> tools
#
# Typing brings the strip back: a list of the word being typed (LatinIME.setSuggestions: mPredicting, a re-correction or
# the preview of a gesture) clears sIdle and shows the strip at once, but only when the row is visible and no tool owns it
# (MrTools.applyMain), so it never takes the place of a tool in use (translator, clipboard...).
#
# Debounce (setting "pref_sugg_idle", seconds, 0 = off, 2 by default): when the word ends (space, a suggestion picked: the list
# of the next word arrives) and the strip is on screen, the countdown starts. Each new end of word restarts it. When it runs
# out the tools take the row again (sIdle) and stay until the user types. The countdown never runs under a tool or with the row
# hidden, and typing before it ends cancels it. A strip that comes into view with no new list (created after the list)
# starts it through rearm(), unless its list is of a word being typed (sTyping). The next-word lists
# (LatinIME.setNextSuggestions) are never typing, whatever TextEntryState still says of an old correction (LatinIME.mMrNext).
#
# Delay (hold): when the suggestions end with nothing to show (the list is empty) the strip stays visible for
# HOLD_MS (1 s) before giving way to the tools. If new suggestions arrive in that interval, the wait is cancelled and the
# row does not toggle. Each new empty list during the wait restarts the clock.
# Strip colors follow the theme (CandidateView.mrTheme with MrTools.sTextColor).

# static fields
.field static sContainer:Landroid/view/View;

.field static sHandler:Landroid/os/Handler;

.field static sExpire:Ljava/lang/Runnable;

.field static sHost:Landroid/view/ViewGroup;

.field static sTools:Landroid/view/View;

.field static sSugg:Landroid/view/View;

# There are suggestions to show (a real list, not an empty one).
.field static sHas:Z

# The tools took the row back after the debounce and stay until the user types.
.field static sIdle:Z

# The last list with suggestions belonged to a word being typed, corrected or swiped (no debounce runs for it).
.field static sTyping:Z

# Pending timer: 0 = none, 1 = hold (no suggestions, strip still shown), 2 = debounce (waiting to give the row to the tools).
.field static sWait:I

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
    .locals 1

    sput-object p0, Lcom/mrkeyboard/app/MrSugg;->sContainer:Landroid/view/View;

    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sIdle:Z

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->attach()V

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    # a list that arrived before the strip existed had no strip in view to start the debounce for
    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->rearm()V

    return-void
.end method

# LatinIME.removeCandidateViewContainer: suggestions off for the field.
.method public static unhost()V
    .locals 1

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->cancel()V

    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrSugg;->sContainer:Landroid/view/View;

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sIdle:Z

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sTyping:Z

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    return-void
.end method

# LatinIME.setSuggestions / "tap to save" hint: there are (or not) suggestions to show. typing: the list belongs to a word being
# typed, corrected or swiped (not to the next word or a hint).
#   with suggestions, typing:  cancels any wait, hands the row back to the strip at once;
#   with suggestions, between words: shows the strip (unless the tools took the row back) and (re)starts the debounce;
#   without suggestions: if the strip was being shown, it is kept for HOLD_MS before giving way to the tools.
.method public static onList(ZZ)V
    .locals 4

    if-eqz p0, :cond_none

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->cancel()V

    sget-boolean v2, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    sget-boolean v3, Lcom/mrkeyboard/app/MrSugg;->sIdle:Z

    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    sput-boolean p1, Lcom/mrkeyboard/app/MrSugg;->sTyping:Z

    if-eqz p1, :cond_between

    const/4 v0, 0x0

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sIdle:Z

    if-eqz v2, :cond_apply

    if-eqz v3, :cond_end

    :cond_apply
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    goto :cond_end

    :cond_between
    if-nez v3, :cond_end

    if-nez v2, :cond_arm

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    :cond_arm
    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->arm()V

    goto :cond_end

    :cond_none
    sget v0, Lcom/mrkeyboard/app/MrSugg;->sWait:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_nohold

    const-wide/16 v2, 0x3e8

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/MrSugg;->schedule(IJ)V

    goto :cond_end

    :cond_nohold
    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    if-eqz v0, :cond_end

    sget-boolean v0, Lcom/mrkeyboard/app/MrTools;->sBarOn:Z

    invoke-static {v0}, Lcom/mrkeyboard/app/MrSugg;->mode(Z)I

    move-result v0

    const/4 v1, 0x0

    sput-boolean v1, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->cancel()V

    const/4 v1, 0x2

    if-ne v0, v1, :cond_tools

    const/4 v0, 0x1

    const-wide/16 v2, 0x3e8

    invoke-static {v0, v2, v3}, Lcom/mrkeyboard/app/MrSugg;->schedule(IJ)V

    goto :cond_end

    :cond_tools
    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    :cond_end
    return-void
.end method

# The strip has just come into view without a list arriving (the strip was created after the list; the grid key does not come here: the
# row shown again has the tools in it): the debounce starts now if the list in view is between words and the tools did not take the row. A list of a word being typed
# or corrected keeps the strip, as before. Safe to call at any time: nothing happens when the strip is not on screen.
.method public static rearm()V
    .locals 1

    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    if-eqz v0, :cond_end

    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sTyping:Z

    if-nez v0, :cond_end

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->arm()V

    :cond_end
    return-void
.end method

# The grid key with the strip in view, or a tool just closed by it: the tools take the row and stay until the next typing (as when the
# debounce ends). Cancels any wait.
.method static toTools()V
    .locals 1

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->cancel()V

    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sIdle:Z

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    return-void
.end method

# Starts (or restarts) the debounce of the end of the word, if the strip is on screen and the setting is not "off".
.method private static arm()V
    .locals 4

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->stripShown()Z

    move-result v0

    if-eqz v0, :cond_end

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->idleMs()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v2, v0, v2

    if-lez v2, :cond_end

    const/4 v2, 0x2

    invoke-static {v2, v0, v1}, Lcom/mrkeyboard/app/MrSugg;->schedule(IJ)V

    :cond_end
    return-void
.end method

# The debounce, in ms, from the setting "pref_sugg_idle" (seconds; a list of numbers; 0 = off). 2 s when it cannot be read.
.method private static idleMs()J
    .locals 4

    const/4 v1, 0x2

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBarMain:Landroid/view/View;

    if-eqz v0, :cond_calc

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v2, "pref_sugg_idle"

    const-string v3, "2"

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :try_start_0
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_calc
    if-gez v1, :cond_pos

    const/4 v1, 0x0

    :cond_pos
    int-to-long v0, v1

    const-wide/16 v2, 0x3e8

    mul-long/2addr v0, v2

    return-wide v0
.end method

# Is the strip on screen? Row visible (bar key), no tool owning it and the suggestions (not the tools) in it.
.method static stripShown()Z
    .locals 2

    sget-boolean v0, Lcom/mrkeyboard/app/MrTools;->sBarOn:Z

    if-eqz v0, :cond_no

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->rowOwned()Z

    move-result v1

    if-nez v1, :cond_no

    invoke-static {v0}, Lcom/mrkeyboard/app/MrSugg;->mode(Z)I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_no

    const/4 v0, 0x1

    return v0

    :cond_no
    const/4 v0, 0x0

    return v0
.end method

# Schedules (or reschedules) the end of the pending wait: kind 1 = hold, 2 = debounce; delay in ms from now.
.method private static schedule(IJ)V
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

    sput p0, Lcom/mrkeyboard/app/MrSugg;->sWait:I

    invoke-virtual {v0, v1, p1, p2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

# Ends the pending wait without changing the row.
.method private static cancel()V
    .locals 2

    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/MrSugg;->sWait:I

    sget-object v0, Lcom/mrkeyboard/app/MrSugg;->sHandler:Landroid/os/Handler;

    if-eqz v0, :cond_end

    sget-object v1, Lcom/mrkeyboard/app/MrSugg;->sExpire:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    :cond_end
    return-void
.end method

# End of the wait (MrSugg$Expire.run, on the main thread).
#   hold:     the strip had nothing to show: the tools come back;
#   debounce: the user stopped typing: the tools take the row, if the strip is still on screen (under a tool or with the row hidden
#             nothing changes).
.method public static expire()V
    .locals 2

    sget v0, Lcom/mrkeyboard/app/MrSugg;->sWait:I

    const/4 v1, 0x0

    sput v1, Lcom/mrkeyboard/app/MrSugg;->sWait:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_idle

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    return-void

    :cond_idle
    const/4 v1, 0x2

    if-ne v0, v1, :cond_end

    invoke-static {}, Lcom/mrkeyboard/app/MrSugg;->stripShown()Z

    move-result v0

    if-eqz v0, :cond_end

    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sIdle:Z

    invoke-static {}, Lcom/mrkeyboard/app/MrTools;->applyMain()V

    :cond_end
    return-void
.end method

# Suggestions to show: real ones (sHas) or still held by the wait (hold).
.method private static available()Z
    .locals 2

    sget-object v0, Lcom/mrkeyboard/app/MrSugg;->sContainer:Landroid/view/View;

    if-eqz v0, :cond_no

    sget-object v0, Lcom/mrkeyboard/app/MrSugg;->sHost:Landroid/view/ViewGroup;

    if-eqz v0, :cond_no

    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sHas:Z

    if-nez v0, :cond_yes

    sget v0, Lcom/mrkeyboard/app/MrSugg;->sWait:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_no

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

    sget-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sIdle:Z

    if-nez v0, :cond_tools

    const/4 v0, 0x2

    return v0

    :cond_tools
    const/4 v0, 0x1

    return v0
.end method

# Applies the mode to the internal groups of bar_main (the visibility of bar_main belongs to MrTools). MrAnim.swap does it: the two
# groups overlay each other and change with a crossfade when the row is on screen, at once when it is not.
.method static applyInner(IZ)V
    .locals 3

    sget-object v0, Lcom/mrkeyboard/app/MrSugg;->sTools:Landroid/view/View;

    sget-object v1, Lcom/mrkeyboard/app/MrSugg;->sSugg:Landroid/view/View;

    const/4 v2, 0x2

    if-ne p0, v2, :cond_tools

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrAnim;->swap(Landroid/view/View;Landroid/view/View;)V

    return-void

    :cond_tools
    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrAnim;->swap(Landroid/view/View;Landroid/view/View;)V

    return-void
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

    sput-boolean v0, Lcom/mrkeyboard/app/MrSugg;->sIdle:Z

    invoke-static {}, Lcom/mrkeyboard/app/MrAnim;->reset()V

    return-void
.end method
