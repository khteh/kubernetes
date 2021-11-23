#!/bin/bash
#https://www.suse.com/c/rancher_blog/deploying-redis-cluster-on-top-of-kubernetes/
microk8s kubectl scale sts redis-cluster --replicas=0
microk8s kubectl delete cm redis-cluster-config --ignore-not-found=true
microk8s kubectl delete sts redis-cluster --ignore-not-found=true
microk8s kubectl delete pvc -l app=redis-cluster --ignore-not-found=true
microk8s kubectl delete job redis-cluster-init --ignore-not-found=true
microk8s kubectl apply -f redis-cluster-config.yml,redis-cluster.yml,svc-redis-cluster.yml
