# Mr Keyboard - libmrengine (native engine, step 1). CMake project in engine/ (the dictionary reader is native/).
#
# Android (NDK, one folder per ABI; the workflow .github/workflows/mr-native.yml does this):
#   cmake -S engine -B build/arm64-v8a -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
#         -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=android-26 -DCMAKE_BUILD_TYPE=Release
#   cmake --build build/arm64-v8a
# PC (test with the same code, from the project root):
#   cmake -S engine -B build/engine -DCMAKE_BUILD_TYPE=Release -DMR_HOST_TEST=ON && cmake --build build/engine
#   ./build/engine/mr_test dicts 100
# With sanitizers: -DMR_SANITIZE=ON (ASan + UBSan)
# WARNING: the text of this file goes into the mrengine-src.sha256 hash (computed from inside engine/). Changed anything here, even
# just a comment? The libs in lib/ must be built again (see docs/native-engine.md).
cmake_minimum_required(VERSION 3.18)
project(mr_engine CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
option(MR_HOST_TEST "Also build mr_test and mr_bench (PC only)" OFF)
option(MR_SANITIZE "ASan + UBSan (PC only)" OFF)

set(MR_CORE src/mr_fuzzy.cpp src/mr_tri.cpp)

# Common options. -funsigned-char only to match the rest of the app: the code does not depend on char being signed.
set(MR_FLAGS -O2 -Wall -Wextra -Wno-unused-parameter -funsigned-char -fvisibility=hidden)

add_library(mrengine_core STATIC ${MR_CORE})
target_include_directories(mrengine_core PUBLIC src)
target_compile_options(mrengine_core PRIVATE ${MR_FLAGS})
set_target_properties(mrengine_core PROPERTIES POSITION_INDEPENDENT_CODE ON)

add_library(mrengine SHARED src/mr_jni.cpp)
target_link_libraries(mrengine PRIVATE mrengine_core)
target_compile_options(mrengine PRIVATE ${MR_FLAGS})

if(ANDROID)
  # 16 KB pages (Android 15+) and build-id, like the dictionary lib; no debug symbols.
  # --gc-sections and --exclude-libs reduce the size; only JNI_OnLoad stays exported.
  target_link_options(mrengine PRIVATE -Wl,-z,max-page-size=16384 -Wl,--build-id=sha1 -Wl,--gc-sections
                      -Wl,--exclude-libs,ALL -s)
else()
  find_package(JNI REQUIRED)
  target_include_directories(mrengine PRIVATE ${JNI_INCLUDE_DIRS})
endif()

if(MR_SANITIZE AND NOT ANDROID)
  foreach(t mrengine_core mrengine)
    target_compile_options(${t} PRIVATE -fsanitize=address,undefined -fno-omit-frame-pointer -fno-sanitize-recover=undefined)
    target_link_options(${t} PRIVATE -fsanitize=address,undefined)
  endforeach()
endif()

if(MR_HOST_TEST AND NOT ANDROID)
  add_executable(mr_test test/mr_test.cpp)
  target_link_libraries(mr_test PRIVATE mrengine_core)
  add_executable(mr_bench test/mr_bench.cpp)
  target_link_libraries(mr_bench PRIVATE mrengine_core)
  foreach(t mr_test mr_bench)
    target_compile_options(${t} PRIVATE -O2 -Wall -Wextra -funsigned-char)
    if(MR_SANITIZE)
      target_compile_options(${t} PRIVATE -fsanitize=address,undefined -fno-omit-frame-pointer -fno-sanitize-recover=undefined)
      target_link_options(${t} PRIVATE -fsanitize=address,undefined)
    endif()
  endforeach()
endif()
