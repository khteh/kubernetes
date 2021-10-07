#!/bin/bash
microk8s kubectl scale sts mysql --replicas=0
microk8s kubectl delete svc svc-{mysql,mysql-nodeport}
microk8s kubectl delete configmap mysql-initdb --ignore-not-found=true
microk8s kubectl delete statefulset mysql --ignore-not-found=true
microk8s kubectl delete secret mysql-secret --ignore-not-found=true
#microk8s kubectl delete pvc -l app=db-mysql
#microk8s kubectl apply -f svc-mysql.yml,mysql-secret.yml,mysql-initdb.yml,mysqlset.yml
