package com.mrkeyboard.app;

import android.view.View;
import android.view.ViewGroup;

import java.lang.ref.Reference;
import java.lang.ref.WeakReference;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.IdentityHashMap;
import java.util.Map;
import java.util.WeakHashMap;

/**
 * Stage 4 of docs/plan-performance.md (build _84): how many of the big objects of the keyboard are still alive once the garbage
 * collector ran, counted instead of guessed from megabytes. The memory lines (Java heap, native heap) move with what was typed, with
 * which keyboards were made and with when the collector ran, so they cannot say whether something stayed behind after the service
 * ended and was made again. A count can: the service (LatinIME) and the input view of the keyboard are 1 each while the service lives,
 * and after a switch to another keyboard and back it must still be 1 after a collection; a 2 means the old one is held by something.
 *
 * Build _85: when an old one is alive, it also says WHO holds it. The search starts at the static variables of the classes of the app
 * (ROOTS) and follows what the app itself keeps: the fields of its classes, the arrays, lists and maps, the children and the context
 * of the views. It finds the shortest chain to the old object ("MrTools.sKbd:FrameLayout > child:LatinKeyboardView"), or says that no
 * variable of the app reaches it, which leaves the system (a binder, a message queue, a thread) as what holds it. Nothing of this runs
 * while the keyboard works: only the button of the Advanced screen, right after its collection.
 *
 * Build _86: the search no longer stops at the first chain: it reports one for each old object it reaches (up to four, one per line), because
 * the old service and the old input view can be held by different things. An old object that is only held through another one it already
 * reached is not reported apart. The first holder found on the phone was MrLearned.sGate (a static that kept the last Suggest, and through it
 * the AutoDictionary and the whole service); it was fixed, and the next count says what else holds, if anything does.
 *
 * It holds only weak references, so it cannot be what keeps them alive. Nothing runs while the keyboard works besides one registration
 * per service and one per input view; the count is made by the Advanced screen, right after the collection that its row "free memory
 * now" asks for (MrPerf.Trim), and the meter shows it in a line (MrPerf.summary).
 */
final class MrLive {
    /** The classes of the app that have a static variable that holds an object. docs/tools/test_live_roots.py keeps this list complete. */
    private static final String[] ROOTS = {
        "AutoDictionary", "BgTask", "ComposeSequence", "Dictionary$DataType", "KeyStyle", "KeyboardSwitcher", "LatinIME",
        "LatinIMEUtil$GCUtils", "LatinIMEUtil$RingCharBuffer", "MrAi", "MrAiDialog", "MrAiStyleActivity", "MrAnim", "MrBar",
        "MrCacheClear", "MrCacheJobs", "MrCopyRetention", "MrEmojiIndex", "MrEmojiNew", "MrEmojiSearch", "MrEmotes", "MrEs", "MrFonts",
        "MrFuzzy", "MrGesture", "MrGestureInput", "MrGestureWords", "MrGlow", "MrHaptic", "MrLearned", "MrLive", "MrNative", "MrPacks",
        "MrPerf", "MrPredict", "MrRecent", "MrRecorrect", "MrReset", "MrRules", "MrScreens", "MrShots", "MrSugg", "MrTools",
        "MrTrigram", "MrTune", "MrUpdateDialog", "MrUpdateInstall", "MrUpdateUi", "PluginManager", "PointerTracker",
        "ShadowDrawHelper", "SheetStore", "SheetUi", "SpecialKeyPicker", "TextEntryState", "TextEntryState$State",
        "UserBigramDictionary", "UserDictionary"
    };
    private static final String PKG = "com.mrkeyboard.";

    /** What the search may spend: the objects it looks at and the time. A search that runs out of either says so, it does not guess. */
    private static final int BUDGET = 400000;
    private static final long TIME_NS = 2000000000L;
    /** How many chains the search reports (one per old object that it reaches). */
    private static final int MAX_PATHS = 4;

    /** What the last count found about who holds an old object (sHeldKind). */
    static final int HELD_NONE = 0;     // nothing old is alive
    static final int HELD_PATH = 1;     // a chain from a variable of the app to the old object, in sHeld
    static final int HELD_OUTSIDE = 2;  // no variable of the app reaches it: the system holds it
    static final int HELD_CUT = 3;      // the search ran out of objects or of time

    private static final ArrayList<WeakReference<Object>> sServiceRefs = new ArrayList<WeakReference<Object>>();
    private static final ArrayList<WeakReference<Object>> sViewRefs = new ArrayList<WeakReference<Object>>();

    /** What the last count found; sMeasured says there was one since the start of the process or the last reset of the meter. */
    static boolean sMeasured;
    static int sServices;
    static int sViews;
    static int sHeldKind;
    static String sHeld = "";

    private MrLive() { }

    /** LatinIME.onCreate: the service that was just made. */
    static synchronized void service(Object service) {
        watch(sServiceRefs, service);
    }

    /** KeyboardSwitcher, where the input view of the keyboard is made (every time a new one is inflated). */
    static synchronized void view(Object view) {
        watch(sViewRefs, view);
    }

    private static void watch(ArrayList<WeakReference<Object>> list, Object o) {
        if (o == null) return;
        for (int i = list.size() - 1; i >= 0; i--) {
            Object held = list.get(i).get();
            if (held == null) {
                list.remove(i);
            } else if (held == o) {
                return;     // the same object registered again is still one
            }
        }
        list.add(new WeakReference<Object>(o));
    }

    private static int alive(ArrayList<WeakReference<Object>> list) {
        int n = 0;
        for (int i = list.size() - 1; i >= 0; i--) {
            if (list.get(i).get() == null) list.remove(i);
            else n++;
        }
        return n;
    }

    /**
     * What is alive and is not the newest one registered: the newest is the one in use (the service the system made last, the input view
     * inflated last), the others are what stayed behind.
     */
    private static void old(ArrayList<WeakReference<Object>> list, ArrayList<Object> into) {
        for (int i = 0; i < list.size() - 1; i++) {
            Object o = list.get(i).get();
            if (o != null) into.add(o);
        }
    }

    /** Counts what is alive now. Call it right after System.gc(): before it, what is only waiting to be collected would count too. */
    static void measure() {
        measure(null);
    }

    /** The same, looking for who holds an old one from these classes (null: the classes of the app, ROOTS). The tests give their own. */
    static synchronized void measure(Class<?>[] roots) {
        sServices = alive(sServiceRefs);
        sViews = alive(sViewRefs);
        sMeasured = true;
        sHeldKind = HELD_NONE;
        sHeld = "";
        ArrayList<Object> stayed = new ArrayList<Object>();
        old(sServiceRefs, stayed);
        old(sViewRefs, stayed);
        if (stayed.isEmpty()) return;
        try {
            Result r = search(stayed.toArray(), roots != null ? roots : rootClasses());
            sHeldKind = r.kind;
            sHeld = r.path;
        } catch (Throwable t) {
            sHeldKind = HELD_CUT;       // a search that could not run is not an answer
        }
    }

    /** The meter was reset: the line of the count goes too. */
    static synchronized void forget() {
        sMeasured = false;
        sHeldKind = HELD_NONE;
        sHeld = "";
    }

    private static Class<?>[] rootClasses() {
        ArrayList<Class<?>> list = new ArrayList<Class<?>>();
        ClassLoader loader = MrLive.class.getClassLoader();
        for (int i = 0; i < ROOTS.length; i++) {
            try {
                list.add(Class.forName(PKG + "app." + ROOTS[i], false, loader));
            } catch (Throwable t) {
                // a class that is not there is not a root
            }
        }
        return list.toArray(new Class<?>[list.size()]);
    }

    /** The answer of a search: the kind (HELD_*) and, for HELD_PATH, the chain. */
    static final class Result {
        int kind;
        String path = "";
    }

    /**
     * The shortest chain from a static variable of one of the root classes to each of the targets (up to MAX_PATHS), by what the app itself keeps.
     * Breadth first, so each chain found is the shortest one to its target. The targets are looked for by identity. A target is not looked
     * into once found: what only it holds is held through it, and fixing the first holder is what frees them (build _86: the old service
     * can be held by one thing and the old input view by another, and the first chain alone hid the second).
     */
    static Result search(Object[] targets, Class<?>[] roots) {
        Search s = new Search(targets);
        Result r = new Result();
        long deadline = System.nanoTime() + TIME_NS;
        for (int i = 0; i < roots.length && !s.done(); i++) s.addRoot(roots[i]);
        boolean cut = false;
        while (!s.done() && s.head < s.n) {
            if (s.n >= BUDGET || ((s.head & 255) == 0 && System.nanoTime() > deadline)) {
                cut = true;
                break;
            }
            s.expand(s.head++);
        }
        if (s.hits > 0) {
            r.kind = HELD_PATH;         // chains already found are an answer even when the search was cut after them
            r.path = s.paths();
        } else {
            r.kind = cut ? HELD_CUT : HELD_OUTSIDE;
        }
        return r;
    }

    private static String simple(Class<?> c) {
        if (c.isArray()) return simple(c.getComponentType()) + "[]";
        String n = c.getName();
        int dot = n.lastIndexOf('.');
        return dot >= 0 ? n.substring(dot + 1) : n;
    }

    private static final class Search {
        private final IdentityHashMap<Object, Object> want = new IdentityHashMap<Object, Object>();
        private final IdentityHashMap<Object, Object> seen = new IdentityHashMap<Object, Object>();
        private final HashMap<Class<?>, Field[]> fields = new HashMap<Class<?>, Field[]>();
        private Object[] objs = new Object[4096];
        private String[] how = new String[4096];
        private int[] from = new int[4096];
        int n;
        int head;
        /** The targets reached so far, and where each one is in the queue. */
        int hits;
        private final int[] hitAt = new int[MAX_PATHS];

        Search(Object[] targets) {
            for (int i = 0; i < targets.length; i++) {
                if (targets[i] != null) want.put(targets[i], targets[i]);
            }
        }

        private static boolean leaf(Object o) {
            return o instanceof CharSequence || o instanceof Number || o instanceof Boolean || o instanceof Character
                    || o instanceof Class || o instanceof Reference;
        }

        /** The search is over when every target (or MAX_PATHS of them) has been reached. */
        boolean done() {
            return hits >= Math.min(want.size(), MAX_PATHS);
        }

        /** Puts an object in the queue; true when it is one of the targets (then its position is kept in hitAt). */
        private boolean add(int parent, String label, Object o) {
            if (o == null || leaf(o) || seen.containsKey(o)) return false;
            seen.put(o, o);
            if (n == objs.length) {
                int size = n * 2;
                Object[] a = new Object[size];
                String[] h = new String[size];
                int[] f = new int[size];
                System.arraycopy(objs, 0, a, 0, n);
                System.arraycopy(how, 0, h, 0, n);
                System.arraycopy(from, 0, f, 0, n);
                objs = a;
                how = h;
                from = f;
            }
            objs[n] = o;
            how[n] = label;
            from[n] = parent;
            n++;
            if (want.containsKey(o)) {
                if (hits < hitAt.length) hitAt[hits++] = n - 1;
                return true;
            }
            return false;
        }

        void addRoot(Class<?> c) {
            Field[] fs;
            try {
                fs = c.getDeclaredFields();
            } catch (Throwable t) {
                return;
            }
            for (int i = 0; i < fs.length && !done(); i++) {
                Field f = fs[i];
                if (!Modifier.isStatic(f.getModifiers()) || f.getType().isPrimitive()) continue;
                try {
                    f.setAccessible(true);
                    add(-1, simple(c) + "." + f.getName(), f.get(null));
                } catch (Throwable t) {
                    // a field that cannot be read is skipped
                }
            }
        }

        /** The instance fields of a class of the app and of its superclasses that are of the app too (the framework ones are not read). */
        private Field[] fieldsOf(Class<?> c) {
            Field[] cached = fields.get(c);
            if (cached != null) return cached;
            ArrayList<Field> list = new ArrayList<Field>();
            for (Class<?> k = c; k != null && k.getName().startsWith(PKG); k = k.getSuperclass()) {
                Field[] fs;
                try {
                    fs = k.getDeclaredFields();
                } catch (Throwable t) {
                    continue;
                }
                for (int i = 0; i < fs.length; i++) {
                    Field f = fs[i];
                    if (Modifier.isStatic(f.getModifiers()) || f.getType().isPrimitive()) continue;
                    try {
                        f.setAccessible(true);
                        list.add(f);
                    } catch (Throwable t) {
                        // skipped
                    }
                }
            }
            Field[] out = list.toArray(new Field[list.size()]);
            fields.put(c, out);
            return out;
        }

        void expand(int at) {
            Object o = objs[at];
            if (want.containsKey(o)) return;       // a target that was reached is not looked into
            Class<?> c = o.getClass();
            if (c.isArray()) {
                if (!c.getComponentType().isPrimitive()) {
                    Object[] a = (Object[]) o;
                    for (int i = 0; i < a.length && !done(); i++) add(at, "[]", a[i]);
                }
                return;
            }
            if (o instanceof Collection) {
                Object[] a = null;
                try {
                    a = ((Collection<?>) o).toArray();
                } catch (Throwable t) {
                    // a collection that changes under us is skipped
                }
                if (a != null) for (int i = 0; i < a.length && !done(); i++) add(at, "item", a[i]);
            } else if (o instanceof Map) {
                Object[] keys = null;
                Object[] values = null;
                try {
                    Map<?, ?> m = (Map<?, ?>) o;
                    values = m.values().toArray();
                    // the keys of a WeakHashMap are weak: they do not hold what they point to
                    if (!(o instanceof WeakHashMap)) keys = m.keySet().toArray();
                } catch (Throwable t) {
                    // skipped
                }
                if (keys != null) for (int i = 0; i < keys.length && !done(); i++) add(at, "key", keys[i]);
                if (values != null) for (int i = 0; i < values.length && !done(); i++) add(at, "value", values[i]);
            }
            if (done()) return;
            if (o instanceof View) {
                View v = (View) o;
                try {
                    add(at, "context", v.getContext());
                    if (o instanceof ViewGroup) {
                        ViewGroup g = (ViewGroup) o;
                        int count = g.getChildCount();
                        for (int i = 0; i < count && !done(); i++) add(at, "child", g.getChildAt(i));
                    }
                } catch (Throwable t) {
                    // skipped
                }
            }
            if (done() || !c.getName().startsWith(PKG)) return;
            Field[] fs = fieldsOf(c);
            for (int i = 0; i < fs.length && !done(); i++) {
                try {
                    add(at, fs[i].getName(), fs[i].get(o));
                } catch (Throwable t) {
                    // skipped
                }
            }
        }

        /** The chain of each target reached, one per line. */
        String paths() {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < hits; i++) {
                if (i > 0) sb.append('\n');
                sb.append(path(hitAt[i]));
            }
            return sb.toString();
        }

        /** "MrTools.sKbd:FrameLayout > child:LatinKeyboardView": the variable it starts at and what each step of the chain is. */
        String path(int at) {
            ArrayList<String> hops = new ArrayList<String>();
            for (int i = at; i >= 0; i = from[i]) hops.add(0, how[i] + ":" + simple(objs[i].getClass()));
            if (hops.size() > 8) {
                ArrayList<String> cut = new ArrayList<String>();
                for (int i = 0; i < 4; i++) cut.add(hops.get(i));
                cut.add("...");
                for (int i = hops.size() - 3; i < hops.size(); i++) cut.add(hops.get(i));
                hops = cut;
            }
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < hops.size(); i++) {
                if (i > 0) sb.append(" > ");
                sb.append(hops.get(i));
            }
            return sb.toString();
        }
    }
}
