#!/bin/bash
kubectl scale sts mysql-slave --replicas=0
kubectl scale sts mysql-master --replicas=0
kubectl delete configmap mysqlinit --ignore-not-found=true
kubectl delete statefulset mysql-slave --ignore-not-found=true
kubectl delete statefulset mysql-master --ignore-not-found=true
kubectl delete secret mysql-secret --ignore-not-found=true
kubectl delete pvc -l app=mysql-master
kubectl delete pvc -l app=mysql-slave
kubectl apply -f mysql-secret.yml,mysqlinit.yml,mysql-master.yml,mysql-slave.yml
