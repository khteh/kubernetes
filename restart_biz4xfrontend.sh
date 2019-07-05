#!/bin/bash
./restart_env.sh
kubectl scale sts biz4x-frontend --replicas=0
kubectl delete secret biz4xdb-secret --ignore-not-found=true
kubectl delete statefulset biz4x-frontend
kubectl delete svc svc-biz4xfrontend
kubectl apply -f biz4xdb.mysql.yml,svc-biz4xfrontend.yml,biz4x-frontend.yml
