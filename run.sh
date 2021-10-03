#!/bin/bash

# debug me
set -x

RUN_TIME="${RUN_TIME:-10}"
BUCKET="ams3.digitaloceanspaces.com"
HOST_BUCKET="%(bucket)s.ams3.digitaloceanspaces.com"
BUCKET_SUB_FOLDER="${BUCKET_SUB_FOLDER:-device-id}"
OUTPUT_DIR="${OUTPUT_DIR:-/home/vlc/to_cloud}"
BUCKET_NAME="${BUCKET_NAME:-sec-cam}"
minimumsize=100000
sleeptime=1

mkdir -p  $OUTPUT_DIR

while :
do

  DATE=`date +%Y_%m_%d`
  TIME=`date +%H_%M_%S`
  FILE="${DATE}_${TIME}.mp4"

  ffmpeg -nostdin -i $STREAM_URL -t $RUN_TIME -c copy -bsf:a aac_adtstoasc ${OUTPUT_DIR}/${FILE}
  ret=$?
  if [ $ret -ne 0 ]; then
    echo "[`date +%Y_%m_%d-%H_%M_%S`] Stream closed, pausing : $sleeptime"
    sleep $sleeptime
    continue
  fi

  # Check file exists
  if [ -f "${OUTPUT_DIR}/${FILE}" ]; then
      # Check file size
      actualsize=$(wc -c <"${OUTPUT_DIR}/${FILE}")
      if [ $actualsize -ge $minimumsize ]; then
        s3cmd --access_key=$ACCESS_KEY --secret_key=$SECRET_KEY  --host=$BUCKET --host-bucket=$HOST_BUCKET put $OUTPUT_DIR/$FILE s3://$BUCKET_NAME/$BUCKET_SUB_FOLDER/$DATE/$FILE
      else
        echo "File too small"
        continue
      fi
      # remove file
      rm $OUTPUT_DIR/$FILE
  fi
  rm -rfv $OUTPUT_DIR/*
done
