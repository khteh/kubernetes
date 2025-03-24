#!/bin/bash
kubectl scale sts mysql --replicas=0
kubectl delete svc svc-{mysql,mysql-nodeport}
kubectl delete configmap mysql-initdb --ignore-not-found=true
kubectl delete statefulset mysql --ignore-not-found=true
kubectl delete secret mysql-secret --ignore-not-found=true
kubectl delete pvc -l app=db-mysql
kubectl apply -f svc-mysql.yml,mysql_secret.yml,mysql-initdb.yml,mysqlset.yml
