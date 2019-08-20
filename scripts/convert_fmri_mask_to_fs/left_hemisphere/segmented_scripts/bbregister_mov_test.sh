#!/bin/bash
export SUBJECTS_DIR=/home/qigroup/Documents/projects/blast/derivatives/freesurfer

cd /home/qigroup/Documents/projects/blast/derivatives/freesurfer

mlist=$(cat /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/ROI.list.txt)
nlist=$(basename -s .mgh -a $mlist)
for i in $nlist;
	do
	bbregister --mov /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/$i.mgh \
		--s fsaverage --t1 \
		--reg /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/fsaverage_register_$i.dat ;
	done
	

