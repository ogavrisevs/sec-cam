#!/bin/bash

# debug me
set -x

RUN_TIME="${RUN_TIME:-60}"
BUCKET_SUB_FOLDER="${BUCKET_SUB_FOLDER:-device-id}"
export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-eu-central-1}"
export S3_USE_SIGV4="True"
OUTPUT_DIR="${OUTPUT_DIR:-/home/vlc/to_cloud}"
BUCKET_NAME="${OUTPUT_DIR:-sec-cam}"

mkdir -p  $OUTPUT_DIR
DATE=`date +%Y_%m_%d`
TIME=`date +%H_%M_%S`

FILE="${DATE}_${TIME}.mp4"

/usr/bin/vlc -v -I dummy --run-time=$RUN_TIME --sout "#file{mux=mp4,dst=${OUTPUT_DIR}/${FILE},access=file}" $STREAM_URL vlc://quit

# Check file exists
if [ ! -f "${OUTPUT_DIR}/${FILE}" ]; then
    echo "File not found! :: ${OUTPUT_DIR}/${FILE} "
    exit 1
fi

# Check file size
minimumsize=500000
actualsize=$(wc -c <"${OUTPUT_DIR}/${FILE}")
if [ $actualsize -ge $minimumsize ]; then
  aws s3 cp $OUTPUT_DIR/$FILE s3://$BUCKET_NAME/$BUCKET_SUB_FOLDER/$DATE/$FILE
else
  echo "file size is less then $minimumsize bytes"
  exit 1
fi