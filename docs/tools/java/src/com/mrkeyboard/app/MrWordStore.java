package com.mrkeyboard.app;

import java.util.List;

/**
 * v1.85: storage behind the screens "What the keyboard learned" and "Add words and texts" (MrLearned, MrLearnedActivity, MrImportActivity).
 * Five kinds of rows, all per locale ("pt_BR", "en_US", "es": the id of the pack with "_"):
 *  - KIND_LEARNED_WORD / KIND_LEARNED_PAIR: what the keyboard learned (auto_dict.db and userbigram_dict.db, the schema of the original keyboard,
 *    which this code only reads and deletes from);
 *  - KIND_IMPORTED_WORD / KIND_IMPORTED_PAIR: what the user added on purpose (mr_words.db), with the batch of the import (to undo it) and a weight of 1 to 100;
 *  - KIND_BLOCKED: words that are never suggested and never learned.
 * MrSqlStore is the SQLite implementation (on the phone); MrMemStore keeps everything in lists, so the rules (limits, undo, block, export) run in a PC test.
 */
interface MrWordStore {
    int KIND_LEARNED_WORD = 0;
    int KIND_LEARNED_PAIR = 1;
    int KIND_IMPORTED_WORD = 2;
    int KIND_IMPORTED_PAIR = 3;
    int KIND_BLOCKED = 4;

    /** Order of a list: the most used first, or the newest first (the highest id). */
    int SORT_USED = 0;
    int SORT_NEW = 1;

    /** One row. {@code a} is the word (or the first word of a pair), {@code b} the second word of a pair (null otherwise). */
    final class Row {
        long id;
        int kind;
        String a;
        String b;
        /** Learned rows: the frequency of the original keyboard. Imported rows: the weight, 1 to 100. */
        int freq;
        /** Imported rows: the import they came from. 0 otherwise. */
        long batch;
        /** Imported rows: when (ms). 0 for learned rows (the original schema has no date). */
        long added;

        Row() { }

        Row(int kind, String a, String b, int freq, long batch, long added) {
            this.kind = kind;
            this.a = a;
            this.b = b;
            this.freq = freq;
            this.batch = batch;
            this.added = added;
        }

        /** "word" or "word1 word2". */
        String text() {
            return b == null ? a : a + " " + b;
        }
    }

    int count(int kind, String locale);

    /**
     * A page of rows. {@code filter}: part of a word, accents and case ignored (null or empty = all); for a pair either word. {@code limit} rows from
     * {@code offset}. The rows have no "newest" order of their own: SORT_NEW is the highest id first.
     */
    List<Row> list(int kind, String locale, String filter, int sort, int offset, int limit);

    /** Every row of the kind and locale (export, loading into the dictionaries). */
    List<Row> all(int kind, String locale);

    /** Adds a row of any kind (a learned row only when editing one). Returns the id, or -1. */
    long add(int kind, String locale, Row row);

    boolean delete(int kind, long id);

    /** Deletes every row of the kind and locale. Returns how many. */
    int deleteAll(int kind, String locale);

    /** Deletes the imported words and pairs of an import. Returns how many rows. */
    int deleteBatch(String locale, long batch);

    /** A new number for an import (never used before). */
    long newBatch();

    /** The locales that have any row of any kind. */
    List<String> locales();

    /** Groups many changes in one transaction (a big import is one disk write, not thousands). Always followed by end(). */
    void begin();

    void end();
}
