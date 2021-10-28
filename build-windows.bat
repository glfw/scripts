@echo off
setlocal

set sourcedir=%1
if not exist "%sourcedir%" (
    echo %sourcedir%: Source directory does not exist
    exit /b 1
)

set tag=%2
if "%tag%" EQU "" (
    echo No tag name specified
    exit /b 1
)

set noextra=-DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO

rem MinGW 32-bit
setlocal
path C:\MinGW\bin;%PATH%
set toolchain=i686
set targetdir=glfw-%tag%.bin.WIN32/lib-mingw
call :build_mingw_static
call :build_mingw_dll
endlocal

rem MinGW-w64 32-bit
setlocal
path C:\Program Files (x86)\mingw-w64\i686-8.1.0-win32-dwarf-rt_v6-rev0\mingw32\bin;%PATH%
set targetdir=glfw-%tag%.bin.WIN32/lib-mingw-w64
set toolchain=w64-i686
call :build_mingw_static
call :build_mingw_dll
endlocal

rem MinGW-w64 64-bit
setlocal
path C:\Program Files\mingw-w64\x86_64-8.1.0-win32-seh-rt_v6-rev0\mingw64\bin;%PATH%
set targetdir=glfw-%tag%.bin.WIN64/lib-mingw-w64
set toolchain=w64-x86_64
call :build_mingw_static
call :build_mingw_dll
endlocal

rem Visual C++ 2010 32-bit
setlocal
set generator=Visual Studio 10 2010
set arch=Win32
set toolset=v100
set targetdir=glfw-%tag%.bin.WIN32\lib-vc2010
call :build_vs_static
call :build_vs_static_mt
call :build_vs_dll
endlocal

rem Visual C++ 2012 32-bit
setlocal
set generator=Visual Studio 11 2012
set arch=Win32
set toolset=v110_xp
set targetdir=glfw-%tag%.bin.WIN32\lib-vc2012
call :build_vs_static
call :build_vs_static_mt
call :build_vs_dll
endlocal

rem Visual C++ 2012 64-bit
setlocal
set generator=Visual Studio 11 2012
set arch=x64
set toolset=v110_xp
set targetdir=glfw-%tag%.bin.WIN64\lib-vc2012
call :build_vs_static
call :build_vs_static_mt
call :build_vs_dll
endlocal

rem Visual C++ 2013 32-bit
setlocal
set generator=Visual Studio 12 2013
set arch=Win32
set toolset=v120_xp
set targetdir=glfw-%tag%.bin.WIN32\lib-vc2013
call :build_vs_static
call :build_vs_static_mt
call :build_vs_dll
endlocal

rem Visual C++ 2013 64-bit
setlocal
set generator=Visual Studio 12 2013
set arch=x64
set toolset=v120_xp
set targetdir=glfw-%tag%.bin.WIN64\lib-vc2013
call :build_vs_static
call :build_vs_static_mt
call :build_vs_dll
endlocal

rem Visual C++ 2015 32-bit
setlocal
set generator=Visual Studio 14 2015
set arch=Win32
set toolset=v140_xp
set targetdir=glfw-%tag%.bin.WIN32\lib-vc2015
call :build_vs_static
call :build_vs_static_mt
call :build_vs_dll
endlocal

rem Visual C++ 2015 64-bit
setlocal
set generator=Visual Studio 14 2015
set arch=x64
set toolset=v140_xp
set targetdir=glfw-%tag%.bin.WIN64\lib-vc2015
call :build_vs_static
call :build_vs_static_mt
call :build_vs_dll
endlocal

rem Visual C++ 2017 32-bit
setlocal
set generator=Visual Studio 15 2017
set arch=Win32
set toolset=v141_xp
set targetdir=glfw-%tag%.bin.WIN32\lib-vc2017
call :build_vs_static
call :build_vs_static_mt
call :build_vs_dll
endlocal

rem Visual C++ 2017 64-bit
setlocal
set generator=Visual Studio 15 2017
set arch=x64
set toolset=v141_xp
set targetdir=glfw-%tag%.bin.WIN64\lib-vc2017
call :build_vs_static
call :build_vs_static_mt
call :build_vs_dll
endlocal

rem Visual C++ 2019 32-bit
setlocal
set generator=Visual Studio 16 2019
set arch=Win32
set toolset=v142
set targetdir=glfw-%tag%.bin.WIN32\lib-vc2019
call :build_vs_static
call :build_vs_static_mt
call :build_vs_dll
endlocal

rem Visual C++ 2019 64-bit
setlocal
set generator=Visual Studio 16 2019
set arch=x64
set toolset=v142
set targetdir=glfw-%tag%.bin.WIN64\lib-vc2019
call :build_vs_static
call :build_vs_static_mt
call :build_vs_dll
endlocal

rem Visual C++ 2019 32-bit DLL with static UCRT
setlocal
set generator=Visual Studio 16 2019
set arch=Win32
set toolset=v142
set targetdir=glfw-%tag%.bin.WIN32\lib-static-ucrt
call :build_vs_dll_mt
endlocal

rem Visual C++ 2019 64-bit with static UCRT
setlocal
set generator=Visual Studio 16 2019
set arch=x64
set toolset=v142
set targetdir=glfw-%tag%.bin.WIN64\lib-static-ucrt
call :build_vs_dll_mt
endlocal

rem Visual C++ 2022 32-bit
setlocal
set generator=Visual Studio 17 2022
set arch=Win32
set toolset=v143
set targetdir=glfw-%tag%.bin.WIN32\lib-vc2022
call :build_vs_static
call :build_vs_static_mt
call :build_vs_dll
endlocal

rem Visual C++ 2022 64-bit
setlocal
set generator=Visual Studio 17 2022
set arch=x64
set toolset=v143
set targetdir=glfw-%tag%.bin.WIN64\lib-vc2022
call :build_vs_static
call :build_vs_static_mt
call :build_vs_dll
endlocal

endlocal
exit /b 0

:build_mingw_static
set CFLAGS=-s -Werror
set builddir=build\mingw-%toolchain%-static
cmake -E make_directory %builddir%
cmake -E make_directory %targetdir%
cmake -S "%sourcedir%" -B %builddir% -G "MinGW Makefiles" %noextra% -DCMAKE_BUILD_TYPE=Release
cmake --build %builddir%
cmake -E copy %builddir%\src\libglfw3.a %targetdir%
exit /b 0

:build_mingw_dll
set CFLAGS=-s -Werror
set builddir=build\mingw-%toolchain%-dll
cmake -E make_directory %builddir%
cmake -E make_directory %targetdir%
cmake -S "%sourcedir%" -B %builddir% -G "MinGW Makefiles" %noextra% -DBUILD_SHARED_LIBS=YES -DCMAKE_BUILD_TYPE=Release
cmake --build %builddir%
cmake -E copy %builddir%\src\libglfw3dll.a %targetdir%
cmake -E copy %builddir%\src\glfw3.dll     %targetdir%
exit /b 0

:build_vs_static
set CFLAGS=/WX
set builddir=build\vs-%toolset%-%arch%-static
cmake -E make_directory %builddir%
cmake -E make_directory %targetdir%
cmake -S "%sourcedir%" -B %builddir% -G "%generator%" -A %arch% -T %toolset% %noextra%
cmake --build %builddir% --config Release
cmake -E copy %builddir%\src\Release\glfw3.lib %targetdir%
exit /b 0

:build_vs_static_mt
set CFLAGS=/WX
set builddir=build\vs-%toolset%-%arch%-static-mt
cmake -E make_directory %builddir%
cmake -E make_directory %targetdir%
cmake -S "%sourcedir%" -B %builddir% -G "%generator%" -A %arch% -T %toolset% %noextra% -DUSE_MSVC_RUNTIME_LIBRARY_DLL=OFF
cmake --build %builddir% --config Release
cmake -E copy %builddir%\src\Release\glfw3.lib %targetdir%\glfw3_mt.lib
exit /b 0

:build_vs_dll
set CFLAGS=/WX
set builddir=build\vs-%toolset%-%arch%-dll
cmake -E make_directory %builddir%
cmake -E make_directory %targetdir%
cmake -S "%sourcedir%" -B %builddir% -G "%generator%" -A %arch% -T %toolset% %noextra% -DBUILD_SHARED_LIBS=YES
cmake --build %builddir% --config Release
cmake -E copy %builddir%\src\Release\glfw3dll.lib %targetdir%
cmake -E copy %builddir%\src\Release\glfw3.dll    %targetdir%
exit /b 0

:build_vs_dll_mt
set CFLAGS=/WX
set builddir=build\vs-%toolset%-%arch%-dll-mt
cmake -E make_directory %builddir%
cmake -E make_directory %targetdir%
cmake -S "%sourcedir%" -B %builddir% -G "%generator%" -A %arch% -T %toolset% %noextra% -DBUILD_SHARED_LIBS=YES -DUSE_MSVC_RUNTIME_LIBRARY_DLL=OFF
cmake --build %builddir% --config Release
cmake -E copy %builddir%\src\Release\glfw3dll.lib %targetdir%
cmake -E copy %builddir%\src\Release\glfw3.dll    %targetdir%
exit /b 0

