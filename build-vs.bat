@echo off

set COMMON=-DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO
set SHARED=%COMMON% -DBUILD_SHARED_LIBS=YES
set STATIC=%COMMON% -DBUILD_SHARED_LIBS=NO
set GLFWDIR="..\glfw"

rem Visual C++ 2010 32-bit
set GENERATOR="Visual Studio 10 2010"
set ARCH="Win32"
set BUILDDIR="build\vc2010-x86"
set TARGETDIR="glfw-bin.WIN32\lib-vc2010"
set TOOLSET=v100
call :build

rem Visual C++ 2012 32-bit
set GENERATOR="Visual Studio 11 2012"
set ARCH="Win32"
set BUILDDIR="build\vc2012-x86"
set TARGETDIR="glfw-bin.WIN32\lib-vc2012"
set TOOLSET=v110_xp
call :build

rem Visual C++ 2012 64-bit
set GENERATOR="Visual Studio 11 2012"
set ARCH="x64"
set BUILDDIR="build\vc2012-x64"
set TARGETDIR="glfw-bin.WIN64\lib-vc2012"
set TOOLSET=v110_xp
call :build

rem Visual C++ 2013 32-bit
set GENERATOR="Visual Studio 12 2013"
set ARCH="Win32"
set BUILDDIR="build\vc2013-x86"
set TARGETDIR="glfw-bin.WIN32\lib-vc2013"
set TOOLSET=v120_xp
call :build

rem Visual C++ 2013 64-bit
set GENERATOR="Visual Studio 12 2013"
set ARCH="x64"
set BUILDDIR="build\vc2013-x64"
set TARGETDIR="glfw-bin.WIN64\lib-vc2013"
set TOOLSET=v120_xp
call :build

rem Visual C++ 2015 32-bit
set GENERATOR="Visual Studio 14 2015"
set ARCH="Win32"
set BUILDDIR="build\vc2015-x86"
set TARGETDIR="glfw-bin.WIN32\lib-vc2015"
set TOOLSET=v140_xp
call :build

rem Visual C++ 2015 64-bit
set GENERATOR="Visual Studio 14 2015"
set ARCH="x64"
set BUILDDIR="build\vc2015-x64"
set TARGETDIR="glfw-bin.WIN64\lib-vc2015"
set TOOLSET=v140_xp
call :build

rem Visual C++ 2017 32-bit
set GENERATOR="Visual Studio 15 2017"
set ARCH="Win32"
set BUILDDIR="build\vc2017-x86"
set TARGETDIR="glfw-bin.WIN32\lib-vc2017"
set TOOLSET=v141_xp
call :build

rem Visual C++ 2017 64-bit
set GENERATOR="Visual Studio 15 2017"
set ARCH="x64"
set BUILDDIR="build\vc2017-x64"
set TARGETDIR="glfw-bin.WIN64\lib-vc2017"
set TOOLSET=v141_xp
call :build

rem Visual C++ 2019 32-bit
set GENERATOR="Visual Studio 16 2019"
set ARCH="Win32"
set BUILDDIR="build\vc2019-x86"
set TARGETDIR="glfw-bin.WIN32\lib-vc2019"
set TOOLSET=v142
call :build

rem Visual C++ 2019 64-bit
set GENERATOR="Visual Studio 16 2019"
set ARCH="x64"
set BUILDDIR="build\vc2019-x64"
set TARGETDIR="glfw-bin.WIN64\lib-vc2019"
set TOOLSET=v142
call :build

exit /b 0

:build
cmake -E make_directory %BUILDDIR%
cmake -E make_directory %TARGETDIR%
cmake -S %GLFWDIR% -B %BUILDDIR% -G %GENERATOR% -A %ARCH% -T %TOOLSET% %STATIC%
cmake --build %BUILDDIR% --config Release
cmake %SHARED% %BUILDDIR%
cmake --build %BUILDDIR% --config Release
cmake -E copy %BUILDDIR%\src\Release\glfw3.lib    %TARGETDIR%
cmake -E copy %BUILDDIR%\src\Release\glfw3dll.lib %TARGETDIR%
cmake -E copy %BUILDDIR%\src\Release\glfw3.dll    %TARGETDIR%
exit /b 0

