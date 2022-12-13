#!/bin/bash
Don't use this. Use `kubectl apply kibana-eck.yml` instead
microk8s kubectl scale sts kibana --replicas=0
microk8s kubectl delete configmap kibana-config --ignore-not-found=true
microk8s kubectl delete statefulset kibana --ignore-not-found=true
microk8s kubectl delete svc svc-kibana --ignore-not-found=true
#microk8s kubectl apply -f kibana-config.yml,kibana.yml
