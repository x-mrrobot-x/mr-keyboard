# Mr Keyboard - libjni_pckeyboard (native dictionary, based on Hacker's Keyboard / LatinIME, Apache-2.0)
#
# Android (NDK):
#   cmake -S native -B build/arm64-v8a -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
#         -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=android-26 -DCMAKE_BUILD_TYPE=Release
#   cmake --build build/arm64-v8a
# PC (test with the same code, unsigned char as on ARM):
#   cmake -S native -B build/host -DCMAKE_BUILD_TYPE=Release -DMR_HOST_TEST=ON && cmake --build build/host
cmake_minimum_required(VERSION 3.18)
project(mr_keyboard_native CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
option(MR_HOST_TEST "Also build the dict_test test (PC only)" OFF)

set(MR_SOURCES src/dictionary.cpp src/char_utils.cpp)

add_library(jni_pckeyboard SHARED src/mr_binary_dictionary_jni.cpp ${MR_SOURCES})
# unsigned char on every architecture (on x86 the default is signed)
target_compile_options(jni_pckeyboard PRIVATE -O2 -funsigned-char -Wno-unused-variable -Wno-writable-strings)

if(ANDROID)
  find_library(log-lib log)
  target_link_libraries(jni_pckeyboard ${log-lib})
  # 16 KB pages (Android 15+) and build-id; NDK r27 still aligns to 4 KB by default
  target_link_options(jni_pckeyboard PRIVATE -Wl,-z,max-page-size=16384 -Wl,--build-id=sha1 -s)
else()
  find_package(JNI REQUIRED)
  target_include_directories(jni_pckeyboard PRIVATE ${JNI_INCLUDE_DIRS})
endif()

if(MR_HOST_TEST AND NOT ANDROID)
  add_executable(dict_test test/dict_test.cpp ${MR_SOURCES})
  target_include_directories(dict_test PRIVATE src)
  target_compile_options(dict_test PRIVATE -O2 -funsigned-char -Wno-unused-variable -Wno-writable-strings)
endif()
