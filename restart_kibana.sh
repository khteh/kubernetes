#!/bin/bash
Don't use this. Use `kubectl apply kibana-eck.yml` instead
kubectl scale sts kibana --replicas=0
kubectl delete configmap kibana-config --ignore-not-found=true
kubectl delete statefulset kibana --ignore-not-found=true
kubectl delete svc svc-kibana --ignore-not-found=true
#kubectl apply -f kibana-config.yml,kibana.yml
