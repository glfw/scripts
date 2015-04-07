#!/bin/sh

mkdir -p lib-mingw/x86
mkdir -p lib-mingw/x64

mkdir -p build-mingw-x86
pushd    build-mingw-x86

cmake -DCMAKE_TOOLCHAIN_FILE=../../glfw/CMake/i686-pc-mingw32.cmake -DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO -DBUILD_SHARED_LIBS=NO ../../glfw
make
cmake -DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO -DBUILD_SHARED_LIBS=YES ../../glfw
make

popd

cp build-mingw-x86/src/libglfw3.a lib-mingw/x86
cp build-mingw-x86/src/glfw3dll.a lib-mingw/x86
cp build-mingw-x86/src/glfw3.dll  lib-mingw/x86

mkdir -p build-mingw-x64
pushd    build-mingw-x64

cmake -DCMAKE_TOOLCHAIN_FILE=../../glfw/CMake/x86_64-w64-mingw32.cmake -DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO -DBUILD_SHARED_LIBS=NO ../../glfw
make
cmake -DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO -DBUILD_SHARED_LIBS=YES ../../glfw
make

popd

cp build-mingw-x64/src/libglfw3.a lib-mingw/x64
cp build-mingw-x64/src/glfw3dll.a lib-mingw/x64
cp build-mingw-x64/src/glfw3.dll  lib-mingw/x64

cmd /c build.bat

