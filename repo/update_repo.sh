#!/usr/bin/env bash
cd $(dirname "$0")
FTPARCHIVE='apt-ftparchive'
for arch in iphoneos-arm; do
    echo $dist $arch
    binary=binary-${arch}
    contents=Contents-${arch}
    mkdir -p ${binary}
    rm -f {Release{,.gpg},${binary}/{Packages{,.bz2,xz,.zst},Release{,.gpg}}}

    $FTPARCHIVE packages pool > \
            ./Packages 2>/dev/null
    bzip2 -c9 ./Packages > ./Packages.bz2
    xz -c9 ./Packages > ./Packages.xz
    zstd -q -c19 ./Packages > ./Packages.zst

    $FTPARCHIVE release -c config/zebra.conf . > Release 2>/dev/null
done
