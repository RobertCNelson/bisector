#!/bin/sh -e
#
# Copyright (c) 2012 Robert Nelson <robertcnelson@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

DIR=$PWD

if [ ! -f "${DIR}/patches/bisect_defconfig" ] ; then
	cp "${DIR}/patches/defconfig" "${DIR}/patches/bisect_defconfig"
fi

cp -v "${DIR}/patches/bisect_defconfig" "${DIR}/patches/defconfig"

cd "${DIR}/KERNEL/" || exit
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
# [test-bbb-5: 4.0.0-x0-00682-g1a370f4-dirty (up 2 days, 12 hours, 13 minutes)]
# [test-bbb-6: 4.0.0-x0-00682-g1a370f4-dirty (up 2 days, 12 hours, 9 minutes)]

git bisect good 1a370f4cd95e056d55ef5bf1a183880e70195e59

# v4.0-1013-g3be1b98
# [test-bbb-1: 4.0.0-x0-01013-g3be1b98-dirty (up 1 day, 14 hours, 30 minutes)]
# [test-bbb-2: 4.0.0-x0-01013-g3be1b98-dirty (up 1 day, 14 hours, 28 minutes)]

git bisect good 3be1b98e073bdd4c1bb3144201a927c4a21330ba

# unverfied... (doesn't matter as next was bad..)
# v4.0-rc5-193-gc6ab3ae

git bisect bad c6ab3aec4bc4beda2d6eb8ea43c6f5be3b215d3f #nuno
#git bisect good c6ab3aec4bc4beda2d6eb8ea43c6f5be3b215d3f

# v4.0-rc3-96-gab330cf
# 1 boards rebooted

git bisect bad ab330cf3888d8e0779fa05a243d53ba9f53a7ba9

# v4.0-rc3-48-g44b3165
# 1 boards rebooted

git bisect bad 44b316525986252bb95d356419fc9e75f0532112

# v4.0-rc3-24-gd5fa3e9
# [test-bbb-4: 4.0.0-rc3-x0-00024-gd5fa3e9-dirty (up 1 day, 5 hours, 20 minutes)]
# [test-bbb-dc: 4.0.0-rc3-x0-00024-gd5fa3e9-dirty (up 1 day, 3 hours, 7 minutes)]

###TESTING>>>

#testing: 3
#git bisect bad d5fa3e9f7398adf337f03fa3257d5e9b214078ee

# v4.0-rc3-12-g28378d5
# [test-bbb-3: 4.0.0-rc3-x0-00012-g28378d5-dirty (up 1 day, 1 hour, 21 minutes)]

#testing: 7
#git bisect good d5fa3e9f7398adf337f03fa3257d5e9b214078ee

# v4.0-rc3-36-gccf5fb6
# [test-bbb-7: 4.0.0-rc3-x0-00036-gccf5fb6-dirty (up 1 day, 1 hour, 9 minutes)]

#git bisect log
#git describe
#exit 2

git describe
cd "${DIR}/" || exit
