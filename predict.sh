#!/bin/bash

set -eou pipefail
IFS=$'\n\t'

shards=$1

for i in $(seq 0 "$((${shards}-1))"); do
    for j in {0..2492}; do
        echo "shard: $((${i}+1))/${shards}, requests: $((${j}+1))/100"
        r=$((${j}*${shards}/5))
        # r=$(5)
        python sisa.py --model purchase --test --dataset datasets/purchase/datasetfile --label "${r}" --batch_size 16 --container "${shards}" --shard "${i}"
    done
done
