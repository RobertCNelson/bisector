#!/bin/sh -e

DIR=$PWD

cp -v ${DIR}/patches/bisect_defconfig ${DIR}/patches/defconfig

cd ${DIR}/KERNEL/
git bisect start
git bisect good v4.0
git bisect bad v4.1-rc1

#2/6 reboots...
git bisect bad 6c373ca89399c5a3f7ef210ad8f63dc3437da345
#2 reboots...
git bisect bad e95e7f627062be5e6ce971ce873e6234c91ffc50

git describe
cd ${DIR}/
