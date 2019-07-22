#!/bin/bash
kubectl scale sts elasticsearch-master --replicas=0
kubectl delete configmap elasticsearch-config access-log-template --ignore-not-found=true
kubectl delete job elasticsearch-init --ignore-not-found=true
kubectl delete statefulset elasticsearch-master --ignore-not-found=true
kubectl delete svc svc-elasticsearch-discovery --ignore-not-found=true
#kubectl delete DaemonSet daemonset --ignore-not-found=true
#kubectl apply -f daemonset.yml,elasticsearch-config.yml,access-log-template.yml,svc-elasticsearch.yml,svc-elasticsearch-discovery.yml,elasticsearch-master.yml,elasticsearch.yml
kubectl apply -f elasticsearch-config.yml,access-log-template.yml,svc-elasticsearch-discovery.yml,elasticsearch-master.yml
