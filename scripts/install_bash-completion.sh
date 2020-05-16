#!/bin/bash

startdir=`pwd`
tmpdir="/tmp/bash-completion"

git clone https://github.com/scop/bash-completion.git ${tmpdir}
cd ${tmpdir}
autoreconf -i
mkdir build
cd build
../configure --prefix=${HOME}/.bash-completion
make -j4
make install
cd ${startdir}
rm -rf ${tmpdir}
