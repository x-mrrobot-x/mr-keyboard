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

    public void getWords(WordComposer composer, WordCallback callback, int[] nextLettersFrequencies) { }

    public boolean isValidWord(CharSequence word) { return false; }
}
