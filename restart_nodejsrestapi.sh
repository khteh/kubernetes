#!/bin/bash
kubectl scale sts nodejsrestapi --replicas=0
kubectl delete statefulset nodejsrestapi --ignore-not-found=true
kubectl delete svc svc-{nodejsrestapi,nodejsrestapi-nodeport} --ignore-not-found=true
kubectl delete cm access-log-template nodejsrestapi nodejs-fluentd-config --ignore-not-found=true
kubectl apply -f access_log_template.yml,nodejsrestapi_config.yml,svc-nodejsrestapi.yml,nodejs-fluentd_config.yml,nodejsrestapi.yml
