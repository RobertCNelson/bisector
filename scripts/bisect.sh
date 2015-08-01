#!/bin/sh -e

DIR=$PWD

cp -v ${DIR}/patches/bisect_defconfig ${DIR}/patches/defconfig

cd ${DIR}/KERNEL/
git bisect start
git bisect good v4.0
git bisect bad v4.1-rc1


git describe
cd ${DIR}/
