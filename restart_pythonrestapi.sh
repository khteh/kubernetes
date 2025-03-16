#!/bin/bash
kubectl scale sts pythonrestapi --replicas=0
kubectl delete statefulset pythonrestapi --ignore-not-found=true
kubectl delete svc svc-{pythonrestapi,pythonrestapi-nodeport} --ignore-not-found=true
kubectl delete cm access-log-template pythonrestapi pythonrestapi-fluentd-config --ignore-not-found=true
kubectl apply -f access-log-template.yml,pythonrestapi_config.yml,pythonrestapi-fluentd-config.yml,svc-pythonrestapi.yml,pythonrestapi.yml
