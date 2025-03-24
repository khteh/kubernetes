#!/bin/bash
#https://www.suse.com/c/rancher_blog/deploying-redis-cluster-on-top-of-kubernetes/
kubectl delete job redis-cluster-init --ignore-not-found=true
kubectl apply -f rbac-pods.yml
kubectl apply -f redis-cluster-initjob.yml
