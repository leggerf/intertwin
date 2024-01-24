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

## Airflow

```
k get pods -n airflow
```

To see the Airflow dashboard, do ```kubectl port-forward svc/airflow-webserver 8080:8080 --namespace airflow```
and go to [http://localhost:8080/]() (admin/admin)
