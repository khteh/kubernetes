#!/bin/bash
kubectl scale sts mysql-slave --replicas=0
kubectl scale sts mysql-master --replicas=0
kubectl delete configmap mysqlinit --ignore-not-found=true
kubectl delete statefulset mysql-slave --ignore-not-found=true
kubectl delete statefulset mysql-master --ignore-not-found=true
kubectl delete secret mysql-secret --ignore-not-found=true
kubectl delete pvc mysql-master-persistent-storage-mysql-master-0 --ignore-not-found=true
kubectl delete pvc mysql-slave-persistent-storage-mysql-slave-0 --ignore-not-found=true
kubectl apply -f mysql-secret.yml,mysqlinit.yml,mysql-master.yml,mysql-slave.yml
