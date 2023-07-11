#!/bin/bash
kubectl scale sts pythonrestapi --replicas=0
kubectl delete statefulset pythonrestapi --ignore-not-found=true
kubectl delete svc svc-{pythonrestapi,pythonrestapi-nodeport} --ignore-not-found=true
kubectl delete cm pythonrestapi --ignore-not-found=true
kubectl apply -f pythonrestapi_config.yml,svc-pythonrestapi.yml,pythonrestapi.yml
