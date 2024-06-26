#! /bin/bash

scripts=$(dirname "$0")
base=$(realpath $scripts/..)

models=$base/models
data=$base/data
tools=$base/tools

mkdir -p $models

num_threads=4
device=""

SECONDS=0

(cd $tools/pytorch-examples/word_language_model &&
    CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python main.py --data $data/rick_morty \
        --epochs 40 \
        --log-interval 100 \
        --emsize 200 --nhid 200 --dropout 0 0.2 0.4 0.5 0.6 0.8 --tied \
        --save $models/model.pt \
        --mps
)

echo "time taken:"
echo "$SECONDS seconds"
