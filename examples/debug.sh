#!/bin/bash

SEG_SIZE=$1
SEG_FILE_DIR=/tmp/output

SEG_FILE_NUM=$(ls $SEG_FILE_DIR -1 | wc -l)
echo "segment num: $SEG_FILE_NUM"

for ((i = 0; i < $SEG_FILE_NUM; ++i)); do
    echo "segment #$i"
    BASEDIR=test-vectors RUST_LOG=info BLOCK_NO=13284491 SEG_FILE_DIR="$SEG_FILE_DIR" SEG_FILE_NUM=$i SEG_SIZE=$SEG_SIZE cargo run --release --example zkmips aggregate_proof_all_debug
done
