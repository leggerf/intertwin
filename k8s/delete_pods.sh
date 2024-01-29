# delete pods based on substring (in this case 'task')

MATCH=task

kubectl get pod -n airflow | grep $MATCH
#kubectl delete pod -n airflow $(kubectl get pod -n airflow | grep $MATCH | awk '{print $1}')
