#!/bin/sh
# Generates the smali of the Mr Keyboard Java layer (MrText, MrFix, MrFuzzy, MrPredict, MrTrigram, MrRules, MrJson, MrPacks, MrPacksActivity, MrAi, MrAiDialog, MrAiPrefs, MrAiStyleActivity, MrUpdate, MrUpdateDialog, MrUpdateInstall, MrUpdateReceiver, MrUpdateSchedule, MrUpdateNotify, MrUpdateJob, MrUpdateRearm, MrUpdateUi, MrScreens, MrScreenIme, MrNav, MrKeep, MrBarClose, MrAccel, MrKit, MrLearned, MrImport, MrLearnedActivity, MrImportActivity, MrWordStore, MrMemStore, MrSqlStore) from
# docs/tools/java/src and copies it to smali/com/mrkeyboard/app/.
#
# Usage (at the root of the apktool project):
#   DX_JAR=/path/dx-27.0.3.jar APKTOOL_JAR=/path/apktool_2.11.1.jar sh docs/tools/build_java.sh
#
# Needs a JDK (javac with --release 8), dx (it comes with dex2jar 2.1, lib/dx-27.0.3.jar) and
# apktool. The stubs in java/stubs are only for compiling (signatures of the APK classes); they
# do not go into the dex. No lambdas or new APIs: the code must run on Android 8 (minSdk 26).
set -e
ROOT=$(pwd)
SRC="$ROOT/docs/tools/java"
OUT=$(mktemp -d)
: "${DX_JAR:?set DX_JAR}"
: "${APKTOOL_JAR:?set APKTOOL_JAR}"

mkdir -p "$OUT/stubs" "$OUT/classes"
javac -encoding UTF-8 -nowarn --release 8 -d "$OUT/stubs" $(find "$SRC/stubs" -name '*.java')
javac -encoding UTF-8 -Xlint:-options --release 8 -g:source,lines -cp "$OUT/stubs" -d "$OUT/classes" \
    $(find "$SRC/src" -name '*.java')
java -cp "$DX_JAR" com.android.dx.command.Main --dex --min-sdk-version=26 \
    --output="$OUT/classes.dex" "$OUT/classes"
(cd "$OUT" && zip -q mr.apk classes.dex)
java -jar "$APKTOOL_JAR" d -r -f "$OUT/mr.apk" -o "$OUT/dec" >/dev/null
cp "$OUT"/dec/smali/com/mrkeyboard/app/Mr*.smali "$ROOT/smali/com/mrkeyboard/app/"
ls "$OUT"/dec/smali/com/mrkeyboard/app/
rm -rf "$OUT"
