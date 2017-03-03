#!/bin/bash -e

INST_DATE=`git show -s --format=%ci ${VERSION} | awk '{split($0,d,"[- ]"); print d[1]d[2]d[3]}'`
export INST_VERSION=${INST_DATE}-${VERSION}
export RISCV_PATH=${RISCV_BASE}/${INST_VERSION}
export PATH=${RISCV_PATH}/bin:${PATH}

git submodule update --init --recursive
./configure --prefix=${RISCV_PATH} --with-arch=rv32i
make ${JOBS}

mkdir -p ${RISCV_MODULEFILES}
cat <<EOF > ${RISCV_MODULEFILES}/${INST_VERSION}
#%Module
prepend-path PATH ${RISCV_PATH}/bin
EOF
