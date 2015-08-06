#!/bin/sh -e

DIR=$PWD

cp -v ${DIR}/patches/bisect_defconfig ${DIR}/patches/defconfig

cd ${DIR}/KERNEL/
git bisect start
git bisect good v4.0
git bisect bad v4.1-rc1

# v4.0-5833-g6c373ca
# 5 boards rebooted

git bisect bad 6c373ca89399c5a3f7ef210ad8f63dc3437da345

# v4.0-2825-ge95e7f6
# 1 boards rebooted

git bisect bad e95e7f627062be5e6ce971ce873e6234c91ffc50

# v4.0-1399-gc4be50e
# 2 boards rebooted

git bisect bad c4be50eee2bd4d50e0f0ca58776f685c08de69c3

# v4.0-682-g1a370f4
# [test-bbb-5: 4.0.0-x0-00682-g1a370f4-dirty (up 1 day, 9 hours, 48 minutes)]
# [test-bbb-6: 4.0.0-x0-00682-g1a370f4-dirty (up 1 day, 9 hours, 44 minutes)]

git bisect good 1a370f4cd95e056d55ef5bf1a183880e70195e59

# v4.0-1013-g3be1b98
# [test-bbb-1: 4.0.0-x0-01013-g3be1b98-dirty (up 12 hours, 5 minutes)]
# [test-bbb-2: 4.0.0-x0-01013-g3be1b98-dirty (up 12 hours, 3 minutes)]

git bisect good 3be1b98e073bdd4c1bb3144201a927c4a21330ba

# unverfied...
# v4.0-rc5-193-gc6ab3ae
# [test-bbb-7: 
# [test-bbb-dc: 

#git bisect log
#git describe
#exit 2

#others: board 3 rebooted...
#git bisect bad c6ab3aec4bc4beda2d6eb8ea43c6f5be3b215d3f
#others: board 7 rebooted...
#git bisect bad ab330cf3888d8e0779fa05a243d53ba9f53a7ba9

#git bisect good
#git bisect bad 44b316525986252bb95d356419fc9e75f0532112
#git bisect log
#exit 2


#nuno's results:
#git bisect good 3be1b98e073bdd4c1bb3144201a927c4a21330ba # v4.0-1013-g3be1b98
#git bisect bad c6ab3aec4bc4beda2d6eb8ea43c6f5be3b215d3f # v4.0-rc5-193-gc6ab3ae
#git bisect bad ab330cf3888d8e0779fa05a243d53ba9f53a7ba9 # v4.0-rc3-96-gab330cf

#testing: board 3/7
#git bisect good 44b316525986252bb95d356419fc9e75f0532112

#testing: board 4/8
#git bisect bad 44b316525986252bb95d356419fc9e75f0532112

#git bisect good
#git bisect bad
#git bisect log
#exit 2

git describe
cd ${DIR}/
