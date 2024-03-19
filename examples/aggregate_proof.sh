#!/bin/bash

rm -rf /tmp/output/
BASEDIR=test-vectors RUST_LOG=trace ELF_PATH=test-vectors/hello BLOCK_NO=13284491 SEG_OUTPUT=/tmp/output SEG_SIZE=$1    cargo run --release --example zkmips split

BASEDIR=test-vectors RUST_LOG=debug BLOCK_NO=13284491 SEG_FILE="/tmp/output/0" SEG_SIZE=$1 cargo run --release --example zkmips prove

BASEDIR=test-vectors RUST_LOG=info BLOCK_NO=13284491 SEG_FILE="/tmp/output/0" SEG_FILE2="/tmp/output/1" SEG_SIZE=$1 cargo run --release --example zkmips aggregate_proof
