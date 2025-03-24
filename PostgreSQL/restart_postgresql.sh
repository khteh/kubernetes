#!/bin/bash
kubectl scale sts postgresql --replicas=0
kubectl delete svc svc-{postgresql,postgresql-nodeport}
kubectl delete configmap postgresql-initdb --ignore-not-found=true
kubectl delete statefulset postgresql --ignore-not-found=true
kubectl delete secret postgresql-secret --ignore-not-found=true
kubectl delete pvc -l app=db-postgresql
kubectl apply -f svc-postgresql.yml,postgresql_secret.yml,postgresql-initdb.yml,postgresql.yml
