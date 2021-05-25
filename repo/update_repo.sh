#!/usr/bin/env bash
cd $(dirname "$0")
FTPARCHIVE='apt-ftparchive'
for arch in iphoneos-arm; do
    echo $dist $arch
    binary=binary-${arch}
    contents=Contents-${arch}
    mkdir -p ${binary}
    rm -f {Release{,.gpg},${binary}/{Packages{,.xz,.zst},Release{,.gpg}}}

    $FTPARCHIVE packages pool > \
            ./Packages 2>/dev/null
    xz -c9 ./Packages > ./Packages.xz
    zstd -q -c19 ./Packages > ./Packages.zst

    $FTPARCHIVE release -c config/zebra.conf . > Release 2>/dev/null
done
