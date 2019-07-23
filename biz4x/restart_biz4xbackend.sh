#!/bin/bash
#./restart_env.sh
kubectl scale sts biz4x-backend --replicas=0
kubectl delete secret biz4x-secret --ignore-not-found=true
kubectl delete statefulset biz4x-backend
kubectl delete svc svc-biz4xbackend
kubectl apply -f biz4x-secret.yml,svc-biz4xbackend.yml,biz4x-backend.yml
