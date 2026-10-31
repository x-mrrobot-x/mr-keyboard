package android.content.res;
public class Resources {
    public static boolean hasText = true;
    public int getIdentifier(String name, String defType, String defPackage) { return hasText && name.equals("mr_ui_link_no_browser") ? 7 : 0; }
    public String getString(int id) { return id == 7 ? "No hay ninguna app para abrir el enlace" : null; }
    public String getString(int id, Object... a) { return getString(id); }
    public Configuration getConfiguration() { return null; }
    public int getColor(int id) { return 0; }
    public android.util.DisplayMetrics getDisplayMetrics() { return null; }
}
