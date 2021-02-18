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
    cmake -S "$GLFWDIR" -B $BUILDDIR $STATIC -DCMAKE_OSX_ARCHITECTURES=$ARCHS
    cmake --build $BUILDDIR
    cmake $SHARED $BUILDDIR
    cmake --build $BUILDDIR
    cmake -E copy $BUILDDIR/src/libglfw3.a      $TARGETDIR
    cmake -E copy $BUILDDIR/src/libglfw.3.dylib $TARGETDIR
}

# macOS x86_64
BUILDDIR="build/macos-x86_64"
TARGETDIR="glfw-$GLFWVER.bin.MACOS/lib-x86_64"
ARCHS="x86_64"
build

# macOS arm64
BUILDDIR="build/macos-arm64"
TARGETDIR="glfw-$GLFWVER.bin.MACOS/lib-arm64"
ARCHS="arm64"
build

# macOS x86_64/arm64 Universal
BUILDDIR="build/macos-universal"
TARGETDIR="glfw-$GLFWVER.bin.MACOS/lib-universal"
ARCHS="x86_64;arm64"
build

