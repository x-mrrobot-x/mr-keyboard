.class public final Lcom/mrkeyboard/app/MrAnim;
.super Ljava/lang/Object;
.source "MrAnim.java"

# The animations of the toolbar row (bar_main). Only fades and a vertical scale (ViewPropertyAnimator): the height of the keyboard
# window never animates, because the app behind it would be resized on every frame.
#
#   swap(in, out)  the row changes from one group to the other (tools <-> suggestions, MrSugg.applyInner): crossfade of
#                  bar_tools and bar_sugg, which overlay each other in bar_main (a FrameLayout). With the row off screen,
#                  or with a group missing, they change at once.
#   show(row)      bar_main comes back (grid key, a tool closed): the SAME entrance as the card of the emoji search (MrEmojiSearch.enter):
#                  it grows upward from its bottom edge (scaleY 0.6 -> 1, pivot at the bottom) while it fades in, 240 ms. A fade-out
#                  in progress turns back.
#   hide(row)      bar_main goes away (grid key, row off): the same movement backwards (shrinks towards its bottom edge while it fades
#                  out, 140 ms), and only at the end it leaves the layout (GONE), so the keyboard does not jump up before the row has gone.
#   gone(row)      bar_main goes away at once, no fade. When a tool owns the row (MrTools.rowOwned) its header takes the place in
#                  the same frame, so the row cannot linger on screen above it.
#
# RULES: an animation that is cancelled never runs its end action (ViewPropertyAnimator), so every change of state starts by
# stopping the one in progress (stop) and ends with alpha 1 and scale 1 (rest) on the views that stay. The end action is this
# class itself (Runnable): the view leaves the layout (GONE) and gets alpha 1 and scale 1 back for the next time. sTo and
# sHiding are views, not flags, so views of a keyboard that was built again never take a state of the old ones. They are cleared in
# reset() (MrSugg.release). The animator scale of the system (developer options, battery saver) is respected by the animator
# itself: at 0 everything ends at once, the end action included, which is why the state is written before it is started.
.implements Ljava/lang/Runnable;

# static fields
# The group (bar_tools or bar_sugg) the row is showing or fading to: the last swap.
.field static sTo:Landroid/view/View;

# The row (bar_main) while it fades out towards GONE.
.field static sHiding:Landroid/view/View;

# instance fields
# The view that leaves the layout when the fade-out ends.
.field private final mView:Landroid/view/View;

# direct methods
.method private constructor <init>(Landroid/view/View;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/mrkeyboard/app/MrAnim;->mView:Landroid/view/View;

    return-void
.end method

# Alpha 1 and scale 1: how a view stays after an animation and how it starts the next one.
.method private static rest(Landroid/view/View;)V
    .locals 1

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-virtual {p0, v0}, Landroid/view/View;->setAlpha(F)V

    invoke-virtual {p0, v0}, Landroid/view/View;->setScaleY(F)V

    return-void
.end method

# Stops the animation in progress of the view, if any. Its end action does not run.
.method private static stop(Landroid/view/View;)V
    .locals 1

    invoke-virtual {p0}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewPropertyAnimator;->cancel()V

    return-void
.end method

# The row grows from, and shrinks to, its bottom edge (as the card of the emoji search): the pivot is its height in pixels, from its layout
# params (it can be gone, with no size of its own yet), or what it measures when the params give no number.
.method private static pivot(Landroid/view/View;)V
    .locals 2

    invoke-virtual {p0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_measured

    iget v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    :cond_measured
    if-gtz v1, :cond_set

    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    move-result v1

    :cond_set
    int-to-float v0, v1

    invoke-virtual {p0, v0}, Landroid/view/View;->setPivotY(F)V

    return-void
.end method

# Animates the view to alpha and scaleY in ms. end (can be null) runs when it ends, not when it is cancelled.
.method private static to(Landroid/view/View;FFLjava/lang/Runnable;I)V
    .locals 3

    invoke-virtual {p0}, Landroid/view/View;->animate()Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/view/ViewPropertyAnimator;->alpha(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    invoke-virtual {v0, p2}, Landroid/view/ViewPropertyAnimator;->scaleY(F)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    int-to-long v1, p4

    invoke-virtual {v0, v1, v2}, Landroid/view/ViewPropertyAnimator;->setDuration(J)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    if-eqz p3, :cond_start

    invoke-virtual {v0, p3}, Landroid/view/ViewPropertyAnimator;->withEndAction(Ljava/lang/Runnable;)Landroid/view/ViewPropertyAnimator;

    move-result-object v0

    :cond_start
    invoke-virtual {v0}, Landroid/view/ViewPropertyAnimator;->start()V

    return-void
.end method

# The end of a fade-out: the view leaves the layout and is ready for the next time.
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrAnim;->mView:Landroid/view/View;

    sget-object v1, Lcom/mrkeyboard/app/MrAnim;->sHiding:Landroid/view/View;

    if-ne v1, v0, :cond_gone

    const/4 v1, 0x0

    sput-object v1, Lcom/mrkeyboard/app/MrAnim;->sHiding:Landroid/view/View;

    :cond_gone
    invoke-static {v0}, Lcom/mrkeyboard/app/MrAnim;->rest(Landroid/view/View;)V

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

# MrSugg.release (keyboard destroyed): lets go of the views.
.method static reset()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAnim;->sTo:Landroid/view/View;

    sput-object v0, Lcom/mrkeyboard/app/MrAnim;->sHiding:Landroid/view/View;

    return-void
.end method

# Shows the row. Gone: grows upward from its bottom edge while it fades in (240 ms, as the card of the emoji search). Fading out: turns back (120 ms).
# Visible: nothing.
.method static show(Landroid/view/View;)V
    .locals 4

    const/4 v3, 0x0

    invoke-virtual {p0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_shown

    sput-object v3, Lcom/mrkeyboard/app/MrAnim;->sHiding:Landroid/view/View;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrAnim;->stop(Landroid/view/View;)V

    invoke-static {p0}, Lcom/mrkeyboard/app/MrAnim;->pivot(Landroid/view/View;)V

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroid/view/View;->setAlpha(F)V

    const v1, 0x3f19999a    # 0.6f, the same as MrEmojiSearch.ENTER_FROM

    invoke-virtual {p0, v1}, Landroid/view/View;->setScaleY(F)V

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroid/view/View;->setVisibility(I)V

    const/high16 v0, 0x3f800000    # 1.0f

    const/16 v2, 0xf0

    invoke-static {p0, v0, v0, v3, v2}, Lcom/mrkeyboard/app/MrAnim;->to(Landroid/view/View;FFLjava/lang/Runnable;I)V

    return-void

    :cond_shown
    sget-object v0, Lcom/mrkeyboard/app/MrAnim;->sHiding:Landroid/view/View;

    if-ne v0, p0, :cond_done

    sput-object v3, Lcom/mrkeyboard/app/MrAnim;->sHiding:Landroid/view/View;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrAnim;->stop(Landroid/view/View;)V

    const/high16 v0, 0x3f800000    # 1.0f

    const/16 v2, 0x78

    invoke-static {p0, v0, v0, v3, v2}, Lcom/mrkeyboard/app/MrAnim;->to(Landroid/view/View;FFLjava/lang/Runnable;I)V

    :cond_done
    return-void
.end method

# Hides the row: the entrance backwards (shrinks towards its bottom edge while it fades out, 140 ms); it leaves the layout (GONE) at the end.
# Gone, or already fading: nothing.
.method static hide(Landroid/view/View;)V
    .locals 4

    invoke-virtual {p0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_done

    sget-object v0, Lcom/mrkeyboard/app/MrAnim;->sHiding:Landroid/view/View;

    if-eq v0, p0, :cond_done

    sput-object p0, Lcom/mrkeyboard/app/MrAnim;->sHiding:Landroid/view/View;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrAnim;->stop(Landroid/view/View;)V

    invoke-static {p0}, Lcom/mrkeyboard/app/MrAnim;->pivot(Landroid/view/View;)V

    new-instance v3, Lcom/mrkeyboard/app/MrAnim;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/MrAnim;-><init>(Landroid/view/View;)V

    const/4 v0, 0x0

    const v1, 0x3f19999a    # 0.6f

    const/16 v2, 0x8c

    invoke-static {p0, v0, v1, v3, v2}, Lcom/mrkeyboard/app/MrAnim;->to(Landroid/view/View;FFLjava/lang/Runnable;I)V

    :cond_done
    return-void
.end method

# Takes the row out of the layout at once (a tool owns it).
.method static gone(Landroid/view/View;)V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lcom/mrkeyboard/app/MrAnim;->sHiding:Landroid/view/View;

    invoke-static {p0}, Lcom/mrkeyboard/app/MrAnim;->stop(Landroid/view/View;)V

    invoke-static {p0}, Lcom/mrkeyboard/app/MrAnim;->rest(Landroid/view/View;)V

    const/16 v0, 0x8

    invoke-virtual {p0, v0}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

# The row changes group: in is shown and out is hidden (150 ms crossfade when the row is on screen, at once otherwise).
# The same in as the last call: nothing (it is there, or on its way). A group that is missing: the other one changes at once.
.method static swap(Landroid/view/View;Landroid/view/View;)V
    .locals 5

    sget-object v0, Lcom/mrkeyboard/app/MrAnim;->sTo:Landroid/view/View;

    if-ne v0, p0, :cond_go

    if-eqz p0, :cond_go

    return-void

    :cond_go
    sput-object p0, Lcom/mrkeyboard/app/MrAnim;->sTo:Landroid/view/View;

    if-eqz p0, :cond_snap

    if-eqz p1, :cond_snap

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sBarMain:Landroid/view/View;

    if-eqz v0, :cond_snap

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_snap

    invoke-virtual {p0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_fade

    invoke-virtual {p1}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_snap

    :cond_fade
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAnim;->stop(Landroid/view/View;)V

    invoke-static {p1}, Lcom/mrkeyboard/app/MrAnim;->stop(Landroid/view/View;)V

    invoke-virtual {p0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_up

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroid/view/View;->setAlpha(F)V

    invoke-virtual {p0, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_up
    const/high16 v0, 0x3f800000    # 1.0f

    const/high16 v1, 0x3f800000    # 1.0f: the groups only fade, they keep their size

    const/4 v3, 0x0

    const/16 v2, 0x96

    invoke-static {p0, v0, v1, v3, v2}, Lcom/mrkeyboard/app/MrAnim;->to(Landroid/view/View;FFLjava/lang/Runnable;I)V

    invoke-virtual {p1}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_end

    new-instance v4, Lcom/mrkeyboard/app/MrAnim;

    invoke-direct {v4, p1}, Lcom/mrkeyboard/app/MrAnim;-><init>(Landroid/view/View;)V

    const/4 v0, 0x0

    invoke-static {p1, v0, v1, v4, v2}, Lcom/mrkeyboard/app/MrAnim;->to(Landroid/view/View;FFLjava/lang/Runnable;I)V

    return-void

    :cond_snap
    if-eqz p0, :cond_snap_out

    invoke-static {p0}, Lcom/mrkeyboard/app/MrAnim;->stop(Landroid/view/View;)V

    invoke-static {p0}, Lcom/mrkeyboard/app/MrAnim;->rest(Landroid/view/View;)V

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_snap_out
    if-eqz p1, :cond_end

    invoke-static {p1}, Lcom/mrkeyboard/app/MrAnim;->stop(Landroid/view/View;)V

    invoke-static {p1}, Lcom/mrkeyboard/app/MrAnim;->rest(Landroid/view/View;)V

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_end
    return-void
.end method
