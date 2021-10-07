#!/bin/bash
microk8s kubectl scale sts postgresql --replicas=0
microk8s kubectl delete svc svc-{postgresql,postgresql-nodeport}
microk8s kubectl delete configmap postgresql-initdb --ignore-not-found=true
microk8s kubectl delete statefulset postgresql --ignore-not-found=true
microk8s kubectl delete secret postgresql-secret --ignore-not-found=true
microk8s kubectl delete pvc -l app=db-postgresql
microk8s kubectl apply -f svc-postgresql.yml,postgresql-secret.yml,postgresql-initdb.yml,postgresql.yml
