#push to my dockerhub

TAG=0.0.0
docker image tag rucio-intertwin leggerf/rucio-intertwin:$TAG 
docker push leggerf/rucio-intertwin:$TAG

