# Finger position (stage 6): code map, options and how they are measured

Status: closed. Measured (below) and the owner decided to leave the app as it is; no code change.

The question: the keyboard knows which key was touched and which keys were near, but not how near. A touch on the edge between `s` and `d` and a touch
in the middle of `s` reach the engine the same way. Does using the distance make the strip and the autocorrection better?

## What the app does today (read from the code)

| Step | Where | What happens |
|---|---|---|
| Touch | `PointerTracker.detectAndSendKey` | calls `KeyDetector.getKeyIndexAndNearbyCodes(x, y, codes)` and then `listener.onKey(code, codes, x, y)`; `x` and `y` are the touch point |
| Neighbours | `ProximityKeyDetector.getKeyIndexAndNearbyCodes` | fills `codes` with the touched key and the keys within 1.4 key widths (`LatinKeyboardBaseView`, the constant `1.4f` passed to `setProximityThreshold`), at most 12, **in order of distance**; `mDistances` stays inside the detector (it is only used to sort the array): the distances never leave it, only the order does |
| Typing | `LatinIME.onKey` -> `onKeyOrig(code, codes, x, y)` -> `handleCharacter(code, codes)` | `x` and `y` are used only to push the letter in the `RingCharBuffer`; `handleCharacter` does not receive them |
| Word | `WordComposer.add(code, codes)` | keeps the codes of each letter (`getCodesAt`), nothing about the position |
| Completion | `BinaryDictionary.getWords` (`libjni_pckeyboard.so`) | takes the codes of each letter |
| Correction | `MrFuzzy.afterWords` -> `MrNative.search` -> `Fuzzy::subCost` (`libmrengine.so`) | the neighbours of each touch go to the engine as they come; a substitution by the 1st neighbour costs `C_PROX_1` 25, by the 2nd `C_PROX_2` 30, by any other `C_PROX_FAR` 35, and by a key that is not a neighbour `C_SUB` |
| Autocorrect | `MrFuzzy.finish`, `sTouchNear` | uses the rank of the neighbour again (the 2nd option is a neighbour of the touch) |

So the **rank** of the neighbours already counts (since 1.66); what is lost is the **distance**: how much closer the 1st neighbour is than the 2nd, and how close the touch was to the
key that was hit.

## The options

**(a) Move the threshold.** Change the neighbour limit (`1.4f`, a constant in `LatinKeyboardBaseView.smali`) and, if the numbers ask for it, the three costs above. Nothing is carried to the engine; fewer neighbours
means less noise, more neighbours means more help. One constant in smali, no C++, no new native libs.

**(b) Reorder the candidates by the distance of the touch.** The offsets of each touch travel to the composer (`ProximityKeyDetector` or `PointerTracker` -> `onKeyOrig` -> `handleCharacter` -> a longer `WordComposer.add`)
and `MrFuzzy` (`afterWords`/`finish`) reorders the candidates that have as many letters as were typed by how likely the touches are for each of them, keeping the engine's order as the tie-breaker.
Touches: `LatinIME.smali`, `WordComposer.smali`, a Java class for the model (the Java layer is generated into `smali/`, `docs/tools/java/src`). No C++, so no new `native-libs.zip`.

**(c) The distance inside the engine.** `nSearch` receives a cost per neighbour instead of a rank, so the search itself finds the word the touches point to. It is the most precise and the most work:
a different signature of a native function, `kEngineVersion` 2, a new `native-libs.zip`, plus everything in (b) to carry the offsets. `TouchRescore` does not measure it; (b) is its proxy.

## How it is measured (`TouchRescore`)

`docs/tools/e2e/TouchRescore.java`, run by `bash docs/tools/e2e/run_touch_eval.sh` (the manual workflow `mr-eval.yml` runs it after the stage 5 evaluation; `TouchEval` runs there too, as the baseline of the app as it is).

Every word of `everyday_<lang>.txt` is typed 8 times with simulated touches: the point is drawn around the key centre with a normal dispersion (sigma in key widths: 0.15, 0.2 and 0.3), the touched key is the one that contains
the point, and the neighbours are the keys within the threshold in order of distance, exactly as `ProximityKeyDetector` does. The words go to the real engine (`Suggest.getSuggestions`, correction mode 3) and
the same list is then read in several ways:
- **engine order (today)**;
- **touch model, lambda L**: the candidates with as many letters as were typed are reordered, among the places they already hold, by `log-likelihood of the touches - L x position in the list` (a Gaussian around each key
  centre); L is in nats per list position: a large L is the engine's order, a small one is the touches alone;
- **touch model, lambda 1, sigma x0.7 / x1.5**: the same with a model that is wrong about the dispersion, which is the case on a phone (nobody tells the app the sigma of a person's thumb).

And the neighbour threshold takes 1.4 (today), 1.1 and 0.8 key widths, which is option (a).

Columns: for the words that came out with a touch error, **in strip** (the right word is among the 3 places, 0 being the typed one), **right fix** (what the autocorrection leaves after the space is the right word) and **swapped**
(it was swapped for another word); for the words with no touch error, **in strip** and **spoiled** (the autocorrection changed a word that was right). The last two must not get worse.

Limits to keep in mind:
- The simulated touches are as friendly as it gets: independent, centred on the key and with a known sigma. A real thumb has a bias that depends on the hand and the grip. The gains are therefore an upper bound, and
  the rows with the wrong sigma are the first to look at.
- Only substitutions are simulated (a touch that lands on another key). Letters missing or doubled have no distance to use.
- The candidates are the engine's: a word the engine did not find cannot be moved into the strip. (c) would also change that, and it is not measured.
- The lists carry no scores, so the engine's order enters as a penalty per position (lambda).
- Time on the runner is noisy; the model adds one pass over at most 12 candidates, so the cost on the phone is small, but the decision on latency is made on the phone.

## Running it

Actions -> "Mr Keyboard - evaluation (by hand)" -> Run workflow. The artifact `mr-eval-reports` then also has `touch_<lang>.txt` (TouchEval and TouchRescore of each language), besides what stage 5 writes.

## Results (run on the owner's runner, packs pt-BR 9, en-US 7, es 7)

Hit rates in percent, pt-BR / en-US / es, for the words that came out with a touch error. At sigma 0.2 about 8% of the words have one; at sigma 0.3, about half.

| | sigma 0.2, in strip | sigma 0.2, right fix | sigma 0.2, swapped | sigma 0.3, right fix | sigma 0.3, swapped |
|---|---|---|---|---|---|
| engine order (today) | 98.7 / 99.0 / 99.4 | 94.0 / 91.5 / 93.0 | 1.7 / 2.4 / 2.5 | 85.0 / 82.4 / 85.8 | 5.8 / 5.9 / 4.6 |
| touch model, lambda 4 (best) | 98.9 / 99.4 / 99.4 | 94.2 / 92.1 / 93.1 | 1.6 / 1.8 / 2.3 | 85.5 / 83.1 / 86.2 | 5.2 / 5.2 / 4.2 |
| touch model, lambda 1 | 98.4 / 99.7 / 99.2 | 92.6 / 91.8 / 92.5 | 3.2 / 2.1 / 3.0 | 83.9 / 82.1 / 85.5 | 6.8 / 6.2 / 4.9 |
| touch model, lambda 0.5 | 98.3 / 99.6 / 99.1 | 92.1 / 91.3 / 91.9 | 3.6 / 2.5 / 3.6 | 83.0 / 81.5 / 84.9 | 7.7 / 6.8 / 5.5 |

- Re-ordering by the distance of the finger gains at most 0.1 to 0.6 points of right fix at sigma 0.2 and 0.4 to 0.7 at sigma 0.3, and only with the engine's order weighing the most (lambda 4). The more weight the
  touches get, the worse it is (up to 1.9 points lost at lambda 0.5). With a model that is wrong about the dispersion the result is the same or worse (sigma x0.7 at lambda 1: 2.0, 0.2 and 1.3 points lost at sigma 0.2).
- The words that were typed right (no touch error) are not affected in any row: the words spoiled by autocorrection are 0.22 to 0.24% in pt-BR and 0.00% in en-US and es in every row.
- The neighbour threshold: 1.1 key widths is the same as 1.4 at sigma 0.15 and 0.2 in the three languages, and loses 4.7 / 3.5 / 3.7 points of right fix at sigma 0.3. 0.8 loses 11.4 / 11.4 / 11.0 points at sigma 0.2
  (strip 88.8 / 86.5 / 87.9) and 29 to 31 points at sigma 0.3. Nothing below 1.4 is better; thresholds above 1.4 were not measured.
- Headroom: at sigma 0.2 the right word is already in the strip in 98.7 to 99.4% of the words with a touch error, and the right fix is 91.5 to 94.0%. Even a perfect use of the finger position could not move more than
  about 6 to 8.5 points of those 8% of words, which is 0.5 to 0.7% of all the words typed; the measurement above shows a tenth of that at best.

Reading: the order of the neighbours and the dictionary already carry nearly all that the distance would say, and weighing the distance more than that overrides the dictionary. Options (b) and (c) are not worth the smali
(b) or the C++, the new libs and the engine contract (c); (a) should stay as it is. What the simulation does not cover: a bias of the person's thumb (always a bit below or to the side of the key centre), which a model could
learn per person; that would be a different feature (adaptive key centres), not in the plan.
