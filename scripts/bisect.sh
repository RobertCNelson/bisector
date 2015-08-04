#!/bin/sh -e

DIR=$PWD

cp -v ${DIR}/patches/bisect_defconfig ${DIR}/patches/defconfig

cd ${DIR}/KERNEL/
git bisect start
git bisect good v4.0
git bisect bad v4.1-rc1

#05833-g6c373ca-dirty
#4 boards rebooting
git bisect bad 6c373ca89399c5a3f7ef210ad8f63dc3437da345
#02825-ge95e7f6-dirty
#1 board rebooting
git bisect bad e95e7f627062be5e6ce971ce873e6234c91ffc50
#01399-gc4be50e-dirty
#2 boards rebooting
git bisect bad c4be50eee2bd4d50e0f0ca58776f685c08de69c3

git describe
cd ${DIR}/
