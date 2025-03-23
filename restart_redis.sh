#!/bin/bash
#https://www.suse.com/c/rancher_blog/deploying-redis-cluster-on-top-of-kubernetes/
kubectl scale sts redis-cluster --replicas=0
kubectl delete cm redis-cluster-config --ignore-not-found=true
kubectl delete sts redis-cluster --ignore-not-found=true --grace-period=0 --force
for pvc in `kubectl get pvc -l app=redis-cluster | tail -n +2 | cut -d ' ' -f1`; do
    echo pvc: $pvc
    kubectl patch pvc $pvc -p '{"metadata":{"finalizers":null}}'
done
kubectl delete pvc -l app=redis-cluster --ignore-not-found=true --grace-period=0 --force 
kubectl delete job redis-cluster-init --ignore-not-found=true
kubectl apply -f redis_cluster_config.yml,redis-cluster.yml,svc-redis-cluster.yml
