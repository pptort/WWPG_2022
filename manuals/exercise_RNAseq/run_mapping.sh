#!/usr/bin/env bash

N=$(ls | grep ".fastq.gz" | sed 's/_[1-2].fastq.gz//g' | sort | uniq)


for i in $N
do
	echo ">> Maping $i RNA-seq data to the reference genome"
	hisat2 --max-intronlen 10000 -x PbANKA_v3_hisat2id -1 "$i"_1.fastq.gz -2 "$i"_2.fastq.gz -S "$i".sam
	echo ">> Converting SAM file to a BAM"
	samtools view -b -o "$i".bam "$i".sam

	echo ">> Sorting $i BAM file"
	samtools sort -o "$i"_sorted.bam "$i".bam

	echo ">> Indexing $i BAM file"
	samtools index "$i"_sorted.bam

	echo ">> Removing SAM and unsorted BAM files for $i sample"
	rm "$i".sam "$i".bam

	echo -e "\n"
done
