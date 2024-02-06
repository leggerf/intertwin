# k8s infrastructure

## To access the k8s cluster at CNAF

```
source ./setup-k8s.sh
```

## Current namespaces

```
k get ns
NAME                   STATUS   AGE
default                Active   44d
kube-system            Active   44d
kube-public            Active   44d
kube-node-lease        Active   44d
kubernetes-dashboard   Active   13d
airflow                Active   13d
minio                  Active   12d
elastic                Active   12d
kafka                  Active   5d21h
```

## Remove pods

- to remove pods based on namespace and name, edit and execute ```./delete-pods.sh```

## Airflow

```
k get pods -n airflow
```

- to see the Airflow dashboard, do ```kubectl port-forward svc/airflow-webserver 8080:8080 --namespace airflow``` or
```
source ./setup-port.sh
```
- go to [http://localhost:8080/](http://localhost:8080/) (admin/admin)

- DAGs are kept in Intertwin [GH repo](https://github.com/interTwin-eu/DT-Virgo-dags)
- Currently image pull from private repo in airflow does not work. To pull images to all nodes you need [this](#pull-images)

## Images in dockerhub

- to use images in k8s, you need to push them in dockerhub.
- first, create a private repository on dockerhub (private because it stores your EGI token)
- then login to dockerhub on your machine ```docker login docker.io```. This creates a file with your authentication credentials in ```~/.docker/config.json```
- build your image
```
TAG=0.0.0
docker image tag rucio-intertwin leggerf/rucio-intertwin:$TAG
docker push leggerf/rucio-intertwin:$TAG
```
- add secret to k8s (change namespace if needed)
```
kubectl create secret generic dockerhub \
    --from-file=.dockerconfigjson=~/.docker/config.json \
    --type=kubernetes.io/dockerconfigjson --namespace airflow
```
- test image pull with
```
kubectl apply -f pull-image.yaml 
pod/pull-image created
k get pods
k logs pull-image
```

### Pull images

- to automatically pull docker images to all nodes in the cluster, we use daemonsets.
- ```k apply -f ds-pull-images.yaml```
- pods can be cleaned with the ```delete-pods.sh``` [script](#remove-pods)
