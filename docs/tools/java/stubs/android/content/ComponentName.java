package android.content;

/** Compile stub. */
public final class ComponentName {
    private final String pkg, cls;
    public ComponentName(Context pkg, Class<?> cls) {
        this.pkg = pkg.getPackageName();
        this.cls = cls.getName();
    }
    public ComponentName(String pkg, String cls) {
        this.pkg = pkg;
        this.cls = cls;
    }
    public String getPackageName() { return pkg; }
    public String getClassName() { return cls; }
}
