#!/bin/bash
#Input sequences for alignment prefab data base
dir10=/prefab/prefab/in
dir11=/prefab/prefab/clustal_omega/aligned_seq/
dir12=/prefab/prefab/in_muscle
dir13=/prefab/prefab/muscle_dir/aligned_seq/
date=date
ref=/prefab/prefab/ref/
echo "Aligning the sequences using CLUSTAL OMEGA Algorithms"

cd $dir10
for f in *
do
	echo "$f"
	echo "Clustal Omega alignment is in process for file "$f""
$date
	./clustalo -i $f --verbose --force -o $dir11/$f  --log=clustalo_alignment.log
done

echo "Sequence Alignment using CLUSTAL OMEGA compeleted..!!!"
echo "######################################################################################"
$date
echo "Now aligning sequences using MUSCLE Algorithms"

cd $dir12

for f in *
do
	echo "Sequence alignment for "$f" began"
	echo "MUSCLE algorithm is in process for aligning sequences in sequences "$f""

$date
	./muscle -in $f -out $dir13/$f -loga /prefab/prefab/muscle_alignment.log
done
echo "Sequence Alignment using MUSCLE Algorithm has been completed....!!!"
echo "######################################################################################"
$date

echo "Alignment of sequence completed for Prefab database..!!"
echo "Complete and exit..!!"

echo "Now Calculating the Quality score for prefab database alignments...!!"
cp /prefab/prefab/src/qscore/qscore $dir11
cd $dir11
for f in *
do
echo "Calculating quality score for Clustal omega sequences..!!"
	./qscore -test $f -ref $ref$f 
$date
done
echo "Completed the quality score calculation for clustal omega sequences"

echo "                                                                   "
echo "									"
cp /prefab/prefab/src/qscore/qscore $dir13
cd $dir13
echo "########################################################################################"
for  f in *
do
echo "Calculating quality score for MUSCLE  sequences..!!"
	./qscore -test $f -ref $ref$f
$date
done
echo "Completed the quality score calculation for clustal omega sequences"

echo "##########################################################################################"
