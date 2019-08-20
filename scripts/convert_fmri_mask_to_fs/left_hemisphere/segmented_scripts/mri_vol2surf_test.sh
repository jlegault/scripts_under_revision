#!/bin/bash
export SUBJECTS_DIR=/home/qigroup/Documents/projects/blast/derivatives/freesurfer

cd /home/qigroup/Documents/projects/blast/derivatives/freesurfer

mlist=$(cat /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/ROI.list.txt)
nlist=$(basename -s .mgh -a $mlist)
for i in $nlist;
	do
	mri_vol2surf --mov /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/$i.mgh \
		--srcreg /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/fsaverage_register_$i.dat \
		--trgsubject fsaverage \
		--out /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/${i}_surf.mgh \
		--hemi lh ;
	done
	

