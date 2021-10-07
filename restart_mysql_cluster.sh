#!/bin/bash
microk8s kubectl delete configmap mysql-initdb --ignore-not-found=true
microk8s kubectl scale sts mysql-{master,slave} --replicas=0
microk8s kubectl delete svc svc-mysql-{master,slave,nodeport} --ignore-not-found=true
microk8s kubectl delete sts mysql-{master,slave} --ignore-not-found=true
microk8s kubectl delete secret mysql-secret --ignore-not-found=true
microk8s kubectl delete pvc -l app=mysql-master
microk8s kubectl delete pvc -l app=mysql-slave
microk8s kubectl apply -f mysql-secret.yml,svc-mysql-cluster.yml,mysql-initdb.yml,mysql-master.yml,mysql-slave.yml
