#!/bin/bash
# author: Alexa Tompary

set -e  # fail immediately on error

if [ $# -ne 1 ]; then
  echo "
usage: `basename $0`  nifti_folder

re-orients your nifti volumes and bxh headers to LAS order.

BXH XCEDE tools must be in the path for this script to run.

see http://nifti.nimh.nih.gov/nifti-1 for details on NIfTi format.
see http://nbirn.net/tools/bxh_tools/index.shtm for details on BXH headers.
  "
  exit
fi

source globals.sh

nifti_folder=$1
ORIENTATION=LAS
#cd data/nifti
for bxh_file in data/nifti/*.bxh; do

  echo $bxh_file
	# reorient each scan
  temp=$bxh_file.old_orientation.bxh
  mv $bxh_file $temp
  pwd | ls
  echo "move"
  bxhreorient --overwrite --orientation=$ORIENTATION $temp $bxh_file
  rm -f $temp
  
	# reconvert the scan
  file_prefix=${bxh_file%%.*}
  bxh2analyze --overwrite --analyzetypes --niigz --niftihdr -s $bxh_file $file_prefix >/dev/null
done
echo "done"  
 rm -rf ${nifti_folder}/*.dat
