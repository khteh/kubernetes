#!/bin/bash
kubectl scale sts mysql --replicas=0
kubectl delete configmap mysqlinit --ignore-not-found=true
kubectl delete statefulset mysql --ignore-not-found=true
kubectl delete secret mysql-secret --ignore-not-found=true
kubectl delete pvc -l app=db-mysql
kubectl apply -f mysql-secret.yml,mysqlinit.yml,mysqlset.yml
