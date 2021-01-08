
Stream Endpoints
-----------------

    18b43064ab85 - priekssa
    https://stream-eu1-charlie.dropcam.com/nexus_aac/32236e1a18974e3abebdf1eb93f8a875/playlist.m3u8?public=Lq8I8PL69l

    641666de23a6 - terase
    https://stream-eu1-charlie.dropcam.com/nexus_aac/121b3e6f27c64665ab49669d8a794558/playlist.m3u8?public=sDIhzEohqP

Media info
-----------

    Codec : H264-MPEG-4- AVC
    res: 1280x738
    Audio: MPEG ACC Audio Sterio

Build
-------

    rsync -avzh /home/me/work-priv/sec-cam do:/home/ubuntu

    docker build -t ogavrisevs/nestcam:0.22 .
    docker push ogavrisevs/nestcam:0.22
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
    ogavrisevs/nestcam:0.22

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
    ogavrisevs/nestcam:0.22
