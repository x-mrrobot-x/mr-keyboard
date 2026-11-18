# Words and phrases for one app

"Add words and texts" can add words for **every app** (as always) or for **one app**: the words then show up in the suggestions only when the person types in that app (a bank's name only in the bank app, a team's slang only in the chat app).

## What the person sees

- **Add words and texts** (`MrImportActivity`): under the language card there is a second card, **Add for**: *All apps* or the name and icon of one app. Tapping it opens a dialog (`MrAppPicker`): first row *All apps*, then the apps of the phone with their icon and name, a search field (from 9 apps on). The apps come 30 at a time: when you scroll to 75 dp before the last card the next 30 are added at the end (no *Show more* button). After *Add*, the *Add for* card goes back to *All apps*, as the text box goes back to empty. A note under the card says what the choice means ("The words work in every app." / "The words only show up in suggestions when you type in WhatsApp."). The preview, the save, the report and *Undo the last addition* are the same ones; the report and the question of the undo name the app.
- **What the keyboard learned** (`MrLearnedActivity`): on the **Added** tab, when some app has words in the language, a card **Words of** appears under the tabs: *All apps* (the words that work everywhere) or one of the apps that have words (the dialog lists only those, each with how many). With an app on, the list, the count of the tab, *Forget all*, *Fix*, *Forget* and *Export a copy* are the ones of that app (the file is named `mr-keyboard-words-<language>-<package>.txt` and has a `# app:` comment line; importing it again for the same app gives the same text, so it is also the backup). *Block this word* is not offered there: blocking is a decision for every app. The *Add* button opens "Add words and texts" with that app chosen. Changing the language keeps the app only if it has words in the new language. The Learned and Blocked tabs have no such card: what the keyboard learned and what was blocked are for every app.
- The apps offered are the ones with an icon on the launcher that are **not part of the system**: an app that came with the phone is left out, except one that was updated from a store (Chrome, Gmail and Google Messages are system apps that the person keeps updated and types in). The manifest asks for the launcher apps in `<queries>` (Android 11+ hides the others); `QUERY_ALL_PACKAGES` is not used.

## How it is stored

No new table. The words and pairs are the same rows as the added ones (`KIND_IMPORTED_WORD` / `KIND_IMPORTED_PAIR` of `mr_words.db`), and the column that holds the language holds `language|package` (`MrApp.scope`: `pt_BR|com.whatsapp`). Neither a language id nor a package name has a bar, so one `LIKE '%|%'` tells them apart: `MrWordStore.locales()` lists the languages without the apps, `scopes()` lists the keys of the apps. Batches, undo, forget, edit, export and the 'dups' rule work on a key exactly as they do on a language. Caps are per app and language: **5,000 words and 10,000 pairs** (`MrApp.MAX_WORDS/MAX_PAIRS`; the whole list is in memory while the app is in front); the ones of every app keep 20,000 / 30,000. Blocked words are the ones of the language: a blocked word is not added for an app, and a `[blocked]` section of a list is ignored when the list is added for an app.

## What the keyboard does

All of it is in `MrApp` (plus three small hooks in smali: `LatinIME.onStartInput`, `AutoDictionary.getWords/isValidWord`, `UserBigramDictionary.getBigrams`).

1. **A field opens** (`LatinIME.onStartInput` → `MrApp.onInput(ctx, editorInfo)`, `EditorInfo.packageName`). Same app as the last field: one string comparison, nothing else. Another app: the tree of the last app is let go **at once** (its words never show up in the new app, not even while the new tree is made) and, if the new app has words, a thread makes its tree.
2. **The tree** is one `ExpandableDictionary` (the same class and the same search as the learned words; kind 3) with the added words of the app and language and the pairs (`setBigram`), without the blocked words. It is made by one worker thread of minimum priority, and **published in one step** through a `volatile` field: the typing thread reads the whole tree or none, and never waits. A request that arrives while the worker is busy is answered when it ends, from the state of that moment (a generation counter; an old answer is never published).
3. **Kept while the person is away.** Leaving the app does nothing: the context stays until a field opens in **another** app, which replaces it (also when the keyboard did not open in between, e.g. the person goes to another app and comes back). A field with no package changes nothing.
4. **No weight.** Which apps have words at all is read once per process (and again after a change): while no app has any, a field in another app costs a comparison and a set lookup, with no thread, no query and no tree. An app without words has no tree (null, not an empty one). Only the application `Context` is kept (nothing of an activity or a service). The list of apps of the dialog is kept in a small local database (see "The list of apps and its cache" below); icons are loaded one at a time for the rows on screen (a new drawing of the list, e.g. a search typed, stops the old thread) and not kept.
5. **When it is asked.** After its own words, `AutoDictionary.getWords` asks the tree for completions and corrections (`MrApp.words`, through the same gate of frequency 6); `isValidWord` accepts a word of the tree (so it is not corrected away); `UserBigramDictionary.getBigrams` adds the words that follow the previous one; gesture typing copies the tree with the other words of the person (`MrGestureWords` reads `MrApp.dictionary()`; the copy is made again when the tree is swapped).
6. **When it is made again**: the language or the keyboard reloads its dictionaries (`MrLearned.load` → `MrApp.onLoad`; this also covers a change of the blocked words) and any change of the added words (`MrLearned.changed` → `MrApp.dataChanged`). A store that fails costs only the words of the app: nothing is thrown and the next field reads again.

## The list of apps and its cache

`MrAppCache` (database `mr_apps.db`, `MrAppCacheDb`: package, name and place of the files of each app, plus the signature and the language of the names) makes the dialog open at once. Off the main thread:

1. what was kept is shown right away (nothing is asked of the system);
2. the **fast pass** (`MrAppList.scan`) asks only for the packages with a launcher icon, without the system apps, and makes a **signature**: the SHA-1 of the sorted packages with the place of their files (it changes when an app is installed, removed or updated);
3. same signature and same language of the phone: that is all, no name is asked and nothing is written;
4. otherwise the **slow pass** asks for the names, only of the apps that are new or were updated (the others keep the kept name, unless the language of the phone changed), keeps the result and sends it to the open dialog, which adds and removes the rows that changed (the search text and the page reached stay);
5. with nothing kept, the slow pass runs at once and the result is kept. If the phone cannot answer, what was kept stays as it is (a failure is not "no apps").

No icon and no other data is kept. The dialog of "What the keyboard learned" (only the apps that have words) has few apps and keeps asking the system directly.

## Next page by scrolling

The same rule is used in the three lists that used to have *Show more*: the apps of the dialog (30 at a time), the words of "What the keyboard learned" (50) and the words of the preview of "Add words and texts" (100). `MrKit.onScroll` listens to the page and `MrKit.nearEnd` tells when the bottom of the screen is at most `MrKit.NEAR_END_DP` (75) dp before the last card; then the next page is added (the dialog of apps and the preview add rows at the end, nothing is redrawn). A page that does not fill the screen asks for the next one by itself.

The page that holds these lists is an `MrPage` (a `ScrollView`) and the new cards are added inside `MrPage.keepPosition`: for 400 ms the page does not scroll to a child that asks to be shown (a search field that still has the focus, even with its text cleared, pulled the page up each time the layout changed), and if the layout took the page up anyway, the position is put back at once and after the next layout (only once, and never down). So the page stays where the person is while the next 30 cards come, with or without a search before.

## Tests

`AppWordsTest` (the key, the caps, undo, forget, edit, export, blocked words, the tree: off the main thread, kept while away, replaced by the next app, no cost without words, last request wins, failing store, no context), `AppScreensTest` (the list of apps with a fake phone: system apps, updated apps, search without accents; the cache: fast pass, signature, kept list first, only new names asked, removed/updated apps, language change, failing phone; the dialog and its paging by scroll, the page that keeps its place (MrPage), updates while open; the list of learned words paging; the card going back to All apps; both screens driven through the stubs; the texts in three languages; the manifest; the hooks in smali) — both run by `docs/tools/run_java_tests.sh`; `res_check.py` checks the texts, the manifest query and the hooks.

On the phone (both modes, *Autocompletar* on and off; Settings → Suggestions and dictionaries → My words → Add words and texts):
1. Add words for app X (e.g. `zapzapx`) → open a field in X and type `zapz`: the word is suggested; in app Y it is not.
2. Add words for All apps (e.g. `todosx`): suggested in X and in Y.
3. In X, go to the home screen and back without opening another field: still suggested. Open a field in Y, then back in X: suggested again.
4. My words → Added → Words of → X: list, count, forget one, forget all, export; *Undo the last addition* after adding for X only takes back those words.
