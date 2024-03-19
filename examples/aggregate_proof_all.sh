#!/bin/bash

SEG_SIZE=1024
SEG_FILE_DIR=/tmp/output

rm -rf $SEG_FILE_DIR

BASEDIR=test-vectors RUST_LOG=trace ELF_PATH=test-vectors/hello BLOCK_NO=13284491 SEG_OUTPUT=$SEG_FILE_DIR SEG_SIZE=$SEG_SIZE ARGS="" cargo run --release --example zkmips split

SEG_FILE_NUM=$(ls $SEG_FILE_DIR -1 | wc -l)
echo "segment num: $SEG_FILE_NUM"

for (( i=0; i < $SEG_FILE_NUM; ++i ))
do
    echo "segment #$i"
    BASEDIR=test-vectors RUST_LOG=info BLOCK_NO=13284491 SEG_FILE="$SEG_FILE_DIR/$i" SEG_SIZE=$SEG_SIZE cargo run --release --example zkmips prove
done

BASEDIR=test-vectors RUST_LOG=trace BLOCK_NO=13284491 SEG_FILE_DIR="$SEG_FILE_DIR" SEG_FILE_NUM=$(ls $SEG_FILE_DIR -1 | wc -l) SEG_SIZE=$SEG_SIZE cargo run --release --example zkmips aggregate_proof_all
