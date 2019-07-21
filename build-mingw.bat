@echo off

set COMMON=-DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO -DCMAKE_C_FLAGS=-s
set SHARED=%COMMON% -DBUILD_SHARED_LIBS=YES
set STATIC=%COMMON% -DBUILD_SHARED_LIBS=NO
set GLFWDIR="%1" 
set GLFWVER="%2"

if "%GLFWVER%" EQU "" exit /b 1
if not exist "%GLFWDIR%" exit /b 1

rem MinGW
set GENERATOR="MinGW Makefiles"
set BUILDDIR="build\mingw-x86"
set TARGETDIR="glfw-%GLFWVER%.bin.WIN32\lib-mingw"

cmake -E make_directory %BUILDDIR%
cmake -E make_directory %TARGETDIR%
cmake -S %GLFWDIR% -B %BUILDDIR% -G %GENERATOR% %STATIC%
cmake --build %BUILDDIR%
cmake %SHARED% %BUILDDIR%
cmake --build %BUILDDIR%
cmake -E copy %BUILDDIR%\src\libglfw3.a    %TARGETDIR%
cmake -E copy %BUILDDIR%\src\libglfw3dll.a %TARGETDIR%
cmake -E copy %BUILDDIR%\src\glfw3.dll     %TARGETDIR%

