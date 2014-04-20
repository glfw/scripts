# GLFW Windows binaries

This is the Windows binary package for GLFW.

GLFW is a free, Open Source, multi-platform library for OpenGL and OpenGL ES
application development.  It provides a simple, platform-independent API for
creating windows and contexts, reading input, handling events, etc.

| Directory   | Description                  |
| ----------- | ---------------------------- |
| `docs`      | HTML documentation           |
| `include`   | Public header files          |
| `lib-mingw` | Library files for MinGW      |
| `lib-msvc*` | Library files for Visual C++ |

The numbers used for the `lib-msvc*` directories are the [version numbers of
Visual C++ releases](https://en.wikipedia.org/wiki/Visual_C++), not of the
compiler or the year-based marketing names of Visual Studio (i.e. Visual C++
2012).  You can find the version number of Visual C++ in the *About* dialog.

| Directory     | Version | Marketed as     |
| ------------- | ------- | --------------- |
| `lib-msvc100` | 10.0    | Visual C++ 2010 |
| `lib-msvc110` | 11.0    | Visual C++ 2012 |
| `lib-msvc120` | 12.0    | Visual C++ 2013 |

You cannot use the library files compiled for one version of Visual C++ with
another version of Visual C++ or with MinGW.  If there are no pre-compiled files
for your version of Visual C++, download [CMake](http://www.cmake.org) and the
source release of GLFW and compile your own.

