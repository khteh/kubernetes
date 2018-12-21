#!/bin/bash
microk8s.kubectl scale sts mysql --replicas=0
microk8s.kubectl delete configmap mysqlinit
microk8s.kubectl delete statefulset mysql
microk8s.kubectl delete secret mysql-secret
microk8s.kubectl delete pvc mysql-persistent-storage-mysql-0
#microk8s.kubectl delete svc svc-web
microk8s.kubectl apply -f mysql-secret.yml,mysqlinit.yml,mysqlset.yml
