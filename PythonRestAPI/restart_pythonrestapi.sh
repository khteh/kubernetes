#!/bin/bash
kubectl scale sts pythonrestapi --replicas=0
kubectl delete statefulset pythonrestapi --ignore-not-found=true
#kubectl delete svc svc-{pythonrestapi,pythonrestapi-nodeport} --ignore-not-found=true
kubectl delete cm access-log-template hypercorn-config pythonrestapi pythonrestapi-fluentd-config --ignore-not-found=true
kubectl apply -f ../access_log_template.yml,hypercorn_config.yml,pythonrestapi_config.yml,fluentd_config.yml,svc-pythonrestapi.yml,pythonrestapi.yml
