
Stream Endpoints
-----------------

    18b43064ab85
    https://stream-eu1-charlie.dropcam.com:443/nexus_aac/12************58/playlist.m3u8?public=sDIhzEohqP
    
    641666de23a6
    https://stream-eu1-bravo.dropcam.com/nexus_aac/32*****************75/playlist.m3u8?public=Lq8I8PL69l

Media info
-----------

    Codec : H264-MPEG-4- AVC
    res: 1280x738
    Audio: MPEG ACC Audio Sterio

Build
-------
    
    rsync -avzh /home/me/work-priv/sec-cam do:/root/

    docker build -t ogavrisevs/nestcam:0.20 .
    docker push ogavrisevs/nestcam:0.20
    docker build -t ogavrisevs/nestcam .
    docker push ogavrisevs/nestcam:latest

Run local
----------

    docker rm -f out-1
    source secrets
    docker run \
    --detach \
    --restart=always \
    --name out-1 \
    -e "RUN_TIME=600" \
    -e "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" \
    -e "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" \
    -e "BUCKET_SUB_FOLDER=18b43064ab85" \
    -e "STREAM_URL=$STREAM1" \
    ogavrisevs/nestcam:0.20

   docker run \
    --detach \
    --restart=always \
    --name out-2 \
    -e "RUN_TIME=600" \
    -e "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" \
    -e "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" \
    -e "BUCKET_SUB_FOLDER=641666de23a6" \
    -e "STREAM_URL=$STREAM2" \
    ogavrisevs/nestcam:0.20


