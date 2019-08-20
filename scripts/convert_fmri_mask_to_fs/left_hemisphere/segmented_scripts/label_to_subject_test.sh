export SUBJECTS_DIR=/home/qigroup/Documents/projects/blast/derivatives/freesurfer

cd /home/qigroup/Documents/projects/blast/derivatives/freesurfer

mlist=$(cat /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/ROI.list.txt)
nlist=$(basename -s .mgh -a $mlist)
flist=$(cat /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/subject.list.txt)
glist=$(basename -a $flist)
for i in $nlist;
	do
	mri_label2label --srcsubject fsaverage \
		--srclabel /home/qigroup/Documents/projects/blast/derivatives/freesurfer/fsaverage/label/${i}_surf.label \
		--trgsubject $s --trglabel /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/${s}_${i}_surf.label \
		--regmethod surface --hemi lh \

	for s in $glist;
		do
			mri_label2label --srcsubject fsaverage \
			--srclabel /home/qigroup/Documents/projects/blast/derivatives/freesurfer/fsaverage/label/${i}_surf.label \
			--trgsubject $s --trglabel /home/qigroup/Documents/projects/blast/derivatives/freesurfer/freesurfer_fsgd_analyses/mask_files/fedorenko_overlap_mask/${s}_${i}_surf.label \
			--regmethod surface --hemi lh ;
	done
