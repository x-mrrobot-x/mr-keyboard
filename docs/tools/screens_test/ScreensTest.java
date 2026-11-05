package com.mrkeyboard.app;

import android.app.Activity;
import android.app.Application;
import android.graphics.Insets;
import android.os.Build;
import android.view.View;
import android.view.WindowInsets;

/**
 * MrScreens (the insets of the screens on Android 15+): which Android registers it, what goes to the padding of the
 * content area, and above all what is left for the views below, which must not be able to reserve the bars again.
 */
public class ScreensTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }

    static final int BARS = WindowInsets.Type.systemBars() | WindowInsets.Type.displayCutout();

    /** A screen whose content area is the given view. */
    static class Screen extends Activity {
        final View content;
        Screen(View content) { this.content = content; }
        public View findViewById(int id) { return id == MrScreens.CONTENT ? content : null; }
    }

    static WindowInsets insets(int status, int nav, int cutoutLeft, int ime) {
        WindowInsets.Builder b = new WindowInsets.Builder();
        b.setInsets(WindowInsets.Type.statusBars(), Insets.of(0, status, 0, 0));
        b.setInsets(WindowInsets.Type.navigationBars(), Insets.of(0, 0, 0, nav));
        b.setInsets(WindowInsets.Type.tappableElement(), Insets.of(0, 0, 0, nav));
        b.setInsets(WindowInsets.Type.displayCutout(), Insets.of(cutoutLeft, 0, 0, 0));
        b.setInsets(WindowInsets.Type.ime(), Insets.of(0, 0, 0, ime));
        return b.build();
    }

    static int registered(int sdk) {
        Build.VERSION.SDK_INT = sdk;
        Application app = new Application();
        MrScreens.install(app);
        return app.registered.size();
    }

    /** The screen goes through onActivityStarted and receives the insets, as the system would deliver them. */
    static WindowInsets deliver(View content, WindowInsets in) {
        return content.stubInsetsListener().onApplyWindowInsets(content, in);
    }

    public static void main(String[] a) {
        int[] below = {26, 28, 29, 30, 33, 34};
        for (int sdk : below) check("Android SDK " + sdk + ": nothing is registered (the system fits the window)", registered(sdk) == 0);
        int[] from = {35, 36, 37};
        for (int sdk : from) check("Android SDK " + sdk + ": one callback registered", registered(sdk) == 1);
        Build.VERSION.SDK_INT = 36;
        boolean nullApp = true;
        try { MrScreens.install(null); } catch (RuntimeException e) { nullApp = false; }
        check("install(null) does not fail", nullApp);

        // ---- the screen starts: listener on the content area and new request of the insets
        View content = new View();
        MrScreens cb = new MrScreens();
        cb.onActivityStarted(new Screen(content));
        check("starting a screen puts the listener on the content area", content.stubInsetsListener() == cb);
        check("starting a screen asks for the insets", content.stubInsetsRequests() == 1);
        cb.onActivityStarted(new Screen(content));
        check("starting it again keeps one listener and asks again (returning from another screen)",
                content.stubInsetsListener() == cb && content.stubInsetsRequests() == 2);
        boolean noContent = true;
        try { cb.onActivityStarted(new Screen(null)); } catch (RuntimeException e) { noContent = false; }
        check("a screen with no content area does not break", noContent);

        // ---- portrait, gestures: status bar 80, navigation bar 48
        WindowInsets left = deliver(content, insets(80, 48, 0, 0));
        check("padding = status bar on top and navigation bar at the bottom",
                content.getPaddingLeft() == 0 && content.getPaddingTop() == 80 && content.getPaddingRight() == 0 && content.getPaddingBottom() == 48);
        check("what goes down: bars and cutout are zero (a view below cannot reserve them again)",
                left.getInsets(BARS) == Insets.NONE);
        check("what goes down: the status bar alone is zero too (the gap under the title)",
                left.getInsets(WindowInsets.Type.statusBars()) == Insets.NONE);
        check("what goes down: the tappable element (3 buttons) is zero too",
                left.getInsets(WindowInsets.Type.tappableElement()) == Insets.NONE);

        // ---- 3 buttons, notch on the side (landscape): cutout 60 on the left, status bar 24
        deliver(content, insets(24, 96, 60, 0));
        check("landscape: the cutout on the left becomes padding on the left",
                content.getPaddingLeft() == 60 && content.getPaddingTop() == 24 && content.getPaddingBottom() == 96);

        // ---- cutout bigger than the status bar: takes the largest of the two
        WindowInsets.Builder b = new WindowInsets.Builder();
        b.setInsets(WindowInsets.Type.statusBars(), Insets.of(0, 60, 0, 0));
        b.setInsets(WindowInsets.Type.displayCutout(), Insets.of(0, 90, 0, 0));
        deliver(content, b.build());
        check("cutout taller than the status bar: top padding is the largest", content.getPaddingTop() == 90);

        // ---- keyboard: height that SheetEditorActivity works out must stay the same (ime - systemBars at the bottom)
        WindowInsets before = insets(80, 48, 0, 900);
        int oldExtra = Math.max(0, before.getInsets(WindowInsets.Type.ime()).bottom - before.getInsets(WindowInsets.Type.systemBars()).bottom);
        WindowInsets down = deliver(content, before);
        int newExtra = Math.max(0, down.getInsets(WindowInsets.Type.ime()).bottom - down.getInsets(WindowInsets.Type.systemBars()).bottom);
        check("keyboard open: the extra height that the editor computes is the same as before (" + oldExtra + ")", oldExtra == 852 && newExtra == oldExtra);
        WindowInsets hidden = deliver(content, insets(80, 48, 0, 0));
        int hiddenExtra = Math.max(0, hidden.getInsets(WindowInsets.Type.ime()).bottom - hidden.getInsets(WindowInsets.Type.systemBars()).bottom);
        check("keyboard closed: extra height is zero", hiddenExtra == 0);
        WindowInsets small = deliver(content, insets(80, 48, 0, 30));
        check("keyboard shorter than the navigation bar: zero, never negative", small.getInsets(WindowInsets.Type.ime()).bottom == 0);

        // ---- the same insets object is not changed (the system keeps its copy)
        WindowInsets original = insets(80, 48, 0, 900);
        deliver(content, original);
        check("the insets that the system delivered are not changed", original.getInsets(WindowInsets.Type.statusBars()).top == 80
                && original.getInsets(WindowInsets.Type.ime()).bottom == 900);

        // ---- if it ever runs below Android 11: it neither pads nor changes anything
        Build.VERSION.SDK_INT = 29;
        View other = new View();
        WindowInsets sent = insets(80, 48, 0, 0);
        WindowInsets back = new MrScreens().onApplyWindowInsets(other, sent);
        check("below Android 11 the insets pass untouched and there is no padding",
                back == sent && other.getPaddingTop() == 0 && other.getPaddingBottom() == 0);

        // ---- dialog of the AI Editor (window from the top of the display to the keyboard): fitDialog
        Build.VERSION.SDK_INT = 36;
        View dRoot = new View();
        MrScreens.fitDialog(dRoot);
        check("dialog on Android 15+: listener on the root and a request of the insets",
                dRoot.stubInsetsListener() != null && dRoot.stubInsetsRequests() == 1);
        dRoot.stubInsetsListener().onApplyWindowInsets(dRoot, insets(80, 0, 0, 0));
        check("dialog, portrait: the status bar is padding on top (the card stays below it), nothing else",
                dRoot.getPaddingTop() == 80 && dRoot.getPaddingBottom() == 0 && dRoot.getPaddingLeft() == 0 && dRoot.getPaddingRight() == 0);
        WindowInsets dLand = dRoot.stubInsetsListener().onApplyWindowInsets(dRoot, insets(60, 0, 110, 0));
        check("dialog, landscape with the camera on the side: padding on the side and on top",
                dRoot.getPaddingLeft() == 110 && dRoot.getPaddingTop() == 60);
        check("dialog: what is left for the views below is zero (the card does not reserve the bars again)",
                dLand.getInsets(BARS).top == 0 && dLand.getInsets(BARS).left == 0);
        dRoot.stubInsetsListener().onApplyWindowInsets(dRoot, insets(0, 0, 0, 0));
        check("dialog that does not touch the bars: no padding at all",
                dRoot.getPaddingTop() == 0 && dRoot.getPaddingLeft() == 0 && dRoot.getPaddingBottom() == 0);
        dRoot.stubInsetsListener().onApplyWindowInsets(dRoot, insets(80, 48, 0, 900));
        check("dialog over the whole display (no keyboard height known): bars in the padding, keyboard is not",
                dRoot.getPaddingTop() == 80 && dRoot.getPaddingBottom() == 48);
        Build.VERSION.SDK_INT = 34;
        View dOld = new View();
        MrScreens.fitDialog(dOld);
        check("dialog on Android 14 or below: no listener, no request (as before)",
                dOld.stubInsetsListener() == null && dOld.stubInsetsRequests() == 0);
        Build.VERSION.SDK_INT = 36;
        boolean dNull = true;
        try { MrScreens.fitDialog(null); } catch (RuntimeException e) { dNull = false; }
        check("fitDialog(null) does not fail", dNull);

        System.out.println(fail == 0 ? "ALL OK (" + ok + " checks)" : fail + " FAILURE(S)");
        System.exit(fail == 0 ? 0 : 1);
    }
}
