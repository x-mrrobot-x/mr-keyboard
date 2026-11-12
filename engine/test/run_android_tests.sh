#!/bin/bash
# The engine tests on the ANDROID builds of the code, without a device: for each ABI the tests are built by the NDK as static
# executables and run on the PC, the x86 ones directly and the ARM ones under qemu-user. It is the same C++, the same compiler
# and the same options as libmrengine.so; what the PC tests cannot show is whether the ARM code (NEON, 32-bit sizes, the libm of
# Android) gives the same answers, and this does. It does NOT measure speed (an emulator is some 50 times slower than a phone) and
# does not replace a run on a device: for that, push the same executables with adb (see README.md, "On a phone").
#
# From the project root:
#   bash engine/test/run_android_tests.sh <NDK folder> [abi ...]        default: arm64-v8a armeabi-v7a x86_64 x86
# Needs cmake and, for the ARM ones, qemu-user (Debian/Ubuntu: apt install qemu-user-static; QEMU_DIR=<folder> if it is not on PATH).
# Variables: OUT (build folder, default /tmp/mr_android_tests); ROUNDS (corrupt files per language, default 10);
#            FULL=1 goes through every file of gestures three times, as on the PC (default: once, the "quick" mode of
#            mr_gesture_test); MR_TEST=N also runs mr_test with N rounds (the correction search; some minutes under qemu).
# Exits with 1 if a test fails or cannot run.
#
# Two details of static Android executables:
#   - they are built for android-30 (the libs are for android-26): before that a static arm64 executable is refused by its own
#     libc (TLS alignment). The code compiled is the same;
#   - the 32-bit libc refuses to start in a process whose id is above 65535, which happens on a PC that has been on for a long
#     time. The 32-bit tests are therefore started in a new process-id namespace when `unshare` allows it.
set -e
NDK=${1:?usage: bash engine/test/run_android_tests.sh <NDK folder> [abi ...]}
shift
ABIS=${*:-arm64-v8a armeabi-v7a x86_64 x86}
OUT=${OUT:-/tmp/mr_android_tests}
ROUNDS=${ROUNDS:-10}
MODE=quick; [ -n "$FULL" ] && MODE=full
test -f "$NDK/build/cmake/android.toolchain.cmake" || { echo "no NDK at $NDK" >&2; exit 1; }
test -f gesture/encoder.bin || { echo "run at the project root" >&2; exit 1; }
mkdir -p "$OUT"

find_qemu() {   # qemu-<arch>-static or qemu-<arch>, in QEMU_DIR or on PATH
  for n in "qemu-$1-static" "qemu-$1"; do
    if [ -n "$QEMU_DIR" ] && [ -x "$QEMU_DIR/$n" ]; then echo "$QEMU_DIR/$n"; return; fi
    if command -v "$n" > /dev/null 2>&1; then command -v "$n"; return; fi
  done
}

# A new process-id namespace for the 32-bit executables, if the system allows one (see the header).
NS=""
if unshare --user --map-root-user --pid --fork true > /dev/null 2>&1; then NS="unshare --user --map-root-user --pid --fork"; fi

FAILED=0
for abi in $ABIS; do
  RUN=""
  case $abi in
    arm64-v8a)   RUN=$(find_qemu aarch64); [ -n "$RUN" ] || { echo "== $abi: qemu-aarch64 not found" >&2; FAILED=1; continue; } ;;
    armeabi-v7a) RUN=$(find_qemu arm);     [ -n "$RUN" ] || { echo "== $abi: qemu-arm not found" >&2; FAILED=1; continue; }; RUN="$NS $RUN" ;;
    x86)         RUN="$NS" ;;
    x86_64)      ;;
    *) echo "unknown ABI: $abi" >&2; exit 1 ;;
  esac
  B="$OUT/$abi"
  cmake -S engine -B "$B" -DCMAKE_TOOLCHAIN_FILE="$NDK/build/cmake/android.toolchain.cmake" -DANDROID_ABI="$abi" \
        -DANDROID_PLATFORM=android-30 -DCMAKE_BUILD_TYPE=Release -DMR_ANDROID_TEST=ON > "$B.cmake.log" 2>&1 \
    || { echo "== $abi: cmake failed, see $B.cmake.log" >&2; FAILED=1; continue; }
  cmake --build "$B" -j4 >> "$B.cmake.log" 2>&1 || { echo "== $abi: build failed, see $B.cmake.log" >&2; FAILED=1; continue; }
  echo "== $abi: mr_gesture_test ($MODE, $ROUNDS corrupt files per language)${RUN:+ through $RUN}"
  ARGS="dicts gesture/encoder.bin gesture/test $ROUNDS"; [ "$MODE" = quick ] && ARGS="$ARGS quick"
  # shellcheck disable=SC2086
  if $RUN "$B/mr_gesture_test" $ARGS > "$B.gesture.log" 2>&1; then
    grep -E "official runtime|gestures \(|ALL OK" "$B.gesture.log"
  else
    echo "== $abi: mr_gesture_test FAILED" >&2; tail -20 "$B.gesture.log" >&2; FAILED=1
  fi
  if [ -n "$MR_TEST" ]; then
    echo "== $abi: mr_test ($MR_TEST rounds)"
    # shellcheck disable=SC2086
    if $RUN "$B/mr_test" dicts "$MR_TEST" > "$B.mr_test.log" 2>&1; then
      tail -1 "$B.mr_test.log"
    else
      echo "== $abi: mr_test FAILED" >&2; tail -20 "$B.mr_test.log" >&2; FAILED=1
    fi
  fi
done
exit $FAILED
