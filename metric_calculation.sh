#!/bin/bash
#Script for calculating different for benchmarking the performance of Multiple sequence alignment algorithms
#Calculating the benchmark structure similarity from OXBENCH data set 
#setting environment variable for oxbench benchmark
dir0=/oxbench/oxbench_1_3/data/seq/master
export OXBENCH=/oxbench/oxbench_1_3/
#This is the home director created for storing the stamp metric output
dir1=/oxbench/oxbench_1_3/example/clustalo_dir/master/stamp
#directory contains the files that were aligned with clustal omega algorithm
dir2=/oxbench/oxbench_1_3/example/clustalo_dir/master/fasta_align/clustal_align
#column score home directory for storing the column score ouptput for clustal Omega algorithm
dir3=/oxbench/oxbench_1_3/example/clustalo_dir/master/column_score
#Home directory for storing the average accuracy ouptput for clustal Omega algorithm
dir4=/oxbench/oxbench_1_3/example/clustalo_dir/master/dep
#directory contains the files that were aligned with muscle algorithm
dir5=/oxbench/oxbench_1_3/example/muscle_dir/master/muscle_align
#This is the home director created for storing the stamp metric output for muscle aligned sequences
dir6=/oxbench/oxbench_1_3/example/muscle_dir/master/stamp
#Home directory for storing the average accuracy ouptput for clustal Omega algorithm
dir7=/oxbench/oxbench_1_3/example/muscle_dir/master/dep
#column score home directory for storing the column score ouptput for muscle algorithm
dir8=/oxbench/oxbench_1_3/example/muscle_dir/master/column_score
#Converted file location for alignment
dir9=/oxbench/oxbench_1_3/example/clustalo_dir/master/fasta
#present date
date=date

echo "Initialization Compeleted..!!!"

#Conversion of file from PIR to FASTA
echo "Datafile conversion from PIR to FASTA format for giving input to algorithms."
cd $dir0
for f in *
do 
        echo "Processing file "$f"....!!!"
        $date
        echo ""$f"getting converted to fasta for alignment" >> ../convertion.log
        ./aconvert -in p -out f <$f> /oxbench/oxbench_1_3/example/clustalo_dir/master/fasta/"$f.fa"
        echo ""$f" converted to fasta" >> ../convertion.log
	echo "Convertion completed..!!" >> ../convertion.log
done

echo "Conversion of unaligned sequences from PIR to FASTA compeleted..!!!"

#sequence alignment using algorithms

cd $dir10
for f in *
do
        echo "$f"
        echo "Clustal omega alignmnent is in process for file "$f""
        echo " ####################-- "$date"--#####################" >> ../clustal_omega_align.log
        ./clustalo -i $f --verbose --force -o $dir/$f --log ../clustal_alignment.log
        echo "Mutliple sequence alignment for sequence "$f" is completed.!!!!" >>../ clustal_omega_align.log
        echo "#################### -- "$date"--###################" >> ../clustal_omega_align.log
done

cd /oxbench/oxbench_1_3/example/clustalo_dir/master/fasta_muscle
for f in *
do
        echo "Muscle alignment is in process for file "$f""
        echo "################---"$date"--#####################" >> ../muscle_align.log
        ./muscle -in $f -out $dir/$f -loga ../muscle_alignment.log
        echo "Mutliple sequence alignment for sequence "$f" is completed.!!!!" >> ../muscle_align.log
        echo "#################### -- "$date"--###################" >> ../muscle_align.log
done
echo "Alignment of the sequences has been completed"

echo "Now we would be calculating the meterics calculation using OXBENCH suite..!!"
# Performing metrics calculation
echo "Intializing performed..!!"
echo "Starting OXBENCH benchmark evaluation for Clustal Omega & MUSCLE algorithms"

cd $dir1
#Calculating the structure similarity measure for clustal Omega Alignment algorithm
echo "Calculating the strucuture similarity for the sequences...!!!"
	./run_metric.pl stamp mref.id --testdir $dir2 --suffix .fa
	echo "metric calculation completed"
$date
echo "Completed....!!!"
echo "Now calculating the column score measure ..!!!!"

cd $dir3
#Calculating the column score for finding the column score
	echo "calculating the column score for the sequences..!!!"
		./run_metric.pl column  mref.id --testdir $dir2 --suffix .fa
	$date
	echo "Completed calculation of Column scores....!!!!"

echo "Now calculating the dependent average accuray...!!!"
#Calculating the dependent average accuracy for the clustal omega aligned sequences
cd $dir4
	./run_metric.pl dep  mref.id --testdir $dir2 --suffix .fa
	$date
	echo "Completed calculation of dependent average accuracy...!!!"

echo "Metric Calculation for CLUSTAL OMEGA Algorithm has been completed...!!!"

##Calculating the structure similarity measure for MUSCLE algorithm
cd $dir6
echo "Calculating the strucuture similarity for the sequences...!!!"
	./run_metric.pl stamp mref.id --testdir $dir5 --suffix .fa
	echo "metric calculation completed"
$date
echo "Completed....!!!"
echo "Now calculating the column score measure ..!!!!"

cd $dir7 
	echo "calculating the column score for the sequences..!!!"
        ./run_metric.pl column  mref.id --testdir $dir5 --suffix .fa
$date
echo "Completed calculation of Column scores....!!!!"

echo "Now calculating the dependent average accuray...!!!"
cd $dir8
	echo "Calculating average dependent accuracy for Muscle aligned sequences"
	./run_metric.pl dep  mref.id --testdir $dir5 --suffix .fa
	echo "DEP calculation completed..!!!"
$date
echo "Metric Calculation for MUSCLE Algorithm has been completed...!!!"

