Media info
-----------

    Codec : H264-MPEG-4- AVC
    res: 1280x738
    Audio: MPEG ACC Audio Sterio

Build
-------

    rsync -avzh /Users/me/work-priv/sec-cam do:/home/ubuntu

    docker build -t ogavrisevs/nestcam:25 .
    docker push ogavrisevs/nestcam:25
    docker build -t ogavrisevs/nestcam:latest .
    docker push ogavrisevs/nestcam:latest

Run local
----------

    docker rm -f out-1
    source secrets
    docker run \
    --detach \
    --restart=always \
    --name out-1 \
    --log-opt max-size=10m \
    --log-opt max-file=5 \
    -e "RUN_TIME=600" \
    -e "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" \
    -e "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" \
    -e "BUCKET_SUB_FOLDER=18b43064ab85" \
    -e "STREAM_URL=$STREAM1" \
    ogavrisevs/nestcam:25

   docker rm -f out-2
   docker run \
    --detach \
    --restart=always \
    --name out-2 \
    --log-opt max-size=10m \
    --log-opt max-file=5 \
    -e "RUN_TIME=600" \
    -e "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" \
    -e "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" \
    -e "BUCKET_SUB_FOLDER=641666de23a6" \
    -e "STREAM_URL=$STREAM2" \
    ogavrisevs/nestcam:25


Install postfix
-----------------

    apt-get install postfix

Install rclone
-----------------

    curl https://rclone.org/install.sh | sudo bash

    vim ~/.config/rclone/rclone.conf

    [do]
    type = s3
    env_auth = false
    access_key_id = XE**************XS
    secret_access_key = 8s****************************vY
    endpoint = ams3.digitaloceanspaces.com
    acl = private
    
    rclone size do:sec-cam --include "18b43064ab85/2021_05_08/**" --json

    rclone serve http  do: --addr 138.197.181.219:8182 --htpasswd htpasswd

    rclone delete do: --max-age 30
    rclone rmdir do: --max-age 30
