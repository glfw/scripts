#!/bin/bash

dir="$1"
tag="$2"

if [ ! -d "${dir}" ]; then
    echo "${dir}: Directory not found"
    echo "Usage: $(basename $0) <glfwpath> <version>"
    exit 1
fi

if [ -z "${tag}" ]; then
    echo "No version specified"
    echo "Usage: $(basename $0) <glfwpath> <version>"
    exit 1
fi

if [ -e ${tag} ]; then
    echo "$(basename $0): ${tag}: tree already exists"
    exit 1
fi

srcdir=glfw-${tag}
w32dir=glfw-${tag}.bin.WIN32
w64dir=glfw-${tag}.bin.WIN64
macdir=glfw-${tag}.bin.MACOS

mkdir -p ${tag}/${srcdir}

mkdir -p ${tag}/build/docs

mkdir -p ${tag}/${w32dir}/docs
mkdir -p ${tag}/${w32dir}/include/GLFW

mkdir -p ${tag}/${w64dir}/docs
mkdir -p ${tag}/${w64dir}/include/GLFW

mkdir -p ${tag}/${macdir}/docs
mkdir -p ${tag}/${macdir}/include/GLFW

if ! ( git archive --remote "${dir}/.git" ${tag} | tar x -C ${tag}/${srcdir} ); then
    echo "${tag}: failed to export source tree"
    exit 1
fi

rm -rf ${tag}/${srcdir}/.[a-z]*

if ! cmake -S ${tag}/${srcdir} -B ${tag}/build/docs; then
    echo "${tag}: failed to configure project"
    exit 1
fi

if ! cmake --build ${tag}/build/docs --target docs; then
    echo "${tag}: failed to build documentation"
    exit 1
fi

cp build-macos.sh build-windows.bat ${tag}/

cat > ${tag}/makepackages.sh <<EOF
#!/bin/bash

target_src_gz=glfw-${tag}.tar.gz
target_src_bz2=glfw-${tag}.tar.bz2
target_src_zip=glfw-${tag}.zip
target_bin_WIN32=glfw-${tag}.bin.WIN32.zip
target_bin_WIN64=glfw-${tag}.bin.WIN64.zip
target_bin_MACOS=glfw-${tag}.bin.MACOS.zip

rm -f \$target_src_gz \$target_src_bz2 \$target_src_zip
rm -f \$target_bin_WIN32
rm -f \$target_bin_WIN64
rm -f \$target_bin_MACOS

for dir in ${srcdir} ${w32dir} ${w64dir} ${macdir}; do
    find \${dir} -name '*.swo' -o -name '*.swp' -exec rm {} \;
    chmod -R -x+X \${dir}
done

if ! tar -czf \$target_src_gz ${srcdir}; then
    echo "\${target_src_gz}: failed to create package"
    exit 1
fi

if ! tar -cjf \$target_src_bz2 ${srcdir}; then
    echo "\${target_src_bz2}: failed to create package"
    exit 1
fi

if ! zip -rq \$target_src_zip ${srcdir}; then
    echo "\${target_src_zip}: failed to create package"
    exit 1
fi

if ! zip -rq \$target_bin_WIN32 ${w32dir}; then
    echo "\${target_bin_WIN32}: failed to create package"
    exit 1
fi

if ! zip -rq \$target_bin_WIN64 ${w64dir}; then
    echo "\${target_bin_WIN64}: failed to create package"
    exit 1
fi

if ! zip -rq \$target_bin_MACOS ${macdir}; then
    echo "\${target_bin_MACOS}: failed to create package"
    exit 1
fi
EOF
chmod +x ${tag}/makepackages.sh

cat > ${tag}/${macdir}/README.md <<EOF
# GLFW binaries for macOS

This archive contains documentation, headers and pre-compiled static and dynamic
libraries for GLFW ${tag}, targeting macOS 10.8 and later.  Both Intel
(x86\_64), Apple Silicon (arm64) and Universal binaries are provided.
EOF

cat > ${tag}/${w32dir}/README.md <<EOF
# GLFW binaries for 32-bit Windows

This archive contains documentation, headers, pre-compiled static libraries,
import libraries and DLLs for GLFW ${tag}.

Binaries for the following compilers are included

 - Visual C++ 2022 (built with 17.8.3)
 - Visual C++ 2019 (built with 16.11.32)
 - Visual C++ 2017 (built with 15.9.58)
 - Visual C++ 2015 (built with 14.0.25431.01)
 - Visual C++ 2013 (built with 12.0.40629.00)
 - Visual C++ 2012 (built with 11.0.61219.00)
 - MinGW-w64 (built with GCC 8.1.0)
 - MinGW (built with GCC 9.2.0)


## Binaries for Visual C++

All binaries for Visual C++ 2017 and earlier are compatible with Windows XP, but
this is not supported by Visual C++ 2019.

### GLFW as a DLL

To use GLFW as a DLL, link against the \`glfw3dll.lib\` file for your
environment.  This will add a load time dependency on \`glfw3.dll\`.  The
remaining files in the same directory are not needed.

This DLL is built in release mode for the Multithreaded DLL runtime library.

There is also a GLFW DLL and import library pair in the \`lib-static-ucrt\`
directory.  These are built with Visual C++ 2019 and the static Multithreaded
runtime library.

### GLFW as a static library

To use GLFW as a static library, link against \`glfw3.lib\` if your application
is using the Multithreaded DLL runtime library, or \`glfw3_mt.lib\` if it is
using the static Multithreaded runtime library.  The remaining files in the same
directory are not needed.

The static libraries are built in release mode and do not contain debug
information but can still be linked with the debug versions of the runtime
library.


## Binaries for MinGW and MinGW-w64

### GLFW as a DLL

To use GLFW as a DLL, link against the \`libglfw3dll.a\` file for your
environment.  This will add a load time dependency on \`glfw3.dll\`.  The
remaining files in the same directory are not needed.

The DLLs are built in release mode.

The DLLs depend on the \`msvcrt.dll\` C runtime library.  There is also a GLFW
DLL and import library in the \`lib-static-ucrt\` directory that is built with
Visual C++ 2019 and statically linked against the UCRT.

All DLLs in this archive provide the same ABI and can be used as drop-in
replacements for one another, as long as the C runtime library they depend on is
available.

### GLFW as a static library

To use GLFW as a static library, link against the \`libglfw3.a\` file for your
environment.  The other files in the same directory are not needed.

The library is built in release mode and do not contain debug information.
EOF

cat > ${tag}/${w64dir}/README.md <<EOF
# GLFW binaries for 64-bit Windows

This archive contains documentation, headers, pre-compiled static libraries,
import libraries and DLLs for GLFW ${tag}.

Binaries for the following compilers are included

 - Visual C++ 2022 (built with 17.8.3)
 - Visual C++ 2019 (built with 16.11.32)
 - Visual C++ 2017 (built with 15.9.58)
 - Visual C++ 2015 (built with 14.0.25431.01)
 - Visual C++ 2013 (built with 12.0.40629.00)
 - Visual C++ 2012 (built with 11.0.61219.00)
 - MinGW-w64 (built with GCC 8.1.0)


## Binaries for Visual C++

All binaries for Visual C++ 2017 and earlier are compatible with Windows XP, but
this is not supported by Visual C++ 2019.

### GLFW as a DLL

To use GLFW as a DLL, link against the \`glfw3dll.lib\` file for your
environment.  This will add a load time dependency on \`glfw3.dll\`.  The
remaining files in the same directory are not needed.

This DLL is built in release mode for the Multithreaded DLL runtime library.

There is also a GLFW DLL and import library pair in the \`lib-static-ucrt\`
directory.  These are built with Visual C++ 2019 and the static Multithreaded
runtime library.

### GLFW as a static library

To use GLFW as a static library, link against \`glfw3.lib\` if your application
is using the Multithreaded DLL runtime library, or \`glfw3_mt.lib\` if it is
using the static Multithreaded runtime library.  The remaining files in the same
directory are not needed.

The static libraries are built in release mode and do not contain debug
information but can still be linked with the debug versions of the runtime
library.


## Binaries for MinGW-w64

### GLFW as a DLL

To use GLFW as a DLL, link against the \`libglfw3dll.a\` file for your
environment.  This will add a load time dependency on \`glfw3.dll\`.  The
remaining files in the same directory are not needed.

The DLLs are built in release mode.

The DLLs depend on the \`msvcrt.dll\` C runtime library.  There is also a GLFW
DLL and import library in the \`lib-static-ucrt\` directory that is built with
Visual C++ 2019 and statically linked against the UCRT.

All DLLs in this archive provide the same ABI and can be used as drop-in
replacements for one another, as long as the C runtime library they depend on is
available.

### GLFW as a static library

To use GLFW as a static library, link against the \`libglfw3.a\` file for your
environment.  The other files in the same directory are not needed.

The library is built in release mode and do not contain debug information.
EOF

cp -R ${tag}/build/docs/docs/html ${tag}/${srcdir}/docs/

cp ${tag}/${srcdir}/include/GLFW/glfw3.h ${tag}/${w32dir}/include/GLFW/
cp ${tag}/${srcdir}/include/GLFW/glfw3native.h ${tag}/${w32dir}/include/GLFW/
cp ${tag}/${srcdir}/LICENSE.md ${tag}/${w32dir}/
cp -R ${tag}/build/docs/docs/html ${tag}/${w32dir}/docs/

cp ${tag}/${srcdir}/include/GLFW/glfw3.h ${tag}/${w64dir}/include/GLFW/
cp ${tag}/${srcdir}/include/GLFW/glfw3native.h ${tag}/${w64dir}/include/GLFW/
cp ${tag}/${srcdir}/LICENSE.md ${tag}/${w64dir}/
cp -R ${tag}/build/docs/docs/html ${tag}/${w64dir}/docs/

cp ${tag}/${srcdir}/include/GLFW/glfw3.h ${tag}/${macdir}/include/GLFW/
cp ${tag}/${srcdir}/include/GLFW/glfw3native.h ${tag}/${macdir}/include/GLFW/
cp ${tag}/${srcdir}/LICENSE.md ${tag}/${macdir}/
cp -R ${tag}/build/docs/docs/html ${tag}/${macdir}/docs/

