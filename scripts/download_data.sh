#! /bin/bash

scripts=$(dirname "$0")
base=$scripts/..

data=$base/data

mkdir -p $data

tools=$base/tools

# preprocess slightly

cat $data/rick_morty/raw/rick_morty_s010203.txt | python $base/scripts/preprocess_raw.py > $data/rick_morty/raw/rick_morty.cleaned.txt

# tokenize, fix vocabulary upper bound

cat $data/rick_morty/raw/rick_morty.cleaned.txt | python $base/scripts/preprocess.py --vocab-size 7000 --tokenize --lang "en" --sent-tokenize > \
    $data/rick_morty/raw/rick_morty.preprocessed.txt

# split into train, valid and test

head -n 1636 $data/rick_morty/raw/rick_morty.preprocessed.txt | tail -n 1636 > $data/rick_morty/valid.txt
head -n 3272 $data/rick_morty/raw/rick_morty.preprocessed.txt | tail -n 1636 > $data/rick_morty/test.txt
tail -n 13092 $data/rick_morty/raw/rick_morty.preprocessed.txt | head -n 13090 > $data/rick_morty/train.txt
