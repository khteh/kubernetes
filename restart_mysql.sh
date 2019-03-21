#!/bin/bash
kubectl scale sts mysql --replicas=0
kubectl delete configmap mysqlinit --ignore-not-found=true
kubectl delete statefulset mysql --ignore-not-found=true
kubectl delete secret mysql-secret --ignore-not-found=true
kubectl delete pvc mysql-persistent-storage-mysql-0
kubectl apply -f mysql-secret.yml,mysqlinit.yml,mysqlset.yml
