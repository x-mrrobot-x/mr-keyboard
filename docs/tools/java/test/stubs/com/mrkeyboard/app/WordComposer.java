package com.mrkeyboard.app;
import java.util.ArrayList;
/** Versão de teste: palavra digitada + códigos de proximidade por posição. */
public class WordComposer {
    final StringBuilder typed = new StringBuilder();
    final ArrayList<int[]> codes = new ArrayList<int[]>();
    public void add(int primary, int[] c) { typed.append((char) primary); codes.add(c); }
    public int size() { return typed.length(); }
    public int[] getCodesAt(int index) { return codes.get(index); }
    public CharSequence getTypedWord() { return typed.toString(); }
    public boolean isFirstCharCapitalized() { return typed.length() > 0 && Character.isUpperCase(typed.charAt(0)); }
}
