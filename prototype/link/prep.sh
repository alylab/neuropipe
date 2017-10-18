#!/bin/bash
#
# prep.sh prepares for analysis of the subject's data
# original author: mason simon (mgsimon@princeton.edu)
# this script was provided by NeuroPipe. modify it to suit your needs

set -e

source globals.sh


echo "==Prep (1) : convert and wrap raw data =="
echo ' '
bash scripts/convert-and-wrap-raw-data.sh $DICOM_ARCHIVE $NIFTI_DIR $SUBJ $RUNORDER_FILE

echo "==Prep (2) : qa-wrapped-data=="
echo ' '
bash scripts/qa-wrapped-data.sh $NIFTI_DIR $QA_DIR

echo "==Prep (3) : reorient to las=="
echo ' '
bash scripts/reorient-to-las.sh $NIFTI_DIR

echo "==Prep (4) : B0 unwarp prep=="
echo ' '
# bash scripts/B0unwarpPrep.sh $NIFTI_DIR $SUBJ

echo "==Prep (5) : render-fsf-template=="
echo ' '
bash scripts/render-fsf-templates.sh

