#!/bin/bash
# Copyright (C) 2023-2025 - UTC - Stéphane MOTTELET
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# openCV build script for Linux and macOS
# cmake should be in the PATH

cd ..
THIRDPARTY="$(pwd)/$(uname -s)/$(uname -m)"
cd build
OPENCV_VER=4.8.1
FFMPEG_VER=6.0

# ffmpeg build
[ ! -f opencv-${OPENCV_VER}.tar.gz ] && curl -LO https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VER}.tar.gz
tar xvzf ffmpeg-${FFMPEG_VER}.tar.gz
cd ffmpeg-${FFMPEG_VER}
./configure --enable-shared --enable-rpath --disable-static --disable-programs --disable-x86asm --prefix="${THIRDPARTY}"
make -j4
make install
cd ..

# opencv build
[ ! -f opencv-${OPENCV_VER}.tar.gz ] && curl -L https://github.com/opencv/opencv/archive/refs/tags/${OPENCV_VER}.tar.gz -o opencv-${OPENCV_VER}.tar.gz
[ ! -f opencv_contrib-${OPENCV_VER}.tar.gz ] && curl -L https://github.com/opencv/opencv_contrib/archive/refs/tags/${OPENCV_VER}.tar.gz -o opencv_contrib-${OPENCV_VER}.tar.gz
tar xvzf opencv-${OPENCV_VER}.tar.gz
tar xvzf opencv_contrib-${OPENCV_VER}.tar.gz
cd opencv-${OPENCV_VER}
rm -rf build
mkdir -p build
cd build
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:${THIRDPARTY}/lib/pkgconfig"
cmake -DCMAKE_INSTALL_PREFIX="${THIRDPARTY}" \
-DCMAKE_BUILD_TYPE=Release \
-DWITH_VTK=OFF \
-DCMAKE_MACOSX_RPATH=ON \
-DCMAKE_SHARED_LINKER_FLAGS="-Wl,-rpath,${THIRDPARTY}/lib" \
-DCMAKE_INSTALL_RPATH="${THIRDPARTY}/lib" \
-DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-${OPENCV_VER}/modules \
-DBUILD_ZLIB=ON \
-DBUILD_JPEG=ON \
-DBUILD_WEBP=ON \
-DBUILD_PNG=ON \
-DBUILD_TIFF=ON \
-DBUILD_JASPER=ON \
-DBUILD_OPENEXR=ON \
-DBUILD_OPENJPEG=ON \
-DBUILD_opencv_apps=OFF \
-DBUILD_opencv_java=OFF \
-DBUILD_opencv_python=OFF \
-DBUILD_opencv_python2=OFF \
-DBUILD_opencv_python3=OFF \
-DBUILD_opencv_python_bindings_g=OFF \
-DBUILD_opencv_python_tests=OFF \
-DBUILD_opencv_world=ON \
-DBUILD_opencv_hdf=OFF \
-DBUILD_opencv_freetype=OFF \
-DOPENCV_FFMPEG_SKIP_BUILD_CHECK=ON \
-DBUILD_PERF_TESTS=OFF \
-DBUILD_TESTS=OFF \
-DBUILD_DOCS=OFF \
-DBUILD_EXAMPLES=OFF \
..
make -j4
make install
