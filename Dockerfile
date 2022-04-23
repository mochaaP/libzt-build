FROM alpine:latest AS base

WORKDIR /workspace

RUN apk add --no-cache git
RUN git clone --depth=1 --recursive --branch=dev https://github.com/zerotier/libzt.git

COPY ./make.sh .

FROM muslcc/i686:x86_64-linux-musl as build-linux-amd64

ENV TARGETARCH=x86_64
ENV TARGETOS=linux

RUN apk add --no-cache cmake ninja

WORKDIR /workspace
COPY --from=base /workspace /workspace
RUN ./make.sh


FROM muslcc/i686:i686-linux-musl as build-linux-i686

ENV TARGETARCH=i686
ENV TARGETOS=linux

RUN apk add --no-cache cmake ninja

WORKDIR /workspace
COPY --from=base /workspace /workspace
RUN ./make.sh

FROM muslcc/i686:arm-linux-musleabi as build-linux-arm

ENV TARGETARCH=arm
ENV TARGETOS=linux

RUN apk add --no-cache cmake ninja

WORKDIR /workspace
COPY --from=base /workspace /workspace
RUN ./make.sh

FROM muslcc/i686:armv6-linux-musleabi as build-linux-armv6

ENV TARGETARCH=armv6
ENV TARGETOS=linux

RUN apk add --no-cache cmake ninja

WORKDIR /workspace
COPY --from=base /workspace /workspace
RUN ./make.sh

FROM muslcc/i686:armv7l-linux-musleabihf as build-linux-armv7

ENV TARGETARCH=armv7l
ENV TARGETOS=linux

RUN apk add --no-cache cmake ninja

WORKDIR /workspace
COPY --from=base /workspace /workspace
RUN ./make.sh

FROM muslcc/i686:aarch64-linux-musl as build-linux-arm64

ENV TARGETARCH=aarch64
ENV TARGETOS=linux

RUN apk add --no-cache cmake ninja

WORKDIR /workspace
COPY --from=base /workspace /workspace
RUN ./make.sh

FROM muslcc/i686:mips-linux-musl as build-linux-mips

ENV TARGETARCH=mips
ENV TARGETOS=linux

RUN apk add --no-cache cmake ninja

WORKDIR /workspace
COPY --from=base /workspace /workspace
RUN ./make.sh

FROM muslcc/i686:mipsel-linux-musl as build-linux-mipsel

ENV TARGETARCH=mipsle
ENV TARGETOS=linux

RUN apk add --no-cache cmake ninja

WORKDIR /workspace
COPY --from=base /workspace /workspace
RUN ./make.sh

FROM muslcc/i686:mips64-linux-musl as build-linux-mips64

ENV TARGETARCH=mips64
ENV TARGETOS=linux

RUN apk add --no-cache cmake ninja

WORKDIR /workspace
COPY --from=base /workspace /workspace
RUN ./make.sh

FROM muslcc/i686:mips64el-linux-musl as build-linux-mips64el

ENV TARGETARCH=mips64el
ENV TARGETOS=linux

RUN apk add --no-cache cmake ninja

WORKDIR /workspace
COPY --from=base /workspace /workspace
RUN ./make.sh

FROM muslcc/i686:powerpc64-linux-musl as build-linux-ppc64

ENV TARGETARCH=powerpc64
ENV TARGETOS=linux

RUN apk add --no-cache cmake ninja

WORKDIR /workspace
COPY --from=base /workspace /workspace
RUN ./make.sh

FROM muslcc/i686:powerpc64le-linux-musl as build-linux-ppc64le

ENV TARGETARCH=powerpc64le
ENV TARGETOS=linux

RUN apk add --no-cache cmake ninja

WORKDIR /workspace
COPY --from=base /workspace /workspace
RUN ./make.sh

FROM muslcc/i686:s390x-linux-musl as build-linux-s390x

ENV TARGETARCH=s390x
ENV TARGETOS=linux

RUN apk add --no-cache cmake ninja

WORKDIR /workspace
COPY --from=base /workspace /workspace
RUN ./make.sh

FROM muslcc/i686:riscv64-linux-musl as build-linux-riscv64

ENV TARGETARCH=riscv64
ENV TARGETOS=linux

RUN apk add --no-cache cmake ninja

WORKDIR /workspace
COPY --from=base /workspace /workspace
RUN ./make.sh

FROM scratch

WORKDIR /dist

COPY --from=build-linux-amd64 /workspace/build/lib/libzt.a /dist/libzt.amd64.a
COPY --from=build-linux-i686 /workspace/build/lib/libzt.a /dist/libzt.i686.a
COPY --from=build-linux-arm /workspace/build/lib/libzt.a /dist/libzt.arm.a
COPY --from=build-linux-armv6 /workspace/build/lib/libzt.a /dist/libzt.armv6.a
COPY --from=build-linux-armv7 /workspace/build/lib/libzt.a /dist/libzt.armv7.a
COPY --from=build-linux-arm64 /workspace/build/lib/libzt.a /dist/libzt.arm64.a
COPY --from=build-linux-mips /workspace/build/lib/libzt.a /dist/libzt.mips.a
COPY --from=build-linux-mipsel /workspace/build/lib/libzt.a /dist/libzt.mipsel.a
COPY --from=build-linux-mips64 /workspace/build/lib/libzt.a /dist/libzt.mips64.a
COPY --from=build-linux-mips64el /workspace/build/lib/libzt.a /dist/libzt.mips64el.a
COPY --from=build-linux-ppc64 /workspace/build/lib/libzt.a /dist/libzt.ppc64.a
COPY --from=build-linux-ppc64le /workspace/build/lib/libzt.a /dist/libzt.ppc64le.a
COPY --from=build-linux-s390x /workspace/build/lib/libzt.a /dist/libzt.s390x.a
COPY --from=build-linux-riscv64 /workspace/build/lib/libzt.a /dist/libzt.riscv64.a
