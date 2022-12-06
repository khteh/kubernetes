#!/bin/bash
microk8s kubectl scale sts elasticsearch --replicas=0
microk8s kubectl scale sts elasticsearch-master --replicas=0
microk8s kubectl delete configmap elasticsearch-config access-log-template --ignore-not-found=true
microk8s kubectl delete job elasticsearch-init --ignore-not-found=true
microk8s kubectl delete statefulset elasticsearch --ignore-not-found=true
microk8s kubectl delete statefulset elasticsearch-master --ignore-not-found=true
microk8s kubectl delete svc svc-elasticsearch svc-elasticsearch-discovery --ignore-not-found=true
#microk8s kubectl delete DaemonSet daemonset --ignore-not-found=true
#microk8s kubectl apply -f daemonset.yml,elasticsearch-config.yml,access-log-template.yml,svc-elasticsearch.yml,svc-elasticsearch-discovery.yml,elasticsearch-master.yml,elasticsearch.yml
microk8s kubectl apply -f elasticsearch-pvc.yml,elasticsearch-config.yml,access-log-template.yml,svc-elasticsearch.yml,svc-elasticsearch-discovery.yml,elasticsearch-master.yml,elasticsearch.yml
