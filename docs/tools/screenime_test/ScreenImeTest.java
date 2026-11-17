package com.mrkeyboard.app;

import android.content.Context;
import android.graphics.Insets;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.WindowInsets;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.ScrollView;

/**
 * MrScreenIme (the keyboard on the editor screens): which field has the keyboard saved when the screen is recreated,
 * how it is asked for again once the new window has the focus, and the room made for the keyboard on Android 15+.
 */
public class ScreenImeTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }

    /** A context whose keyboard service is the given manager. */
    static class Ctx extends Context {
        final InputMethodManager imm;
        Ctx(InputMethodManager imm) { this.imm = imm; }
        public Object getSystemService(String name) { return INPUT_METHOD_SERVICE.equals(name) ? imm : null; }
        public android.content.res.AssetManager getAssets() { return null; }
        public Context getApplicationContext() { return this; }
        public android.content.res.Resources getResources() { return null; }
        public String getPackageName() { return "x"; }
        public android.content.pm.PackageManager getPackageManager() { return null; }
        public android.content.SharedPreferences getSharedPreferences(String n, int m) { return null; }
        public java.io.File getFilesDir() { return null; }
        public java.io.File getCacheDir() { return null; }
        public void startActivity(android.content.Intent i) { }
    }

    static WindowInsets keyboard(boolean visible, int ime, int nav) {
        WindowInsets.Builder b = new WindowInsets.Builder();
        b.setInsets(WindowInsets.Type.ime(), Insets.of(0, 0, 0, ime));
        b.setInsets(WindowInsets.Type.navigationBars(), Insets.of(0, 0, 0, nav));
        b.setVisible(WindowInsets.Type.ime(), visible);
        return b.build();
    }

    /** What reaches the column after the content area took the bars as padding (MrScreens): nothing left of them. */
    static WindowInsets afterBars(int ime, int nav) {
        return keyboard(true, ime, nav).inset(0, 0, 0, nav);
    }

    static EditText field(InputMethodManager imm, String text) {
        EditText e = new EditText(new Ctx(imm));
        e.setText(text);
        return e;
    }

    public static void main(String[] a) {
        InputMethodManager imm = new InputMethodManager();
        EditText name = field(imm, "Pirata");
        EditText instr = field(imm, "Fale como um pirata, sempre");
        View other = new View(new Ctx(imm));

        // ---- save: which field, and only when the keyboard is really open
        for (int sdk = 26; sdk <= 29; sdk++) {
            Build.VERSION.SDK_INT = sdk;
            name.requestFocus();
            name.stubRootInsets(keyboard(true, 900, 48));
            Bundle b = new Bundle();
            MrScreenIme.save(b, name, instr);
            check("Android SDK " + sdk + ": nothing is saved (the open keyboard cannot be known)", b.size() == 0);
        }
        int[] sdks = {30, 33, 34, 35, 36, 37};
        for (int sdk : sdks) {
            Build.VERSION.SDK_INT = sdk;
            name.stubClearFocus(); instr.stubClearFocus();
            name.stubRootInsets(keyboard(true, 900, 48));
            instr.stubRootInsets(keyboard(true, 900, 48));
            instr.requestFocus();
            Bundle b = new Bundle();
            MrScreenIme.save(b, name, instr);
            check("Android SDK " + sdk + ": second field with focus and open keyboard is saved as 1",
                    b.getInt(MrScreenIme.KEY_FIELD, -1) == 1);
        }
        Build.VERSION.SDK_INT = 36;
        name.stubClearFocus(); instr.stubClearFocus();
        name.requestFocus();
        name.stubRootInsets(keyboard(true, 900, 48));
        Bundle b = new Bundle();
        MrScreenIme.save(b, name, instr);
        check("first field with focus and open keyboard is saved as 0", b.getInt(MrScreenIme.KEY_FIELD, -1) == 0);

        name.stubRootInsets(keyboard(false, 0, 48));
        b = new Bundle();
        MrScreenIme.save(b, name, instr);
        check("focus but keyboard closed: nothing saved", b.size() == 0);

        name.stubClearFocus();
        instr.stubRootInsets(keyboard(true, 900, 48));
        b = new Bundle();
        MrScreenIme.save(b, name, instr);
        check("keyboard open but the focus is elsewhere (a dialog, another view): nothing saved", b.size() == 0);

        name.requestFocus();
        name.stubRootInsets(null);
        b = new Bundle();
        MrScreenIme.save(b, name, instr);
        check("window not attached (no insets): nothing saved", b.size() == 0);

        boolean fine = true;
        try {
            MrScreenIme.save(null, name, instr);
            MrScreenIme.save(new Bundle(), null, null);
            MrScreenIme.restore(null, name, instr);
            MrScreenIme.restore(new Bundle(), null, null);
        } catch (RuntimeException e) { fine = false; }
        check("null bundle and null fields do not break", fine);

        // ---- the cursor goes along
        name.requestFocus();
        name.stubRootInsets(keyboard(true, 900, 48));
        name.setText("Pirata");
        name.setSelection(2, 5);
        b = new Bundle();
        MrScreenIme.save(b, name, instr);
        check("selection saved", b.getInt(MrScreenIme.KEY_START, -1) == 2 && b.getInt(MrScreenIme.KEY_END, -1) == 5);

        // ---- restore: new screen, same texts, the saved state in hand
        EditText n2 = field(imm, "Pirata");
        EditText i2 = field(imm, "Fale como um pirata, sempre");
        imm.shows = 0;
        MrScreenIme.restore(b, n2, i2);
        check("restore gives the focus back to the saved field", n2.hasFocus() && !i2.hasFocus());
        check("restore puts the cursor back", n2.getSelectionStart() == 2 && n2.getSelectionEnd() == 5);
        check("window without focus yet: waits (one listener, nothing shown)",
                n2.getViewTreeObserver().stubListeners() == 1 && n2.stubPostedCount() == 0 && imm.shows == 0);
        n2.stubWindowFocus(false);
        n2.stubRunPosted();
        check("window focus lost event: still nothing shown", imm.shows == 0);
        n2.stubWindowFocus(true);
        check("window gets the focus: the request is posted, not made inside the focus callback",
                n2.stubPostedCount() == 1 && imm.shows == 0);
        check("... and the listener is gone", n2.getViewTreeObserver().stubListeners() == 0);
        n2.stubRunPosted();
        check("the keyboard is asked for that field (implicit)", imm.shows == 1 && imm.lastView == n2
                && imm.lastFlags == InputMethodManager.SHOW_IMPLICIT);
        n2.stubWindowFocus(true);
        n2.stubRunPosted();
        check("the window gaining focus again later does not show it again", imm.shows == 1);

        // window already focused
        EditText n3 = field(imm, "Pirata");
        n3.stubWindowFocus(true);
        imm.shows = 0;
        MrScreenIme.restore(b, n3, null);
        check("window already with focus: posted at once, no listener", n3.stubPostedCount() == 1
                && n3.getViewTreeObserver().stubListeners() == 0);
        n3.stubRunPosted();
        check("... and shown", imm.shows == 1 && imm.lastView == n3);

        // second field
        Build.VERSION.SDK_INT = 36;
        instr.stubClearFocus();
        instr.requestFocus();
        instr.stubRootInsets(keyboard(true, 900, 48));
        name.stubClearFocus();
        instr.setText("Fale como um pirata, sempre");
        instr.setSelection(instr.length(), instr.length());
        Bundle b1 = new Bundle();
        MrScreenIme.save(b1, name, instr);
        check("second field: its own cursor is saved", b1.getInt(MrScreenIme.KEY_START, -1) == instr.length()
                && b1.getInt(MrScreenIme.KEY_END, -1) == instr.length());
        EditText n4 = field(imm, "Pirata");
        EditText i4 = field(imm, "Fale como um pirata, sempre");
        imm.shows = 0;
        MrScreenIme.restore(b1, n4, i4);
        i4.stubWindowFocus(true);
        i4.stubRunPosted();
        check("second field restored and shown", i4.hasFocus() && !n4.hasFocus() && imm.shows == 1 && imm.lastView == i4);

        // nothing to restore
        imm.shows = 0;
        EditText n5 = field(imm, "x");
        n5.stubWindowFocus(true);
        MrScreenIme.restore(null, n5, null);
        MrScreenIme.restore(new Bundle(), n5, null);
        Bundle bad = new Bundle();
        bad.putInt(MrScreenIme.KEY_FIELD, 7);
        MrScreenIme.restore(bad, n5, n5);
        Bundle missing = new Bundle();
        missing.putInt(MrScreenIme.KEY_FIELD, 1);
        MrScreenIme.restore(missing, n5, null);
        n5.stubRunPosted();
        check("first start, no key, unknown index or missing field: no focus, no keyboard",
                !n5.hasFocus() && imm.shows == 0 && n5.stubPostedCount() == 0);

        // a text shorter than the saved selection (the text was changed meanwhile): no crash, cursor untouched
        EditText n6 = field(imm, "ab");
        boolean ok6 = true;
        try { MrScreenIme.restore(b, n6, null); } catch (RuntimeException e) { ok6 = false; }
        check("saved selection past the end of a shorter text: no crash, focus still returns",
                ok6 && n6.hasFocus() && n6.getSelectionStart() == 0 && n6.getSelectionEnd() == 0);
        imm.shows = 0;
        n6.stubWindowFocus(true);
        n6.stubRunPosted();
        check("... and the keyboard is still asked for", imm.shows == 1 && imm.lastView == n6);

        // no keyboard service
        EditText n7 = new EditText(new Ctx(null));
        n7.stubWindowFocus(true);
        MrScreenIme.restore(b, n7, null);
        boolean ok7 = true;
        try { n7.stubRunPosted(); } catch (RuntimeException e) { ok7 = false; }
        check("no keyboard service on the device: no crash", ok7);

        // ---- lift (Android 15+ edge to edge): room for the keyboard in the scrolled column
        for (int sdk = 26; sdk <= 29; sdk++) {
            Build.VERSION.SDK_INT = sdk;
            ScrollView s = new ScrollView(new Ctx(imm));
            View col = new View(new Ctx(imm));
            MrScreenIme.lift(s, col, 20, 16, 20, 24, 12);
            check("Android SDK " + sdk + ": no listener on the scroll", s.stubInsetsListener() == null);
        }
        for (int sdk : sdks) {
            Build.VERSION.SDK_INT = sdk;
            ScrollView s = new ScrollView(new Ctx(imm));
            View col = new View(new Ctx(imm));
            MrScreenIme.lift(s, col, 20, 16, 20, 24, 12);
            check("Android SDK " + sdk + ": listener on the scroll and insets requested",
                    s.stubInsetsListener() != null && s.stubInsetsRequests() == 1);
        }
        Build.VERSION.SDK_INT = 36;
        ScrollView sc = new ScrollView(new Ctx(imm));
        View col = new View(new Ctx(imm));
        col.setPadding(20, 16, 20, 24);   // the screen sets its own padding before asking for the room
        EditText f1 = field(imm, "a");
        f1.stubTop(160);
        MrScreenIme.lift(sc, col, 20, 16, 20, 24, 12);
        View.OnApplyWindowInsetsListener lis = sc.stubInsetsListener();

        WindowInsets closed = keyboard(false, 0, 48).inset(0, 0, 0, 48);
        lis.onApplyWindowInsets(sc, closed);
        check("keyboard closed: the column keeps its own padding", col.getPaddingBottom() == 24 && col.getPaddingLeft() == 20
                && col.getPaddingTop() == 16 && col.getPaddingRight() == 20);

        WindowInsets open = afterBars(900, 48);
        sc.stubFocused = f1;
        WindowInsets back = lis.onApplyWindowInsets(sc, open);
        check("keyboard 900 with bar 48: the column gets 852 of room (the bar is already padding)",
                col.getPaddingBottom() == 24 + 852);
        check("the insets go on unchanged", back == open);
        check("the field with focus scrolls after the layout (posted)", sc.stubPostedCount() == 1 && sc.getScrollY() == 0);
        sc.stubRunPosted();
        check("... to its top minus the margin", sc.getScrollY() == 160 - 12);

        lis.onApplyWindowInsets(sc, open);
        check("same insets again: nothing posted, nothing changed", sc.stubPostedCount() == 0 && col.getPaddingBottom() == 24 + 852);

        sc.scrollTo(0, 5);
        lis.onApplyWindowInsets(sc, afterBars(700, 48));
        check("keyboard shrinks to 700: the room follows", col.getPaddingBottom() == 24 + 652);
        check("... and it does not scroll again", sc.stubPostedCount() == 0 && sc.getScrollY() == 5);

        lis.onApplyWindowInsets(sc, afterBars(900, 48));
        check("keyboard grows again (another keyboard): scrolls again", sc.stubPostedCount() == 1);
        sc.stubRunPosted();

        lis.onApplyWindowInsets(sc, closed);
        check("keyboard closes: back to the own padding, no scroll", col.getPaddingBottom() == 24 && sc.stubPostedCount() == 0);

        // the same arithmetic when the bars still come in the insets (below Android 15, or before MrScreens)
        lis.onApplyWindowInsets(sc, keyboard(true, 900, 48));
        check("bars still inside the insets: same 852", col.getPaddingBottom() == 24 + 852);
        sc.stubRunPosted();
        lis.onApplyWindowInsets(sc, keyboard(true, 30, 48));
        check("keyboard lower than the bar: never negative", col.getPaddingBottom() == 24);

        // scroll target
        ScrollView s2 = new ScrollView(new Ctx(imm));
        View col2 = new View(new Ctx(imm));
        MrScreenIme.lift(s2, col2, 0, 0, 0, 0, 12);
        EditText top = field(imm, "t");
        top.stubTop(5);
        s2.stubFocused = top;
        s2.stubInsetsListener().onApplyWindowInsets(s2, afterBars(900, 48));
        s2.stubRunPosted();
        check("field near the top: the scroll never goes negative", s2.getScrollY() == 0);

        ScrollView s3 = new ScrollView(new Ctx(imm));
        View col3 = new View(new Ctx(imm));
        MrScreenIme.lift(s3, col3, 0, 0, 0, 0, 12);
        s3.stubInsetsListener().onApplyWindowInsets(s3, afterBars(900, 48));
        boolean ok8 = true;
        try { s3.stubRunPosted(); } catch (RuntimeException e) { ok8 = false; }
        check("keyboard appears with no field focused: nothing scrolls, no crash", ok8 && s3.getScrollY() == 0);

        boolean ok9 = true;
        try { MrScreenIme.lift(null, col, 0, 0, 0, 0, 0); MrScreenIme.lift(sc, null, 0, 0, 0, 0, 0); } catch (RuntimeException e) { ok9 = false; }
        check("lift with null views does not break", ok9);

        // ---- show: the keyboard opens with a screen made to be used with it (the key sounds screen)
        for (int sdk : new int[] {26, 36}) {
            Build.VERSION.SDK_INT = sdk;
            EditText sf = field(imm, "x");
            sf.stubWindowFocus(true);
            imm.shows = 0;
            MrScreenIme.show(sf);
            check("Android SDK " + sdk + ": show gives the field the focus and posts the request (window already focused)",
                    sf.hasFocus() && sf.stubPostedCount() == 1 && sf.getViewTreeObserver().stubListeners() == 0 && imm.shows == 0);
            sf.stubRunPosted();
            check("Android SDK " + sdk + ": ... and the keyboard is asked for that field, implicit", imm.shows == 1 && imm.lastView == sf && imm.lastFlags == InputMethodManager.SHOW_IMPLICIT);
        }
        Build.VERSION.SDK_INT = 36;
        EditText sw = field(imm, "x");
        imm.shows = 0;
        MrScreenIme.show(sw);
        check("show before the window has the focus: waits for it, shows nothing yet", sw.hasFocus() && sw.getViewTreeObserver().stubListeners() == 1 && imm.shows == 0);
        sw.stubWindowFocus(true);
        sw.stubRunPosted();
        check("... and asks once the window has it", imm.shows == 1 && imm.lastView == sw);
        boolean okShow = true;
        try {
            MrScreenIme.show(null);
            EditText nk = new EditText(new Ctx(null));
            nk.stubWindowFocus(true);
            MrScreenIme.show(nk);
            nk.stubRunPosted();
        } catch (RuntimeException e) { okShow = false; }
        check("show with no field or no keyboard service does not break", okShow);

        // ---- keepVisible: the room for the keyboard, with the tiles above the field left where they are
        for (int sdk = 26; sdk <= 29; sdk++) {
            Build.VERSION.SDK_INT = sdk;
            ScrollView s = new ScrollView(new Ctx(imm));
            MrScreenIme.keepVisible(s, new View(new Ctx(imm)), 20, 16, 20, 24, 12);
            check("Android SDK " + sdk + ": keepVisible puts no listener (the window resizes by itself)", s.stubInsetsListener() == null);
        }
        Build.VERSION.SDK_INT = 36;
        ScrollView kv = new ScrollView(new Ctx(imm));
        kv.stubSize(1080, 1500);
        View kcol = new View(new Ctx(imm));
        MrScreenIme.keepVisible(kv, kcol, 20, 16, 20, 24, 12);
        check("Android 15+: keepVisible puts the listener and asks for the insets", kv.stubInsetsListener() != null && kv.stubInsetsRequests() == 1);
        EditText low = field(imm, "t");
        low.stubTop(1100);
        low.stubSize(900, 140);
        kv.stubFocused = low;
        kv.stubInsetsListener().onApplyWindowInsets(kv, afterBars(900, 48));
        check("the room is the same as lift's (852 beyond the bars)", kcol.getPaddingBottom() == 24 + 852);
        check("a field under the keyboard: the scroll is asked for after the layout", kv.stubPostedCount() == 1 && kv.getScrollY() == 0);
        kv.stubRunPosted();
        // visible bottom = 0 + 1500 - 852 = 648; the field ends at 1240, plus the margin 12: 604 to go down
        check("... and goes down just far enough to have the field and its margin above the keyboard", kv.getScrollY() == 1100 + 140 + 12 - (1500 - 852));
        kv.stubInsetsListener().onApplyWindowInsets(kv, afterBars(900, 48));
        check("same insets again: nothing more", kv.stubPostedCount() == 0);

        ScrollView ks = new ScrollView(new Ctx(imm));
        ks.stubSize(1080, 1500);
        View kcol2 = new View(new Ctx(imm));
        MrScreenIme.keepVisible(ks, kcol2, 20, 16, 20, 24, 12);
        EditText high = field(imm, "t");
        high.stubTop(300);
        high.stubSize(900, 140);
        ks.stubFocused = high;
        ks.stubInsetsListener().onApplyWindowInsets(ks, afterBars(900, 48));
        ks.stubRunPosted();
        check("a field that already is above the keyboard: the screen stays where it is (the tiles stay in view)", ks.getScrollY() == 0);
        ks.scrollTo(0, 500);
        ks.stubInsetsListener().onApplyWindowInsets(ks, keyboard(false, 0, 48).inset(0, 0, 0, 48));
        ks.stubInsetsListener().onApplyWindowInsets(ks, afterBars(900, 48));
        ks.stubRunPosted();
        check("it never scrolls up", ks.getScrollY() == 500);

        ScrollView kn = new ScrollView(new Ctx(imm));
        kn.stubSize(1080, 1500);
        MrScreenIme.keepVisible(kn, new View(new Ctx(imm)), 0, 0, 0, 0, 12);
        kn.stubInsetsListener().onApplyWindowInsets(kn, afterBars(900, 48));
        boolean okKn = true;
        try { kn.stubRunPosted(); } catch (RuntimeException e) { okKn = false; }
        check("no field with the focus: nothing scrolls, no crash", okKn && kn.getScrollY() == 0);
        boolean okNull = true;
        try { MrScreenIme.keepVisible(null, kcol, 0, 0, 0, 0, 0); MrScreenIme.keepVisible(kv, null, 0, 0, 0, 0, 0); } catch (RuntimeException e) { okNull = false; }
        check("keepVisible with null views does not break", okNull);

        System.out.println(ok + " ok, " + fail + " failures");
        if (fail > 0) System.exit(1);
    }
}
