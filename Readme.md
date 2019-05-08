## Comparative Analysis of Multiple Sequence Algorithm for the study DNA, RNA and protein nucleotides

A. metric_calculation.sh  -
- This files does the following function
1. Take into the input file in PIR format then convert it to FASTA format as required for alignment
2. Multiple Sequence Alignment algorithm implementation to alignign the sequences
3. Performs benchmark analysis using OXBENCH suit to give following metrics
	a. Strucuture Similarity score
	b. Column score
	c. Dependent accuarcy score

B.prefab_alignmet.sh
-This file does following function
1. Takes into the input from prefab data and perform sequence alignment using Clustal Omega and Muscle Alogrithm
2. Perform benchmark  analysis using PREFAB suit to give following metrics
	a. quality score
	b. Column score
	c. Shift score

These files are written taking into consideration of my Linux server environment, hence would just need to change directories while implementing this.


