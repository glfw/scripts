#!/bin/sh

COMMON="-GNinja -DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO -DCMAKE_C_FLAGS=-s"
SHARED="$COMMON -DBUILD_SHARED_LIBS=YES"
STATIC="$COMMON -DBUILD_SHARED_LIBS=NO"
GLFWDIR='../../../glfw'

build()
{
    cmake -E make_directory $BUILDDIR
    cmake -E chdir $BUILDDIR cmake -DCMAKE_TOOLCHAIN_FILE=$TOOLPATH $STATIC $GLFWDIR
    cmake --build $BUILDDIR
    cmake -E chdir $BUILDDIR cmake $SHARED $GLFWDIR
    cmake --build $BUILDDIR

    cmake -E make_directory $TARGETDIR
    cmake -E copy $BUILDDIR/src/libglfw3.a    $TARGETDIR
    cmake -E copy $BUILDDIR/src/libglfw3dll.a $TARGETDIR
    cmake -E copy $BUILDDIR/src/glfw3.dll     $TARGETDIR
}

# MinGW-w64 32-bit
TOOLPATH="$GLFWDIR/CMake/i686-w64-mingw32.cmake"
BUILDDIR="build/mingw-w64-x86"
TARGETDIR="glfw-bin.WIN32/lib-mingw-w64"
build

# MinGW-w64 64-bit
TOOLPATH="$GLFWDIR/CMake/x86_64-w64-mingw32.cmake"
BUILDDIR="build/mingw-w64-x64"
TARGETDIR="glfw-bin.WIN64/lib-mingw-w64"
build

