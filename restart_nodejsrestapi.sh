#!/bin/bash
kubectl scale sts nodejsrestapi --replicas=0
kubectl delete statefulset nodejsrestapi --ignore-not-found=true
kubectl delete svc svc-{nodejsrestapi,nodejsrestapi-nodeport} --ignore-not-found=true
kubectl delete cm nodejsrestapi nodejs-fluentd-config --ignore-not-found=true
kubectl apply -f nodejsrestapi_config.yml,svc-nodejsrestapi.yml,nodejs-fluentd-config.yml,nodejsrestapi.yml
