#!/bin/sh -e

DIR=$PWD

cp -v ${DIR}/patches/bisect_defconfig ${DIR}/patches/defconfig

cd ${DIR}/KERNEL/
git bisect start
git bisect good v4.0
git bisect bad v4.1-rc1

#4 boards rebooting
git bisect bad 6c373ca89399c5a3f7ef210ad8f63dc3437da345 # v4.0-5833-g6c373ca

#1 board rebooting
git bisect bad e95e7f627062be5e6ce971ce873e6234c91ffc50 # v4.0-2825-ge95e7f6

#2 boards rebooting
git bisect bad c4be50eee2bd4d50e0f0ca58776f685c08de69c3 # v4.0-1399-gc4be50e

#5/5 boards 21 hours in..
#2/2 going foward moving 3 to next few...
git bisect good 1a370f4cd95e056d55ef5bf1a183880e70195e59 # v4.0-682-g1a370f4

#boards: 1 & 2...
git bisect good 3be1b98e073bdd4c1bb3144201a927c4a21330ba # v4.0-1013-g3be1b98

#boards: 3 & 4...
git bisect bad c6ab3aec4bc4beda2d6eb8ea43c6f5be3b215d3f # v4.0-rc3-96-gab330cf

#boards: 7 & 8...
git bisect bad ab330cf3888d8e0779fa05a243d53ba9f53a7ba9 # v4.0-rc3-96-gab330cf

#nuno's results:
#git bisect good 3be1b98e073bdd4c1bb3144201a927c4a21330ba # v4.0-1013-g3be1b98
#git bisect bad c6ab3aec4bc4beda2d6eb8ea43c6f5be3b215d3f # v4.0-rc5-193-gc6ab3ae
#git bisect bad ab330cf3888d8e0779fa05a243d53ba9f53a7ba9 # v4.0-rc3-96-gab330cf

git describe
cd ${DIR}/
