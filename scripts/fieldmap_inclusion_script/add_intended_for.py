from glob import glob
from os.path import join, splitext
from bids import BIDSLayout
from dateutil.parser import parse
import re
import json
import bisect
import os
import os.path as op
import logging
import sys

# make sure python 3.7 is enabled by exporting path to location of anaconda3 folder
export PATH=/home/jlegault/anaconda3/bin:$PATH

# make sure you are using pybids version 0.6.5 
pip install pybids==0.6.5

# Command to run script: python3.7 add_intended_for_2.py /path_to_subjdir/
	# you must include the trailing / at the end of the subject directory 

# Designate subject directory when you run command and fMRI file type to include in intended for portion
subj_dir = sys.argv[1]
data_suffix = '.nii.gz'

layout = BIDSLayout(subj_dir)


def files_to_dict(file_list):
    """Convert list of BIDS Files to dictionary where key is
    acquisition time (datetime.datetime object) and value is
    the File object.
    """
    out_dict = {}
    for f in file_list:
        fn = f.filename
        with open(fn, 'r') as fi:
            data = json.load(fi)
        dt = parse(data['AcquisitionTime'])
        out_dict[dt] = f
    return out_dict


# Get json files for field maps
fmap_jsons = layout.get(modality='fmap', extensions='phasediff.json')

fmap_dict = files_to_dict(fmap_jsons)
dts=sorted(fmap_dict.keys())
intendedfor_dict = {fmap.filename: [] for fmap in fmap_jsons}

# Get all scans with associated field maps

func_jsons = layout.get(type='bold', extensions='json') + \
             layout.get(type='rest', extensions='json') + \
             layout.get(type='langloc', extensions='json')

func_dict = files_to_dict(func_jsons)

for func in func_dict.keys():
    fn, _ = splitext(func_dict[func].filename)
    fn += data_suffix
    fn = fn.split(subj_dir)[-1]

    # Find most immediate field map before scan
    idx = bisect.bisect_right(dts, func) - 1
    fmap_file = fmap_dict[dts[idx]].filename
    intendedfor_dict[fmap_file].append(fn)

for fmap_file in intendedfor_dict.keys():
    with open(fmap_file, 'r') as fi:
        data = json.load(fi)

    # Overwrites original json file
    if 'IntendedFor' not in data.keys():
        data['IntendedFor'] = intendedfor_dict[fmap_file]
        with open(fmap_file, 'w') as fo:
            json.dump(data, fo, indent=4, sort_keys=True)
