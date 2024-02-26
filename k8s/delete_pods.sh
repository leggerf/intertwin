# delete pods based on substring and namespace

MATCH=task
NS=airflow

#MATCH=image
#NS=default


kubectl get pod -n $NS | grep $MATCH
kubectl delete pod -n $NS $(kubectl get pod -n $NS | grep $MATCH | awk '{print $1}')
