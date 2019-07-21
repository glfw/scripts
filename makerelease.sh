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

mkdir -p ${tag}/build-docs

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

rm -f ${tag}/${srcdir}/.[a-z]*

if ! cmake -S ${tag}/${srcdir} -B ${tag}/build-docs; then
  echo "${tag}: failed to configure project"
  exit 1
fi

if ! cmake --build ${tag}/build-docs --target docs; then
  echo "${tag}: failed to build documentation"
  exit 1
fi

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

cp -R ${tag}/build-docs/docs/html ${tag}/${srcdir}/docs/

cp ${tag}/${srcdir}/include/GLFW/glfw3.h ${tag}/${w32dir}/include/GLFW/
cp ${tag}/${srcdir}/include/GLFW/glfw3native.h ${tag}/${w32dir}/include/GLFW/
cp ${tag}/${srcdir}/LICENSE.md ${tag}/${w32dir}/
cp -R ${tag}/build-docs/docs/html ${tag}/${w32dir}/docs/

cp ${tag}/${srcdir}/include/GLFW/glfw3.h ${tag}/${w64dir}/include/GLFW/
cp ${tag}/${srcdir}/include/GLFW/glfw3native.h ${tag}/${w64dir}/include/GLFW/
cp ${tag}/${srcdir}/LICENSE.md ${tag}/${w64dir}/
cp -R ${tag}/build-docs/docs/html ${tag}/${w64dir}/docs/

cp ${tag}/${srcdir}/include/GLFW/glfw3.h ${tag}/${macdir}/include/GLFW/
cp ${tag}/${srcdir}/include/GLFW/glfw3native.h ${tag}/${macdir}/include/GLFW/
cp ${tag}/${srcdir}/LICENSE.md ${tag}/${macdir}/
cp -R ${tag}/build-docs/docs/html ${tag}/${macdir}/docs/

