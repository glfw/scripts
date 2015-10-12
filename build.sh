#!/bin/sh

OPTIONS='-DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO'
GLFWDIR='../../../glfw'

mkdir -p glfw-bin.WIN32/lib-mingw
mkdir -p glfw-bin.WIN32/lib-mingw-w64
mkdir -p glfw-bin.WIN64/lib-mingw-w64

mkdir -p build/mingw-x86
pushd    build/mingw-x86

cmake -DCMAKE_TOOLCHAIN_FILE=$GLFWDIR/CMake/i686-pc-mingw32.cmake $OPTIONS -DBUILD_SHARED_LIBS=NO $GLFWDIR
make
cmake $OPTIONS -DBUILD_SHARED_LIBS=YES $GLFWDIR
make

popd

cp build/mingw-x86/src/libglfw3.a glfw-bin.WIN32/lib-mingw
cp build/mingw-x86/src/glfw3dll.a glfw-bin.WIN32/lib-mingw
cp build/mingw-x86/src/glfw3.dll  glfw-bin.WIN32/lib-mingw

mkdir -p build/mingw-w64-x86
pushd    build/mingw-w64-x86

cmake -DCMAKE_TOOLCHAIN_FILE=$GLFWDIR/CMake/i686-w64-mingw32.cmake $OPTIONS -DBUILD_SHARED_LIBS=NO $GLFWDIR
make
cmake $OPTIONS -DBUILD_SHARED_LIBS=YES $GLFWDIR
make

popd

cp build/mingw-w64-x86/src/libglfw3.a glfw-bin.WIN32/lib-mingw-w64
cp build/mingw-w64-x86/src/glfw3dll.a glfw-bin.WIN32/lib-mingw-w64
cp build/mingw-w64-x86/src/glfw3.dll  glfw-bin.WIN32/lib-mingw-w64


mkdir -p build/mingw-w64-x64
pushd    build/mingw-w64-x64

cmake -DCMAKE_TOOLCHAIN_FILE=$GLFWDIR/CMake/x86_64-w64-mingw32.cmake $OPTIONS -DBUILD_SHARED_LIBS=NO $GLFWDIR
make
cmake $OPTIONS -DBUILD_SHARED_LIBS=YES $GLFWDIR
make

popd

cp build/mingw-w64-x64/src/libglfw3.a glfw-bin.WIN64/lib-mingw-w64
cp build/mingw-w64-x64/src/glfw3dll.a glfw-bin.WIN64/lib-mingw-w64
cp build/mingw-w64-x64/src/glfw3.dll  glfw-bin.WIN64/lib-mingw-w64

cmd /c build.bat

