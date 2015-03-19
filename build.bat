@echo off

mkdir lib-vc2010\x86
mkdir lib-vc2012\x86
mkdir lib-vc2012\x64
mkdir lib-vc2013\x86
mkdir lib-vc2013\x64

mkdir build-vc2010-x86
cd    build-vc2010-x86

call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" x86
"C:\Program Files (x86)\CMake\bin\cmake.exe" -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO -DBUILD_SHARED_LIBS=NO ..\..\glfw
nmake
"C:\Program Files (x86)\CMake\bin\cmake.exe" -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO -DBUILD_SHARED_LIBS=YES ..\..\glfw
nmake

cd ..

copy build-vc2010-x86\src\glfw3.lib    lib-vc2010\x86
copy build-vc2010-x86\src\glfw3dll.lib lib-vc2010\x86
copy build-vc2010-x86\src\glfw3.dll    lib-vc2010\x86

mkdir build-vc2012-x86
cd    build-vc2012-x86

call "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\vcvarsall.bat" x86
"C:\Program Files (x86)\CMake\bin\cmake.exe" -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO -DBUILD_SHARED_LIBS=NO ..\..\glfw
nmake
"C:\Program Files (x86)\CMake\bin\cmake.exe" -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO -DBUILD_SHARED_LIBS=YES ..\..\glfw
nmake

cd ..

copy build-vc2012-x86\src\glfw3.lib    lib-vc2012\x86
copy build-vc2012-x86\src\glfw3dll.lib lib-vc2012\x86
copy build-vc2012-x86\src\glfw3.dll    lib-vc2012\x86

mkdir build-vc2012-x64
cd    build-vc2012-x64

call "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\vcvarsall.bat" x86_amd64
"C:\Program Files (x86)\CMake\bin\cmake.exe" -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO -DBUILD_SHARED_LIBS=NO ..\..\glfw
nmake
"C:\Program Files (x86)\CMake\bin\cmake.exe" -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO -DBUILD_SHARED_LIBS=YES ..\..\glfw
nmake

cd ..

copy build-vc2012-x64\src\glfw3.lib    lib-vc2012\x64
copy build-vc2012-x64\src\glfw3dll.lib lib-vc2012\x64
copy build-vc2012-x64\src\glfw3.dll    lib-vc2012\x64

mkdir build-vc2013-x86
cd    build-vc2013-x86

call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" x86
"C:\Program Files (x86)\CMake\bin\cmake.exe" -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO -DBUILD_SHARED_LIBS=NO ..\..\glfw
nmake
"C:\Program Files (x86)\CMake\bin\cmake.exe" -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO -DBUILD_SHARED_LIBS=YES ..\..\glfw
nmake

cd ..

copy build-vc2013-x86\src\glfw3.lib    lib-vc2013\x86
copy build-vc2013-x86\src\glfw3dll.lib lib-vc2013\x86
copy build-vc2013-x86\src\glfw3.dll    lib-vc2013\x86

mkdir build-vc2013-x64
cd    build-vc2013-x64

call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" x86_amd64
"C:\Program Files (x86)\CMake\bin\cmake.exe" -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO -DBUILD_SHARED_LIBS=NO ..\..\glfw
nmake
"C:\Program Files (x86)\CMake\bin\cmake.exe" -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO -DBUILD_SHARED_LIBS=YES ..\..\glfw
nmake

cd ..

copy build-vc2013-x64\src\glfw3.lib    lib-vc2013\x64
copy build-vc2013-x64\src\glfw3dll.lib lib-vc2013\x64
copy build-vc2013-x64\src\glfw3.dll    lib-vc2013\x64

