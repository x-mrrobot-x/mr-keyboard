package android.text.style;

public class URLSpan extends ClickableSpan {
    private final String mUrl;
    public URLSpan(String url) { mUrl = url; }
    public String getURL() { return mUrl; }
    public void onClick(android.view.View widget) { }
}
