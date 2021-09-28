#!/bin/bash
microk8s kubectl scale sts pythonrestapi --replicas=0
microk8s kubectl delete statefulset pythonrestapi --ignore-not-found=true
microk8s kubectl delete svc svc-pythonrestapi --ignore-not-found=true
microk8s kubectl delete cm pythonrestapi --ignore-not-found=true
microk8s kubectl apply -f pythonrestapi_config.yml,svc-pythonrestapi.yml,pythonrestapi.yml
