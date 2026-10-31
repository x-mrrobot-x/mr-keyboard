package com.mrkeyboard.app;

import java.util.ArrayList;
import java.util.List;

/** Stub de compilação e de teste de PC (a classe de verdade é o smali Keyboard). */
public class Keyboard {
    public static class Key {
        public int[] codes;
        public int x, y, width, height;

        public Key(int code, int x, int y, int width, int height) {
            this.codes = new int[] {code};
            this.x = x; this.y = y; this.width = width; this.height = height;
        }

        /** Como a de verdade: quadrado da distância do centro da tecla ao ponto. */
        public int squaredDistanceFrom(int px, int py) {
            int dx = x + width / 2 - px, dy = y + height / 2 - py;
            return dx * dx + dy * dy;
        }
    }

    /** Só para os testes. */
    public final List<Key> keys = new ArrayList<Key>();

    public List<Key> getKeys() { return keys; }

    /** Teste: todas as teclas (a de verdade devolve as perto do ponto, numa grade). */
    public int[] getNearestKeys(int x, int y) {
        int[] all = new int[keys.size()];
        for (int i = 0; i < all.length; i++) all[i] = i;
        return all;
    }
}
