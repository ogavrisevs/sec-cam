
Stream Endpoints
-----------------

    rtmps://stream-ire-alfa.dropcam.com/nexus/62e26******************350874785de
    https://stream-ire-alfa.dropcam.com/nexus_aac/62e262d*******785de/playlist.m3u8
    https://stream-ire-alfa.dropcam.com/nexus_aac/32236e1*******8a875/playlist.m3u8

Media info
-----------

    Codec : H264-MPEG-4- AVC
    res: 1280x738
    Audio: MPEG ACC Audio Sterio

Store stream
------------

Trought transcode to file:

    vlc -I dummy --run-time=60 https://stream-ire-alfa.dropcam.com/nexus_aac/62**********************************de/playlist.m3u8 --sout "#transcode{vcodec=h264,acodec=mpga,ab=128,channels=2,samplerate=44100}:file{mux=mp4,dst=out.mp4,access=file}" vlc://quit

Directly to file:

    vlc -I dummy --run-time=60 https://stream-ire-alfa.dropcam.com/nexus_aac/62**************************de/playlist.m3u8 --sout "#file{mux=mp4,dst=out.mp4,access=file}" vlc://quit

VLC params
------------

    https://wiki.videolan.org/VLC_command-line_help/

Run container
-------------

    docker run -it -v ~/work/sec-cam/out/:/home/vlc/ vlc https://stream-ire-alfa.dropcam.com/nexus_aac/62****************************de/playlist.m3u8 vlc://quit

Build
-------

    docker build -t ogavrisevs/nestcam:0.15 .
    docker push ogavrisevs/nestcam:0.15
    docker build -t ogavrisevs/nestcam .
    docker push ogavrisevs/nestcam:latest

Run local
----------

    docker run \
    --detach \
    -e "RUN_TIME=180" \
    -e "AWS_ACCESS_KEY_ID=AK****************OQ" \
    -e "AWS_SECRET_ACCESS_KEY=V9**************************************0m" \
    -e "STREAM_URL=https://stream-ire-alfa.dropcam.com/nexus_aac/32**********************75/playlist.m3u8" \ ogavrisevs/nestcam:latest

Set up grafana google cloud
---------------------------

  helm install stable/grafana
  kubectl get secret --namespace default invinvible-rottweiler-grafana -o jsonpath="{.data.grafana-admin-password}" | base64 --decode ; echo

Create Google container cluster
---------------------------------
  gcloud config set project midyear-respect-167907
  gcloud container clusters list
  gcloud container clusters create cluster-1 --zone europe-west1-d --enable-kubernetes-alpha --num-nodes 2 --machine-type n1-standard-1 --max-nodes 2
