#!/bin/sh

COMMON="-DCMAKE_OSX_DEPLOYMENT_TARGET=10.8 -DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO"
SHARED="$COMMON -DBUILD_SHARED_LIBS=YES"
STATIC="$COMMON -DBUILD_SHARED_LIBS=NO"
GLFWDIR="$1"
GLFWVER="$2"

if [ ! -d "$GLFWDIR" ]; then
    echo "$GLFWDIR: Directory not found"
    echo "Usage: $(basename $0) <glfwpath> <version>"
    exit 1
fi

if [ -z "$GLFWVER" ]; then
    echo "No version specified"
    echo "Usage: $(basename $0) <glfwpath> <version>"
    exit 1
fi

build()
{
    cmake -E make_directory $BUILDDIR
    cmake -E make_directory $TARGETDIR
    cmake -S "$GLFWDIR" -B $BUILDDIR $STATIC
    cmake --build $BUILDDIR
    cmake $SHARED $BUILDDIR
    cmake --build $BUILDDIR
    cmake -E copy $BUILDDIR/src/libglfw3.a      $TARGETDIR
    cmake -E copy $BUILDDIR/src/libglfw.3.dylib $TARGETDIR
}

# macOS 64-bit
BUILDDIR="build/macos"
TARGETDIR="glfw-$GLFWVER.bin.MACOS/lib-macos"
build

