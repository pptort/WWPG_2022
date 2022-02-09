#!/usr/bin/env bash

N=$(ls | grep ".fastq.gz" | sed 's/_[1-2].fastq.gz//g' | sort | uniq)

for i in $N; do kallisto quant -i PbANKA_v3_kallisto -o $i -b 100 "$i"_1.fastq.gz "$i"_2.fastq.gz; done




