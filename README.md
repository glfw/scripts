# Build Script Horror

These are the horrible ad-hoc release building scripts for GLFW.  Most of this
stuff should be offloaded to CI services, because no one who is not a CI service
should be expected to have all these dependencies installed.

## Windows Dependencies

 - CMake 3.13+
 - Visual Studio 2013
 - Visual Studio 2015
   - Windows XP support
 - Visual Studio 2017
   - Windows XP support
 - Visual Studio 2019
 - Visual Studio 2022
 - MinGW-w64 i686-win32-dwarf-msvcrt
 - MinGW-w64 x86\_64-win32-dwarf-msvcrt
 - A Unix-y environment with bash and cmake

## macOS Dependencies

 - CMake 3.13+
 - Xcode
   - Command-line tools

