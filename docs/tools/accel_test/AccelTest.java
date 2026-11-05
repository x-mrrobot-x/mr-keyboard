package com.mrkeyboard.app;

import android.app.Dialog;
import android.inputmethodservice.InputMethodService;
import android.os.Build;
import android.util.Log;
import android.view.View;
import android.view.Window;

/**
 * MrAccel (diagnostic of the keyboard window): one line in the log per process, only when the window is attached to its
 * display, with what the window really has; it changes nothing and a failure never reaches the keyboard.
 */
public class AccelTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }

    /** The decor view of the keyboard window. */
    static class Decor extends View { }

    static class Win extends Window {
        final View decor;
        Win(View decor) { this.decor = decor; }
        public View getDecorView() { return decor; }
    }

    static class Box extends Dialog {
        final Window window;
        Box(Window window) { super(null, 0); this.window = window; }
        public Window getWindow() { return window; }
    }

    /** The keyboard service with the window it hands out. */
    static class Ime extends InputMethodService {
        final Dialog dialog;
        Ime(Dialog dialog) { this.dialog = dialog; }
        public Dialog getWindow() { return dialog; }
    }

    static class BrokenIme extends InputMethodService {
        public Dialog getWindow() { throw new IllegalStateException("window not ready"); }
    }

    static int lines() { return Log.stubLines.size(); }

    static Decor decor(boolean attached, boolean accelerated) {
        Decor d = new Decor();
        d.stubWindowState(attached, accelerated);
        return d;
    }

    public static void main(String[] a) {
        Build.VERSION.SDK_INT = 34;

        // ---- window shown and attached, accelerated: ONE line, says true, with the Android
        MrAccel.reset();
        Log.stubLines.clear();
        Decor d = decor(true, true);
        Ime ime = new Ime(new Box(new Win(d)));
        MrAccel.onShown(ime);
        check("nothing is written before the view runs its posted work (it waits for the attach)", lines() == 0 && d.stubPostedCount() == 1);
        d.stubRunPosted();
        check("one line in the log", lines() == 1);
        check("the line has the tag MrAccel", Log.stubLines.get(0).startsWith("MrAccel: "));
        check("the line says the window is accelerated", Log.stubLines.get(0).contains("hardwareAccelerated=true"));
        check("the line has the Android SDK", Log.stubLines.get(0).contains("SDK 34"));
        check("the state says it was logged", MrAccel.logged());

        // ---- shown again: no second line, no more work posted
        MrAccel.onShown(ime);
        check("shown again: no work posted (once per process)", d.stubPostedCount() == 0);
        check("shown again: still one line", lines() == 1);

        // ---- not accelerated: says false
        MrAccel.reset();
        Log.stubLines.clear();
        Decor soft = decor(true, false);
        MrAccel.onShown(new Ime(new Box(new Win(soft))));
        soft.stubRunPosted();
        check("window drawn by software: the line says false", lines() == 1 && Log.stubLines.get(0).contains("hardwareAccelerated=false"));

        // ---- two shows before the view runs its work: still one line
        MrAccel.reset();
        Log.stubLines.clear();
        Decor twice = decor(true, true);
        Ime imeTwice = new Ime(new Box(new Win(twice)));
        MrAccel.onShown(imeTwice);
        MrAccel.onShown(imeTwice);
        check("two shows before the work runs: two posted", twice.stubPostedCount() == 2);
        twice.stubRunPosted();
        check("two posted: one line only", lines() == 1);

        // ---- the view is not attached when the work runs: no line, and the next show tries again
        MrAccel.reset();
        Log.stubLines.clear();
        Decor loose = decor(false, false);
        Ime imeLoose = new Ime(new Box(new Win(loose)));
        MrAccel.onShown(imeLoose);
        loose.stubRunPosted();
        check("view not attached: no line (it would say false only because it does not know yet)", lines() == 0 && !MrAccel.logged());
        loose.stubWindowState(true, true);
        MrAccel.onShown(imeLoose);
        loose.stubRunPosted();
        check("attached on the next show: the line is written then", lines() == 1 && Log.stubLines.get(0).contains("hardwareAccelerated=true"));

        // ---- nothing available: no line and no failure
        MrAccel.reset();
        Log.stubLines.clear();
        boolean safe = true;
        try {
            MrAccel.onShown(null);
            MrAccel.onShown(new Ime(null));
            MrAccel.onShown(new Ime(new Box(null)));
            MrAccel.onShown(new Ime(new Box(new Win(null))));
            MrAccel.onShown(new BrokenIme());
        } catch (RuntimeException e) { safe = false; }
        check("no service, no dialog, no window, no decor view, or a window that is not ready: nothing happens and nothing fails", safe && lines() == 0);

        System.out.println(fail == 0 ? "ALL OK (" + ok + " checks)" : fail + " FAILURE(S)");
        System.exit(fail == 0 ? 0 : 1);
    }
}
