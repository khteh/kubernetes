#!/bin/bash
./restart_env.sh
kubectl scale sts restapi --replicas=0
kubectl delete configmap webconfig --ignore-not-found=true
kubectl delete statefulset restapi
kubectl delete svc svc-restapi
kubectl apply -f webconfig.yml,svc-restapi.yml,restapi.yml
