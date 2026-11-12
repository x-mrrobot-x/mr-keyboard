# Emoji search and delete (since 1.97.0)

The emoji panel has a floating bar at the bottom with two buttons: **search** and **delete**. This file is the living description of
the feature: what exists, how it works, where the words come from and what is left. Update it in the same commit that changes any of that.

## What the person sees

- **Delete** does what the Backspace key of the keyboard does, in the field of the app: the same feedback (vibration and sound of the key),
  one delete on the press and the repeat while the finger stays down (400 ms to start, then every 50 ms, as the key does).
- **Search** replaces the toolbar row by a header like the one of the Gboard emoji search: a back arrow and the title, a card with the
  results in two rows (one row in landscape) that scrolls sideways, and the search field with a magnifier. The keyboard stays under it and
  types in that field. The colours are the ones of the theme (the same roles the other panels use) and the texts follow the app language.
- With the field empty the card shows the recent emojis of the panel. Each key typed searches again. A tap on a result writes the emoji in
  the app (not in the search field), puts it in the recents of the panel, and **the search stays open**. **Back** goes back to the emoji
  panel and the toolbar row gets its height back.

## How it is built

- The search is a panel mode of its own, **7** (`MrEmojiSearch.MODE`), next to the others of `MrTools.showPanel` (0 keyboard, 1 clipboard,
  2 translator, 3 attachments, 4 emojis, 6 fonts), built like the Fonts tool. Four calls in `MrTools.smali` are all it needs:
  `MrEmojiSearch.setup(root)` when the keyboard view is made, `onPanel(mode)` at the start of `showPanel` and `afterPanel(mode)` at its end, and
  `setup(null)` in `MrTools.release` (the service is destroyed: the search lets go of its views, its context and the repeat of the delete button, as the other tools do).
  Everything else is in `docs/tools/java/src/com/mrkeyboard/app/MrEmojiSearch.java`, `MrEmojiIndex.java` and `MrEmojiNew.java` (the smali of the three comes from
  `docs/tools/build_java.sh`, as for the rest of the Java layer).
- Typing goes to the field of the header through the redirect the translator already used (`MrTools.sRedirect`, and `MrTools.sField` for the keys
  that are events). While the search is open `MrTools.sRedirect` is that field; when it closes the word typed there is committed
  (`LatinIME.mrCommit`) and the redirect and the field go back as they were. A tap on a result bypasses the redirect
  (`LatinIME.getAppInputConnection`).
- **Height.** The toolbar row has a fixed height (`mr_bar_height` times the bar-size setting, `MrBar`). The header needs more room, so `MrBar` got
  two calls any panel can use: `MrBar.expand(bar, px)` makes a bar taller (it remembers the height it had) and `MrBar.restore(bar)` gives it
  back; while a bar is expanded the bar-size setting does not touch it. The search header asks for `mr_es_height` (195 dp, 138 dp in landscape)
  on opening and restores on leaving, so the next panel or tool that needs more room only has to do the same two calls.
- **Look.** The card with the results and the field has 16 dp corners (`MrTools.radius(8)`; the cards of the other panels have 10 dp): `MrEmojiSearch`
  takes `MrTools.cardBg()` (same colour, flat themes included) and only changes its radius. The header has room around it: `mr_es_pad_top`
  (8 dp, 4 dp in landscape) above the title, `mr_es_pad_bottom` (8 dp, 5 dp) below the card, 6 dp at the sides and 4 dp between the title and the card;
  `mr_es_height` grew by what these added, so the card keeps its size.
- **Entrance.** When the search opens the header comes in growing upward from its bottom edge (`scaleY` from 0.6 to 1, pivot at the bottom) while it
  fades in (`alpha` 0 to 1), `ENTER_MS` = 240 ms, with `ViewPropertyAnimator`. The window is already as tall as it will be (`MrBar.expand` is
  one step), so only the drawing moves: the keyboard is not resized on every frame, which would make the app below it lay out again 15 times. On
  leaving, the animation is cancelled and the header put back opaque and full size for the next time. With the animations of the system off, it ends at once.
- **An error here never takes the keyboard down.** `setup` runs while the keyboard is made and `onPanel` runs every time a field is bound
  (`MrTools.reset` goes through `showPanel(0)`); both catch what the search throws, give the keyboard back as it was (redirect and field of the
  translator, header closed, height restored) and forget the search, so the keyboard works without it.
- `p_emote` (the emoji panel) became a `FrameLayout`: the list fills it (with a bottom padding so the last row is not under the bar) and
  the bar `emote_fab` floats over it.

## The words

- **Source:** the annotations of the Unicode CLDR, release 49 (`common/annotations/{en,pt,es}.xml` and `common/annotationsDerived/{en,pt,es}.xml`):
  for each emoji a name and keywords in each language. The derived files carry the ones the main files do not (flags, keycaps, sequences).
- **Only emojis.** The CLDR annotation files also describe plain characters (brackets, punctuation, arrows, geometric shapes...). They are
  left out: `docs/tools/make_emoji_search.py` writes only the **1,803 emojis of the panel** (1,633 of the base list and 170 newer ones), in the panel
  order, and every one of them has words in the three languages. Typing a bracket or any other punctuation finds nothing.
- **Files:** `res/raw/mr_emoji_en.txt`, `mr_emoji_pt.txt`, `mr_emoji_es.txt` (UTF-8, about 330 KB in all before the APK compresses them). One
  line per emoji: `emoji TAB name | keyword | keyword ...`. Lines that start with "# " are comments (the keycap of the number sign is a line
  that starts with a hash).
- **To update** (a new CLDR release, or emojis added to the panel): get the six files, then at the project root
  `python3 docs/tools/make_emoji_search.py <folder-or-zip> --cldr <release>` and commit `res/raw/` (and `docs/LICENSE-Unicode-CLDR.txt` if the
  source has a `UNICODE_LICENSE.txt`). It exits with an error when more than 3% of the panel has no words.
- **Panel and CLDR.** The base list of the panel (`MrEmotes.dataBase`, hand-written smali) stops at Emoji 13. The CLDR has more, so the newer emojis
  have their own table, `MrEmojiNew.java` (see below), and the words are written for the base list and the table together. The panel still
  has no skin tones, no man/woman versions of the activities ("man running"), no "facing right" ones and no hair components (red hair,
  curly hair, bald, white hair as stand-alone emojis): the base list never had them and they would add about 120 more.

## The newer emojis

- **What:** 170 emojis from Emoji 14 to 17, from the CLDR: the melting face and the other new faces, the pink, light blue and grey hearts, heart on
  fire and mending heart, the new hands, the person with a crown, the pregnant man, animals (moose, donkey, jellyfish, goose, black bird, phoenix,
  polar bear...), food (beans, ginger, pea pod, jar, lime, brown mushroom), objects, symbols (wireless, heavy equals sign), the flags of England,
  Scotland, Wales and Sark, the person versions of the professions, the hair, mobility and family combinations and the kisses.
- **Where:** `docs/tools/java/src/com/mrkeyboard/app/MrEmojiNew.java`, a table by category (the same eight as `MrEmotes`: smileys and people,
  animals, food, activities, travel, objects, symbols, flags). Each group is `anchor|new|new...`: the new emojis go right after the anchor, an
  emoji of the base list of that category; if the anchor is not there (the base list changed) they go to the end of the category, so none is
  lost. An emoji already in the base list is not added twice. **To add an emoji, add it to the table**, then run `make_emoji_search.py` so it
  gets words (the converter reads the table, and `check_emoji_search.py` fails if an emoji of the table has none).
- **How it gets into the panel:** `MrEmotes.data(I)` is now a small wrapper in the smali: it takes the base list from `dataBase(I)` and returns
  `MrEmojiNew.merge(cat, base)`. The result is kept per category, so the merge runs once.
- **What the phone cannot draw is left out.** `merge` asks `Paint.hasGlyph(emoji)` for each new emoji (API 23, the minimum here is 26; it also
  reads sequences, such as the joined ones) and skips the ones the font of the phone has no single glyph for, so an older Android does not
  show empty boxes and a newer one shows them all. The answers are kept (once per emoji, for the process). The search asks the same
  (`MrEmojiNew.filter`) so it never offers an emoji the panel would not show.
- **The U+FE0F rule.** The panel writes U+FE0F after the characters that are text by default (the heart, the female and male signs, the
  white flag...). The new emojis follow it (heart on fire, the transgender flag, the health worker); `check_emoji_search.py` checks it against
  the base list.
- **Not checked on a phone:** that `hasGlyph` answers true for the joined emojis and for the England, Scotland and Wales flags (tag
  sequences) on the Android versions that can draw them, and false on the ones that cannot. The PC tests use a stub for it.

## How it matches

`MrEmojiIndex` (no Android classes, tested on the PC).

- The text typed is lower-cased, loses accents and marks (so "nino" finds "niño" and "coracao" finds "coração") and is cut into words (at most 5).
- An emoji matches when **every** word typed begins one of its words, in **any** of the three languages at once: "heart", "coração" and
  "corazón" find the same emoji whatever the app language.
- Score of a word: whole word 6, beginning of a word 3, +2 when it is a word of the name (not a keyword), +1 when it is the first word of the name;
  +1 for a word found in the language of the app (it wins a tie). Same score: the order of the panel. At most 60 results.
- **Cost.** The words are read when the search opens, in a background thread, and dropped when the emoji panel is left, so the keyboard carries
  nothing for them the rest of the time. Each language is kept as one `char[]` with all its words plus `int[]` offsets (no object per word):
  about 220 KB while the emoji panel is in use. A search takes about 0.4 ms on a PC.

## Tests

- `docs/tools/emoji_search_test/EmojiSearchTest.java` (in `run_java_tests.sh`): normalisation, matching in three languages, ranking and ties, limits,
  a missing language file, the keycap #, `MrBar.expand/restore`, and the real files in `res/raw` (known words, only emojis, speed).
- `docs/tools/emoji_search_test/EmojiPanelTest.java` (in `run_java_tests.sh`): the state of the panel with fake views: open, back, the other panels,
  redirect and field, height given and taken back, the entrance (alpha, scale, pivot, duration, cancelled on leaving), an error in setup or in opening (nothing escapes, the keyboard is given back), the service destroyed with the delete button held, the delete button (press, repeat, release, cancel), a tap writing in the app only, words loaded
  late or dropped, a keyboard view made again with the search open.
- `docs/tools/emoji_search_test/EmojiNewTest.java` (in `run_java_tests.sh`): the table (one group per anchor, no emoji twice), the merge (after the anchor,
  at the end when the anchor is missing, never twice), a phone whose font lacks some of them (left out of the list and of the results, the
  answers kept), and words in the three languages for every emoji of the table.
- `docs/tools/emoji_search_test/test_make_emoji_search.py`: the converter with made-up CLDR files and a made-up table of newer emojis.
- `docs/tools/check_emoji_search.py` (in `mr-checks.yml`): layout tags, the texts in the three languages, the hooks (four calls), the table of newer
  emojis (anchors, duplicates, the U+FE0F rule, the call in `MrEmotes.smali`), and that the three files list the emojis of the panel (base list
  and newer ones) in its order.

## To try on a phone before a release

Nothing of this has run on a device yet (only on the PC, with fake views).

1. Open the emoji panel: the floating bar shows over the list with two buttons. It is opaque, in a neutral colour of the theme (`MrTools.floatBg`: the face of a letter key, role `panel_btn`, with the border of the fields, role `panel_field_stroke`, and fully round corners); the icons take the colour of the key labels (`MrTools.sKeyText`) and a tap lights a round fill (`MrTools.flatPill`). The two icons (`ic_mr_search`, `ic_mr_backspace`) fill the same box (about 15.8 x 15.8 dp of glyph in the 20 dp icon, viewport 2.5 to 21.5) with the same stroke (2.0): keep that when one of them is redrawn. Try a light, a dark and a neon theme: the bar must not be louder than the keys and the icons must read on it.
2. Write some text in an app, open the emoji panel and press **delete**: it deletes like Backspace; holding it repeats; with a selection it deletes the selection.
3. Press **search**: the header replaces the toolbar row, the keyboard types in its field, the card shows the recent emojis. The header comes in growing
   upward and fading in (no sudden flash), the card has rounder corners and the header is not stuck to the top edge or to the keys.
4. Type "coração", "heart", "corazón", "gato", "cat", "bandeira brasil": results appear as you type; accents do not matter.
5. Tap a result: it is written in the app, the search stays open; tap another one.
6. Press **Back**: the emoji panel is there, the toolbar row is the size it was (also with the bar size changed in the settings).
7. Rotate the phone with the search open; leave the app with it open; open the clipboard from another panel after using it.
8. Change the app language (Portuguese, English, Spanish): the title, the hint and the "no emojis found" text follow it.
9. Scroll the emoji panel: the newer emojis are there (the melting face after the upside-down face, the pink heart after the red one, the flags of
   England, Scotland and Wales at the end) and none shows as an empty box. On an older Android the ones it cannot draw must be missing, not boxes.
10. Search "derretendo", "melting", "rosa", "phoenix": the newer emojis are found. Search a bracket: nothing.

## Licence of the words

The names and keywords come from Unicode CLDR data, Copyright © 1991-2026 Unicode, Inc., distributed under the **Unicode License v3**
(SPDX `Unicode-3.0`, <https://www.unicode.org/copyright.html>). The full text is in `docs/LICENSE-Unicode-CLDR.txt`, and every
`res/raw/mr_emoji_*.txt` says where its words come from. The licence asks that its copyright and permission notice go with the data, which is what
this section and that file are for. Unicode and the CLDR project are not affiliated with Mr Keyboard.
