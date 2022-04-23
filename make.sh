#!/bin/sh
# Common build script

if [ "$TARGETOS" = "linux" ]; then
  EXTRA_CMAKE_OPTIONS=""
  EXTRA_CMAKE_CFLAGS="-Wno-everything -w -std=c++11"
  EXTRA_ZT_FLAGS="-static-libgcc -static-libstdc++ -static"

  if [ "$TARGETARCH" = "x86_64" ]; then
    EXTRA_CMAKE_CFLAGS=$EXTRA_CMAKE_CFLAGS" -msse -msse2"
    EXTRA_CMAKE_OPTIONS=$EXTRA_CMAKE_OPTIONS" -DZT_USE_X64_ASM_SALSA=1 -DZT_USE_X64_ASM_ED25519=1"
  fi

  if [ "$TARGETARCH" = "arm" ] || [ "$TARGETARCH" = "armel" ] || [ "$TARGETARCH" = "armhf" ] || [ "$TARGETARCH" = "armv6" ] || [ "$TARGETARCH" = "armv6l" ] || [ "$TARGETARCH" = "armv6zk" ] || [ "$TARGETARCH" = "armv7" ] || [ "$TARGETARCH" = "armv7l" ] || [ "$TARGETARCH" = "armv7hl" ] || [ "$TARGETARCH" = "armv7e" ]; then
    EXTRA_CMAKE_OPTIONS=$EXTRA_CMAKE_OPTIONS" -DZT_USE_ARM32_NEON_ASM_CRYPTO=1"
    EXTRA_CMAKE_CFLAGS=$EXTRA_CMAKE_CFLAGS" -DZT_NO_TYPE_PUNNING"
  fi

  if [ "$TARGETARCH" = "aarch64" ]; then
    EXTRA_CMAKE_CFLAGS=$EXTRA_CMAKE_CFLAGS" -DZT_ARCH_ARM_HAS_NEON -march=armv8-a+crypto -mtune=generic -mstrict-align"
    EXTRA_CMAKE_CFLAGS=$EXTRA_CMAKE_CFLAGS" -DZT_NO_TYPE_PUNNING"
  fi

  if [ "$TARGETARCH" = "mips" ] || [ "$TARGETARCH" = "mipsel" ] || [ "$TARGETARCH" = "mips64" ] || [ "$TARGETARCH" = "mips64el" ]; then
    EXTRA_CMAKE_CFLAGS=$EXTRA_CMAKE_CFLAGS" -DZT_NO_TYPE_PUNNING"
  fi

  if [ "$TARGETARCH" = "powerpc" ] || [ "$TARGETARCH" = "powerpc64" ] || [ "$TARGETARCH" = "powerpcle" ] || [ "$TARGETARCH" = "powerpc64le" ]; then
    EXTRA_CMAKE_CFLAGS=$EXTRA_CMAKE_CFLAGS" -DZT_NO_TYPE_PUNNING"
  fi

  if [ "$TARGETARCH" = "i386" ] || [ "$TARGETARCH" = "i486" ] || [ "$TARGETARCH" = "i586" ] || [ "$TARGETARCH" = "i686" ] || [ "$TARGETARCH" = "x86_64" ] || [ "$TARGETARCH" = "arm64" ]; then
    EXTRA_CMAKE_OPTIONS=$EXTRA_CMAKE_OPTIONS" -DZT_SSO_SUPPORTED=1"
  fi

  cmake \
    -DBUILD_RELEASE=ON -DRELEASE_OPTIMIZATION="-O3" -DCMAKE_VERBOSE_MAKEFILE="ON"\
    -DBUILD_STATIC_LIB=True -DBUILD_SHARED_LIB=False \
    -DBUILD_EXAMPLES=False -DBUILD_HOST_SELFTEST=False -DALLOW_INSTALL_TARGET=False \
    -Hlibzt -Bbuild -GNinja \
    -DCMAKE_C_FLAGS="${EXTRA_CMAKE_CFLAGS}" \
    -DCMAKE_CXX_FLAGS="${EXTRA_CMAKE_CFLAGS}" \
    -DZT_FLAGS="${EXTRA_ZT_FLAGS}" \
    ${EXTRA_CMAKE_OPTIONS} \
    && cmake --build build -j$(nproc)
fi

if [ "$TARGETOS" = "windows" ]; then
  echo "Not supported currently, please do a native build."
fi

if [ "$TARGETOS" = "darwin" ]; then
  echo "Not supported currently, please do a native build."
fi
