@echo off

set COMMON=-DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO
set SHARED=%COMMON% -DBUILD_SHARED_LIBS=YES
set STATIC=%COMMON% -DBUILD_SHARED_LIBS=NO
set MT=-DUSE_MSVC_RUNTIME_LIBRARY_DLL=OFF
set GLFWDIR=%1 
set GLFWVER=%2

if "%GLFWVER%" EQU "" exit /b 1
if not exist "%GLFWDIR%" exit /b 1

rem Visual C++ 2010 32-bit
set GENERATOR=Visual Studio 10 2010
set ARCH=Win32
set TOOLSET=v100
set TARGETDIR=glfw-%GLFWVER%.bin.WIN32\lib-vc2010
call :build_static
call :build_static_mt
call :build_dll

rem Visual C++ 2012 32-bit
set GENERATOR=Visual Studio 11 2012
set ARCH=Win32
set TOOLSET=v110_xp
set TARGETDIR=glfw-%GLFWVER%.bin.WIN32\lib-vc2012
call :build_static
call :build_static_mt
call :build_dll

rem Visual C++ 2012 64-bit
set GENERATOR=Visual Studio 11 2012
set ARCH=x64
set TOOLSET=v110_xp
set TARGETDIR=glfw-%GLFWVER%.bin.WIN64\lib-vc2012
call :build_static
call :build_static_mt
call :build_dll

rem Visual C++ 2013 32-bit
set GENERATOR=Visual Studio 12 2013
set ARCH=Win32
set TOOLSET=v120_xp
set TARGETDIR=glfw-%GLFWVER%.bin.WIN32\lib-vc2013
call :build_static
call :build_static_mt
call :build_dll

rem Visual C++ 2013 64-bit
set GENERATOR=Visual Studio 12 2013
set ARCH=x64
set TOOLSET=v120_xp
set TARGETDIR=glfw-%GLFWVER%.bin.WIN64\lib-vc2013
call :build_static
call :build_static_mt
call :build_dll

rem Visual C++ 2015 32-bit
set GENERATOR=Visual Studio 14 2015
set ARCH=Win32
set TOOLSET=v140_xp
set TARGETDIR=glfw-%GLFWVER%.bin.WIN32\lib-vc2015
call :build_static
call :build_static_mt
call :build_dll

rem Visual C++ 2015 64-bit
set GENERATOR=Visual Studio 14 2015
set ARCH=x64
set TOOLSET=v140_xp
set TARGETDIR=glfw-%GLFWVER%.bin.WIN64\lib-vc2015
call :build_static
call :build_static_mt
call :build_dll

rem Visual C++ 2017 32-bit
set GENERATOR=Visual Studio 15 2017
set ARCH=Win32
set TOOLSET=v141_xp
set TARGETDIR=glfw-%GLFWVER%.bin.WIN32\lib-vc2017
call :build_static
call :build_static_mt
call :build_dll

rem Visual C++ 2017 64-bit
set GENERATOR=Visual Studio 15 2017
set ARCH=x64
set TOOLSET=v141_xp
set TARGETDIR=glfw-%GLFWVER%.bin.WIN64\lib-vc2017
call :build_static
call :build_static_mt
call :build_dll

rem Visual C++ 2019 32-bit
set GENERATOR=Visual Studio 16 2019
set ARCH=Win32
set TOOLSET=v142
set TARGETDIR=glfw-%GLFWVER%.bin.WIN32\lib-vc2019
call :build_static
call :build_static_mt
call :build_dll

rem Visual C++ 2019 64-bit
set GENERATOR=Visual Studio 16 2019
set ARCH=x64
set TOOLSET=v142
set TARGETDIR=glfw-%GLFWVER%.bin.WIN64\lib-vc2019
call :build_static
call :build_static_mt
call :build_dll

rem Visual C++ 2019 32-bit DLL with static UCRT
set GENERATOR=Visual Studio 16 2019
set ARCH=Win32
set TOOLSET=v142
set TARGETDIR=glfw-%GLFWVER%.bin.WIN32\lib-static-ucrt
call :build_dll_mt

rem Visual C++ 2019 64-bit with static UCRT
set GENERATOR=Visual Studio 16 2019
set ARCH=x64
set TOOLSET=v142
set TARGETDIR=glfw-%GLFWVER%.bin.WIN64\lib-static-ucrt
call :build_dll_mt

exit /b 0

:build_static
set BUILDDIR=build\vs-%TOOLSET%-%ARCH%-static
cmake -E make_directory %BUILDDIR%
cmake -E make_directory %TARGETDIR%
cmake -S "%GLFWDIR%" -B %BUILDDIR% -G "%GENERATOR%" -A %ARCH% -T %TOOLSET% %STATIC%
cmake --build %BUILDDIR% --config Release
cmake -E copy %BUILDDIR%\src\Release\glfw3.lib %TARGETDIR%
exit /b 0

:build_static_mt
set BUILDDIR=build\vs-%TOOLSET%-%ARCH%-static-mt
cmake -E make_directory %BUILDDIR%
cmake -E make_directory %TARGETDIR%
cmake -S "%GLFWDIR%" -B %BUILDDIR% -G "%GENERATOR%" -A %ARCH% -T %TOOLSET% %STATIC% %MT%
cmake --build %BUILDDIR% --config Release
cmake -E copy %BUILDDIR%\src\Release\glfw3.lib %TARGETDIR%\glfw3_mt.lib
exit /b 0

:build_dll
set BUILDDIR=build\vs-%TOOLSET%-%ARCH%-dll
cmake -E make_directory %BUILDDIR%
cmake -E make_directory %TARGETDIR%
cmake -S "%GLFWDIR%" -B %BUILDDIR% -G "%GENERATOR%" -A %ARCH% -T %TOOLSET% %SHARED%
cmake --build %BUILDDIR% --config Release
cmake -E copy %BUILDDIR%\src\Release\glfw3dll.lib %TARGETDIR%
cmake -E copy %BUILDDIR%\src\Release\glfw3.dll    %TARGETDIR%
exit /b 0

:build_dll_mt
set BUILDDIR=build\vs-%TOOLSET%-%ARCH%-dll-mt
cmake -E make_directory %BUILDDIR%
cmake -E make_directory %TARGETDIR%
cmake -S "%GLFWDIR%" -B %BUILDDIR% -G "%GENERATOR%" -A %ARCH% -T %TOOLSET% %SHARED% %MT%
cmake --build %BUILDDIR% --config Release
cmake -E copy %BUILDDIR%\src\Release\glfw3dll.lib %TARGETDIR%
cmake -E copy %BUILDDIR%\src\Release\glfw3.dll    %TARGETDIR%
exit /b 0

