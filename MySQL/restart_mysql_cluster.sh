#!/bin/bash
kubectl delete configmap mysql-initdb --ignore-not-found=true
kubectl scale sts mysql-{master,slave} --replicas=0
kubectl delete svc svc-mysql-{master,slave,nodeport} --ignore-not-found=true
kubectl delete sts mysql-{master,slave} --ignore-not-found=true
kubectl delete secret mysql-secret --ignore-not-found=true
kubectl delete pvc -l app=mysql-master
kubectl delete pvc -l app=mysql-slave
kubectl apply -f mysql_secret.yml,svc-mysql-cluster.yml,mysql-initdb.yml,mysql-master.yml,mysql-slave.yml
