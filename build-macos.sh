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

build_docs()
{
    BUILDDIR="build/docs"
    cmake -E make_directory $BUILDDIR
    cmake -S "$GLFWDIR" -B $BUILDDIR -DGLFW_BUILD_COCOA=0
    cmake --build $BUILDDIR --target docs
    cmake -E copy_directory $BUILDDIR/docs/html glfw-$GLFWVER/docs
    cmake -E copy_directory $BUILDDIR/docs/html glfw-$GLFWVER.bin.MACOS/docs
}

build_static()
{
    BUILDDIR="build/macos-$ARCHNAME-static"
    cmake -E make_directory $BUILDDIR
    cmake -E make_directory $TARGETDIR
    cmake -S "$GLFWDIR" -B $BUILDDIR -DCMAKE_OSX_ARCHITECTURES=$ARCHS $STATIC
    cmake --build $BUILDDIR
    cmake -E copy $BUILDDIR/src/libglfw3.a $TARGETDIR
}

build_dynamic()
{
    BUILDDIR="build/macos-$ARCHNAME-dynamic"
    cmake -E make_directory $BUILDDIR
    cmake -E make_directory $TARGETDIR
    cmake -S "$GLFWDIR" -B $BUILDDIR -DCMAKE_OSX_ARCHITECTURES=$ARCHS $SHARED
    cmake --build $BUILDDIR
    cmake -E copy $BUILDDIR/src/libglfw.3.dylib $TARGETDIR
}

# HTML documentation
build_docs

# macOS x86_64
ARCHNAME="x86_64"
TARGETDIR="glfw-$GLFWVER.bin.MACOS/lib-$ARCHNAME"
ARCHS="x86_64"
build_static
build_dynamic

# macOS arm64
ARCHNAME="arm64"
TARGETDIR="glfw-$GLFWVER.bin.MACOS/lib-$ARCHNAME"
ARCHS="arm64"
build_static
build_dynamic

# macOS x86_64/arm64 Universal
ARCHNAME="universal"
TARGETDIR="glfw-$GLFWVER.bin.MACOS/lib-$ARCHNAME"
ARCHS="x86_64;arm64"
build_static
build_dynamic

