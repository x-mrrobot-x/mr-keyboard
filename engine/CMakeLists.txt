# Mr Keyboard - libmrengine (motor nativo, etapa 1). Projeto de CMake em engine/ (o leitor do dicionário é native/).
#
# Android (NDK, uma pasta por ABI; o workflow .github/workflows/mr-native.yml faz isto):
#   cmake -S engine -B build/arm64-v8a -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
#         -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=android-26 -DCMAKE_BUILD_TYPE=Release
#   cmake --build build/arm64-v8a
# PC (teste com o mesmo código, na raiz do projeto):
#   cmake -S engine -B build/engine -DCMAKE_BUILD_TYPE=Release -DMR_HOST_TEST=ON && cmake --build build/engine
#   ./build/engine/mr_test dicts 100
# Com sanitizers: -DMR_SANITIZE=ON (ASan + UBSan)
# ATENÇÃO: o texto deste arquivo entra no hash mrengine-src.sha256 (a conta é feita de dentro de engine/). Mudou aqui, mesmo
# que só um comentário? As libs de lib/ precisam ser geradas de novo (veja docs/native-engine.md).
cmake_minimum_required(VERSION 3.18)
project(mr_engine CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
option(MR_HOST_TEST "Compila também mr_test e mr_bench (só no PC)" OFF)
option(MR_SANITIZE "ASan + UBSan (só no PC)" OFF)

set(MR_CORE src/mr_fuzzy.cpp src/mr_tri.cpp)

# Opções comuns. -funsigned-char só para ficar igual ao resto do app: o código não depende de char ter sinal.
set(MR_FLAGS -O2 -Wall -Wextra -Wno-unused-parameter -funsigned-char -fvisibility=hidden)

add_library(mrengine_core STATIC ${MR_CORE})
target_include_directories(mrengine_core PUBLIC src)
target_compile_options(mrengine_core PRIVATE ${MR_FLAGS})
set_target_properties(mrengine_core PROPERTIES POSITION_INDEPENDENT_CODE ON)

add_library(mrengine SHARED src/mr_jni.cpp)
target_link_libraries(mrengine PRIVATE mrengine_core)
target_compile_options(mrengine PRIVATE ${MR_FLAGS})

if(ANDROID)
  # Páginas de 16 KB (Android 15+) e build-id, como a lib do dicionário; sem símbolos de depuração.
  # --gc-sections e --exclude-libs reduzem o tamanho; só JNI_OnLoad fica exportado.
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
