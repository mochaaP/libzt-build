# libzt-cross

Cross compiled `libzt.{a,so,dylib,dll}` (ZeroTierSockets SDK).
If you are looking for that golang wrapper, check <https://github.com/mchaNetwork/libzt>.

## Support matrix

* Linux
  > Linked statically against musl libc. <https://musl.cc/>
  >
  > Not every supported triple is being targeted.
  > If you are in need, open an issue and I will possibly look into it.

  * `amd64`:
    SSE, SSE2 is enabled. `salsa20` and `ed25519` are asm calls and hardware accelerated.
  * `i686`:
    Builds for `i486` is disabled. Golang dropped `i486` support in 1.12.
    Softfloat.
  * `arm`:
    `arm` `armv6` `armv7l` are being built. Uses ASM NEON for AES.
  * `aarch64`:
    Uses ARMv8-A crypto instructions.
  * `mips`: `mips` `mipsel` `mips64` `mips64el`
  * `ppc`: `ppc64` `ppc64le`
  * `s390x`
  * `riscv64`

* macOS

  > Built on macOS 11.6.5 (`macos-latest`).
  > <https://github.com/actions/virtual-environments/blob/main/images/macos/macos-11-Readme.md>
  >
  > Using OSXCross is possible and planned, but not implemented yet.
  > PRs welcomed.

  * `amd64`
  * ~~`arm64`~~

* Windows
  > Built with Visual Studio 2022.
  > <https://github.com/actions/virtual-environments/blob/main/images/win/Windows2022-Readme.md>
  >
  > MinGW GCC (x86)/Clang (arm) is possible, but not implemented yet.
  > PRs welcomed.

  * `amd64`
  * `i686`
  * ~~`arm`~~
  * ~~`arm64`~~
