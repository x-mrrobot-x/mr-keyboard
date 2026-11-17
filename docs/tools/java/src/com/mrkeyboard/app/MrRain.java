package com.mrkeyboard.app;

import java.util.Random;

/**
 * The falling letters of the Matrix effect (settings, Advanced, Screens), without any Android in it so that the PC tests can run it: a grid of
 * columns and rows of glyphs where each column carries one "drop" (a head that goes down one row every few steps, with a trail behind it that
 * fades). {@link MrRainDrawable} draws it behind the settings screens, {@link #step} is one beat of the animation.
 *
 * <p>A drop that has gone off the bottom waits a random number of beats above the screen and comes back with another length and another speed, so
 * the columns never move together. The glyph of a cell changes now and then (a few cells in every beat), which gives the flicker of the letters.
 * What a glyph is (the index into the set the drawable chose) and how strong a cell is (1 at the head, less and less along the trail, 0 outside of
 * it) is all that the drawable asks.
 */
final class MrRain {
    /** Shortest and longest trail of a drop, in rows (cut to the height of the grid). */
    static final int TRAIL_MIN = 6;
    static final int TRAIL_MAX = 22;
    /** A head goes down one row every 1..PERIOD_MAX beats (1 is the fastest). */
    static final int PERIOD_MAX = 3;

    private final Random rnd;
    private final int glyphs;
    private int cols;
    private int rows;
    private int[] head;
    private int[] len;
    private int[] period;
    private int[] count;
    private int[] glyph;

    /** {@code glyphs}: how many different glyphs there are (at least 1); {@code seed}: the same seed gives the same rain. */
    MrRain(int glyphs, long seed) {
        this.glyphs = Math.max(1, glyphs);
        this.rnd = new Random(seed);
    }

    int cols() { return cols; }

    int rows() { return rows; }

    /** A grid of cols x rows cells. The drops start spread over the screen and above it, so the first picture already has rain in it. */
    void resize(int cols, int rows) {
        this.cols = Math.max(0, cols);
        this.rows = Math.max(0, rows);
        head = new int[this.cols];
        len = new int[this.cols];
        period = new int[this.cols];
        count = new int[this.cols];
        glyph = new int[this.cols * this.rows];
        for (int c = 0; c < this.cols; c++) {
            launch(c);
            head[c] = rnd.nextInt(Math.max(1, this.rows + len[c])) - len[c];
        }
        for (int i = 0; i < glyph.length; i++) glyph[i] = rnd.nextInt(glyphs);
    }

    /** A new drop for the column: it waits above the top (a negative head), with its own length and speed. */
    private void launch(int c) {
        int most = Math.max(1, Math.min(TRAIL_MAX, rows - 1));
        int least = Math.min(TRAIL_MIN, most);
        len[c] = least + rnd.nextInt(most - least + 1);
        period[c] = 1 + rnd.nextInt(PERIOD_MAX);
        count[c] = 0;
        head[c] = -rnd.nextInt(Math.max(1, rows / 2 + 1));
    }

    /** One beat: every head that is due goes down a row, a drop that has left the grid is replaced, a few glyphs change. */
    void step() {
        for (int c = 0; c < cols; c++) {
            if (++count[c] < period[c]) continue;
            count[c] = 0;
            head[c]++;
            if (head[c] - len[c] >= rows) launch(c);
        }
        int cells = cols * rows;
        for (int n = cells / 40 + 1; cells > 0 && n > 0; n--) glyph[rnd.nextInt(cells)] = rnd.nextInt(glyphs);
    }

    /** First row of the column that has something in it (0 or more); {@code first > last} when the drop is off the grid. */
    int first(int col) { return Math.max(0, head[col] - len[col]); }

    /** Last row of the column that has something in it (the head, cut to the grid). */
    int last(int col) { return Math.min(rows - 1, head[col]); }

    /** The glyph of a cell, an index from 0 to glyphs - 1. */
    int glyphAt(int col, int row) { return glyph[col * rows + row]; }

    /** 1 at the head, then less and less along the trail, 0 where there is nothing (above the trail, below the head). */
    float level(int col, int row) {
        int d = head[col] - row;
        if (d < 0 || d > len[col]) return 0f;
        if (d == 0) return 1f;
        return 1f - d / (float) (len[col] + 1);
    }
}
