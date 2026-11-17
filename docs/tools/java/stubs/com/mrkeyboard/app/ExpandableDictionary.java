package com.mrkeyboard.app;

/**
 * Compile and PC test stub of the dictionary the keyboard fills while it runs (AutoDictionary, UserDictionary): the tree of
 * words as the APK class keeps it, with the members the Java layer reads (MrGestureWords). mrRoots() is added to the real
 * class in the smali. For the tests: addWord builds the tree; stubLoading says the loading thread is filling it; stubClear
 * is what a reload does to the tree (the real clearDictionary); stubChanged stands for the call to MrGestureWords.changed()
 * that the real addWord and clearDictionary make first (hand-edited smali; a stub cannot name a class of the sources).
 */
public class ExpandableDictionary extends Dictionary {
    static class Node {
        char code;
        int frequency;
        boolean terminal;
        NodeArray children;
    }

    static class NodeArray {
        Node[] data = new Node[2];
        int length = 0;

        void add(Node n) {
            if (length + 1 > data.length) {
                Node[] bigger = new Node[length + 2];
                System.arraycopy(data, 0, bigger, 0, length);
                data = bigger;
            }
            data[length++] = n;
        }
    }

    private NodeArray mRoots = new NodeArray();
    public ExpandableDictionary() { }

    /** As the APK class (package-private there): the keyboard makes small trees of its own with it (MrApp). */
    ExpandableDictionary(android.content.Context context, int dicTypeId) {
        stubType = dicTypeId;
    }

    /** Not in Android: the kind the tree was made with, the pairs set on it ({first, second, frequency}) and how often it was asked. */
    public int stubType;
    public final java.util.ArrayList<String[]> stubPairs = new java.util.ArrayList<String[]>();
    public int stubWordsAsked, stubBigramsAsked;
    public CharSequence stubLastPrevious;
    public boolean stubLoading;
    public int stubReloadChecks;
    public static Runnable stubChanged;

    public NodeArray mrRoots() { return mRoots; }

    boolean reloadDictionaryIfRequired() {
        stubReloadChecks++;
        return stubLoading;
    }

    public void stubClear() {
        if (stubChanged != null) stubChanged.run();
        mRoots = new NodeArray();
    }

    /** As the APK class: the word becomes a word of the tree; a word already there keeps the larger frequency. */
    public void addWord(String word, int frequency) {
        if (stubChanged != null) stubChanged.run();
        NodeArray level = mRoots;
        for (int i = 0; i < word.length(); i++) {
            final char c = word.charAt(i);
            Node node = null;
            for (int k = 0; k < level.length && node == null; k++) if (level.data[k].code == c) node = level.data[k];
            if (node == null) {
                node = new Node();
                node.code = c;
                level.add(node);
            }
            if (i == word.length() - 1) {
                node.terminal = true;
                node.frequency = Math.min(255, Math.max(frequency, node.frequency));
            } else {
                if (node.children == null) node.children = new NodeArray();
                level = node.children;
            }
        }
    }

    protected int setBigram(String word1, String word2, int frequency) {
        stubPairs.add(new String[] {word1, word2, String.valueOf(frequency)});
        return frequency;
    }

    /** As the APK class: the frequency of a word of the tree, or -1 when it is not one. */
    public int getWordFrequency(CharSequence word) {
        NodeArray level = mRoots;
        Node node = null;
        for (int i = 0; i < word.length(); i++) {
            node = null;
            for (int k = 0; level != null && k < level.length && node == null; k++) if (level.data[k].code == word.charAt(i)) node = level.data[k];
            if (node == null) return -1;
            level = node.children;
        }
        return node != null && node.terminal ? node.frequency : -1;
    }

    public void getBigrams(WordComposer composer, CharSequence previousWord, WordCallback callback, int[] nextLettersFrequencies) {
        stubBigramsAsked++;
        stubLastPrevious = previousWord;
    }

    public void getWords(WordComposer composer, WordCallback callback, int[] nextLettersFrequencies) {
        stubWordsAsked++;
    }

    public boolean isValidWord(CharSequence word) { return false; }
}
