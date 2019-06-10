
Stream Endpoints
-----------------

    rtmps://stream-eu1-charlie.dropcam.com/nexus/32******************************75

Media info
-----------

    Codec : H264-MPEG-4- AVC
    res: 1280x738
    Audio: MPEG ACC Audio Sterio

Build
-------

    docker build -t ogavrisevs/nestcam:0.19 .
    docker push ogavrisevs/nestcam:0.19
    docker build -t ogavrisevs/nestcam .
    docker push ogavrisevs/nestcam:latest

Run local
----------

    docker run \
    --detach \
    --restart=always \
    -e "RUN_TIME=600" \
    -e "ACCESS_KEY=AK****************OQ" \
    -e "SECRET_KEY=V9**************************************0m" \
    -e "STREAM_URL=rtmps://stream-eu1-charlie.dropcam.com/nexus/32***************************75" \ ogavrisevs/nestcam:latest

Set up grafana google cloud
---------------------------

  helm install stable/grafana
  kubectl get secret --namespace default invinvible-rottweiler-grafana -o jsonpath="{.data.grafana-admin-password}" | base64 --decode ; echo

