
# Exercise 1 

## Map the RNA-seq data to the reference

Go to the exercise directory
$ cd /home/manager/Task_1_SexualDevelopment

Index the genome reference sequence
$ hisat2-build PbANKA_v3.fa PbANKA_v3_hisat2id

map reads 2 references
$ hisat2 --max-intronlen 1000 -x PbANKA_v3_hisat2id -1 Pb_MUT1_1.fastq.gz -2 Pb_MUT1_2.fastq.gz -S MT1.sam 

convert sam 2 bam
$ samtools view -b -o MT1.bam MT1.sam

sort bam file
$ samtools sort -o MTst.bam MT1.bam

index sortedbam file
$	samtools index MT1st.bam

# repeat for the other 5 experimental conditions 

	#remove the sam and bam (unsorted) files
	rm MT[1-3].sam WT[1-3].sam MT[1-3].bam WT[1-3].bam 

Is quite boring to repeat all the commands all the time so why dont you try to generate a bash script with iterations to do it?

Map the reads trying to use a bash script with iterations (run_mapping.sh)
$ chmod +x run_mapping.sh #make the script executable 
$ ./run_mapping.sh 

# Exercise 2 

## Confirm the knockout in the mutant samples

Index the fasta file so Artemis can view each chromosome separately

$ samtools faidx PbANKA_v3.fa

load the reference and the mapping data on artemis

$ art -Dbam="Pb_MUT1_sorted.bam,Pb_MUT2_sorted.bam,Pb_MUT3_sorted.bam,Pb_WT1_sorted.bam,Pb_WT2_sorted.bam,Pb_WT3_sorted.bam" PbANKA_v3.fa &

Select ”Use index” so Artemis will show individual chromosomes.

Right click on the BAM view, and clone the window and de-select one of the condition in each view so you can have MT and WT separately.

Go to chromosome 14 and upload annotation file provided for this chromosome (PbANKA_14_v3.embl).

Press ctrl-g and use Goto Feature With Gene Name to navigate to the gene "AP2-G". 

Remember that this gene was knocked out in MT parasites, so we do not expect to find many reads on this gene in the MT samples. 
Visualize that there are practically no reads mapping to this gene in MT sample. 
A good practice is to count reads and calculate RPKM and compare these parameters between samples.

# Exercise 3


## Call differentially expressed genes

Kalliso and Sleuth are going to used in order to identify differentially expressed genes.

Kallisto needs an index of the transcript sequences.

$ kallisto index -i PbANKA_v3_kallisto PbANKA_v3_transcriptome.fa

Quantify the expression levels of your transcripts for all the samples. Again you can go file by file or ...
yes, you're right it's a good oportinuity to practice interations 
generate a bash script for doing it (run_kallisto.sh provided)

$ chmod +x run_kallisto.sh 

$ ./run_kallisto.sh 


# Exercise 4

## Perform a Gene Ontology enrichment analysis (we have provided an R script to help with this)
