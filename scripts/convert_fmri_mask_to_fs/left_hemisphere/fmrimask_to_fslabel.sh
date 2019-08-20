
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>mask2label_roi3_log.out 2>&1

export SUBJECTS_DIR=/home/qigroup/Documents/projects/blast/derivatives/freesurfer

cd /home/qigroup/Documents/projects/blast/derivatives/freesurfer

mlist=$(cat /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/ROI_3.list.txt)
for i in $mlist;
	do
	bbregister --mov /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/$i.mgh \
		--s fsaverage --t1 \
		--reg /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/fsaverage_register_$i.dat ;
	mri_vol2surf --mov /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/$i.mgh \
		--srcreg /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/fsaverage_register_$i.dat \
		--trgsubject fsaverage \
		--out /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/${i}_surf.mgh \
		--hemi lh ;
	cd /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask
	mri_cor2label --i ${i}_surf.mgh \
		--l ${i}_surf.label \
		--surf fsaverage lh --id 1 ;
	done
