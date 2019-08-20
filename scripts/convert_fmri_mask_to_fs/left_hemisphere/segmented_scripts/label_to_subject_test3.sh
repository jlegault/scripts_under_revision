#!/bin/bash
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3 RETURN
exec 1>log.out 2>&1
return
exit 0

export SUBJECTS_DIR=/home/qigroup/Documents/projects/blast/derivatives/freesurfer

cd /home/qigroup/Documents/projects/blast/derivatives/freesurfer

mlist=$(cat /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/ROI_2.list.txt)
flist=$(cat /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/subject.list.txt)

for roi in $mlist;
	do
	for subject in $flist;
		do
			mri_label2label --srcsubject fsaverage \
			--srclabel /home/qigroup/Documents/projects/blast/derivatives/freesurfer/fsaverage/label/${roi}_surf.label \
			--trgsubject $subject --trglabel /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/${subject}_${roi}_surf.label \
			--regmethod surface --hemi lh ;
		done
	done
